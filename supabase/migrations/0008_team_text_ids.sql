-- The legacy game generates team IDs of the form 'team_<uuid>', which is
-- not a valid uuid. Switch teams.id and team_answers.team_id to text so
-- the shim can pass through the legacy IDs unchanged.

alter table public.team_answers drop constraint team_answers_team_id_fkey;
alter table public.team_answers alter column team_id type text;
alter table public.teams alter column id drop default;
alter table public.teams alter column id type text;
alter table public.team_answers
  add constraint team_answers_team_id_fkey
  foreign key (team_id) references public.teams(id) on delete cascade;
