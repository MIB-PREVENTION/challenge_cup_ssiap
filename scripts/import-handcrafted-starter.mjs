// Imports the 58 hand-crafted SSIAP 1 questions (12 game types) from the
// `e834f6a` JSON and remaps them onto the 5-partie module structure used
// by the live DB. Generates a single SQL file applied via execute_sql.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { execSync } from 'node:child_process';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');

// Pull the original from git history (reads only, no checkout).
const raw = execSync('git show e834f6a:data/questions-ssiap1.json', { cwd: root, encoding: 'utf8' });
const src = JSON.parse(raw);

// Old module → new partie mapping. Keep the same thematic distribution.
const MAP = {
  'ssiap1-box-1': 'ssiap1-partie1',  // Le Feu → Le feu et ses conséquences
  'ssiap1-box-2': 'ssiap1-partie2',  // ERP & IGH → La sécurité incendie
  'ssiap1-box-3': 'ssiap1-partie3',  // Moyens de Secours → Les installations techniques
  'ssiap1-box-4': 'ssiap1-partie4',  // Évacuation → Rôle et missions de l'agent SSIAP 1
};

const E = (v) => v == null ? 'null'
  : typeof v === 'number' || typeof v === 'boolean' ? String(v)
  : `'${String(v).replace(/'/g, "''")}'`;
const intArr = (a) => a == null ? 'null' : `array[${a.join(',')}]`;
const txtArr = (a) => a == null ? 'null' : `array[${a.map(E).join(',')}]`;

const sql = ['begin;'];
const allRows = [];
const subInserts = { options: [], items: [], pairs: [], categories: [], categoryItems: [], decisionSteps: [] };

for (const m of src.modules) {
  const newModule = MAP[m.id];
  if (!newModule) continue;
  for (const q of m.questions) {
    const newId = `ssiap1-hc-${q.id.replace(/^ssiap1-/, '')}`;
    allRows.push({
      id: newId,
      module_id: newModule,
      type: q.type,
      title: q.title,
      question: q.question,
      scenario: q.scenario,
      situation: q.situation,
      explanation: q.explanation,
      correctAnswer: q.correct_answer,
      correctAnswers: q.correct_answers,
      correctOrder: q.correct_order,
      correctBlanks: q.correct_blanks,
      correctPath: q.correct_path,
      wordBank: q.word_bank,
      sentence: q.sentence,
      imageKey: q.image_key,
      imageDesc: q.image_desc,
      tags: ['handcrafted', 'starter-pack'],
    });
    if (q.options) q.options.forEach((o, i) => subInserts.options.push({ qid: newId, i, text: o }));
    if (q.items)   q.items.forEach((it, i) => subInserts.items.push({ qid: newId, i, text: it }));
    if (q.pairs)   q.pairs.forEach((p, i) => subInserts.pairs.push({ qid: newId, i, left: p.left ?? p.from ?? p[0], right: p.right ?? p.to ?? p[1] }));
    if (q.categories) q.categories.forEach((c, i) => subInserts.categories.push({ qid: newId, i, id: c.id, label: c.label }));
    if (q.category_items) q.category_items.forEach((it, i) => subInserts.categoryItems.push({ qid: newId, i, text: it.text, cat: it.category }));
    if (q.decision_steps) q.decision_steps.forEach((s, i) => subInserts.decisionSteps.push({ qid: newId, i, q: s.question, opts: s.options }));
  }
}

// Wipe any prior import of this starter pack (idempotent).
sql.push("delete from public.questions where id like 'ssiap1-hc-%';");

// Compute display_order: append after existing questions in each module.
sql.push(`with maxes as (
  select module_id, coalesce(max(display_order), -1) as m
  from public.questions
  where module_id in ${'(' + [...new Set(allRows.map(r=>E(r.module_id)))].join(',') + ')'}
  group by module_id
)
select 1;`);

// Per-module starting display_order computed in JS (not in SQL since we don't know it ahead).
// We'll resolve it server-side per row via subquery.

// Insert questions
sql.push(`insert into public.questions
  (id, module_id, type, title, question, scenario, situation, explanation,
   correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
   word_bank, sentence, image_key, image_desc, tags, display_order)
values`);
const valueRows = allRows.map(r => `(${E(r.id)}, ${E(r.module_id)}, ${E(r.type)}, ${E(r.title)},
  ${E(r.question)}, ${E(r.scenario)}, ${E(r.situation)}, ${E(r.explanation)},
  ${r.correctAnswer ?? 'null'}, ${intArr(r.correctAnswers)}::integer[],
  ${intArr(r.correctOrder)}::integer[], ${txtArr(r.correctBlanks)}::text[],
  ${intArr(r.correctPath)}::integer[], ${txtArr(r.wordBank)}::text[],
  ${E(r.sentence)}, ${E(r.imageKey)}, ${E(r.imageDesc)},
  ${txtArr(r.tags)}::text[],
  (select coalesce(max(display_order), -1) + 1 + 0 from public.questions q2 where q2.module_id = ${E(r.module_id)}))`);
