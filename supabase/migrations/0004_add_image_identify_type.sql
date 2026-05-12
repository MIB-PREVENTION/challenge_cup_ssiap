-- =====================================================================
-- Adjustments after extracting questions from index.html:
--   - the existing data uses type 'image-identify' (not 'pictogram')
--   - questions have imageKey + imageDesc (reference to local SVG dict)
-- =====================================================================

alter table public.questions drop constraint questions_type_check;
alter table public.questions add constraint questions_type_check
  check (type in (
    'quiz','true-false','multiple-select','sequence','ranking',
    'matching','fill-blank','find-intruder','scenario',
    'categories','decision','image-identify'
  ));

alter table public.questions
  add column image_key  text,
  add column image_desc text;
