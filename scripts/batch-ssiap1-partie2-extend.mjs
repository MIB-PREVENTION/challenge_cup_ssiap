// SSIAP 1 — Partie 2 « La sécurité incendie » — Batch d'extension (+26 q)
// Thèmes : réglementation, ERP, IGH, classification, commissions, compartimentage.
import fs from 'node:fs'; import path from 'node:path'; import { fileURLToPath } from 'node:url';

const MOD = 'ssiap1-partie2';
const PREFIX = 'ssiap1-hc-p2-ext';

const Q = [
  // QUIZ ×4
  { type:'quiz', title:'Article principal ERP', question:'Quel article du Code de la Construction et de l\'Habitation définit les règles de sécurité ERP ?',
    options:['R.123-1 et suivants','L.111-1','D.541-2','CO 12'], correctAnswer:0,
    explanation:'Articles R.123-1 et suivants du CCH = règles applicables aux ERP. CO 12 et autres sont des articles du règlement de sécurité (annexes du CCH).' },
  { type:'quiz', title:'Effectif déclencheur catégorie 5', question:'En dessous de quel effectif un ERP relève-t-il de la 5ème catégorie ?',
    options:['100 personnes','300 personnes','Effectif sous le seuil par type','Aucune limite, c\'est la surface qui compte'], correctAnswer:2,
    explanation:'5ème cat = sous le seuil défini par TYPE (ex : type R 100 personnes, type O 19, type N 19, etc.). Pas de limite unique. Au-dessus = 4ème, 3ème, 2ème ou 1ère cat.' },
  { type:'quiz', title:'Euroclasses réaction', question:'Quelle Euroclasse correspond à la meilleure réaction au feu (matériau incombustible) ?',
    options:['A1','B','D','F'], correctAnswer:0,
    explanation:'A1 = incombustible (ex : béton, acier, verre). A2 = quasi-incombustible. B/C/D = combustibles à degrés croissants. F = sans performance définie.' },
  { type:'quiz', title:'Désenfumage objectif', question:'Quel est l\'objectif PRINCIPAL du désenfumage ?',
    options:['Refroidir les locaux','Éliminer la fumée pour permettre l\'évacuation et l\'intervention','Évacuer le CO2','Faire des économies d\'énergie'], correctAnswer:1,
    explanation:'Désenfumage = évacuation des fumées pour : (1) maintenir cheminements praticables, (2) protéger la structure (T° baisse), (3) faciliter l\'intervention pompiers.' },

  // TRUE-FALSE ×3
  { type:'true-false', title:'IGH bureaux 28m', question:'Un immeuble de bureaux est classé IGH dès que le plancher bas du dernier niveau dépasse 28 m.',
    options:['Vrai','Faux'], correctAnswer:0,
    explanation:'VRAI — Seuil IGH bureaux/hôtels/enseignement = 28 m (mesuré du sol accessible aux pompiers au plancher bas du dernier niveau).' },
  { type:'true-false', title:'5ème catégorie sans visite', question:'Un ERP de 5ème catégorie sans locaux à sommeil n\'a aucune visite de la commission de sécurité.',
    options:['Vrai','Faux'], correctAnswer:0,
    explanation:'VRAI — 5ème cat sans sommeil dispense de visite périodique. Sauf à l\'ouverture, ou en cas de transformation, ou plainte. Avec sommeil = visites prévues.' },
  { type:'true-false', title:'Compartimentage ERP', question:'Le compartimentage d\'un ERP doit toujours respecter une surface maximale de 800 m² par compartiment.',
    options:['Vrai','Faux'], correctAnswer:1,
    explanation:'FAUX — La surface dépend du type d\'ERP, de la catégorie, de la présence de sprinkler. Ex : 1500 m² possibles avec sprinkler. Pas de chiffre unique universel.' },

  // MULTI ×3
  { type:'multiple-select', title:'Composition commission sécurité', question:'Quels membres font OBLIGATOIREMENT partie d\'une commission de sécurité communale ?',
    options:['Maire ou son représentant','SDIS (sapeurs-pompiers)','DDT (urbanisme/accessibilité)','Police nationale','Représentant de l\'Église'],
    correctAnswers:[0,1,2,3],
    explanation:'Maire + SDIS + DDT + police/gendarmerie = membres permanents. L\'Église n\'a aucun rôle réglementaire. Le directeur d\'ERP est invité mais pas membre.' },
  { type:'multiple-select', title:'Documents notice sécurité', question:'Que contient une notice descriptive de sécurité ?',
    options:['Calculs d\'effectif','Description des moyens de secours','Programme musical de l\'établissement','Plans des dégagements','Mode de désenfumage prévu'],
    correctAnswers:[0,1,3,4],
    explanation:'Notice = doc technique pour la commission : effectifs, moyens, dégagements, désenfumage, isolement, alarme. Pas de programme commercial.' },
  { type:'multiple-select', title:'Avantages compartimentage', question:'Quels sont les bénéfices du compartimentage ?',
    options:['Limiter la propagation du feu','Préserver les voies d\'évacuation','Augmenter le coefficient d\'occupation','Faciliter l\'intervention pompiers','Réduire la facture électrique'],
    correctAnswers:[0,1,3],
    explanation:'Limiter propagation + préserver chemins + faciliter intervention. Le coefficient d\'occupation et l\'électricité ne sont pas concernés par le compartimentage.' },

  // FIND-INTRUDER ×2
  { type:'find-intruder', title:'Pas un type ERP', question:'Lequel de ces types ERP N\'EXISTE PAS dans la réglementation française ?',
    options:['Type J — Personnes âgées','Type L — Salles polyvalentes','Type Q — Bureaux administratifs','Type V — Lieux de culte'],
    correctAnswer:2,
    explanation:'Type Q n\'existe pas. Bureaux = Type W. J, L, V sont valides. Les types vont de J à Y, plus PA/SG/CTS/REF/PS pour cas particuliers.' },
  { type:'find-intruder', title:'Pas une obligation IGH', question:'Laquelle de ces obligations N\'EST PAS spécifique aux IGH ?',
    options:['Service de sécurité 24h/24','Compartimentage 2500 m²/3 niveaux','Évacuation totale au signal d\'alarme','Colonne humide aux étages'],
    correctAnswer:2,
    explanation:'Évacuation IGH = SECTORISÉE (par compartiment), pas totale. C\'est la spécificité IGH : on évacue le compartiment sinistré + 2 voisins, pas tout l\'immeuble.' },

  // SCENARIO ×2
  { type:'scenario', title:'Travaux par points chauds', question:'Action correcte ?',
    scenario:'Une entreprise extérieure soude un escalier métallique au 3ème étage. Vous arrivez et constatez : pas de permis de feu, pas d\'extincteur à proximité, atmosphère poussiéreuse.',
    options:['Laisser faire — l\'entreprise est qualifiée','Stopper immédiatement et exiger un permis de feu signé','Faire signer un permis verbal','Aller acheter un extincteur'],
    correctAnswer:1,
    explanation:'Permis de feu (GN13) obligatoire AVANT travaux par points chauds. Sans permis = arrêt immédiat. Document écrit, signé donneur d\'ordre + exécutant, valable 1 jour.' },
  { type:'scenario', title:'Vérification commission imminente', question:'Que faites-vous ?',
    scenario:'La commission de sécurité passe demain. Le directeur vous demande de "ranger" le registre en supprimant les anomalies récentes.',
    options:['Obéir, on a le temps de corriger','Refuser fermement, garder l\'intégrité du registre, expliquer le risque pénal de falsification','Photocopier le registre original','Signaler à la commission par téléphone'],
    correctAnswer:1,
    explanation:'Falsifier un registre = infraction pénale. Refuser, archiver l\'original, traiter les anomalies réglementairement. La commission préfère un registre honnête à un faux.' },

  // IMAGE-IDENTIFY ×2 (pictograms existants : assembly, exit-direction)
  { type:'image-identify', title:'Pictogramme rassemblement', question:'Ce pictogramme vert ISO 7010 désigne :',
    imageKey:'assembly', imageDesc:'ISO 7010 — E007',
    options:['Une zone de fumeurs','Le point de rassemblement après évacuation','Une infirmerie','Une zone de chargement'],
    correctAnswer:1,
    explanation:'E007 — Point de rassemblement. Position obligatoire sur le plan d\'évacuation. Communiquée aux pompiers à leur arrivée.' },
  { type:'image-identify', title:'Sortie de secours', question:'Ce panneau vert avec personnage et flèche indique :',
    imageKey:'exit-direction', imageDesc:'ISO 7010 — E003',
    options:['Direction des toilettes','Direction d\'une issue de secours','Sortie de l\'entreprise','Zone de fitness'],
    correctAnswer:1,
    explanation:'E003 — Direction issue de secours. Doit être éclairé par BAES, jalonné jusqu\'à la sortie finale.' },

  // SEQUENCE ×2
  { type:'sequence', title:'Étapes ouverture ERP', question:'Remettez dans l\'ordre les étapes pour ouvrir un nouvel ERP :',
    items:['Dépôt de la demande au maire','Étude technique des services','Visite et avis de la commission','Arrêté d\'autorisation d\'ouverture du maire'],
    correctOrder:[0,1,2,3],
    explanation:'Demande → étude → visite/avis → arrêté. L\'avis défavorable bloque l\'ouverture. Délai légal 4 mois maximum.' },
  { type:'sequence', title:'Hiérarchie réglementaire', question:'Classez ces textes du PLUS GÉNÉRAL au PLUS PARTICULIER :',
    items:['Loi (Code de la Construction)','Décrets (R.123)','Arrêté (règlement de sécurité)','Notice descriptive du bâtiment'],
    correctOrder:[0,1,2,3],
    explanation:'Loi > Décret > Arrêté > document spécifique au bâtiment. Cette pyramide guide en cas de doute : la norme la plus haute prime.' },

  // RANKING ×2
  { type:'ranking', title:'Catégories ERP par effectif', question:'Classez ces catégories ERP de l\'EFFECTIF LE PLUS ÉLEVÉ au PLUS FAIBLE :',
    items:['1ère catégorie (>1500 personnes)','2ème catégorie (701-1500)','3ème catégorie (301-700)','4ème catégorie (≤300, > seuil 5è)'],
    correctOrder:[0,1,2,3],
    explanation:'Plus le numéro est petit, plus l\'effectif est grand. La 5ème (sous seuil) n\'est pas listée ici car elle dépend du type.' },
  { type:'ranking', title:'Sévérité Euroclasses', question:'Classez les Euroclasses du PLUS PERFORMANT au MOINS PERFORMANT face au feu :',
    items:['A1 — Incombustible','A2 — Très peu combustible','B — Combustible difficilement inflammable','D — Combustible très inflammable'],
    correctOrder:[0,1,2,3],
    explanation:'A1 > A2 > B > C > D > E > F. Lettre haute = meilleure réaction au feu. Sous-classes (-s1, -s2, -d0, -d1) précisent fumées/gouttelettes.' },

  // MATCHING ×2
  { type:'matching', title:'Type ERP ↔ activité', question:'Associez chaque type ERP à son activité principale :',
    pairs:[{left:'Type J',right:'Personnes âgées / handicapées'},{left:'Type M',right:'Magasins / centres commerciaux'},{left:'Type R',right:'Enseignement'},{left:'Type U',right:'Établissements de soins'}],
    explanation:'J = personnes âgées. L = salles polyvalentes. M = magasins. N = restaurants. O = hôtels. R = enseignement. U = soins. À mémoriser pour SSIAP 1.' },
  { type:'matching', title:'IGH ↔ destination', question:'Associez chaque classe IGH à sa destination :',
    pairs:[{left:'GHA',right:'Habitation (>50 m)'},{left:'GHO',right:'Hôtels'},{left:'GHU',right:'Sanitaire'},{left:'GHW',right:'Bureaux'}],
    explanation:'GH + lettre = type. A=habitation, O=hôtels, R=enseignement, S=archives, U=sanitaire, W=bureaux, Z=mixte. Seuil IGH habitation 50 m, autres 28 m.' },

  // FILL-BLANK ×2
  { type:'fill-blank', title:'Complétez seuils IGH',
    question:'Complétez les seuils :',
    sentence:'Un IGH habitation est défini à partir de %1% mètres. Un IGH bureaux à partir de %2% mètres.',
    correctBlanks:['50','28'],
    wordBank:['50','28','100','12','40','60'],
    explanation:'IGH habitation : 50 m (plancher bas dernier niveau). Autres usages (bureaux, hôtels, enseignement) : 28 m. Au-delà = ITGH (300 m).' },
  { type:'fill-blank', title:'Complétez compartimentage IGH',
    question:'Complétez les règles de compartimentage IGH :',
    sentence:'Dans un IGH, chaque compartiment ne doit pas dépasser %1% m² et %2% niveaux superposés.',
    correctBlanks:['2500','3'],
    wordBank:['2500','3','5000','2','1000','5','1500','4'],
    explanation:'Article GH 10 : 2500 m² max et 3 niveaux max. Parois CF 2 h. Ces seuils découpent l\'IGH en zones autonomes.' },

  // CATEGORIES ×1
  { type:'categories', title:'Type ERP par activité',
    question:'Classez ces établissements dans le bon type ERP :',
    categories:[{id:'M',label:'🛍️ Type M — Magasins'},{id:'O',label:'🏨 Type O — Hôtels'},{id:'R',label:'🎓 Type R — Enseignement'}],
    items:[{text:'Centre commercial',category:'M'},{text:'Hôtel 4 étoiles',category:'O'},{text:'Lycée professionnel',category:'R'},{text:'Crèche',category:'R'},{text:'Hypermarché',category:'M'},{text:'Auberge de jeunesse',category:'O'}],
    explanation:'Bien classer = appliquer la bonne réglementation. Crèche = R (enseignement/petite enfance). Auberge = O (hébergement).' },

  // DECISION ×1
  { type:'decision', title:'Demande modification structurelle', question:'Arbre de décision :',
    scenario:'Un locataire de votre ERP veut percer un mur porteur entre deux locaux pour agrandir sa boutique. Il vous dit que ce sont "juste des travaux d\'aménagement".',
    steps:[
      { question:'ÉTAPE 1 — Vérifiez-vous l\'impact sécurité ?',
        options:[{text:'Oui, mur porteur = risque structure et compartimentage',nextStep:1},{text:'Non, c\'est l\'affaire du locataire',nextStep:99},{text:'Refuser sans analyse',nextStep:99}] },
      { question:'ÉTAPE 2 — Quelle procédure imposer ?',
        options:[{text:'Étude par bureau d\'études + demande commission de sécurité',nextStep:2},{text:'Verbal au directeur uniquement',nextStep:99},{text:'Aucune — bricolage interne suffit',nextStep:99}] },
      { question:'ÉTAPE 3 — Avant les travaux ?',
        options:[{text:'Permis de feu signé + balisage + extincteurs sur place',nextStep:null},{text:'Aucune préparation',nextStep:null},{text:'Couper le feu d\'alarme',nextStep:null}] }
    ],
    correctPath:[0,0,0],
    explanation:'Mur porteur + compartimentage CF = sécurité. Procédure : analyse → étude → commission → permis de feu → travaux. Skip une étape = engager sa responsabilité.' }
];

