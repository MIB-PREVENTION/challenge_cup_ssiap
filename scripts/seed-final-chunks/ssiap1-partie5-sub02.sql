begin;
-- SSIAP 1 — Concrétisation des acquis (partie 5, sub 2/2, 6 questions)
insert into public.questions (
  id, module_id, type, question, explanation, correct_answer, correct_answers, tags, display_order
) values
('ssiap1-q187', 'ssiap1-partie5', 'quiz', 'Que signifie l''acronyme TRI dans le contexte de la gestion d''une évacuation d''urgence avec des blessés ?', 'Le triage médical (ou tri) est la procédure de classement des victimes par ordre de priorité de prise en charge médicale lors d''un accident avec de nombreuses victimes (AMV - Accident à Multiples Victimes). Les catégories sont : T1 (urgence absolue, pronostic vital engagé, intervention immédiate) ; T2 (urgence relative, peut attendre quelques heures) ; T3 (urgence différée, blessures légères) ; T4 (décédés ou blessures incompatibles avec la survie). L''agent SSIAP n''effectue pas lui-même le triage médical (c''est le rôle du médecin SAMU) mais doit connaître ce concept pour communiquer efficacement avec les secours et organiser les zones de regroupement des victimes.', 1, null::integer[], array['theme1','seq1','POI, exercices d''évacuation, plans','Exercices et plans']::text[], 20),
('ssiap1-q188', 'ssiap1-partie5', 'multiple-select', 'L''agent SSIAP est responsable de la sécurité incendie dans son établissement. Quelles sont ses limites de responsabilité ? (plusieurs réponses possibles)', 'La responsabilité de l''agent SSIAP est réelle mais circonscrite : il est responsable de l''exécution correcte de ses missions définies par le POI et sa fiche de poste ; sa responsabilité pénale peut être engagée en cas de faute (non-application des procédures, négligence grave conduisant à un sinistre) ; sa responsabilité se limite à ses actes ou omissions personnels (il n''est pas responsable des défaillances de l''employeur, du matériel non entretenu, des décisions de la direction). La responsabilité est partagée entre l''agent, son responsable SSIAP 2/3, et la direction de l''établissement. L''agent n''est pas le seul responsable mais sa responsabilité propre est bien réelle.', null, array[0,1,3]::integer[], array['theme1','seq1','POI, exercices d''évacuation, plans','Exercices et plans']::text[], 21),
('ssiap1-q191', 'ssiap1-partie5', 'quiz', 'L''arrêté du 2 mai 2005 est relatif à :', 'L''arrêté du 2 mai 2005 est relatif aux missions, à l''emploi et à la qualification du personnel permanent des Services de Sécurité Incendie et d''Assistance aux Personnes (SSIAP). Il crée les trois niveaux SSIAP 1, 2, 3 et définit leurs missions, formations et conditions d''exercice. Il ne traite ni des risques électriques, ni des ICPE, ni de la construction des IGH (qui font l''objet d''autres textes réglementaires).', 1, null::integer[], array['theme1','seq1','POI, exercices d''évacuation, plans','Exercices et plans']::text[], 22),
('ssiap1-q193', 'ssiap1-partie5', 'quiz', 'Quel est l''objectif d''un défibrillateur automatisé externe (DEA/DAE) dans un ERP ?', 'Le DEA (Défibrillateur Automatisé Externe ou DAE) est un appareil destiné à analyser le rythme cardiaque et à délivrer un choc électrique (défibrillation) pour rétablir un rythme cardiaque normal lors d''une fibrillation ventriculaire ou d''une tachycardie ventriculaire sans pouls (les deux principales causes d''arrêt cardiaque subitement récupérables). Le DEA guide l''utilisateur par des instructions vocales. Il est utilisable par tout citoyen sans formation médicale. Les ERP de catégorie 1 à 4 sont tenus d''en être équipés. L''agent SSIAP, formé PSC1/PSE1, doit savoir utiliser un DEA.', 1, null::integer[], array['theme1','seq1','POI, exercices d''évacuation, plans','Exercices et plans']::text[], 23),
('ssiap1-q198', 'ssiap1-partie5', 'quiz', 'La réglementation impose des vérifications périodiques des installations de sécurité par des organismes agréés. Ces vérifications sont différentes des contrôles visuels effectués par l''agent SSIAP car elles :', 'Les vérifications périodiques réglementaires (annuelles, triennales ou quinquennales selon les installations) sont réalisées par des techniciens ou organismes habilités (bureau de contrôle, technicien certifié), avec des instruments de mesure et des procédures normalisées. Elles couvrent toutes les installations : électricité, gaz, SSI, ascenseurs, extincteurs, colonnes sèches, etc. Les rapports de vérification sont consignés dans le registre de sécurité et présentés à la commission de sécurité. Les contrôles visuels de l''agent SSIAP (rondes) sont complémentaires mais n''ont pas la même valeur réglementaire : ils permettent de détecter les anomalies visibles entre deux vérifications professionnelles.', 1, null::integer[], array['theme1','seq1','POI, exercices d''évacuation, plans','Exercices et plans']::text[], 24),
('ssiap1-q199', 'ssiap1-partie5', 'quiz', 'Dans un ERP comportant des locaux à sommeil (hôtel, résidence), quelle procédure d''évacuation spécifique peut être mise en place ?', 'Dans les ERP avec locaux à sommeil (hôtels, EHPAD, hôpitaux), l''évacuation simultanée de tous les occupants peut être dangereuse et difficile (personnes endormies, mobilité réduite, soins en cours). La réglementation prévoit donc une évacuation progressive ou défensive : évacuation immédiate des personnes dans et autour de la zone sinistrée, puis extension progressive selon le développement du sinistre ; ou confinement défensif dans les chambres (portes fermées) en attendant l''intervention des pompiers. Ces procédures, validées par la commission de sécurité, doivent figurer dans le POI et faire l''objet d''exercices spécifiques. Le compartimentage renforcé de ces établissements est conçu pour permettre ce type de stratégie.', 1, null::integer[], array['theme1','seq1','POI, exercices d''évacuation, plans','Exercices et plans']::text[], 25)
on conflict (id) do update set
  type=excluded.type, question=excluded.question, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  tags=excluded.tags, display_order=excluded.display_order, updated_at=now();