sql.push(valueRows.join(',\n') + ';');

// Sub-tables
if (subInserts.options.length) {
  sql.push('insert into public.question_options (question_id, option_index, option_text) values');
  sql.push(subInserts.options.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.text)})`).join(',\n') + ';');
}
if (subInserts.items.length) {
  sql.push('insert into public.question_items (question_id, item_index, item_text) values');
  sql.push(subInserts.items.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.text)})`).join(',\n') + ';');
}
if (subInserts.pairs.length) {
  sql.push('insert into public.question_pairs (question_id, pair_index, left_text, right_text) values');
  sql.push(subInserts.pairs.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.left)}, ${E(o.right)})`).join(',\n') + ';');
}
if (subInserts.categories.length) {
  sql.push('insert into public.question_categories (question_id, category_index, category_id, category_label) values');
  sql.push(subInserts.categories.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.id)}, ${E(o.label)})`).join(',\n') + ';');
}
if (subInserts.categoryItems.length) {
  sql.push('insert into public.question_category_items (question_id, item_index, item_text, correct_category) values');
  sql.push(subInserts.categoryItems.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.text)}, ${E(o.cat)})`).join(',\n') + ';');
}
if (subInserts.decisionSteps.length) {
  sql.push('insert into public.question_decision_steps (question_id, step_index, step_question, options) values');
  sql.push(subInserts.decisionSteps.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.q)}, '${JSON.stringify(o.opts).replace(/'/g, "''")}'::jsonb)`).join(',\n') + ';');
}

sql.push('commit;');

// Split into two parts so each fits in a single execute_sql call.
const partA = ['begin;'];
partA.push("delete from public.questions where id like 'ssiap1-hc-%';");
partA.push(`insert into public.questions
  (id, module_id, type, title, question, scenario, situation, explanation,
   correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
   word_bank, sentence, image_key, image_desc, tags, display_order)
values
${valueRows.join(',\n')};`);
partA.push('commit;');
fs.writeFileSync(path.join(root, 'supabase', 'migrations', '0013a_starter_questions.sql'), partA.join('\n') + '\n');

const partB = ['begin;'];
if (subInserts.options.length) {
  partB.push('insert into public.question_options (question_id, option_index, option_text) values');
  partB.push(subInserts.options.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.text)})`).join(',\n') + ';');
}
if (subInserts.items.length) {
  partB.push('insert into public.question_items (question_id, item_index, item_text) values');
  partB.push(subInserts.items.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.text)})`).join(',\n') + ';');
}
if (subInserts.pairs.length) {
  partB.push('insert into public.question_pairs (question_id, pair_index, left_text, right_text) values');
  partB.push(subInserts.pairs.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.left)}, ${E(o.right)})`).join(',\n') + ';');
}
if (subInserts.categories.length) {
  partB.push('insert into public.question_categories (question_id, category_index, category_id, category_label) values');
  partB.push(subInserts.categories.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.id)}, ${E(o.label)})`).join(',\n') + ';');
}
if (subInserts.categoryItems.length) {
  partB.push('insert into public.question_category_items (question_id, item_index, item_text, correct_category) values');
  partB.push(subInserts.categoryItems.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.text)}, ${E(o.cat)})`).join(',\n') + ';');
}
if (subInserts.decisionSteps.length) {
  partB.push('insert into public.question_decision_steps (question_id, step_index, step_question, options) values');
  partB.push(subInserts.decisionSteps.map(o => `(${E(o.qid)}, ${o.i}, ${E(o.q)}, '${JSON.stringify(o.opts).replace(/'/g, "''")}'::jsonb)`).join(',\n') + ';');
}
partB.push('commit;');
fs.writeFileSync(path.join(root, 'supabase', 'migrations', '0013b_starter_subtables.sql'), partB.join('\n') + '\n');

console.log('Wrote 0013a_starter_questions.sql and 0013b_starter_subtables.sql');
console.log('Distribution per module:');
const dist = {};
allRows.forEach(r => { dist[r.module_id] = (dist[r.module_id] || 0) + 1; });
console.table(dist);
console.log('Distribution per type:');
const tdist = {};
allRows.forEach(r => { tdist[r.type] = (tdist[r.type] || 0) + 1; });
console.table(tdist);