// ─── Generation ──────────────────────────────────────────────────────
const E = (v) => v == null ? 'null' : typeof v === 'number' || typeof v === 'boolean' ? String(v) : `'${String(v).replace(/'/g,"''")}'`;
const intArr = (a) => a == null ? 'null' : `array[${a.join(',')}]`;
const txtArr = (a) => a == null ? 'null' : `array[${a.map(E).join(',')}]`;

const partA = ['begin;', `delete from public.questions where id like '${PREFIX}-%';`,
  `insert into public.questions (id, module_id, type, title, question, scenario, situation, explanation, correct_answer, correct_answers, correct_order, correct_blanks, correct_path, word_bank, sentence, image_key, image_desc, tags, pool, display_order) values`];
const rows = Q.map((q,i) => {
  const id = `${PREFIX}-q${i+1}`;
  return `(${E(id)}, ${E(MOD)}, ${E(q.type)}, ${E(q.title)}, ${E(q.question)}, ${E(q.scenario||null)}, null, ${E(q.explanation)}, ${q.correctAnswer ?? 'null'}, ${intArr(q.correctAnswers)}::integer[], ${intArr(q.correctOrder)}::integer[], ${txtArr(q.correctBlanks)}::text[], ${intArr(q.correctPath)}::integer[], ${txtArr(q.wordBank)}::text[], ${E(q.sentence||null)}, ${E(q.imageKey||null)}, ${E(q.imageDesc||null)}, array['handcrafted','starter-pack','partie2-ext']::text[], 'challenge', (select coalesce(max(display_order),-1)+1+${i} from public.questions q2 where q2.module_id=${E(MOD)} and q2.id not like '${PREFIX}-%'))`;
});
partA.push(rows.join(',\n') + ';', 'commit;');

