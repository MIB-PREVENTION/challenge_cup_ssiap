-- =====================================================================
-- Challenge Cup SSIAP — Initial schema
-- Inspired by challenge_cup_RPP_edf, simplified for the SSIAP MVP.
-- Multi-tenant layer (organizations, companies, licenses, trainers,
-- versioning, trainer_requests) is intentionally deferred to a later
-- migration when integrating with the training-center platform.
-- =====================================================================

create extension if not exists pgcrypto;
create extension if not exists "uuid-ossp";

-- =====================================================================
-- 1. MODULES (les "boîtes" du jeu)
-- =====================================================================
create table public.modules (
  id            text primary key,
  level         smallint not null check (level between 1 and 3),
  title         text not null,
  subtitle      text,
  icon          text default '📋',
  color         text default 'from-blue-500 to-indigo-600',
  display_order integer not null default 0,
  is_active     boolean not null default true,
  created_at    timestamptz default now()
);

create index modules_level_idx on public.modules(level, display_order);

-- =====================================================================
-- 2. QUESTIONS
-- =====================================================================
create table public.questions (
  id              text primary key,
  module_id       text not null references public.modules(id) on delete cascade,
  type            text not null check (type in (
                    'quiz','true-false','multiple-select','sequence','ranking',
                    'matching','fill-blank','find-intruder','scenario',
                    'categories','decision','pictogram'
                  )),
  title           text,
  question        text not null,
  scenario        text,
  situation       text,
  explanation     text,

  -- Réponses correctes (selon le type)
  correct_answer  integer,
  correct_answers integer[],
  correct_order   integer[],
  correct_blanks  text[],
  correct_path    integer[],
  word_bank       text[],
  sentence        text,

  -- Médias
  image_url       text,
  video_url       text,

  -- Méta
  difficulty      smallint default 1 check (difficulty between 1 and 3),
  tags            text[] default '{}',
  status          text default 'published' check (status in ('draft','published','archived')),
  is_active       boolean default true,
  display_order   integer default 0,
  created_at      timestamptz default now(),
  updated_at      timestamptz default now()
);

create index questions_module_idx on public.questions(module_id, display_order);
create index questions_type_idx   on public.questions(type);
create index questions_active_idx on public.questions(is_active) where is_active;

-- Sub-tables (one row per option/item/pair/category/step)
create table public.question_options (
  id           bigserial primary key,
  question_id  text not null references public.questions(id) on delete cascade,
  option_index integer not null,
  option_text  text not null,
  unique (question_id, option_index)
);

create table public.question_items (
  id          bigserial primary key,
  question_id text not null references public.questions(id) on delete cascade,
  item_index  integer not null,
  item_text   text not null,
  unique (question_id, item_index)
);

create table public.question_pairs (
  id          bigserial primary key,
  question_id text not null references public.questions(id) on delete cascade,
  pair_index  integer not null,
  left_text   text not null,
  right_text  text not null,
  unique (question_id, pair_index)
);

create table public.question_categories (
  id              bigserial primary key,
  question_id     text not null references public.questions(id) on delete cascade,
  category_index  integer not null,
  category_id     text not null,
  category_label  text not null,
  unique (question_id, category_index)
);

create table public.question_category_items (
  id               bigserial primary key,
  question_id      text not null references public.questions(id) on delete cascade,
  item_index       integer not null,
  item_text        text not null,
  correct_category text not null,
  unique (question_id, item_index)
);

create table public.question_decision_steps (
  id          bigserial primary key,
  question_id text not null references public.questions(id) on delete cascade,
  step_index  integer not null,
  step_question text not null,
  options     jsonb not null default '[]'::jsonb,
  unique (question_id, step_index)
);

-- =====================================================================
-- 3. SESSIONS DE JEU
-- =====================================================================
create table public.sessions (
  id                uuid primary key default uuid_generate_v4(),
  session_code      text unique not null,
  level             smallint not null check (level between 1 and 3),
  status            text default 'waiting' check (status in ('waiting','playing','correction','finished')),
  current_module_id text references public.modules(id),
  current_q_idx     integer default 0,
  opened_modules    text[] default '{}',

  -- Configuration choisie par le formateur (inspiré RPP)
  -- { qpb, activeModules, qtypeFilters, diffFilters }
  config            jsonb not null default '{
                      "qpb": 8,
                      "activeModules": [],
                      "qtypeFilters": [],
                      "diffFilters": []
                    }'::jsonb,

  -- Snapshot de l'ordre des questions (random) par module
  randomized_games  jsonb default '[]'::jsonb,

  question_started_at timestamptz,
  answers_count       integer default 0,

  created_at        timestamptz default now(),
  finished_at       timestamptz,
  supervisor_id     uuid
);

create index sessions_code_idx   on public.sessions(session_code);
create index sessions_status_idx on public.sessions(status);

-- =====================================================================
-- 4. ÉQUIPES
-- =====================================================================
create table public.teams (
  id              uuid primary key default uuid_generate_v4(),
  session_id      uuid not null references public.sessions(id) on delete cascade,
  name            text not null,
  avatar          text default '👷',
  score           integer default 0,
  total_correct   integer default 0,
  total_answered  integer default 0,
  has_answered    boolean default false,
  online          boolean default true,
  joined_at       timestamptz default now(),
  last_seen_at    timestamptz default now(),
  unique (session_id, name)
);

create index teams_session_idx on public.teams(session_id);

