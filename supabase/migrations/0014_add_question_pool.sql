-- Two pools of questions:
--   'quiz'      : pure QCM / multi-réponses pour entraînement classique (~600 importées)
--   'challenge' : variété de 12 types pour le Challenge Cup
alter table public.questions
  add column if not exists pool text default 'quiz'
  check (pool in ('quiz','challenge'));

update public.questions
   set pool='challenge'
 where 'starter-pack' = any(tags) or 'handcrafted' = any(tags);

create index if not exists questions_pool_idx on public.questions(pool);
