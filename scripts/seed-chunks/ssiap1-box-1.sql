begin;
-- module ssiap1-box-1 : Le Feu
insert into public.modules (id, level, title, subtitle, icon, color, display_order, is_active)
values ('ssiap1-box-1', 1, 'Le Feu', 'Combustion, classes, propagation', '🔥', 'from-red-500 to-orange-600', 0, true)
on conflict (id) do update set title=excluded.title, subtitle=excluded.subtitle, icon=excluded.icon;
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b1-q1', 'ssiap1-box-1', 'scenario', 'Odeur suspecte', 'Quelle est votre PREMIÈRE action ?',
  'Lors d''une ronde de nuit, vous sentez une forte odeur de brûlé dans le couloir du 2ème étage. Vous approchez d''une porte et constatez qu''elle est chaude au toucher. Aucune fumée visible.', null, 'Porte chaude = feu violent possible derrière. On ne l''ouvre JAMAIS. On déclenche l''alarme en priorité puis on alerte le PC.',
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
  'ssiap1-b1-q2', 'ssiap1-box-1', 'quiz', 'Tétraèdre du feu', 'Quels sont les 4 éléments du tétraèdre du feu ?',
  null, null, 'Tétraèdre = combustible + comburant (O2) + énergie d''activation + réaction en chaîne. Supprimer l''un des 4 éteint le feu.',
  0, null::integer[],
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
  'ssiap1-b1-q3', 'ssiap1-box-1', 'multiple-select', 'Facteurs de propagation', 'Quels facteurs ACCÉLÈRENT la propagation d''un incendie ? (plusieurs réponses)',
  null, null, 'Charge calorifique ✅, courants d''air ✅, géométrie ✅, air sec ✅. La couleur des murs n''a aucun impact sur la propagation ❌.',
  null, array[0,2,3,4]::integer[],
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
  'ssiap1-b1-q4', 'ssiap1-box-1', 'find-intruder', 'Classe de feu inexistante', 'Parmi ces classes de feu, laquelle N''EXISTE PAS dans la nomenclature européenne actuelle ?',
  null, null, 'La classe E n''existe plus depuis la révision européenne. Classes valides : A (solides), B (liquides), C (gaz), D (métaux), F (huiles cuisson).',
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
  'ssiap1-b1-q5', 'ssiap1-box-1', 'true-false', 'Fumée et mortalité', 'La fumée est la principale cause de décès lors d''un incendie, avant les brûlures directes.',
  null, null, 'VRAI — 80% des victimes meurent d''intoxication aux fumées (CO, HCN, CO2...) avant d''être atteintes par les flammes. Les fumées désorientation et provoquent la perte de conscience.',
  0, null::integer[],
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
  'ssiap1-b1-q6', 'ssiap1-box-1', 'matching', 'Agents extincteurs', 'Associez chaque agent extincteur à son mode d''action principal :',
  null, null, 'Eau = refroidit la base. CO2 = chasse l''oxygène. Poudre = interrompt la réaction en chaîne. Mousse = double action couvrant + refroidissant.',
  null, null::integer[],
  null::integer[], null::text[],
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
  'ssiap1-b1-q7', 'ssiap1-box-1', 'sequence', 'Phases d''un incendie', 'Remettez dans l''ordre chronologique les phases de développement d''un incendie :',
  null, null, 'Naissance → Développement → Flashover (500°C au plafond) → Décrescence. Le flashover est le point de non-retour : tous les matériaux s''enflamment simultanément.',
  null, null::integer[],
  array[0,1,2,3]::integer[], null::text[],
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
  'ssiap1-b1-q8', 'ssiap1-box-1', 'fill-blank', 'Réaction et résistance', 'Complétez ces deux notions fondamentales :',
  null, null, 'Réaction = comment le matériau se comporte face à une flamme (classement Euroclasses A à F). Résistance = durée en minutes/heures où la structure tient (REI 30, 60, 120...).',
  null, null::integer[],
  null::integer[], array['réaction au feu','résistance au feu']::text[],
  null::integer[], array['réaction au feu','résistance au feu','conductivité','inflammabilité','opacité','résistance mécanique']::text[],
  'La %1% d''un matériau évalue sa participation à la naissance et au développement du feu, tandis que la %2% évalue la durée pendant laquelle il conserve sa fonction.', null, null,
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
  'ssiap1-b1-q9', 'ssiap1-box-1', 'ranking', 'Résistance des matériaux', 'Classez ces matériaux du PLUS résistant au MOINS résistant face au feu :',
  null, null, 'Béton > Brique > Bois (carbonise mais reste porteur un moment) > Acier nu (perd 50% de sa résistance dès 400-600°C).',
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
  'ssiap1-b1-q10', 'ssiap1-box-1', 'categories', 'Extincteur adapté', 'Classez ces agents extincteurs selon leur utilisation sur un feu d''origine électrique :',
  null, null, 'CO2 ✅ et Poudre ✅ = non conducteurs. Eau jet plein ❌, eau pulvérisée conductrice ❌, mousse ❌ = risque d''électrocution grave.',
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
  'ssiap1-b1-q11', 'ssiap1-box-1', 'image-identify', 'Panneau triangulaire jaune', 'Ce panneau triangulaire jaune signale :',
  null, null, 'Triangle jaune ISO 7010 W012 = AVERTISSEMENT danger électrique. Présence de tension dangereuse. Ne jamais intervenir sans habilitation électrique.',
  1, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  'electrical-hazard', 'ISO 7010 — W012', 10
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
  'ssiap1-b1-q12', 'ssiap1-box-1', 'decision', 'Découverte d''incendie', 'Arbre de décision — étape par étape :',
  'Vous êtes en patrouille. Vous découvrez de la fumée qui sort sous la porte d''un local technique. La porte est tiède. Vous êtes seul.', null, 'Alarme en 1er → Intervention si feu petit et sortie disponible → Abandon si le feu prend de l''ampleur. La vie prime sur les biens.',
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
  'ssiap1-b1-q13', 'ssiap1-box-1', 'true-false', 'Backdraft vs Flashover', 'Le backdraft et le flashover sont deux noms différents pour désigner le même phénomène.',
  null, null, 'FAUX — Backdraft = explosion due à un apport soudain d''oxygène dans un local enfumé. Flashover = embrasement généralisé par montée en température (500°C au plafond). Deux phénomènes distincts et tous deux mortels.',
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
  'ssiap1-b1-q14', 'ssiap1-box-1', 'scenario', 'Choix de l''extincteur', 'Quel extincteur utilisez-vous et pourquoi ?',
  'Dans la salle serveur, un câble électrique prend feu. Vous disposez d''un extincteur à eau pulvérisée non additif et d''un extincteur CO2. Les flammes font 40 cm de haut.', null, 'CO2 = agent non conducteur, idéal pour les locaux électriques/informatiques. L''eau conduit l''électricité → risque d''électrocution. Exception : eau pulvérisée avec additif anti-électrostatique (vérifier le marquage "feux électriques").',
  1, null::integer[],
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
delete from public.question_options        where question_id in ('ssiap1-b1-q1','ssiap1-b1-q2','ssiap1-b1-q3','ssiap1-b1-q4','ssiap1-b1-q5','ssiap1-b1-q6','ssiap1-b1-q7','ssiap1-b1-q8','ssiap1-b1-q9','ssiap1-b1-q10','ssiap1-b1-q11','ssiap1-b1-q12','ssiap1-b1-q13','ssiap1-b1-q14');
delete from public.question_items          where question_id in ('ssiap1-b1-q1','ssiap1-b1-q2','ssiap1-b1-q3','ssiap1-b1-q4','ssiap1-b1-q5','ssiap1-b1-q6','ssiap1-b1-q7','ssiap1-b1-q8','ssiap1-b1-q9','ssiap1-b1-q10','ssiap1-b1-q11','ssiap1-b1-q12','ssiap1-b1-q13','ssiap1-b1-q14');
delete from public.question_pairs          where question_id in ('ssiap1-b1-q1','ssiap1-b1-q2','ssiap1-b1-q3','ssiap1-b1-q4','ssiap1-b1-q5','ssiap1-b1-q6','ssiap1-b1-q7','ssiap1-b1-q8','ssiap1-b1-q9','ssiap1-b1-q10','ssiap1-b1-q11','ssiap1-b1-q12','ssiap1-b1-q13','ssiap1-b1-q14');
delete from public.question_categories     where question_id in ('ssiap1-b1-q1','ssiap1-b1-q2','ssiap1-b1-q3','ssiap1-b1-q4','ssiap1-b1-q5','ssiap1-b1-q6','ssiap1-b1-q7','ssiap1-b1-q8','ssiap1-b1-q9','ssiap1-b1-q10','ssiap1-b1-q11','ssiap1-b1-q12','ssiap1-b1-q13','ssiap1-b1-q14');
delete from public.question_category_items where question_id in ('ssiap1-b1-q1','ssiap1-b1-q2','ssiap1-b1-q3','ssiap1-b1-q4','ssiap1-b1-q5','ssiap1-b1-q6','ssiap1-b1-q7','ssiap1-b1-q8','ssiap1-b1-q9','ssiap1-b1-q10','ssiap1-b1-q11','ssiap1-b1-q12','ssiap1-b1-q13','ssiap1-b1-q14');
delete from public.question_decision_steps where question_id in ('ssiap1-b1-q1','ssiap1-b1-q2','ssiap1-b1-q3','ssiap1-b1-q4','ssiap1-b1-q5','ssiap1-b1-q6','ssiap1-b1-q7','ssiap1-b1-q8','ssiap1-b1-q9','ssiap1-b1-q10','ssiap1-b1-q11','ssiap1-b1-q12','ssiap1-b1-q13','ssiap1-b1-q14');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q1', 0, 'Ouvrir la porte pour vérifier l''intérieur');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q1', 1, 'Ne pas ouvrir — déclencher l''alarme et alerter le PC de sécurité');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q1', 2, 'Chercher un extincteur avant tout');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q1', 3, 'Appeler vos collègues pour confirmation');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q2', 0, 'Combustible, comburant, énergie d''activation, réaction en chaîne');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q2', 1, 'Eau, air, terre, feu');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q2', 2, 'Flamme, fumée, chaleur, gaz');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q2', 3, 'Bois, oxygène, chaleur, vent');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q3', 0, 'La charge calorifique élevée');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q3', 1, 'La couleur des murs');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q3', 2, 'Les courants d''air et la ventilation');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q3', 3, 'La géométrie et la hauteur du local');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q3', 4, 'L''humidité de l''air faible');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q4', 0, 'Classe A — feux de solides');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q4', 1, 'Classe B — feux de liquides');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q4', 2, 'Classe E — feux d''installations électriques');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q4', 3, 'Classe F — feux d''huiles de cuisson');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q5', 0, 'Vrai');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q5', 1, 'Faux');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b1-q6', 0, 'Eau pulvérisée', 'Refroidissement');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b1-q6', 1, 'CO2', 'Étouffement (chasse O2)');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b1-q6', 2, 'Poudre ABC', 'Inhibition chimique');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b1-q6', 3, 'Mousse', 'Étouffement + refroidissement');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b1-q7', 0, 'Feu naissant (< 1m²)');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b1-q7', 1, 'Phase de développement (flammes vives)');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b1-q7', 2, 'Embrasement généralisé — flashover');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b1-q7', 3, 'Phase de décrescence');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b1-q9', 0, 'Béton armé avec protection');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b1-q9', 1, 'Brique réfractaire pleine');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b1-q9', 2, 'Bois lamellé collé (carbonisation lente)');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b1-q9', 3, 'Acier nu sans protection');
insert into public.question_categories (question_id, category_index, category_id, category_label) values ('ssiap1-b1-q10', 0, 'ok', '✅ Utilisable sur feu électrique');
insert into public.question_categories (question_id, category_index, category_id, category_label) values ('ssiap1-b1-q10', 1, 'nok', '❌ INTERDIT sur feu électrique');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b1-q10', 0, 'CO2', 'ok');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b1-q10', 1, 'Poudre ABC (sèche)', 'ok');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b1-q10', 2, 'Eau jet plein', 'nok');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b1-q10', 3, 'Eau pulvérisée conductrice', 'nok');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b1-q10', 4, 'Mousse', 'nok');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q11', 0, 'Un moyen de lutte incendie à proximité');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q11', 1, 'Un danger électrique — zone à risque');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q11', 2, 'Un défibrillateur accessible');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q11', 3, 'Une coupure d''urgence électricité');
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b1-q12', 0, 'ÉTAPE 1 — Que faites-vous en premier ?', '[{"text":"Ouvrir pour voir l''étendue du feu","nextStep":99},{"text":"Déclencher l''alarme et appeler le PC sécurité","nextStep":1},{"text":"Prendre un extincteur avant tout","nextStep":99}]'::jsonb);
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b1-q12', 1, 'ÉTAPE 2 — La porte est tiède (pas chaude). Pouvez-vous intervenir ?', '[{"text":"Non, évacuer sans intervenir","nextStep":99},{"text":"Oui si feu naissant, sortie dans le dos, extincteur adapté","nextStep":2},{"text":"Oui toujours, c''est mon rôle","nextStep":99}]'::jsonb);
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b1-q12', 2, 'ÉTAPE 3 — L''extincteur est vide après 15 secondes, le feu progresse. Que faites-vous ?', '[{"text":"Continuer avec les mains","nextStep":null},{"text":"Abandonner l''intervention, évacuer, fermer la porte","nextStep":null},{"text":"Attendre les pompiers sur place","nextStep":null}]'::jsonb);
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q13', 0, 'Vrai');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q13', 1, 'Faux');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q14', 0, 'L''eau pulvérisée — elle refroidit bien');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q14', 1, 'Le CO2 — non conducteur, adapté aux feux électriques');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q14', 2, 'Les deux ensemble pour plus d''efficacité');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b1-q14', 3, 'Ni l''un ni l''autre — évacuer sans intervenir');
commit;
