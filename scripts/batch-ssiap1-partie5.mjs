// SSIAP 1 — Partie 5 « Concrétisation des acquis »
// Thème : POI, exercices d'évacuation, plans, recyclage, application terrain.
// 40 questions couvrant les 12 types de jeu (pool 'challenge').
//
// Generates the seed SQL on stdout. Apply via Supabase execute_sql.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const MOD = 'ssiap1-partie5';
const PREFIX = 'ssiap1-hc-p5';

const Q = [
  // ─── QUIZ (4) ─────────────────────────────────────────────────────
  { type:'quiz', title:'Acronyme POI',
    question:'Que signifie POI dans le contexte de la sécurité incendie ?',
    options:['Plan d\'Opération Interne','Plan d\'Organisation Incendie','Procédure d\'Opération Immédiate','Programme Officiel d\'Intervention'],
    correctAnswer:0,
    explanation:'POI = Plan d\'Opération Interne. Document organisant la réponse à un sinistre dans les établissements à risques (Seveso, IGH, gros ERP). Décrit qui fait quoi, où et avec quels moyens.' },
  { type:'quiz', title:'Recyclage SSIAP 1',
    question:'Tous les combien de temps un agent SSIAP 1 doit-il faire son recyclage triennal ?',
    options:['Tous les ans','Tous les 2 ans','Tous les 3 ans','Tous les 5 ans'],
    correctAnswer:2,
    explanation:'Recyclage triennal obligatoire — 14 heures (7h théorie + 7h pratique). Sans recyclage, le diplôme n\'est plus valable et l\'agent ne peut plus exercer.' },
  { type:'quiz', title:'Fréquence exercices évacuation ERP',
    question:'Dans un ERP courant, à quelle fréquence MINIMALE les exercices d\'évacuation doivent-ils être organisés ?',
    options:['Tous les mois','Tous les 6 mois','Une fois par an','Tous les 3 ans'],
    correctAnswer:1,
    explanation:'Article R.123-43 du CCH : exercice tous les 6 mois en ERP courant. En type R (enseignement) : 1 dans le 1er mois de l\'année scolaire puis 2/3/an selon catégorie.' },
  { type:'quiz', title:'Hauteur d\'affichage des plans',
    question:'À quelle hauteur d\'œil un plan d\'évacuation doit-il être affiché ?',
    options:['À 1 mètre du sol','Entre 1,30 m et 1,80 m','À hauteur de poignée de porte','Sous le plafond'],
    correctAnswer:1,
    explanation:'Hauteur recommandée 1,30 m à 1,80 m — accessible aussi aux personnes en fauteuil. Le plan doit être lisible, à jour, et orienté correctement (vous êtes ici).' },

  // ─── TRUE-FALSE (4) ──────────────────────────────────────────────
  { type:'true-false', title:'POI dans tous les ERP',
    question:'Le POI est obligatoire dans tous les ERP, quelle que soit la catégorie.',
    options:['Vrai','Faux'], correctAnswer:1,
    explanation:'FAUX — Le POI est obligatoire pour les sites à risques particuliers (installations classées Seveso, IGH, certains ERP de 1ère catégorie). Les ERP courants ont des consignes simplifiées via l\'affichage.' },
  { type:'true-false', title:'Plan d\'évacuation et extincteurs',
    question:'Le plan d\'évacuation doit obligatoirement faire figurer les extincteurs.',
    options:['Vrai','Faux'], correctAnswer:0,
    explanation:'VRAI — La norme NF X08-070 impose la représentation des moyens de secours : extincteurs, RIA, déclencheurs manuels, point de rassemblement, issues de secours. Avec leur localisation exacte.' },
  { type:'true-false', title:'SSIAP donne l\'ordre d\'évacuation',
    question:'L\'agent SSIAP 1 a l\'autorité pour ordonner l\'évacuation totale d\'un ERP.',
    options:['Vrai','Faux'], correctAnswer:1,
    explanation:'FAUX — L\'agent SSIAP 1 exécute. La décision d\'évacuation totale appartient au chef de service sécurité (SSIAP 3) ou à défaut à l\'exploitant. SSIAP 1 peut déclencher l\'alarme évacuation localement.' },
  { type:'true-false', title:'Exercice noté au registre',
    question:'Tout exercice d\'évacuation doit être consigné au registre de sécurité avec son retour d\'expérience.',
    options:['Vrai','Faux'], correctAnswer:0,
    explanation:'VRAI — Date, durée, anomalies, plan d\'action correctif. Le registre prouve la régularité réglementaire et est exigible par la commission de sécurité.' },

  // ─── MULTIPLE-SELECT (3) ─────────────────────────────────────────
  { type:'multiple-select', title:'Mentions obligatoires plan',
    question:'Quelles informations sont OBLIGATOIRES sur un plan d\'évacuation ? (plusieurs réponses)',
    options:['Vous êtes ici','Itinéraires d\'évacuation','Numéro SIRET de l\'établissement','Localisation des moyens de secours','Numéros d\'appel des secours'],
    correctAnswers:[0,1,3,4],
    explanation:'« Vous êtes ici » + cheminements + moyens de secours + numéros d\'urgence. Le SIRET n\'a aucun intérêt opérationnel — pas obligatoire.' },
  { type:'multiple-select', title:'Documents en commission',
    question:'Quels documents sont à présenter à la commission de sécurité lors d\'une visite ?',
    options:['Registre de sécurité','Notice descriptive de sécurité','Bilans comptables','Rapports de vérifications périodiques','Contrats de travail du personnel'],
    correctAnswers:[0,1,3],
    explanation:'Registre + notice + rapports de contrôle (extincteurs, SSI, gaz, électricité). Bilans comptables et contrats RH = pas du ressort de la commission.' },
  { type:'multiple-select', title:'Composantes d\'un POI',
    question:'Quelles parties trouve-t-on dans un POI ?',
    options:['Identification des risques','Organisation des secours','Cartographie des dangers','Tarifs de prestation','Fiches réflexes par scénario'],
    correctAnswers:[0,1,2,4],
    explanation:'Risques + organisation + cartographie + fiches réflexes. Les tarifs commerciaux n\'ont rien à faire dans un POI opérationnel.' },

  // ─── FIND-INTRUDER (3) ────────────────────────────────────────────
  { type:'find-intruder', title:'Pas sur un plan d\'évacuation',
    question:'Lequel de ces éléments NE doit PAS figurer sur un plan d\'évacuation ?',
    options:['Localisation des extincteurs','Sens d\'évacuation','Liste nominative des employés','Point de rassemblement'],
    correctAnswer:2,
    explanation:'La liste des employés relève de la confidentialité RH et n\'a aucun intérêt opérationnel sur un plan affiché publiquement.' },
  { type:'find-intruder', title:'Pas une mission du serre-file',
    question:'Laquelle de ces actions N\'EST PAS du ressort du serre-file ?',
    options:['Vérifier les locaux','Fermer les portes coupe-feu','Décider d\'évacuer le bâtiment','Transmettre l\'effectif au point de rassemblement'],
    correctAnswer:2,
    explanation:'Le serre-file vérifie/ferme/compte. La décision d\'évacuation appartient au responsable d\'évacuation, pas au serre-file qui exécute.' },
  { type:'find-intruder', title:'Pas un point de ronde',
    question:'Lequel de ces points N\'EST PAS un point de contrôle classique d\'une ronde SSIAP ?',
    options:['Issues de secours dégagées','Compteurs électriques accessibles','Caisses du jour réconciliées','État des extincteurs'],
    correctAnswer:2,
    explanation:'Les caisses commerciales = ressort de la direction/comptabilité. La ronde SSIAP vérifie l\'état des moyens de secours, des dégagements et des locaux à risques.' },

  // ─── SCENARIO (5) ─────────────────────────────────────────────────
  { type:'scenario', title:'Plan d\'évacuation manquant',
    question:'Que faites-vous ?',
    scenario:'En arrivant au PC sécurité, vous constatez que le plan d\'évacuation du 2ème étage a été retiré (rénovation des couloirs). Le chantier doit durer 3 semaines.',
    options:['Rien — il sera remis à la fin du chantier','Mettre un plan provisoire affiché et consigner au registre','Évacuer le 2ème étage','Faire un courrier formel au directeur uniquement'],
    correctAnswer:1,
    explanation:'L\'absence d\'affichage = non-conformité immédiate. Solution : plan provisoire + signalement au registre + alerte hiérarchie. La conformité prime, on ne peut pas attendre 3 semaines.' },
  { type:'scenario', title:'Exercice non préparé',
    question:'Quelle est votre attitude ?',
    scenario:'Le directeur vous demande de déclencher un exercice d\'évacuation maintenant, sans préavis, sans information à la sous-traitance, sans coordination avec l\'accueil. "On verra bien si ça marche."',
    options:['Exécuter — c\'est la hiérarchie','Refuser et expliquer les risques (panique, accidents, sous-traitants non formés)','Faire semblant et déclencher seulement l\'alarme','Demander un courrier écrit'],
    correctAnswer:1,
    explanation:'Un exercice non préparé peut blesser (panique, sous-traitants, PMR oubliées). L\'exercice doit être structuré, briefé, mesuré. Refuser et expliquer est professionnel.' },
  { type:'scenario', title:'Visite commission imprévue',
    question:'Comment réagissez-vous ?',
    scenario:'Un inspecteur de la commission de sécurité arrive sans prévenir. Le directeur est absent, vous êtes seul SSIAP en poste.',
    options:['Refuser l\'accès','Accueillir, présenter les documents disponibles, prévenir la direction','Demander un rendez-vous officiel','Évacuer l\'inspecteur du site'],
    correctAnswer:1,
    explanation:'Inspecteurs/contrôleurs ont droit d\'accès. Accueillir poliment, présenter le registre + ce qui est disponible, joindre la direction immédiatement. Refuser engage la responsabilité.' },
  { type:'scenario', title:'Évacuation au cinéma',
    question:'Quelle action prioritaire ?',
    scenario:'Vous êtes SSIAP 1 dans un multiplexe de cinéma (type L). Une alarme se déclenche pendant la projection. Le public est dans le noir, désorienté.',
    options:['Couper l\'alarme — fausse alerte probable','Allumer immédiatement la lumière de salle, ouvrir les portes, guider vocalement','Attendre la fin de la séance','Appeler le directeur d\'abord'],
    correctAnswer:1,
    explanation:'Lumière + ouverture portes + guidage vocal calme = procédure type L. La désorientation dans le noir est dangereuse. Ne JAMAIS couper l\'alarme sans levée de doute.' },
  { type:'scenario', title:'Personne en bas de l\'escalier',
    question:'Action correcte ?',
    scenario:'Lors d\'un exercice d\'évacuation, vous trouvez un visiteur âgé essoufflé, assis en bas de l\'escalier, qui dit "j\'arrive, j\'arrive".',
    options:['Le pousser à continuer','S\'arrêter avec lui, prévenir le PC, l\'aider à atteindre le point de rassemblement à son rythme','L\'abandonner pour finir l\'évacuation','L\'allonger sur place'],
    correctAnswer:1,
    explanation:'Personne en difficulté = on ne laisse pas seul. Communication PC pour info, accompagnement à son rythme jusqu\'au point sûr. La sécurité humaine prime sur le chrono d\'exercice.' },

  // ─── IMAGE-IDENTIFY (3) ───────────────────────────────────────────
  { type:'image-identify', title:'Pictogramme rassemblement',
    question:'Ce pictogramme vert ISO 7010 désigne :',
    imageKey:'assembly', imageDesc:'ISO 7010 — E007',
    options:['Un poste de premiers secours','Le point de rassemblement après évacuation','La salle de pause du personnel','L\'accueil principal'],
    correctAnswer:1,
    explanation:'E007 — Point de rassemblement. Lieu désigné pour comptage post-évacuation. Sa position est notée sur le plan d\'évacuation et communiquée aux pompiers.' },
  { type:'image-identify', title:'Sortie de secours',
    question:'Ce panneau vert avec personnage et flèche indique :',
    imageKey:'exit-direction', imageDesc:'ISO 7010 — E003',
    options:['Le sens du courant d\'air','La direction d\'une issue de secours','L\'accès au stationnement personnel','Le poste de garde'],
    correctAnswer:1,
    explanation:'E003 — Direction issue de secours. Pictogramme luminescent ou rétro-éclairé jalonnant tout le cheminement d\'évacuation, jusqu\'à la sortie finale.' },
  { type:'image-identify', title:'Emplacement extincteur',
    question:'Ce panneau carré rouge avec extincteur blanc signale :',
    imageKey:'extinguisher', imageDesc:'ISO 7010 — F001',
    options:['Une zone à risque incendie','L\'emplacement d\'un extincteur','Une coupure d\'urgence électrique','Une porte CF à fermer'],
    correctAnswer:1,
    explanation:'F001 — Emplacement extincteur. Doit être visible à 15 m, l\'extincteur accessible sans obstacle. Son emplacement figure sur les plans d\'évacuation.' },

  // ─── SEQUENCE (3) ─────────────────────────────────────────────────
  { type:'sequence', title:'Étapes d\'un exercice évacuation',
    question:'Remettez dans l\'ordre les étapes d\'un exercice d\'évacuation réussi :',
    items:['Préparation et information préalable des occupants','Déclenchement de l\'alarme','Évacuation et chronométrage','Comptage au point de rassemblement','Débriefing et consignation au registre'],
    correctOrder:[0,1,2,3,4],
    explanation:'Préparation → Déclenchement → Évacuation → Comptage → Débriefing. Sauter une étape (ex : pas de débriefing) rend l\'exercice inutile pédagogiquement.' },
  { type:'sequence', title:'Procédure d\'accueil pompiers',
    question:'Classez dans l\'ordre les actions d\'accueil des secours :',
    items:['Récupérer plans, clés, badges au PC','Se positionner à l\'entrée principale','Donner l\'information précise (lieu, nature, victimes)','Guider la première équipe vers le sinistre'],
    correctOrder:[0,1,2,3],
    explanation:'L\'agent SSIAP doit être PRÊT à donner les bonnes infos en quelques secondes : où ? quoi ? combien ? Cela conditionne la rapidité d\'intervention.' },
  { type:'sequence', title:'Phases d\'un débriefing',
    question:'Ordre logique d\'un débriefing post-exercice :',
    items:['Collecte des observations à chaud','Analyse des points forts et faibles','Identification des actions correctives','Consignation écrite au registre'],
    correctOrder:[0,1,2,3],
    explanation:'À chaud (mémoire fraîche) → analyse → corrections → trace écrite. Sans consignation, l\'exercice n\'a pas de valeur réglementaire ni d\'amélioration continue.' },

  // ─── RANKING (3) ──────────────────────────────────────────────────
  { type:'ranking', title:'Périodicité maintenance',
    question:'Classez ces vérifications de la PLUS FRÉQUENTE à la MOINS FRÉQUENTE :',
    items:['Test BAES par l\'exploitant','Vérification annuelle extincteurs','Épreuve hydraulique extincteurs','Recyclage SSIAP 1'],
    correctOrder:[0,1,3,2],
    explanation:'Test BAES : mensuel. Vérif extincteurs : annuelle. Recyclage SSIAP : 3 ans. Épreuve hydraulique : 10 ans. Du plus fréquent au plus espacé.' },
  { type:'ranking', title:'Priorités évacuation',
    question:'Classez ces priorités du PLUS IMPORTANT au MOINS IMPORTANT lors d\'une évacuation :',
    items:['Sauver les personnes','Avertir les secours','Limiter la propagation (fermer les portes)','Préserver les biens'],
    correctOrder:[0,1,2,3],
    explanation:'Vies humaines > alerte secours > limitation > biens. Les biens sont assurables, pas les vies. Toute hésitation se règle dans cet ordre.' },
  { type:'ranking', title:'Phases temporelles intervention',
    question:'Classez ces phases dans leur ordre d\'apparition pendant un sinistre :',
    items:['Détection / découverte','Alerte interne (alarme)','Évacuation des occupants','Intervention des secours extérieurs'],
    correctOrder:[0,1,2,3],
    explanation:'Détection → Alarme → Évacuation → Pompiers. Ce schéma est universel et structure tous les POI / consignes.' },

  // ─── MATCHING (3) ─────────────────────────────────────────────────
  { type:'matching', title:'Document ↔ destinataire',
    question:'Associez chaque document à son destinataire principal :',
    pairs:[
      {left:'Registre de sécurité',right:'Commission de sécurité'},
      {left:'Plan d\'évacuation',right:'Public / occupants'},
      {left:'Plan d\'intervention',right:'Sapeurs-pompiers'},
      {left:'Notice descriptive de sécurité',right:'Maître d\'œuvre / architecte'}
    ],
    explanation:'Chaque document a un destinataire et un usage. Confondre les rôles fait perdre du temps en intervention.' },
  { type:'matching', title:'Périodicité ↔ contrôle',
    question:'Associez chaque contrôle à sa périodicité réglementaire :',
    pairs:[
      {left:'Test BAES',right:'Mensuel'},
      {left:'Vérification extincteur',right:'Annuel'},
      {left:'Visite ERP 3ème catégorie',right:'2 ans'},
      {left:'Épreuve hydraulique extincteur',right:'10 ans'}
    ],
    explanation:'Connaître les périodicités = base du métier. Ces 4 sont à mémoriser absolument pour le SSIAP 1.' },
  { type:'matching', title:'Acteur ↔ rôle évacuation',
    question:'Associez chaque acteur à son rôle dans le dispositif :',
    pairs:[
      {left:'Guide-file',right:'Ouvre la marche, dirige vers la sortie'},
      {left:'Serre-file',right:'Ferme la marche, vérifie les locaux'},
      {left:'SSIAP 1',right:'Met en sécurité, accueille les secours'},
      {left:'Responsable évacuation',right:'Décide et coordonne'}
    ],
    explanation:'Chaque rôle est complémentaire. La défaillance d\'un seul peut compromettre toute l\'évacuation.' },

  // ─── FILL-BLANK (3) ───────────────────────────────────────────────
  { type:'fill-blank', title:'Périodicité exercice ERP',
    question:'Complétez la fréquence réglementaire des exercices :',
    sentence:'Dans un ERP courant, un exercice d\'évacuation doit être organisé tous les %1% mois et consigné au %2%.',
    correctBlanks:['6','registre de sécurité'],
    wordBank:['6','12','3','registre de sécurité','plan d\'évacuation','POI','dossier'],
    explanation:'Tous les 6 mois minimum. Consigné au registre de sécurité avec retour d\'expérience pour preuve.' },
  { type:'fill-blank', title:'Recyclage SSIAP',
    question:'Complétez les obligations de recyclage :',
    sentence:'Le recyclage SSIAP 1 a lieu tous les %1% ans pour une durée de %2% heures.',
    correctBlanks:['3','14'],
    wordBank:['3','5','2','14','21','7','30'],
    explanation:'3 ans / 14 heures (7h théorie + 7h pratique). Sans recyclage, la qualification est suspendue.' },
  { type:'fill-blank', title:'Sigles POI / POSI',
    question:'Complétez les acronymes :',
    sentence:'Le %1% organise la réponse à un sinistre majeur. Le %2% organise au quotidien la prévention dans l\'établissement.',
    correctBlanks:['POI','POSI'],
    wordBank:['POI','POSI','PPI','SSI','SDIS','EAS'],
    explanation:'POI = Plan d\'Opération Interne (réaction). POSI = Plan d\'Organisation de la Sécurité Incendie (prévention quotidienne).' },

  // ─── CATEGORIES (3) ───────────────────────────────────────────────
  { type:'categories', title:'Document obligatoire ou non',
    question:'Classez ces documents selon leur caractère réglementaire en ERP :',
    categories:[
      {id:'oblig',label:'📌 Obligatoire'},
      {id:'reco',label:'💡 Recommandé / Facultatif'}
    ],
    items:[
      {text:'Registre de sécurité',category:'oblig'},
      {text:'Plan d\'évacuation à chaque niveau',category:'oblig'},
      {text:'Notice descriptive de sécurité',category:'oblig'},
      {text:'Cartouche de service du PC',category:'reco'},
      {text:'Tableau d\'avancement formations',category:'reco'}
    ],
    explanation:'Obligatoires : registre, plans, notice. Le reste peut être utile mais pas exigé par la commission.' },
  { type:'categories', title:'Niveau d\'urgence',
    question:'Classez ces situations selon leur niveau de gravité :',
    categories:[
      {id:'rou',label:'🔴 Sinistre — évacuation'},
      {id:'orange',label:'🟠 Alerte — vérification urgente'},
      {id:'jaune',label:'🟡 Anomalie — à signaler'}
    ],
    items:[
      {text:'Fumée visible dans un local',category:'rou'},
      {text:'Alarme SSI active sans confirmation',category:'orange'},
      {text:'Voyant défaut technique sur ECS',category:'jaune'},
      {text:'Porte CF bloquée ouverte par cale',category:'jaune'},
      {text:'Odeur de brûlé dans une gaine technique',category:'orange'}
    ],
    explanation:'Bien graduer la réponse évite paniques inutiles ET sous-réactions dangereuses. Le SSIAP doit calibrer.' },
  { type:'categories', title:'Acteurs et compétences',
    question:'Classez ces actions par acteur compétent :',
    categories:[
      {id:'ssiap',label:'🛡️ SSIAP 1'},
      {id:'pomp',label:'🚒 Sapeurs-pompiers'},
      {id:'dir',label:'👔 Direction / exploitant'}
    ],
    items:[
      {text:'Effectuer une ronde de prévention',category:'ssiap'},
      {text:'Décider de la fermeture administrative',category:'dir'},
      {text:'Engager une lance à incendie 70 mm',category:'pomp'},
      {text:'Tenir le registre de sécurité',category:'ssiap'},
      {text:'Signer le permis de feu',category:'dir'}
    ],
    explanation:'Chacun son champ. Sortir de son rôle peut engager la responsabilité civile et pénale.' },

  // ─── DECISION (2) ─────────────────────────────────────────────────
  { type:'decision', title:'Porte CF bloquée ouverte',
    question:'Arbre de décision :',
    scenario:'En ronde du soir, vous constatez qu\'une porte coupe-feu du couloir principal est calée ouverte avec un extincteur posé à terre. C\'est la 3ème fois cette semaine.',
    steps:[
      { question:'ÉTAPE 1 — Action immédiate ?',
        options:[{text:'Refermer la porte et noter au registre',nextStep:1},{text:'Laisser ouvert, c\'est bientôt fini',nextStep:99},{text:'Démonter la porte par la maintenance',nextStep:99}] },
      { question:'ÉTAPE 2 — Comportement récidivant. Que faites-vous ?',
        options:[{text:'Identifier le service responsable et alerter le chef d\'équipe',nextStep:2},{text:'Mettre un cadenas',nextStep:99},{text:'Ne rien dire',nextStep:99}] },
      { question:'ÉTAPE 3 — La traçabilité ?',
        options:[{text:'Noter chaque occurrence au registre + photo + escalade hiérarchique',nextStep:null},{text:'Seulement à l\'oral',nextStep:null},{text:'Tweet interne',nextStep:null}] }
    ],
    correctPath:[0,0,0],
    explanation:'Refermer + tracer + escalader. Une porte CF calée 30 minutes annule tout le compartimentage. Récidive = problème organisationnel à signaler.' },
  { type:'decision', title:'Conflit de procédure',
    question:'Arbre de décision :',
    scenario:'Un manager vous demande de couper l\'alarme déclenchée à 14h pour ne pas déranger une réunion VIP. Vous savez que la procédure impose une levée de doute physique avant tout réarmement.',
    steps:[
      { question:'ÉTAPE 1 — Réponse immédiate ?',
        options:[{text:'Refuser poliment et expliquer la procédure',nextStep:1},{text:'Couper — c\'est un manager',nextStep:99},{text:'Faire semblant de couper',nextStep:99}] },
      { question:'ÉTAPE 2 — Le manager insiste fortement.',
        options:[{text:'Maintenir le refus, contacter immédiatement le chef de service sécurité',nextStep:2},{text:'Céder pour ne pas créer de tension',nextStep:99},{text:'Quitter le poste',nextStep:99}] },
      { question:'ÉTAPE 3 — Une fois la levée de doute négative effectuée.',
        options:[{text:'Réarmer + consigner l\'incident au registre + transmettre',nextStep:null},{text:'Réarmer sans rien dire',nextStep:null},{text:'Modifier la fiche de poste',nextStep:null}] }
    ],
    correctPath:[0,0,0],
    explanation:'La procédure prime sur l\'autorité hiérarchique sur ce type de risque. Ne pas céder protège juridiquement l\'agent. Tout doit être tracé.' }
];

