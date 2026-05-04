begin;
-- SSIAP 1 — Les installations techniques (partie 3, sub 2/2, 2 questions)
insert into public.questions (
  id, module_id, type, question, explanation, correct_answer, correct_answers, tags, display_order
) values
('ssiap1-q175', 'ssiap1-partie3', 'quiz', 'La mise hors service temporaire (inhibition/isolement) d''un détecteur lors de travaux doit obligatoirement s''accompagner de :', 'L''inhibition d''un détecteur (mise en sécurité temporaire lors de travaux, peinture, poussières) supprime la surveillance automatique d''une zone. Pour compenser cette perte de vigilance, des mesures compensatoires doivent être mises en place : augmentation de la fréquence des rondes dans la zone concernée ; présence physique d''un veilleur lors des travaux ; vérification que la zone est exempte de tout risque à la fin de chaque journée (pas de matériaux combustibles, pas de point chaud résiduel) ; réactivation du détecteur dès que possible. Ces mesures doivent être formalisées dans la main courante et communiquées à l''équipe. L''inhibition sans mesure compensatoire est une faute grave.', 1, null::integer[], array['theme1','seq1','SSI - composants et fonctionnement','Système de Sécurité Incendie (SSI)']::text[], 20),
('ssiap1-q176', 'ssiap1-partie3', 'quiz', 'Quel équipement permet la communication entre la zone de refuge (espace d''attente sécurisé) et le PC sécurité ?', 'Les zones de refuge (espaces d''attente sécurisés) doivent être équipées d''un système de communication bidirectionnelle entre la zone et le PC de sécurité ou un point de permanence humaine. Cet interphone (ou système équivalent défini par la norme NF EN 81-28 ou la réglementation ERP/IGH) permet à la PMR en attente d''indiquer sa présence, son nombre et son état aux secours, et aux secours de communiquer des instructions. Le téléphone portable peut être une solution de secours mais n''est pas le dispositif réglementaire prévu. Ce système doit fonctionner même en cas de coupure d''électricité.', 1, null::integer[], array['theme1','seq1','SSI - composants et fonctionnement','Système de Sécurité Incendie (SSI)']::text[], 21)
on conflict (id) do update set
  type=excluded.type, question=excluded.question, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  tags=excluded.tags, display_order=excluded.display_order, updated_at=now();
delete from public.question_options where question_id in ('ssiap1-q175','ssiap1-q176');
insert into public.question_options (question_id, option_index, option_text) values
('ssiap1-q175', 0, 'La suppression définitive du détecteur'),
('ssiap1-q175', 1, 'Des mesures compensatoires (rondes plus fréquentes, présence d''un veilleur, extinction préventive des travaux en fin de journée)'),
('ssiap1-q175', 2, 'L''accord verbal du directeur uniquement'),
('ssiap1-q175', 3, 'La coupure de toute l''installation SSI'),
('ssiap1-q175', 4, 'Aucune de ces réponses n''est correcte'),
('ssiap1-q176', 0, 'Un téléphone portable'),
('ssiap1-q176', 1, 'Un interphone ou système de communication bidirectionnelle intégré à la zone de refuge'),
('ssiap1-q176', 2, 'Un mégaphone'),
('ssiap1-q176', 3, 'Un signal lumineux clignotant'),
('ssiap1-q176', 4, 'Aucune de ces réponses n''est correcte');
commit;
