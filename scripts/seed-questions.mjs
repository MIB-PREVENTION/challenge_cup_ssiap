// Seed modules + questions into Supabase using REST (no SDK dependency).
// Uses the publishable / service-role key from env.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');

const SUPABASE_URL = process.env.SUPABASE_URL || 'https://uojhwuwplpodgnwvwvmm.supabase.co';
const KEY = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_KEY;
if (!KEY) {
  console.error('Set SUPABASE_SERVICE_ROLE_KEY or SUPABASE_KEY');
  process.exit(1);
}

async function upsert(table, rows, onConflict) {
  if (!rows.length) return;
  const url = `${SUPABASE_URL}/rest/v1/${table}?on_conflict=${onConflict}`;
  const res = await fetch(url, {
    method: 'POST',
    headers: {
      apikey: KEY,
      Authorization: `Bearer ${KEY}`,
      'Content-Type': 'application/json',
      Prefer: 'resolution=merge-duplicates,return=minimal',
    },
    body: JSON.stringify(rows),
  });
  if (!res.ok) {
    throw new Error(`${table}: ${res.status} ${res.statusText}\n${await res.text()}`);
  }
  console.log(`  ${table}: ${rows.length} rows`);
}

const file = process.argv[2] || path.join(root, 'data', 'questions-ssiap1.json');
const dataset = JSON.parse(fs.readFileSync(file, 'utf8'));

const modules = dataset.modules.map(({ questions, ...m }) => m);

const questions = [];
const optionsRows = [], itemsRows = [], pairsRows = [];
const catRows = [], catItemRows = [], stepRows = [];

for (const m of dataset.modules) {
  for (const q of m.questions) {
    const { options, items, pairs, categories, category_items, decision_steps, ...rest } = q;
    questions.push(rest);
    options?.forEach((opt, i) => optionsRows.push({ question_id: q.id, option_index: i, option_text: opt }));
    items?.forEach((it, i) => itemsRows.push({ question_id: q.id, item_index: i, item_text: it }));
    pairs?.forEach((p, i) => pairsRows.push({
      question_id: q.id, pair_index: i,
      left_text:  p.left  ?? p.from ?? p[0],
      right_text: p.right ?? p.to   ?? p[1],
    }));
    categories?.forEach((c, i) => catRows.push({
      question_id: q.id, category_index: i,
      category_id:    c.id    ?? c.key  ?? `cat-${i}`,
      category_label: c.label ?? c.name ?? String(c),
    }));
    category_items?.forEach((it, i) => catItemRows.push({
      question_id: q.id, item_index: i,
      item_text:        it.text     ?? it.item ?? String(it),
      correct_category: it.category ?? it.cat,
    }));
    decision_steps?.forEach((s, i) => stepRows.push({
      question_id: q.id, step_index: i,
      step_question: s.question ?? s.q,
      options: s.options ?? [],
    }));
  }
}

console.log(`Seeding ${SUPABASE_URL}`);
await upsert('modules', modules, 'id');
await upsert('questions', questions, 'id');
await upsert('question_options',        optionsRows, 'question_id,option_index');
await upsert('question_items',          itemsRows,   'question_id,item_index');
await upsert('question_pairs',          pairsRows,   'question_id,pair_index');
await upsert('question_categories',     catRows,     'question_id,category_index');
await upsert('question_category_items', catItemRows, 'question_id,item_index');
await upsert('question_decision_steps', stepRows,    'question_id,step_index');
console.log('Seed complete.');