-- =====================================================================
-- 5. RÉPONSES DES ÉQUIPES
-- =====================================================================
create table public.team_answers (
  id              uuid primary key default uuid_generate_v4(),
  session_id      uuid not null references public.sessions(id) on delete cascade,
  team_id         uuid not null references public.teams(id) on delete cascade,
  question_id     text not null references public.questions(id),
  module_id       text not null references public.modules(id),
  q_idx           integer not null,
  answer          jsonb,
  is_correct      boolean default false,
  answer_time_ms  integer default 0,
  base_points     integer default 0,
  speed_bonus     integer default 0,
  total_points    integer default 0,
  answered_at     timestamptz default now(),
  unique (team_id, question_id)
);

create index team_answers_session_idx on public.team_answers(session_id);
create index team_answers_team_idx    on public.team_answers(team_id);

-- =====================================================================
-- 6. SUPERVISORS (formateurs)
-- =====================================================================
create table public.supervisors (
  id            uuid primary key default gen_random_uuid(),
  email         text unique not null,
  password_hash text not null,
  firstname     text,
  lastname      text,
  status        text default 'active' check (status in ('active','suspended','archived')),
  -- Préparé pour la future plateforme multi-modules / forfaits
  plan          text default 'DEMO',
  license_key   text,
  created_at    timestamptz default now()
);

-- =====================================================================
-- 7. LOGS (audit)
-- =====================================================================
create table public.logs (
  id          bigserial primary key,
  session_id  uuid references public.sessions(id) on delete set null,
  level       text default 'info' check (level in ('info','warn','error','success','debug')),
  category    text,
  message     text,
  team_name   text,
  metadata    jsonb default '{}'::jsonb,
  created_at  timestamptz default now()
);

create index logs_session_idx on public.logs(session_id, created_at desc);

-- =====================================================================
-- 8. RPC : authentification superviseur
-- =====================================================================
create or replace function public.verify_supervisor(p_email text, p_password text)
returns table (id uuid, email text, firstname text, lastname text, plan text)
language plpgsql
security definer
set search_path = public
as $$
begin
  return query
  select s.id, s.email, s.firstname, s.lastname, s.plan
  from public.supervisors s
  where s.email = p_email
    and s.status = 'active'
    and s.password_hash = crypt(p_password, s.password_hash);
end;
$$;

revoke all on function public.verify_supervisor(text, text) from public;
grant execute on function public.verify_supervisor(text, text) to anon, authenticated;

-- =====================================================================
-- 9. RPC : créer une session (le formateur fournit la config)
-- =====================================================================
create or replace function public.create_session(
  p_level smallint,
  p_config jsonb
)
returns table (id uuid, session_code text)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_code text;
  v_id   uuid;
begin
  -- Génère un code session à 6 caractères unique
  loop
    v_code := upper(substr(md5(random()::text), 1, 6));
    exit when not exists (select 1 from public.sessions where session_code = v_code);
  end loop;

  insert into public.sessions (session_code, level, config)
  values (v_code, p_level, coalesce(p_config, '{}'::jsonb))
  returning sessions.id into v_id;

  return query select v_id, v_code;
end;
$$;

grant execute on function public.create_session(smallint, jsonb) to anon, authenticated;

-- =====================================================================
-- 10. ROW LEVEL SECURITY
-- =====================================================================
alter table public.modules                 enable row level security;
alter table public.questions               enable row level security;
alter table public.question_options        enable row level security;
alter table public.question_items          enable row level security;
alter table public.question_pairs          enable row level security;
alter table public.question_categories     enable row level security;
alter table public.question_category_items enable row level security;
alter table public.question_decision_steps enable row level security;
alter table public.sessions                enable row level security;
alter table public.teams                   enable row level security;
alter table public.team_answers            enable row level security;
alter table public.supervisors             enable row level security;
alter table public.logs                    enable row level security;

-- Catalogue (lecture publique) : modules + questions + sous-tables
create policy "modules read"            on public.modules                 for select using (is_active);
create policy "questions read"          on public.questions               for select using (is_active and status = 'published');
create policy "options read"            on public.question_options        for select using (true);
create policy "items read"              on public.question_items          for select using (true);
create policy "pairs read"              on public.question_pairs          for select using (true);
create policy "categories read"         on public.question_categories     for select using (true);
create policy "cat items read"          on public.question_category_items for select using (true);
create policy "decision steps read"     on public.question_decision_steps for select using (true);

-- Sessions : lecture par code (tout le monde), update via RPC plus tard
create policy "sessions read"  on public.sessions for select using (true);
create policy "sessions write" on public.sessions for update using (true) with check (true);

-- Teams : insert/update par les stagiaires (anon), lecture publique
create policy "teams read"   on public.teams for select using (true);
create policy "teams insert" on public.teams for insert with check (true);
create policy "teams update" on public.teams for update using (true) with check (true);

-- Team answers : insert par le stagiaire qui possède la team, lecture publique
create policy "team_answers read"   on public.team_answers for select using (true);
create policy "team_answers insert" on public.team_answers for insert with check (true);

-- Supervisors : pas d'accès direct (passage uniquement par RPC verify_supervisor)
-- (aucune policy = pas d'accès via PostgREST)

-- Logs : insert public, read public (audit)
create policy "logs read"   on public.logs for select using (true);
create policy "logs insert" on public.logs for insert with check (true);

-- =====================================================================
-- 11. REALTIME : activer la publication sur les tables vivantes
-- =====================================================================
alter publication supabase_realtime add table public.sessions;
alter publication supabase_realtime add table public.teams;
alter publication supabase_realtime add table public.team_answers;