delete from public.question_options where question_id in ('ssiap1-q187','ssiap1-q188','ssiap1-q191','ssiap1-q193','ssiap1-q198','ssiap1-q199');
insert into public.question_options (question_id, option_index, option_text) values
('ssiap1-q187', 0, 'Transmission Radio d''Incendie'),
('ssiap1-q187', 1, 'Triage, classement des victimes par priorité de prise en charge médicale'),
('ssiap1-q187', 2, 'Tableau de Référence des Incidents'),
('ssiap1-q187', 3, 'Technique de Réduction des Incendies'),
('ssiap1-q187', 4, 'Aucune de ces réponses n''est correcte'),
('ssiap1-q188', 0, 'Il est responsable de l''exécution de ses missions selon le POI et ses attributions'),
('ssiap1-q188', 1, 'Il engage sa responsabilité pénale s''il n''applique pas les procédures en cas d''incendie'),
('ssiap1-q188', 2, 'Il est seul responsable de tous les sinistres dans l''établissement'),
('ssiap1-q188', 3, 'Sa responsabilité est limitée aux actes qu''il a personnellement effectués ou omis'),
('ssiap1-q188', 4, 'Il n''a aucune responsabilité, c''est uniquement celle de l''employeur'),
('ssiap1-q191', 0, 'La prévention des risques électriques dans les ERP'),
('ssiap1-q191', 1, 'Aucune de ces réponses n''est correcte'),
('ssiap1-q191', 2, 'La réglementation des ICPE (Installations Classées)'),
('ssiap1-q191', 3, 'La construction des IGH'),
('ssiap1-q193', 0, 'Mesurer le rythme cardiaque pour diagnostiquer une pathologie'),
('ssiap1-q193', 1, 'Délivrer un choc électrique pour rétablir un rythme cardiaque normal en cas d''arrêt cardiaque par fibrillation'),
('ssiap1-q193', 2, 'Stimuler la respiration en cas d''étouffement'),
('ssiap1-q193', 3, 'Surveiller la tension artérielle en continu'),
('ssiap1-q193', 4, 'Aucune de ces réponses n''est correcte'),
('ssiap1-q198', 0, 'Sont moins importantes que les rondes quotidiennes'),
('ssiap1-q198', 1, 'Sont réalisées par des techniciens qualifiés avec des équipements spécialisés, donnent lieu à des rapports consignés au registre de sécurité, et ont une valeur réglementaire'),
('ssiap1-q198', 2, 'Peuvent être effectuées par n''importe quel occupant'),
('ssiap1-q198', 3, 'Ne concernent que les extincteurs et les BAES'),
('ssiap1-q198', 4, 'Aucune de ces réponses n''est correcte'),
('ssiap1-q199', 0, 'Évacuation immédiate et totale de tous les occupants dès le premier signal'),
('ssiap1-q199', 1, 'Évacuation progressive ou défensive par zones, en commençant par les occupants les plus proches du sinistre'),
('ssiap1-q199', 2, 'Confinement de tous les occupants dans les chambres pendant toute la durée du sinistre'),
('ssiap1-q199', 3, 'Évacuation uniquement en cas d''alarme générale de niveau 2'),
('ssiap1-q199', 4, 'Aucune de ces réponses n''est correcte');
commit;