// ─── Generation ──────────────────────────────────────────────────────
const E = (v) => v == null ? 'null'
  : typeof v === 'number' || typeof v === 'boolean' ? String(v)
  : `'${String(v).replace(/'/g, "''")}'`;
const intArr = (a) => a == null ? 'null' : `array[${a.join(',')}]`;
const txtArr = (a) => a == null ? 'null' : `array[${a.map(E).join(',')}]`;

const partA = ['begin;'];
partA.push(`delete from public.questions where id like '${PREFIX}-%';`);
partA.push(`insert into public.questions
  (id, module_id, type, title, question, scenario, situation, explanation,
   correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
   word_bank, sentence, image_key, image_desc, tags, pool, display_order)
values`);
const rows = Q.map((q,i) => {
  const id = `${PREFIX}-q${i+1}`;
  return `(${E(id)}, ${E(MOD)}, ${E(q.type)}, ${E(q.title)}, ${E(q.question)},
  ${E(q.scenario||null)}, null, ${E(q.explanation)},
  ${q.correctAnswer ?? 'null'}, ${intArr(q.correctAnswers)}::integer[],
  ${intArr(q.correctOrder)}::integer[], ${txtArr(q.correctBlanks)}::text[],
  ${intArr(q.correctPath)}::integer[], ${txtArr(q.wordBank)}::text[],
  ${E(q.sentence||null)}, ${E(q.imageKey||null)}, ${E(q.imageDesc||null)},
  array['handcrafted','starter-pack','partie5']::text[], 'challenge',
  (select coalesce(max(display_order), -1) + 1 + ${i} from public.questions q2 where q2.module_id = ${E(MOD)} and q2.id not like '${PREFIX}-%'))`;
});
partA.push(rows.join(',\n') + ';');
partA.push('commit;');

