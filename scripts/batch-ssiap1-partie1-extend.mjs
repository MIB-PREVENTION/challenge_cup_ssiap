// SSIAP 1 — Partie 1 « Le feu et ses conséquences » — Batch d'extension
// Approfondit les 14 questions hand-crafted existantes avec 26 nouvelles
// pour atteindre ~40 questions, toujours équilibrées sur les 12 types.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const MOD = 'ssiap1-partie1';
const PREFIX = 'ssiap1-hc-p1-ext';

const Q = [
  // ─── QUIZ (4) ─────────────────────────────────────────────────────
  { type:'quiz', title:'Point éclair',
    question:'Le point éclair d\'un liquide inflammable correspond à :',
    options:[
      'La température minimale où le liquide émet assez de vapeurs pour s\'enflammer en présence d\'une flamme',
      'La température à laquelle le liquide bout',
      'La température d\'auto-inflammation sans source d\'ignition',
      'La quantité de chaleur dégagée par la combustion'
    ],
    correctAnswer:0,
    explanation:'Point éclair (flash point) = T° minimale d\'émission de vapeurs inflammables. À ne pas confondre avec le point d\'auto-inflammation (sans source extérieure) ni avec le pouvoir calorifique.' },
  { type:'quiz', title:'Modes de propagation thermique',
    question:'Quel est le mode de propagation thermique le plus rapide à grande distance ?',
    options:['Conduction','Convection','Rayonnement','Combustion lente'],
    correctAnswer:2,
    explanation:'Rayonnement = ondes infrarouges, instantané, traverse l\'air. La convection (fumées chaudes) déplace la chaleur dans le bâtiment. La conduction se fait par contact direct (lent).' },
  { type:'quiz', title:'CO mortel',
    question:'À partir de quelle concentration le monoxyde de carbone (CO) devient-il rapidement mortel pour un adulte ?',
    options:['10 ppm','100 ppm','400 ppm','3000 ppm et plus'],
    correctAnswer:3,
    explanation:'Au-delà de 3000 ppm (0,3 %), perte de conscience en quelques minutes, décès rapide. À 100 ppm = symptômes en heures. Le CO se fixe sur l\'hémoglobine 200× plus que l\'O2.' },
  { type:'quiz', title:'REI signification',
    question:'Que signifie le sigle "REI" dans le classement de résistance au feu ?',
    options:[
      'Résistance, Étanchéité, Isolation thermique',
      'Réaction, Efficacité, Inflammation',
      'Résistance Européenne d\'Incendie',
      'Recyclage Énergétique d\'Incendie'
    ],
    correctAnswer:0,
    explanation:'R = Résistance mécanique (capacité portante). E = Étanchéité (aux flammes et fumées). I = Isolation thermique (face non exposée < 140°C). REI 60 = tient les 3 critères 60 minutes.' },

  // ─── TRUE-FALSE (3) ──────────────────────────────────────────────
  { type:'true-false', title:'Auto-inflammation',
    question:'Un liquide peut s\'enflammer sans flamme ni étincelle si sa température dépasse son point d\'auto-inflammation.',
    options:['Vrai','Faux'], correctAnswer:0,
    explanation:'VRAI — Le point d\'auto-inflammation est la T° à laquelle un combustible s\'enflamme spontanément (ex : essence ~280°C, diesel ~250°C). C\'est pourquoi on évite chaud + carburant.' },
  { type:'true-false', title:'CO2 plus lourd que l\'air',
    question:'Le CO2 est plus lourd que l\'air et stagne donc en partie basse des locaux.',
    options:['Vrai','Faux'], correctAnswer:0,
    explanation:'VRAI — Densité CO2 ≈ 1,5 vs 1 pour l\'air. Risque d\'asphyxie en fosse, sous-sol, salle serveur après décharge d\'une installation CO2. Toujours ventiler avant d\'entrer.' },
  { type:'true-false', title:'Eau et feu d\'huile',
    question:'On peut éteindre un feu d\'huile de cuisson en jetant de l\'eau dessus.',
    options:['Vrai','Faux'], correctAnswer:1,
    explanation:'FAUX — Eau + huile à 300°C = vaporisation explosive (boilover). L\'huile est projetée en gouttelettes enflammées. Utiliser un extincteur classe F ou un couvercle/textile humide.' },

  // ─── MULTIPLE-SELECT (3) ─────────────────────────────────────────
  { type:'multiple-select', title:'Effets de la chaleur sur le corps',
    question:'Quels sont les effets DIRECTS de la chaleur intense sur l\'organisme ? (plusieurs réponses)',
    options:['Brûlures cutanées','Asphyxie par les fumées','Hyperthermie','Œdème pulmonaire','Choc thermique'],
    correctAnswers:[0,2,4],
    explanation:'Brûlures, hyperthermie, choc thermique = effets directs. Asphyxie et œdème pulmonaire = effets des fumées (toxicité), pas de la chaleur seule.' },
  { type:'multiple-select', title:'Conditions du tétraèdre',
    question:'Quelles conditions doivent être réunies pour qu\'un feu se développe ?',
    options:['Combustible','Comburant (oxygène)','Énergie d\'activation','Réaction en chaîne','Pression atmosphérique élevée'],
    correctAnswers:[0,1,2,3],
    explanation:'Les 4 piliers du tétraèdre. La pression normale suffit (l\'air contient 21 % O2). Un feu peut exister à basse altitude comme en montagne.' },
  { type:'multiple-select', title:'Composants de la fumée',
    question:'Quels gaz toxiques peut-on retrouver dans la fumée d\'un incendie ?',
    options:['CO (monoxyde de carbone)','HCN (acide cyanhydrique)','HCl (acide chlorhydrique)','O2 pur','SO2 (dioxyde de soufre)'],
    correctAnswers:[0,1,2,4],
    explanation:'CO + HCN + HCl + SO2 selon les matériaux qui brûlent (plastiques, textiles, soufre). L\'O2 est CONSOMMÉ par le feu, pas produit.' },

  // ─── FIND-INTRUDER (2) ────────────────────────────────────────────
  { type:'find-intruder', title:'Pas un agent extincteur',
    question:'Lequel de ces éléments N\'EST PAS un agent extincteur reconnu ?',
    options:['CO2','Mousse AFFF','Sable','Oxygène pur'],
    correctAnswer:3,
    explanation:'L\'oxygène pur ALIMENTE le feu, il ne l\'éteint pas. Sable = étouffement (utilisé pour métaux ou hydrocarbures). CO2 et mousse = agents standards.' },
  { type:'find-intruder', title:'Pas une cause d\'incendie courante',
    question:'Laquelle de ces causes est LA MOINS courante en milieu professionnel ?',
    options:['Court-circuit électrique','Travaux par points chauds','Cigarette mal éteinte','Foudre direct sur bâtiment'],
    correctAnswer:3,
    explanation:'Court-circuits, points chauds, cigarettes représentent la majorité. La foudre est rare grâce aux paratonnerres et reste localisée. Cause statistique mineure en milieu pro.' },

  // ─── SCENARIO (2) ─────────────────────────────────────────────────
  { type:'scenario', title:'Fumée légère sous une porte',
    question:'Action immédiate ?',
    scenario:'Vous patrouillez au sous-sol. Sous une porte de local technique, vous voyez une légère fumée blanche. La porte est tiède. Vous êtes seul avec une radio.',
    options:[
      'Ouvrir pour voir',
      'Ne pas ouvrir, alerter le PC, déclencher le DM le plus proche',
      'Forcer la porte avec un extincteur',
      'Courir chercher un collègue avant tout'
    ],
    correctAnswer:1,
    explanation:'Porte tiède + fumée blanche = feu probable. NE JAMAIS OUVRIR (apport d\'O2 → flashover/backdraft possible). Alerte → DM → attente sécurisée. La radio est l\'outil prioritaire.' },
  { type:'scenario', title:'Chaudière qui claque',
    question:'Conduite à tenir ?',
    scenario:'Dans une chaufferie gaz, vous entendez un claquement et sentez une odeur de gaz forte. Aucune fumée, aucune flamme.',
    options:[
      'Allumer la lumière pour voir',
      'Couper l\'arrivée gaz, ne pas créer d\'étincelle, ventiler, évacuer, alerter',
      'Vaporiser de l\'eau pour disperser le gaz',
      'Approcher pour vérifier l\'origine'
    ],
    correctAnswer:1,
    explanation:'Fuite gaz = priorité ABSOLUE pas d\'étincelle. Couper amont (vanne combustible), ouvrir aération, évacuer la zone, alerter pompiers via portable hors zone. Toute étincelle = explosion.' },

  // ─── IMAGE-IDENTIFY (2) ───────────────────────────────────────────
  { type:'image-identify', title:'Risque incendie générique',
    question:'Ce panneau triangulaire jaune désigne :',
    imageKey:'electrical-hazard', imageDesc:'ISO 7010 — W012',
    options:[
      'Un risque de chute de hauteur',
      'Un danger électrique — risque d\'électrocution',
      'Une zone réservée aux secours',
      'Un risque de glissade'
    ],
    correctAnswer:1,
    explanation:'W012 — Avertissement risque électrique. Présent près des armoires HT, transformateurs. Ne jamais intervenir sans habilitation (B0, BR, BC...).' },
  { type:'image-identify', title:'Extincteur',
    question:'Ce panneau rouge avec extincteur blanc indique :',
    imageKey:'extinguisher', imageDesc:'ISO 7010 — F001',
    options:[
      'L\'emplacement d\'un extincteur portatif',
      'Une zone à risque incendie',
      'Le PC sécurité',
      'Un local technique fermé à clé'
    ],
    correctAnswer:0,
    explanation:'F001 — Emplacement extincteur. Visible à 15 m, accessible sans obstacle. Doit figurer sur le plan d\'évacuation avec son type (eau, CO2, poudre).' },

  // ─── SEQUENCE (2) ─────────────────────────────────────────────────
  { type:'sequence', title:'Ordre PASS extincteur',
    question:'Remettez dans l\'ordre les étapes d\'utilisation d\'un extincteur (méthode PASS) :',
    items:[
      'Pull — Tirer la goupille de sécurité',
      'Aim — Viser la base des flammes',
      'Squeeze — Presser la poignée',
      'Sweep — Balayer de gauche à droite'
    ],
    correctOrder:[0,1,2,3],
    explanation:'P-A-S-S : Pull, Aim, Squeeze, Sweep. Vous tirez la goupille AVANT de viser. Toujours viser la BASE des flammes, pas le sommet. Maintenir 1-3 m de distance.' },
  { type:'sequence', title:'Phases combustion',
    question:'Classez ces phases dans l\'ordre du développement d\'un incendie :',
    items:[
      'Phase de naissance (T° basse, fumée légère)',
      'Phase de développement (T° monte, flammes visibles)',
      'Embrasement généralisé (flashover, ~500°C)',
      'Phase de décrescence (combustible épuisé)'
    ],
    correctOrder:[0,1,2,3],
    explanation:'Naissance → développement → flashover → décrescence. Le flashover est le point critique non-retour : tous les matériaux s\'enflamment simultanément.' },

  // ─── RANKING (2) ──────────────────────────────────────────────────
  { type:'ranking', title:'Classement températures',
    question:'Classez ces températures du PLUS BAS au PLUS HAUT :',
    items:[
      'Point éclair de l\'essence (-43 °C)',
      'Point auto-inflammation gasoil (~250 °C)',
      'Flashover plafond (~500 °C)',
      'Combustion bois en pleine flamme (~1000 °C)'
    ],
    correctOrder:[0,1,2,3],
    explanation:'Essence -43°C → gasoil 250°C → flashover 500°C → bois 1000°C. À retenir : essence très volatile, gasoil moins, flammes très chaudes.' },
  { type:'ranking', title:'Classement vitesse propagation',
    question:'Classez ces matériaux du PLUS RAPIDE au PLUS LENT à propager le feu :',
    items:[
      'Mousse polyuréthane (PUR)',
      'Bois résineux (sapin)',
      'Bois feuillu (chêne)',
      'Béton cellulaire'
    ],
    correctOrder:[0,1,2,3],
    explanation:'Mousse PU = très inflammable, très vite (canapés, matelas !). Sapin résineux > chêne (densité). Béton = quasi-incombustible (Euroclasse A1).' },

  // ─── MATCHING (2) ─────────────────────────────────────────────────
  { type:'matching', title:'Classe ↔ exemples',
    question:'Associez chaque classe de feu à un exemple typique :',
    pairs:[
      { left:'Classe A', right:'Bois, papier, textile' },
      { left:'Classe B', right:'Essence, alcool, peinture' },
      { left:'Classe C', right:'Méthane, propane, butane' },
      { left:'Classe F', right:'Huile de friture' }
    ],
    explanation:'A = solides (carbonisation). B = liquides inflammables. C = gaz. D = métaux (Mg, Al, Na...). F = huiles cuisson. Connaître la classe → choisir l\'extincteur.' },
  { type:'matching', title:'Mode propagation ↔ description',
    question:'Associez chaque mode de propagation thermique à sa description :',
    pairs:[
      { left:'Conduction', right:'Transfert par contact direct des matériaux' },
      { left:'Convection', right:'Transfert par les fumées et gaz chauds' },
      { left:'Rayonnement', right:'Transfert par ondes infrarouges' },
      { left:'Projection', right:'Particules incandescentes (escarbilles)' }
    ],
    explanation:'Les 4 modes opèrent simultanément en incendie réel. Comprendre les 4 = comprendre comment un feu passe d\'une pièce à une autre.' },

  // ─── FILL-BLANK (2) ───────────────────────────────────────────────
  { type:'fill-blank', title:'Triangle vs tétraèdre',
    question:'Complétez la définition :',
    sentence:'Le triangle du feu comporte %1% éléments. Le tétraèdre du feu en ajoute un quatrième : %2%.',
    correctBlanks:['3','la réaction en chaîne'],
    wordBank:['3','4','5','la réaction en chaîne','l\'oxygène','la pression','le combustible'],
    explanation:'Triangle : combustible + comburant + énergie d\'activation = 3 éléments. Tétraèdre : ajoute la réaction en chaîne (auto-entretien moléculaire).' },
  { type:'fill-blank', title:'Limites d\'inflammabilité',
    question:'Complétez les limites de l\'air respirable et de combustion :',
    sentence:'L\'air contient %1% % d\'oxygène. La combustion s\'arrête en dessous de %2% % d\'oxygène.',
    correctBlanks:['21','15'],
    wordBank:['21','15','78','5','30','10','25'],
    explanation:'Air = 21 % O2 + 78 % N2 + 1 % autres. Combustion s\'arrête vers 15 % O2. Principe des systèmes hypoxiques (salles serveur) : maintenir 14-17 % d\'O2.' },

  // ─── CATEGORIES (1) ───────────────────────────────────────────────
  { type:'categories', title:'Classer par classe de feu',
    question:'Classez ces combustibles dans la bonne classe de feu :',
    categories:[
      { id:'A', label:'🟫 Classe A — solides' },
      { id:'B', label:'🟡 Classe B — liquides' },
      { id:'C', label:'⚪ Classe C — gaz' },
      { id:'F', label:'🟧 Classe F — huiles cuisson' }
    ],
    items:[
      { text:'Carton',           category:'A' },
      { text:'Essence',          category:'B' },
      { text:'Bois sec',         category:'A' },
      { text:'Propane bouteille', category:'C' },
      { text:'Acétone',          category:'B' },
      { text:'Huile de tournesol cuite', category:'F' }
    ],
    explanation:'Classer correctement = choisir le bon extincteur. Erreur classique : utiliser eau sur classe B (étend le feu) ou CO2 sur F (projection).' },

  // ─── DECISION (1) ─────────────────────────────────────────────────
  { type:'decision', title:'Feu naissant dans une corbeille',
    question:'Arbre de décision face à un départ de feu :',
    scenario:'Dans un bureau, une corbeille à papier prend feu. Les flammes font 30 cm. Vous êtes à 2 m, un extincteur eau pulvérisée + additif est à 5 m, et le DM est à 8 m.',
    steps:[
      { question:'ÉTAPE 1 — Première action ?',
        options:[
          { text:'Déclencher le DM avant tout', nextStep:1 },
          { text:'Foncer pour étouffer avec mes mains', nextStep:99 },
          { text:'Sortir et fermer la porte', nextStep:99 }
        ] },
      { question:'ÉTAPE 2 — DM enclenché. Action suivante ?',
        options:[
          { text:'Saisir l\'extincteur, viser la base, balayer', nextStep:2 },
          { text:'Attendre les pompiers', nextStep:99 },
          { text:'Verser de l\'eau dessus directement', nextStep:99 }
        ] },
      { question:'ÉTAPE 3 — Le feu est éteint. Que faire ?',
        options:[
          { text:'Vérifier l\'absence de reprise + signaler + consigner au registre', nextStep:null },
          { text:'Reprendre le travail', nextStep:null },
          { text:'Remettre l\'extincteur en place', nextStep:null }
        ] }
    ],
    correctPath:[0,0,0],
    explanation:'DM en premier (alerte interne) → extinction si feu naissant (< 1 m²) → vérification reprise + traçabilité. Toujours signaler même si feu éteint : déclaration sinistre + ré-armement extincteur.' }
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
  array['handcrafted','starter-pack','partie1-ext']::text[], 'challenge',
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
fs.writeFileSync(path.join(root, 'supabase/migrations/0016a_partie1_ext_questions.sql'), partA.join('\n') + '\n');
fs.writeFileSync(path.join(root, 'supabase/migrations/0016b_partie1_ext_subtables.sql'), partB.join('\n') + '\n');

const types = {};
Q.forEach(q => { types[q.type] = (types[q.type]||0) + 1; });
console.log(`Generated ${Q.length} questions for ${MOD} (extension)`);
console.table(types);