const partB = ['begin;'];
const opts=[],items=[],pairs=[],cats=[],catItems=[],steps=[];
Q.forEach((q,i) => {
  const id = `${PREFIX}-q${i+1}`;
  if (q.options) q.options.forEach((o,j)=>opts.push(`(${E(id)},${j},${E(o)})`));
  if (q.items && q.type !== 'categories') q.items.forEach((it,j)=>items.push(`(${E(id)},${j},${E(it)})`));
  if (q.pairs) q.pairs.forEach((p,j)=>pairs.push(`(${E(id)},${j},${E(p.left)},${E(p.right)})`));
  if (q.categories) q.categories.forEach((c,j)=>cats.push(`(${E(id)},${j},${E(c.id)},${E(c.label)})`));
  if (q.type === 'categories' && q.items) q.items.forEach((it,j)=>catItems.push(`(${E(id)},${j},${E(it.text)},${E(it.category)})`));
  if (q.steps) q.steps.forEach((s,j)=>steps.push(`(${E(id)},${j},${E(s.question)},'${JSON.stringify(s.options).replace(/'/g,"''")}'::jsonb)`));
});
if (opts.length) partB.push('insert into public.question_options (question_id,option_index,option_text) values\n'+opts.join(',\n')+';');
if (items.length) partB.push('insert into public.question_items (question_id,item_index,item_text) values\n'+items.join(',\n')+';');
if (pairs.length) partB.push('insert into public.question_pairs (question_id,pair_index,left_text,right_text) values\n'+pairs.join(',\n')+';');
if (cats.length) partB.push('insert into public.question_categories (question_id,category_index,category_id,category_label) values\n'+cats.join(',\n')+';');
if (catItems.length) partB.push('insert into public.question_category_items (question_id,item_index,item_text,correct_category) values\n'+catItems.join(',\n')+';');
if (steps.length) partB.push('insert into public.question_decision_steps (question_id,step_index,step_question,options) values\n'+steps.join(',\n')+';');
partB.push('commit;');

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');
fs.writeFileSync(path.join(root,'supabase/migrations/0017a_partie2_ext_questions.sql'), partA.join('\n')+'\n');
fs.writeFileSync(path.join(root,'supabase/migrations/0017b_partie2_ext_subtables.sql'), partB.join('\n')+'\n');
const types={};Q.forEach(q=>{types[q.type]=(types[q.type]||0)+1;});
console.log(`Generated ${Q.length} questions for ${MOD} (extension)`);console.table(types);