const partB = ['begin;'];
const opts = [], items = [], pairs = [], cats = [], catItems = [], steps = [];
Q.forEach((q,i) => {
  const id = `${PREFIX}-q${i+1}`;
  if (q.options) q.options.forEach((o,j) => opts.push(`(${E(id)}, ${j}, ${E(o)})`));
  if (q.items && q.type !== 'categories') q.items.forEach((it,j) => items.push(`(${E(id)}, ${j}, ${E(it)})`));
  if (q.pairs) q.pairs.forEach((p,j) => pairs.push(`(${E(id)}, ${j}, ${E(p.left)}, ${E(p.right)})`));
  if (q.categories) q.categories.forEach((c,j) => cats.push(`(${E(id)}, ${j}, ${E(c.id)}, ${E(c.label)})`));
  if (q.type === 'categories' && q.items) q.items.forEach((it,j) => catItems.push(`(${E(id)}, ${j}, ${E(it.text)}, ${E(it.category)})`));
  if (q.steps) q.steps.forEach((s,j) => {
    const optsJson = JSON.stringify(s.options).replace(/'/g, "''");
    steps.push(`(${E(id)}, ${j}, ${E(s.question)}, '${optsJson}'::jsonb)`);
  });
});
if (opts.length)     partB.push('insert into public.question_options (question_id, option_index, option_text) values\n' + opts.join(',\n') + ';');
if (items.length)    partB.push('insert into public.question_items (question_id, item_index, item_text) values\n' + items.join(',\n') + ';');
if (pairs.length)    partB.push('insert into public.question_pairs (question_id, pair_index, left_text, right_text) values\n' + pairs.join(',\n') + ';');
if (cats.length)     partB.push('insert into public.question_categories (question_id, category_index, category_id, category_label) values\n' + cats.join(',\n') + ';');
if (catItems.length) partB.push('insert into public.question_category_items (question_id, item_index, item_text, correct_category) values\n' + catItems.join(',\n') + ';');
if (steps.length)    partB.push('insert into public.question_decision_steps (question_id, step_index, step_question, options) values\n' + steps.join(',\n') + ';');
partB.push('commit;');

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');
fs.writeFileSync(path.join(root, 'supabase/migrations/0015a_partie5_questions.sql'), partA.join('\n') + '\n');
fs.writeFileSync(path.join(root, 'supabase/migrations/0015b_partie5_subtables.sql'), partB.join('\n') + '\n');

const types = {};
Q.forEach(q => { types[q.type] = (types[q.type]||0) + 1; });
console.log(`Generated ${Q.length} questions for ${MOD}`);
console.table(types);
