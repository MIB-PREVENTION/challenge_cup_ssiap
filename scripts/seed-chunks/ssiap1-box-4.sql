begin;
-- module ssiap1-box-4 : Évacuation & Organisation
insert into public.modules (id, level, title, subtitle, icon, color, display_order, is_active)
values ('ssiap1-box-4', 1, 'Évacuation & Organisation', 'Dégagements, rôles, exercices', '🚪', 'from-emerald-500 to-teal-600', 3, true)
on conflict (id) do update set title=excluded.title, subtitle=excluded.subtitle, icon=excluded.icon;
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q1', 'ssiap1-box-4', 'scenario', 'Serre-file face à un récalcitrant', 'Quelle est votre action correcte ?',
  'Lors d''une évacuation déclenchée par l''alarme, vous êtes serre-file au 3ème étage. Un cadre supérieur refuse d''évacuer et dit : "Je suis en réunion importante, c''est encore une fausse alarme".', null, 'Le serre-file tente de convaincre fermement. Si refus persistant : noter son identité, localisation précise, et en informer immédiatement le responsable d''évacuation et les pompiers à l''arrivée. Ne jamais abandonner sans signaler.',
  1, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 0
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q2', 'ssiap1-box-4', 'quiz', 'Unité de passage', 'Quelle est la largeur d''une Unité de Passage (UP) réglementaire en ERP ?',
  null, null, '1 UP = 0,60 m. Les dégagements sont calculés en nombre d''UP selon l''effectif. Ex : une porte de 0,90 m = 1 UP. Une largeur de 1,40 m = 2 UP. Ces calculs garantissent un débit d''évacuation suffisant.',
  1, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 1
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q3', 'ssiap1-box-4', 'find-intruder', 'Action correcte en évacuation', 'Lequel de ces comportements est CORRECT lors d''une évacuation d''urgence ?',
  null, null, 'Se rendre calmement au point de rassemblement ✅. Ascenseur ❌ (risque de coupure). Retourner ❌ (risque mortel). Ouvrir les portes CF ❌ (laissent passer le feu et la fumée, elles doivent RESTER FERMÉES).',
  2, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 2
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q4', 'ssiap1-box-4', 'true-false', 'Sens d''ouverture des portes', 'Une porte de sortie desservant plus de 50 personnes doit obligatoirement s''ouvrir dans le sens de l''évacuation.',
  null, null, 'VRAI — Article CO 44 : dès 50 personnes, porte obligatoirement dans le sens de la sortie pour éviter l''effet de bouchon lors d''une bousculade. En dessous de 50, les deux sens sont autorisés.',
  0, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 3
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q5', 'ssiap1-box-4', 'matching', 'Rôles lors de l''évacuation', 'Associez chaque acteur à sa mission principale lors de l''évacuation :',
  null, null, 'Guide-file = en tête de groupe. Serre-file = en queue, dernier sorti, portes fermées. SSIAP = interface avec les pompiers (plans, clés). Responsable = autorité de décision.',
  null, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 4
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q6', 'ssiap1-box-4', 'sequence', 'Procédure d''alerte', 'Remettez dans l''ordre les étapes de la procédure d''alerte en cas d''incendie découvert :',
  null, null, 'Découverte → Alarme (pour évacuer tout le monde) → Alerte secours (18/112) → Accueil des pompiers avec plan, clés, informations. L''alarme AVANT l''alerte externe.',
  null, null::integer[],
  array[0,1,2,3]::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 5
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q7', 'ssiap1-box-4', 'multiple-select', 'Éclairage de sécurité', 'Quels équipements font partie du système d''éclairage de sécurité réglementaire ? (plusieurs réponses)',
  null, null, 'BAES ✅, éclairage d''ambiance/anti-panique ✅, source centralisée ✅. Néon secteur ❌ (s''éteint en coupure). BAAS ❌ = alarme sonore, pas éclairage.',
  null, array[0,2,3]::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 6
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q8', 'ssiap1-box-4', 'fill-blank', 'Autonomie éclairage', 'Complétez les exigences réglementaires sur l''éclairage de sécurité :',
  null, null, '1 heure minimum d''autonomie sur batteries intégrées (BAES). Allumage automatique dès coupure secteur. Permet l''évacuation en toute sécurité même lors d''une coupure électrique totale.',
  null, null::integer[],
  null::integer[], array['1','normale']::text[],
  null::integer[], array['1','normale','2','secours','3','principale']::text[],
  'L''éclairage de sécurité doit fonctionner au minimum %1% heure en cas de coupure et doit s''allumer automatiquement dès la perte de l''alimentation %2%.', null, null,
  null, null, 7
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q9', 'ssiap1-box-4', 'ranking', 'Phases de l''évacuation', 'Classez ces phases dans l''ordre chronologique correct d''une évacuation réussie :',
  null, null, 'Alarme → Évacuation ordonnée → Comptage (vérifier que personne ne manque) → Retour exclusivement après feu maître. Ne JAMAIS retourner sans autorisation des pompiers.',
  null, null::integer[],
  array[0,1,2,3]::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 8
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q10', 'ssiap1-box-4', 'categories', 'Actions lors de l''évacuation', 'Classez ces comportements lors de l''évacuation :',
  null, null, 'Déclencher le DM ✅, fermer les portes ✅ (ralentit le feu), rejoindre le point ✅. Ascenseur ❌, retour dans le bâtiment ❌ — ces deux comportements causent des décès chaque année.',
  null, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 9
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q11', 'ssiap1-box-4', 'image-identify', 'Équipement vert lumineux', 'Cet équipement avec pictogramme de sortie lumineux est un :',
  null, null, 'BAES = Bloc Autonome d''Éclairage de Sécurité. Batterie intégrée, autonomie 1h minimum. S''allume automatiquement sur coupure secteur. Test mensuel obligatoire par l''exploitant (bouton "test").',
  1, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  'baes', 'BAES — Bloc Autonome Éclairage Sécurité', 10
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q12', 'ssiap1-box-4', 'decision', 'Exercice d''évacuation décevant', 'Comment gérez-vous le retour d''expérience ?',
  'L''exercice d''évacuation annuel vient de se terminer : 14 minutes pour évacuer 180 personnes sur 3 étages. Le précédent exercice avait duré 7 minutes. Un goulot d''étranglement a été observé dans l''escalier B.', null, 'Débriefing immédiat → Analyse fine des causes → Compte-rendu complet au registre avec plan d''amélioration. L''exercice n''a de valeur que s''il génère des actions correctives.',
  null, null::integer[],
  null::integer[], null::text[],
  array[1,1,1]::integer[], null::text[],
  null, null, null,
  null, null, 11
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q13', 'ssiap1-box-4', 'true-false', 'Rôle du serre-file', 'Le serre-file doit laisser toutes les portes ouvertes derrière lui pour faciliter la circulation lors de l''évacuation.',
  null, null, 'FAUX — Le serre-file doit FERMER toutes les portes coupe-feu derrière lui. Une porte CF fermée ralentit la progression du feu et de la fumée de 30 à 120 minutes selon sa résistance. C''est une des actions les plus efficaces lors d''une évacuation.',
  1, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 12
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b4-q14', 'ssiap1-box-4', 'scenario', 'PMR coincée en hauteur', 'Quelle est la procédure correcte ?',
  'Lors de l''évacuation, vous croisez une collègue en fauteuil roulant au 4ème étage. L''ascenseur est neutralisé. Les escaliers sont inaccessibles pour elle.', null, 'EAS = Espace d''Attente Sécurisé, adjacent aux escaliers, protégé du feu. La PMR y attend les pompiers dans une zone sécurisée. Sa position DOIT être communiquée aux secours à l''arrivée. Porter une personne dans des escaliers peut blesser les deux parties.',
  2, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  null, null, 13
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
delete from public.question_options        where question_id in ('ssiap1-b4-q1','ssiap1-b4-q2','ssiap1-b4-q3','ssiap1-b4-q4','ssiap1-b4-q5','ssiap1-b4-q6','ssiap1-b4-q7','ssiap1-b4-q8','ssiap1-b4-q9','ssiap1-b4-q10','ssiap1-b4-q11','ssiap1-b4-q12','ssiap1-b4-q13','ssiap1-b4-q14');
delete from public.question_items          where question_id in ('ssiap1-b4-q1','ssiap1-b4-q2','ssiap1-b4-q3','ssiap1-b4-q4','ssiap1-b4-q5','ssiap1-b4-q6','ssiap1-b4-q7','ssiap1-b4-q8','ssiap1-b4-q9','ssiap1-b4-q10','ssiap1-b4-q11','ssiap1-b4-q12','ssiap1-b4-q13','ssiap1-b4-q14');
delete from public.question_pairs          where question_id in ('ssiap1-b4-q1','ssiap1-b4-q2','ssiap1-b4-q3','ssiap1-b4-q4','ssiap1-b4-q5','ssiap1-b4-q6','ssiap1-b4-q7','ssiap1-b4-q8','ssiap1-b4-q9','ssiap1-b4-q10','ssiap1-b4-q11','ssiap1-b4-q12','ssiap1-b4-q13','ssiap1-b4-q14');
delete from public.question_categories     where question_id in ('ssiap1-b4-q1','ssiap1-b4-q2','ssiap1-b4-q3','ssiap1-b4-q4','ssiap1-b4-q5','ssiap1-b4-q6','ssiap1-b4-q7','ssiap1-b4-q8','ssiap1-b4-q9','ssiap1-b4-q10','ssiap1-b4-q11','ssiap1-b4-q12','ssiap1-b4-q13','ssiap1-b4-q14');
delete from public.question_category_items where question_id in ('ssiap1-b4-q1','ssiap1-b4-q2','ssiap1-b4-q3','ssiap1-b4-q4','ssiap1-b4-q5','ssiap1-b4-q6','ssiap1-b4-q7','ssiap1-b4-q8','ssiap1-b4-q9','ssiap1-b4-q10','ssiap1-b4-q11','ssiap1-b4-q12','ssiap1-b4-q13','ssiap1-b4-q14');
delete from public.question_decision_steps where question_id in ('ssiap1-b4-q1','ssiap1-b4-q2','ssiap1-b4-q3','ssiap1-b4-q4','ssiap1-b4-q5','ssiap1-b4-q6','ssiap1-b4-q7','ssiap1-b4-q8','ssiap1-b4-q9','ssiap1-b4-q10','ssiap1-b4-q11','ssiap1-b4-q12','ssiap1-b4-q13','ssiap1-b4-q14');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q1', 0, 'Le laisser — vous ne pouvez pas forcer un supérieur hiérarchique');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q1', 1, 'Tenter de le convaincre, si refus noter son identité et prévenir le responsable d''évacuation');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q1', 2, 'L''escorter physiquement de force');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q1', 3, 'Continuer sans lui — c''est son problème');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q2', 0, '0,40 m');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q2', 1, '0,60 m');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q2', 2, '0,80 m');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q2', 3, '1,00 m');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q3', 0, 'Prendre l''ascenseur pour gagner du temps');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q3', 1, 'Retourner chercher son manteau et son téléphone');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q3', 2, 'Se rendre calmement au point de rassemblement');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q3', 3, 'Ouvrir toutes les portes coupe-feu pour faciliter le passage');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q4', 0, 'Vrai');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q4', 1, 'Faux');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b4-q5', 0, 'Guide-file', 'Ouvre la marche et guide vers la sortie');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b4-q5', 1, 'Serre-file', 'Ferme la marche, vérifie les locaux, ferme les portes');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b4-q5', 2, 'Agent SSIAP', 'Coordonne l''évacuation et accueille les secours');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b4-q5', 3, 'Responsable d''évacuation', 'Décide et supervise l''ensemble du dispositif');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b4-q6', 0, 'Découvrir ou constater le sinistre');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b4-q6', 1, 'Déclencher le Déclencheur Manuel d''alarme le plus proche');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b4-q6', 2, 'Alerter les sapeurs-pompiers (18 ou 112)');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b4-q6', 3, 'Accueillir et guider les secours à leur arrivée');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q7', 0, 'BAES (Bloc Autonome d''Éclairage de Sécurité)');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q7', 1, 'Néon fluorescent standard alimenté secteur');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q7', 2, 'Éclairage d''ambiance anti-panique');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q7', 3, 'Source centralisée sur batteries avec luminaires déportés');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q7', 4, 'BAAS (Bloc Autonome d''Alarme Sonore)');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b4-q9', 0, 'Déclenchement du signal d''alarme sonore');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b4-q9', 1, 'Évacuation guidée des occupants par les guides-files');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b4-q9', 2, 'Comptage et appel au point de rassemblement');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b4-q9', 3, 'Retour autorisé uniquement par les sapeurs-pompiers');
insert into public.question_categories (question_id, category_index, category_id, category_label) values ('ssiap1-b4-q10', 0, 'ok', '✅ À faire impérativement');
insert into public.question_categories (question_id, category_index, category_id, category_label) values ('ssiap1-b4-q10', 1, 'nok', '🚫 Strictement interdit');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b4-q10', 0, 'Déclencher le DM en quittant son poste', 'ok');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b4-q10', 1, 'Fermer la porte de son bureau derrière soi', 'ok');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b4-q10', 2, 'Prendre l''ascenseur pour les étages supérieurs', 'nok');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b4-q10', 3, 'Rejoindre le point de rassemblement désigné', 'ok');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b4-q10', 4, 'Retourner récupérer un document urgent', 'nok');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q11', 0, 'Détecteur de fumée optique');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q11', 1, 'Bloc Autonome d''Éclairage de Sécurité (BAES)');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q11', 2, 'Déclencheur manuel d''alarme');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q11', 3, 'Diffuseur sonore d''alarme incendie');
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b4-q12', 0, 'ÉTAPE 1 — Après l''exercice, que faites-vous en premier ?', '[{"text":"Féliciter quand même tout le monde","nextStep":99},{"text":"Réunir les guides-files et serres-files pour un débriefing à chaud","nextStep":1},{"text":"Appeler les pompiers pour signaler un dysfonctionnement","nextStep":99}]'::jsonb);
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b4-q12', 1, 'ÉTAPE 2 — Goulot d''étranglement dans l''escalier B : quelle analyse faites-vous ?', '[{"text":"C''est normal, les gens ne savent pas évacuer","nextStep":99},{"text":"Identifier la cause : largeur insuffisante, affectation de l''escalier C non communiquée, panique ?","nextStep":2},{"text":"Interdire cet escalier sans analyse","nextStep":99}]'::jsonb);
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b4-q12', 2, 'ÉTAPE 3 — Que consignez-vous dans le registre de sécurité ?', '[{"text":"Le temps total uniquement","nextStep":null},{"text":"Compte-rendu complet : temps, effectif, anomalies, analyse des causes, plan d''amélioration et mesures correctives","nextStep":null},{"text":"Rien — c''était un exercice, pas un vrai sinistre","nextStep":null}]'::jsonb);
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q13', 0, 'Vrai');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q13', 1, 'Faux');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q14', 0, 'La porter seul dans les escaliers malgré le risque');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q14', 1, 'La laisser — les pompiers s''en chargeront');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q14', 2, 'La conduire dans l''Espace d''Attente Sécurisé (EAS) le plus proche et signaler sa position aux secours');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b4-q14', 3, 'Lui demander d''attendre que la fumée se dissipe');
commit;
