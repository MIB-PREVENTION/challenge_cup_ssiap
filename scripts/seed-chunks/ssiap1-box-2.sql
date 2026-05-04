begin;
-- module ssiap1-box-2 : ERP & IGH
insert into public.modules (id, level, title, subtitle, icon, color, display_order, is_active)
values ('ssiap1-box-2', 1, 'ERP & IGH', 'Réglementation, classification, obligations', '🏛️', 'from-blue-600 to-indigo-700', 1, true)
on conflict (id) do update set title=excluded.title, subtitle=excluded.subtitle, icon=excluded.icon;
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b2-q1', 'ssiap1-box-2', 'quiz', 'Classification ERP', 'Un ERP est classé selon deux critères principaux. Lesquels ?',
  null, null, 'Type = lettre selon l''activité (M=magasin, R=enseignement, O=hôtel...). Catégorie = de 1 à 5 selon l''effectif. Ces deux critères déterminent toutes les obligations réglementaires.',
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
  'ssiap1-b2-q2', 'ssiap1-box-2', 'scenario', 'Travaux et SSI', 'Quelle est la bonne conduite à tenir ?',
  'Des travaux de rénovation prévoient d''ouvrir une trémie de 0,5m² dans un plancher coupe-feu 1h30 pour faire passer des câbles. Le chef de chantier dit que c''est "un petit percement sans importance".', null, 'Toute modification impactant la sécurité incendie (structure CF, SSI) nécessite une autorisation préalable de la commission. Le permis de feu est obligatoire pour les travaux par points chauds.',
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
  'ssiap1-b2-q3', 'ssiap1-box-2', 'find-intruder', 'Type ERP inexistant', 'Parmi ces types d''ERP, lequel N''EXISTE PAS dans la réglementation française ?',
  null, null, 'Le type Z n''existe pas. Les vrais types vont de J à Y : J(personnes âgées), L(salles), M(magasins), N(restaurants), O(hôtels), P(dancings), R(enseignement), S(bibliothèques), T(expo), U(soins), V(culte), W(bureaux), X(sports), Y(musées).',
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
  'ssiap1-b2-q4', 'ssiap1-box-2', 'true-false', 'IGH habitation', 'Un immeuble d''habitation est classé IGH dès que le plancher bas du dernier niveau habité dépasse 28 mètres.',
  null, null, 'FAUX — Seuil IGH habitation = 50 mètres. Le seuil de 28 m s''applique aux IGH à usage de bureaux, hôtels, établissements d''enseignement. Ces seuils conditionnent des exigences très renforcées.',
  1, null::integer[],
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
  'ssiap1-b2-q5', 'ssiap1-box-2', 'matching', 'Classes IGH', 'Associez chaque sigle IGH à son usage :',
  null, null, 'GHA=habitation (>50m), GHO=hôtels, GHW=bureaux, GHU=sanitaire, GHR=enseignement, GHS=archives, GHZ=mixte. Le code GH + lettre = type d''usage.',
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
  'ssiap1-b2-q6', 'ssiap1-box-2', 'multiple-select', 'Obligations IGH', 'Quelles obligations sont SPÉCIFIQUES aux IGH ? (plusieurs réponses)',
  null, null, 'SSIAP 24h/24 ✅, compartimentage ✅, SSI cat.A ✅, colonnes humides ✅. L''exercice trimestriel n''est pas une obligation spécifique IGH — 2 fois/an en ERP courant.',
  null, array[0,1,2,4]::integer[],
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
  'ssiap1-b2-q7', 'ssiap1-box-2', 'sequence', 'Instruction dossier ERP', 'Remettez dans l''ordre les étapes d''instruction d''une demande d''ouverture d''ERP :',
  null, null, 'Sans avis FAVORABLE de la commission, le maire ne peut pas délivrer l''autorisation. Un avis défavorable = fermeture administrative possible.',
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
  'ssiap1-b2-q8', 'ssiap1-box-2', 'fill-blank', 'Compartimentage IGH', 'Complétez la règle de compartimentage des IGH :',
  null, null, 'Article GH 10 : 2 500 m² max et 3 niveaux max par compartiment. Les parois délimitatives doivent être CF 2h minimum.',
  null, null::integer[],
  null::integer[], array['2500','3']::text[],
  null::integer[], array['2500','3','5000','2','1000','4','1500','6']::text[],
  'Dans un IGH, chaque compartiment ne doit pas dépasser %1% m² de surface et %2% niveaux en superposition.', null, null,
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
  'ssiap1-b2-q9', 'ssiap1-box-2', 'ranking', 'Fréquence des visites de commission', 'Classez ces catégories d''ERP par fréquence de visite (de la plus fréquente à la moins fréquente) :',
  null, null, '1ère et 2ème cat. = annuelle. 3ème cat. = tous les 2 ans. 4ème cat. = tous les 3 ans. La 5ème catégorie est dispensée de passage en commission sauf lors de l''ouverture.',
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
  'ssiap1-b2-q10', 'ssiap1-box-2', 'categories', 'Documents ERP', 'Classez ces documents selon leur caractère obligatoire en ERP :',
  null, null, 'Registre ✅, Notice ✅, Plans ✅ = obligatoires. Les catalogues et revues ont une valeur documentaire mais ne sont pas des obligations réglementaires.',
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
  'ssiap1-b2-q11', 'ssiap1-box-2', 'image-identify', 'Panneau vert personnes', 'Ce pictogramme vert représente :',
  null, null, 'ISO 7010 E007 = Point de rassemblement. Lieu où tous les occupants doivent se regrouper après évacuation pour permettre le comptage et informer les secours.',
  1, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  'assembly', 'ISO 7010 — E007', 10
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
  'ssiap1-b2-q12', 'ssiap1-box-2', 'decision', 'Registre non tenu', 'Quelle est la marche à suivre ?',
  'Vous prenez votre poste de SSIAP. En consultant le registre de sécurité, vous constatez qu''il n''a pas été rempli depuis 5 semaines et que plusieurs vérifications périodiques ne sont pas documentées.', null, 'Signaler → Rechercher les preuves existantes → Programmer les vérifications manquantes. La falsification de registre est une infraction pénale.',
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
  'ssiap1-b2-q13', 'ssiap1-box-2', 'true-false', 'Permis de feu', 'Dans un ERP, le permis de feu peut être accordé verbalement si le responsable sécurité est présent.',
  null, null, 'FAUX — Le permis de feu (GN13) est TOUJOURS écrit, daté, signé des deux parties (donneur d''ordre + exécutant). Aucune exception. Un permis verbal n''a aucune valeur juridique.',
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
  'ssiap1-b2-q14', 'ssiap1-box-2', 'scenario', 'Commission de sécurité', 'Le directeur a-t-il raison ?',
  'La commission de sécurité émet un avis défavorable lors de la visite périodique d''un ERP de 1ère catégorie. Le directeur affirme que la commission "n''a pas le pouvoir de fermer".', null, 'La commission émet un avis (favorable ou défavorable). En cas d''avis défavorable, le maire PEUT prendre un arrêté de fermeture. C''est le maire qui décide, mais il engage sa responsabilité en maintenant ouvert un ERP dangereux.',
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
insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  'ssiap1-b2-q15', 'ssiap1-box-2', 'image-identify', 'Flèche verte personnage', 'Ce panneau vert avec personnage et flèche indique :',
  null, null, 'ISO 7010 E003 = Direction vers une issue de secours. Ces panneaux jalonnent tout le cheminement d''évacuation. Ils doivent être visibles en permanence, de jour comme de nuit (rétro-éclairés ou luminescents).',
  1, null::integer[],
  null::integer[], null::text[],
  null::integer[], null::text[],
  null, null, null,
  'exit-direction', 'ISO 7010 — E003', 14
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();
delete from public.question_options        where question_id in ('ssiap1-b2-q1','ssiap1-b2-q2','ssiap1-b2-q3','ssiap1-b2-q4','ssiap1-b2-q5','ssiap1-b2-q6','ssiap1-b2-q7','ssiap1-b2-q8','ssiap1-b2-q9','ssiap1-b2-q10','ssiap1-b2-q11','ssiap1-b2-q12','ssiap1-b2-q13','ssiap1-b2-q14','ssiap1-b2-q15');
delete from public.question_items          where question_id in ('ssiap1-b2-q1','ssiap1-b2-q2','ssiap1-b2-q3','ssiap1-b2-q4','ssiap1-b2-q5','ssiap1-b2-q6','ssiap1-b2-q7','ssiap1-b2-q8','ssiap1-b2-q9','ssiap1-b2-q10','ssiap1-b2-q11','ssiap1-b2-q12','ssiap1-b2-q13','ssiap1-b2-q14','ssiap1-b2-q15');
delete from public.question_pairs          where question_id in ('ssiap1-b2-q1','ssiap1-b2-q2','ssiap1-b2-q3','ssiap1-b2-q4','ssiap1-b2-q5','ssiap1-b2-q6','ssiap1-b2-q7','ssiap1-b2-q8','ssiap1-b2-q9','ssiap1-b2-q10','ssiap1-b2-q11','ssiap1-b2-q12','ssiap1-b2-q13','ssiap1-b2-q14','ssiap1-b2-q15');
delete from public.question_categories     where question_id in ('ssiap1-b2-q1','ssiap1-b2-q2','ssiap1-b2-q3','ssiap1-b2-q4','ssiap1-b2-q5','ssiap1-b2-q6','ssiap1-b2-q7','ssiap1-b2-q8','ssiap1-b2-q9','ssiap1-b2-q10','ssiap1-b2-q11','ssiap1-b2-q12','ssiap1-b2-q13','ssiap1-b2-q14','ssiap1-b2-q15');
delete from public.question_category_items where question_id in ('ssiap1-b2-q1','ssiap1-b2-q2','ssiap1-b2-q3','ssiap1-b2-q4','ssiap1-b2-q5','ssiap1-b2-q6','ssiap1-b2-q7','ssiap1-b2-q8','ssiap1-b2-q9','ssiap1-b2-q10','ssiap1-b2-q11','ssiap1-b2-q12','ssiap1-b2-q13','ssiap1-b2-q14','ssiap1-b2-q15');
delete from public.question_decision_steps where question_id in ('ssiap1-b2-q1','ssiap1-b2-q2','ssiap1-b2-q3','ssiap1-b2-q4','ssiap1-b2-q5','ssiap1-b2-q6','ssiap1-b2-q7','ssiap1-b2-q8','ssiap1-b2-q9','ssiap1-b2-q10','ssiap1-b2-q11','ssiap1-b2-q12','ssiap1-b2-q13','ssiap1-b2-q14','ssiap1-b2-q15');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q1', 0, 'La hauteur des bâtiments et leur surface');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q1', 1, 'L''activité exercée (type) et l''effectif maximal accueilli (catégorie)');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q1', 2, 'La date de construction et le nombre d''étages');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q1', 3, 'La commune et la distance aux secours');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q2', 0, 'Accepter les travaux — c''est effectivement mineur');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q2', 1, 'Exiger un permis de feu et une demande d''autorisation à la commission de sécurité avant tout début');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q2', 2, 'Autoriser à condition de reboucher immédiatement après');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q2', 3, 'Appeler les pompiers pour avis verbal');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q3', 0, 'Type M — Magasins et centres commerciaux');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q3', 1, 'Type O — Hôtels et pensions de famille');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q3', 2, 'Type Z — Zones industrielles et entrepôts');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q3', 3, 'Type U — Établissements de soins');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q4', 0, 'Vrai');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q4', 1, 'Faux');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b2-q5', 0, 'GHA', 'Habitation');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b2-q5', 1, 'GHO', 'Hôtels et résidences');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b2-q5', 2, 'GHW', 'Bureaux');
insert into public.question_pairs (question_id, pair_index, left_text, right_text) values ('ssiap1-b2-q5', 3, 'GHU', 'Établissements sanitaires');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q6', 0, 'Service de sécurité SSIAP 24h/24 et 7j/7');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q6', 1, 'Compartimentage maximum 2 500 m² sur 3 niveaux');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q6', 2, 'SSI de catégorie A obligatoire');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q6', 3, 'Exercice d''évacuation trimestriel');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q6', 4, 'Colonnes en charge (humides) aux étages');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b2-q7', 0, 'Dépôt du dossier (notice sécurité + plans)');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b2-q7', 1, 'Instruction technique par les services');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b2-q7', 2, 'Visite et avis de la commission de sécurité');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b2-q7', 3, 'Délivrance de l''autorisation d''ouverture par le maire');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b2-q9', 0, '1ère catégorie — visite annuelle');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b2-q9', 1, '2ème catégorie — visite annuelle');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b2-q9', 2, '3ème catégorie — visite tous les 2 ans');
insert into public.question_items (question_id, item_index, item_text) values ('ssiap1-b2-q9', 3, '4ème catégorie — visite tous les 3 ans');
insert into public.question_categories (question_id, category_index, category_id, category_label) values ('ssiap1-b2-q10', 0, 'obligatoire', '📌 Obligatoire réglementairement');
insert into public.question_categories (question_id, category_index, category_id, category_label) values ('ssiap1-b2-q10', 1, 'non', '💡 Utile mais non obligatoire');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b2-q10', 0, 'Registre de sécurité', 'obligatoire');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b2-q10', 1, 'Notice descriptive de sécurité', 'obligatoire');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b2-q10', 2, 'Plan de masse à jour', 'obligatoire');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b2-q10', 3, 'Catalogue équipements', 'non');
insert into public.question_category_items (question_id, item_index, item_text, correct_category) values ('ssiap1-b2-q10', 4, 'Revue professionnelle incendie', 'non');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q11', 0, 'Une zone de repos pour le personnel');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q11', 1, 'Le point de rassemblement après évacuation');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q11', 2, 'Un vestiaire collectif');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q11', 3, 'Un accès réservé aux secours');
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b2-q12', 0, 'ÉTAPE 1 — Première action immédiate ?', '[{"text":"Remplir les dates manquantes rétrospectivement","nextStep":99},{"text":"Documenter l''état des lacunes et alerter la hiérarchie","nextStep":1},{"text":"Attendre la prochaine commission pour signaler","nextStep":99}]'::jsonb);
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b2-q12', 1, 'ÉTAPE 2 — Les rapports de vérification technique (extincteurs, SSI) sont absents.', '[{"text":"Inventer des données vraisemblables","nextStep":99},{"text":"Contacter les entreprises de maintenance pour obtenir les copies","nextStep":2},{"text":"Signaler à la commission sans attendre","nextStep":99}]'::jsonb);
insert into public.question_decision_steps (question_id, step_index, step_question, options) values ('ssiap1-b2-q12', 2, 'ÉTAPE 3 — Une vérification annuelle d''extincteurs est dépassée de 2 mois.', '[{"text":"Programmer immédiatement la vérification et consigner dans le registre","nextStep":null},{"text":"Attendre que quelqu''un s''en aperçoive","nextStep":null},{"text":"Fermer l''établissement","nextStep":null}]'::jsonb);
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q13', 0, 'Vrai');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q13', 1, 'Faux');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q14', 0, 'Oui — la commission ne fait que des recommandations');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q14', 1, 'Non — un avis défavorable peut entraîner une fermeture administrative par le maire');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q14', 2, 'Oui — seuls les tribunaux peuvent fermer un ERP');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q14', 3, 'Non — c''est la préfecture qui décide directement');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q15', 0, 'Le sens de circulation habituel');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q15', 1, 'La direction vers une issue de secours');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q15', 2, 'Le poste de premiers secours');
insert into public.question_options (question_id, option_index, option_text) values ('ssiap1-b2-q15', 3, 'L''accès au stationnement');
commit;
