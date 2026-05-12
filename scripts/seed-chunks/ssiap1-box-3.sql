begin;
-- module ssiap1-box-3 : Moyens de Secours
insert into public.modules (id, level, title, subtitle, icon, color, display_order, is_active)
values ('ssiap1-box-3', 1, 'Moyens de Secours', 'SSI, extincteurs, RIA, colonnes sèches', '🧯', 'from-cyan-500 to-blue-600', 2, true)
on conflict (id) do update set title=excluded.title, subtitle=excluded.subtitle, icon=excluded.icon;
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b3-q1', 'ssiap1-box-3', 'scenario', 'Alarme SSI — levée de doute', 'Quelle est la procédure correcte ?',
  'Le tableau de signalisation affiche "ALARME FEU — Zone 12 — Sous-sol parking" depuis 2 minutes. Vous regardez les caméras de surveillance : aucune fumée visible. Votre responsable vous demande de réarmer immédiatement "pour ne pas déranger".', null, 'Toute alarme = levée de doute obligatoire avant réarmement. Réarmer sans vérification = faute professionnelle grave pouvant engager la responsabilité pénale. L''ordre hiérarchique ne supplante pas la procédure réglementaire.',
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
  'ssiap1-b3-q2', 'ssiap1-box-3', 'quiz', 'Signification SSI', 'Que désigne l''acronyme SSI ?',
  null, null, 'SSI = Système de Sécurité Incendie (norme NF S 61-931). Il comprend le SDI (Système de Détection Incendie) et le SMSI (Système de Mise en Sécurité Incendie).',
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
  'ssiap1-b3-q3', 'ssiap1-box-3', 'true-false', 'CO2 et feu de friture', 'Un extincteur CO2 peut être utilisé sur un feu de friture (classe F) car il étouffe les flammes.',
  null, null, 'FAUX — Le CO2 est DANGEREUX sur les feux de classe F. La pression du jet peut projeter l''huile bouillante et provoquer un embrasement violent (explosion d''huile). Seuls les extincteurs homologués pour classe F (à eau avec additif) conviennent.',
  1, null::integer[],
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
  'ssiap1-b3-q4', 'ssiap1-box-3', 'find-intruder', 'Ce qui n''est pas un DAS', 'Parmi ces équipements, lequel N''EST PAS un Dispositif Actionné de Sécurité (DAS) ?',
  null, null, 'Le DM (Déclencheur Manuel) est un dispositif d''ENTRÉE du SDI — il déclenche l''alarme. Les DAS sont des dispositifs de SORTIE du SMSI — ils agissent : portes CF, volets, clapets, exutoires de désenfumage.',
  2, null::integer[],
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
  'ssiap1-b3-q5', 'ssiap1-box-3', 'matching', 'Extincteur adapté au feu', 'Associez chaque type de feu à l''extincteur le plus adapté :',
  null, null, 'Eau = refroidit les feux solides. CO2 = non conducteur pour l''électrique. Mousse = étouffement sur liquides. Poudre ABC = polyvalent mais salissant et dégrade le matériel électronique.',
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
  'ssiap1-b3-q6', 'ssiap1-box-3', 'sequence', 'Catégories de SSI', 'Classez les catégories de SSI de la PLUS COMPLÈTE à la PLUS SIMPLE :',
  null, null, 'A (obligatoire IGH et ERP à sommeil important) → B → C → D (alarme + compartimentage partiel) → E (alarme seule). La catégorie A est la plus complète et la plus sûre.',
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
  'ssiap1-b3-q7', 'ssiap1-box-3', 'multiple-select', 'Vérifications extincteurs', 'Quelles vérifications sont OBLIGATOIRES pour les extincteurs portatifs ? (plusieurs réponses)',
  null, null, 'Contrôle visuel mensuel ✅, vérif. annuelle agréée ✅, plombage et pression ✅. L''épreuve hydraulique est tous les 10 ans ❌. Le remplacement systématique tous les 3 ans n''est pas une obligation réglementaire ❌.',
  null, array[0,1,4]::integer[],
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
  'ssiap1-b3-q8', 'ssiap1-box-3', 'fill-blank', 'Colonnes d''incendie', 'Complétez la distinction fondamentale :',
  null, null, 'Colonne sèche : obligatoire dès 18m de hauteur de plancher bas. Colonne humide : obligatoire en IGH et grands ERP. La colonne humide offre une intervention immédiate sans attendre les pompiers.',
  null, null::integer[],
  null::integer[], array['colonne sèche','colonne humide']::text[],
  null::integer[], array['colonne sèche','colonne humide','colonne montante','RIA','sprinkler','tuyau d''attaque']::text[],
  'La %1% est une canalisation vide alimentée en eau par les pompiers à l''arrivée. La %2% est maintenue sous pression en permanence par des surpresseurs avec des RIA à chaque étage.', null, null,
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
  'ssiap1-b3-q9', 'ssiap1-box-3', 'ranking', 'Ordre d''intervention extinction', 'Classez ces moyens d''extinction par ordre d''intervention (du PREMIER déclenché au DERNIER) :',
  null, null, 'Sprinkler (automatique dès le départ de feu) → Extincteur (feu naissant) → RIA (feu développé) → Colonne (feu important avec sapeurs-pompiers). Chaque moyen correspond à une ampleur croissante du sinistre.',
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
  'ssiap1-b3-q10', 'ssiap1-box-3', 'categories', 'SDI ou SMSI', 'Classez ces équipements dans leur sous-système SSI :',
  null, null, 'SDI = Détecte et signale : détecteurs automatiques, DM, ECS, ECSAV. SMSI = Agit sur l''environnement : CMSI + tous les DAS (portes CF, volets, clapets, exutoires).',
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
  'ssiap1-b3-q11', 'ssiap1-box-3', 'image-identify', 'Panneau rouge extincteur', 'Ce panneau carré rouge avec un extincteur blanc indique :',
  null, null, 'ISO 7010 F001 = Emplacement d''un extincteur. Carré rouge = matériel de lutte incendie. Il doit être visible à 15 mètres maximum. L''extincteur doit être accessible sans obstacle.',
  1, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  'extinguisher', 'ISO 7010 — F001', 10
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
  'ssiap1-b3-q12', 'ssiap1-box-3', 'decision', 'Anomalie sprinkler', 'Procédure de gestion de la défaillance :',
  'Une alarme "Manque de pression réseau sprinkler" s''affiche sur le tableau de bord du PC sécurité. Il est 23h00, l''établissement est ouvert avec 150 personnes.', null, 'Alerter → Mesures compensatoires (rondes) → Traçabilité complète (main courante + registre + transmission à la relève). Le sprinkler en panne = risque majeur → surveillance renforcée.',
  null, null::integer[],
  null::integer[], null::text[],
  array[1,1,0]::integer[], null::text[],
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
  'ssiap1-b3-q13', 'ssiap1-box-3', 'quiz', 'Inhibition de zone SSI', 'Qu''est-ce qu''une "inhibition de zone" dans un SSI ?',
  null, null, 'Inhibition = mise hors service temporaire d''une zone (travaux, maintenance). Nécessite un niveau d''accès 2 minimum, une documentation écrite et des mesures compensatoires (rondes, surveillance humaine renforcée).',
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
  'ssiap1-b3-q14', 'ssiap1-box-3', 'true-false', 'Test mensuel BAES', 'Un BAES (Bloc Autonome d''Éclairage de Sécurité) doit obligatoirement être testé tous les mois par l''exploitant.',
  null, null, 'VRAI — Le test mensuel (appui sur le bouton "test" : vérification de l''allumage) est obligatoire. Un contrôle annuel approfondi (autonomie, état de la batterie) doit être réalisé par un technicien qualifié.',
  0, null::integer[],
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
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b3-q15', 'ssiap1-box-3', 'image-identify', 'Panneau RIA', 'Ce panneau rouge circulaire avec tuyau indique l''emplacement d''un :',
  null, null, 'RIA = Robinet d''Incendie Armé. Équipement de 2ème intervention composé d''un robinet, un dévidoir et un tuyau semi-rigide. Toujours en eau. Nécessite une formation avant utilisation. Portée 15-20 mètres.',
  1, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  'ria', 'Panneau réglementaire RIA', 14
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
delete from public.question_options        where question_id in ('ssiap1-b3-q1','ssiap1-b3-q2','ssiap1-b3-q3','ssiap1-b3-q4','ssiap1-b3-q5','ssiap1-b3-q6','ssiap1-b3-q7','ssiap1-b3-q8','ssiap1-b3-q9','ssiap1-b3-q10','ssiap1-b3-q11','ssiap1-b3-q12','ssiap1-b3-q13','ssiap1-b3-q14','ssiap1-b3-q15');
delete from public.question_items          where question_id in ('ssiap1-b3-q1','ssiap1-b3-q2','ssiap1-b3-q3','ssiap1-b3-q4','ssiap1-b3-q5','ssiap1-b3-q6','ssiap1-b3-q7','ssiap1-b3-q8','ssiap1-b3-q9','ssiap1-b3-q10','ssiap1-b3-q11','ssiap1-b3-q12','ssiap1-b3-q13','ssiap1-b3-q14','ssiap1-b3-q15');
delete from public.question_pairs          where question_id in ('ssiap1-b3-q1','ssiap1-b3-q2','ssiap1-b3-q3','ssiap1-b3-q4','ssiap1-b3-q5','ssiap1-b3-q6','ssiap1-b3-q7','ssiap1-b3-q8','ssiap1-b3-q9','ssiap1-b3-q10','ssiap1-b3-q11','ssiap1-b3-q12','ssiap1-b3-q13','ssiap1-b3-q14','ssiap1-b3-q15');
delete from public.question_categories     where question_id in ('ssiap1-b3-q1','ssiap1-b3-q2','ssiap1-b3-q3','ssiap1-b3-q4','ssiap1-b3-q5','ssiap1-b3-q6','ssiap1-b3-q7','ssiap1-b3-q8','ssiap1-b3-q9','ssiap1-b3-q10','ssiap1-b3-q11','ssiap1-b3-q12','ssiap1-b3-q13','ssiap1-b3-q14','ssiap1-b3-q15');
delete from public.question_category_items where question_id in ('ssiap1-b3-q1','ssiap1-b3-q2','ssiap1-b3-q3','ssiap1-b3-q4','ssiap1-b3-q5','ssiap1-b3-q6','ssiap1-b3-q7','ssiap1-b3-q8','ssiap1-b3-q9','ssiap1-b3-q10','ssiap1-b3-q11','ssiap1-b3-q12','ssiap1-b3-q13','ssiap1-b3-q14','ssiap1-b3-q15');
delete from public.question_decision_steps where question_id in ('ssiap1-b3-q1','ssiap1-b3-q2','ssiap1-b3-q3','ssiap1-b3-q4','ssiap1-b3-q5','ssiap1-b3-q6','ssiap1-b3-q7','ssiap1-b3-q8','ssiap1-b3-q9','ssiap1-b3-q10','ssiap1-b3-q11','ssiap1-b3-q12','ssiap1-b3-q13','ssiap1-b3-q14','ssiap1-b3-q15');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q1', 0, 'Réarmer comme demandé — c''est sûrement un défaut technique');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q1', 1, 'Refuser, effectuer une levée de doute physique et consigner l''événement');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q1', 2, 'Appeler les pompiers sans rien faire d''autre');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q1', 3, 'Inhiber la zone 12 pour éviter les fausses alarmes');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q2', 0, 'Service de Sécurité Incendie');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q2', 1, 'Système de Sécurité Incendie');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q2', 2, 'Surveillance et Sécurité des Installations');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q2', 3, 'Système de Signalisation Intégrée');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q3', 0, 'Vrai');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q3', 1, 'Faux');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q4', 0, 'Porte coupe-feu à fermeture automatique');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q4', 1, 'Volet de désenfumage motorisé');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q4', 2, 'Déclencheur Manuel d''alarme (boîtier rouge)');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q4', 3, 'Clapet coupe-feu dans une gaine de ventilation');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b3-q5', 0, 'Feu de bois et papier (classe A)', 'Eau pulvérisée');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b3-q5', 1, 'Feu d''installation électrique', 'CO2');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b3-q5', 2, 'Feu de liquide (classe B)', 'Mousse');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b3-q5', 3, 'Feu polyvalent A+B+C', 'Poudre ABC');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b3-q6', 0, 'Catégorie A : détection totale + toutes fonctions sécurité');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b3-q6', 1, 'Catégorie B : détection partielle + toutes fonctions sécurité');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b3-q6', 2, 'Catégorie C : alarme générale sans détection auto');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b3-q6', 3, 'Catégorie E : alarme générale seule');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q7', 0, 'Contrôle visuel mensuel par l''exploitant');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q7', 1, 'Vérification technique annuelle par organisme agréé');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q7', 2, 'Épreuve hydraulique tous les 5 ans');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q7', 3, 'Remplacement automatique tous les 3 ans');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q7', 4, 'Vérification du plombage et de l''indicateur de pression');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b3-q9', 0, 'Sprinkler — déclenchement automatique dès 68°C');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b3-q9', 1, 'Extincteur portatif — première intervention humaine');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b3-q9', 2, 'RIA DN19/25 — deuxième intervention humaine');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b3-q9', 3, 'Colonne sèche ou humide — intervention des sapeurs-pompiers');
insert into public.question_categories (question_id, category_index, category_id, category_label) values ('ssiap1-b3-q10', 0, 'sdi', '🔍 SDI — Système de Détection');
insert into public.question_categories (question_id, category_index, category_id, category_label) values ('ssiap1-b3-q10', 1, 'smsi', '⚡ SMSI — Mise en Sécurité');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b3-q10', 0, 'Détecteur optique de fumée', 'sdi');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b3-q10', 1, 'Déclencheur Manuel (DM)', 'sdi');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b3-q10', 2, 'CMSI (Centralisateur)', 'smsi');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b3-q10', 3, 'Volet de désenfumage', 'smsi');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b3-q10', 4, 'ECS (Équipement de Contrôle)', 'sdi');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b3-q10', 5, 'Porte coupe-feu motorisée', 'smsi');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q11', 0, 'Un local à risque d''incendie');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q11', 1, 'L''emplacement d''un extincteur portatif');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q11', 2, 'Un poste de premiers secours');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q11', 3, 'Une sortie de secours équipée');
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b3-q12', 0, 'ÉTAPE 1 — Première action ?', '[{"text":"Réarmer l''alarme et attendre le matin","nextStep":99},{"text":"Alerter la hiérarchie et contacter l''astreinte technique","nextStep":1},{"text":"Évacuer immédiatement l''établissement","nextStep":99}]'::jsonb);
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b3-q12', 1, 'ÉTAPE 2 — En attendant l''intervention technique (délai 30 min) ?', '[{"text":"Ne rien faire — 30 min c''est court","nextStep":99},{"text":"Mettre en place des rondes renforcées dans les zones concernées","nextStep":2},{"text":"Couper le réseau sprinkler pour éviter les faux déclenchements","nextStep":99}]'::jsonb);
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b3-q12', 2, 'ÉTAPE 3 — L''anomalie est consignée. Que faire avant de quitter votre poste ?', '[{"text":"Consigner dans le registre de sécurité et la main courante, transmettre à la relève","nextStep":null},{"text":"Mettre seulement un post-it sur l''écran","nextStep":null},{"text":"Rien — la maintenance a géré","nextStep":null}]'::jsonb);
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q13', 0, 'Le déclenchement volontaire d''une alarme pour test');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q13', 1, 'La désactivation temporaire d''une zone de détection pour travaux');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q13', 2, 'La mise en service d''une nouvelle zone après installation');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q13', 3, 'La réinitialisation complète du système après alarme');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q14', 0, 'Vrai');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q14', 1, 'Faux');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q15', 0, 'Extincteur portatif');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q15', 1, 'Robinet d''Incendie Armé (RIA)');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q15', 2, 'Poste de premiers secours');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b3-q15', 3, 'Point d''alimentation colonne sèche');
commit;
