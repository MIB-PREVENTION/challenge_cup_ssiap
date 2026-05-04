// Generates a single SQL file from data/questions-ssiap1.json
// Output is intended to be applied via Supabase MCP execute_sql or psql.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');

const dataset = JSON.parse(fs.readFileSync(
  path.join(root, 'data', 'questions-ssiap1.json'), 'utf8'));

const E = (v) => v === null || v === undefined
  ? 'null'
  : typeof v === 'number' || typeof v === 'boolean'
    ? String(v)
    : `'${String(v).replace(/'/g, "''")}'`;

const arr = (v, mapper = E) => v == null
  ? 'null'
  : `array[${v.map(mapper).join(',')}]`;

const sql = [];
sql.push('-- Auto-generated seed for SSIAP 1');
sql.push('begin;');
sql.push('-- 1. modules');
for (const m of dataset.modules) {
  sql.push(`insert into public.modules (id, level, title, subtitle, icon, color, display_order, is_active)
values (${E(m.id)}, ${m.level}, ${E(m.title)}, ${E(m.subtitle)}, ${E(m.icon)}, ${E(m.color)}, ${m.display_order}, ${m.is_active})
on conflict (id) do update set title=excluded.title, subtitle=excluded.subtitle, icon=excluded.icon, color=excluded.color, display_order=excluded.display_order, is_active=excluded.is_active;`);
}

sql.push('-- 2. questions');
for (const m of dataset.modules) {
  for (const q of m.questions) {
    const intArr = (v) => arr(v, n => String(n));
    const txtArr = (v) => arr(v, E);
    sql.push(`insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc,
  display_order
) values (
  ${E(q.id)}, ${E(q.module_id)}, ${E(q.type)}, ${E(q.title)}, ${E(q.question)},
  ${E(q.scenario)}, ${E(q.situation)}, ${E(q.explanation)},
  ${q.correct_answer ?? 'null'}, ${intArr(q.correct_answers)}::integer[],
  ${intArr(q.correct_order)}::integer[], ${txtArr(q.correct_blanks)}::text[],
  ${intArr(q.correct_path)}::integer[], ${txtArr(q.word_bank)}::text[],
  ${E(q.sentence)}, ${E(q.image_url)}, ${E(q.video_url)},
  ${E(q.image_key)}, ${E(q.image_desc)}, ${q.display_order}
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();`);
  }
}

sql.push('-- 3. clear & repopulate sub-tables for these questions');
const qIds = dataset.modules.flatMap(m => m.questions.map(q => q.id));
const inIds = qIds.map(E).join(',');
sql.push(`delete from public.question_options        where question_id in (${inIds});`);
sql.push(`delete from public.question_items          where question_id in (${inIds});`);
sql.push(`delete from public.question_pairs          where question_id in (${inIds});`);
sql.push(`delete from public.question_categories     where question_id in (${inIds});`);
sql.push(`delete from public.question_category_items where question_id in (${inIds});`);
sql.push(`delete from public.question_decision_steps where question_id in (${inIds});`);

for (const m of dataset.modules) {
  for (const q of m.questions) {
    q.options?.forEach((opt, i) =>
      sql.push(`insert into public.question_options (question_id, option_index, option_text) values (${E(q.id)}, ${i}, ${E(opt)});`));
    q.items?.forEach((it, i) =>
      sql.push(`insert into public.question_items (question_id, item_index, item_text) values (${E(q.id)}, ${i}, ${E(it)});`));
    q.pairs?.forEach((p, i) => {
      const left = p.left  ?? p.from ?? p[0];
      const right = p.right ?? p.to   ?? p[1];
      sql.push(`insert into public.question_pairs (question_id, pair_index, left_text, right_text) values (${E(q.id)}, ${i}, ${E(left)}, ${E(right)});`);
    });
    q.categories?.forEach((c, i) => {
      const cid = c.id ?? c.key ?? `cat-${i}`;
      const lbl = c.label ?? c.name ?? String(c);
      sql.push(`insert into public.question_categories (question_id, category_index, category_id, category_label) values (${E(q.id)}, ${i}, ${E(cid)}, ${E(lbl)});`);
    });
    q.category_items?.forEach((it, i) => {
      const txt = it.text ?? it.item ?? String(it);
      const cat = it.category ?? it.cat;
      sql.push(`insert into public.question_category_items (question_id, item_index, item_text, correct_category) values (${E(q.id)}, ${i}, ${E(txt)}, ${E(cat)});`);
    });
    q.decision_steps?.forEach((s, i) => {
      const sq = s.question ?? s.q ?? '';
      const opts = JSON.stringify(s.options ?? []).replace(/'/g, "''");
      sql.push(`insert into public.question_decision_steps (question_id, step_index, step_question, options) values (${E(q.id)}, ${i}, ${E(sq)}, '${opts}'::jsonb);`);
    });
  }
}
sql.push('commit;');

// Single combined file (for git/PR readability)
const combinedOut = path.join(root, 'supabase', 'migrations', '0005_seed_ssiap1_questions.sql');
fs.writeFileSync(combinedOut, sql.join('\n') + '\n');
console.log(`Wrote ${combinedOut} (${sql.length} statements)`);

// Per-module chunks (small enough to apply via MCP execute_sql)
const chunkDir = path.join(root, 'scripts', 'seed-chunks');
fs.mkdirSync(chunkDir, { recursive: true });
for (const m of dataset.modules) {
  const chunk = [];
  chunk.push('begin;');
  chunk.push(`-- module ${m.id} : ${m.title}`);
  chunk.push(`insert into public.modules (id, level, title, subtitle, icon, color, display_order, is_active)
values (${E(m.id)}, ${m.level}, ${E(m.title)}, ${E(m.subtitle)}, ${E(m.icon)}, ${E(m.color)}, ${m.display_order}, ${m.is_active})
on conflict (id) do update set title=excluded.title, subtitle=excluded.subtitle, icon=excluded.icon;`);

  const intArr = (v) => arr(v, n => String(n));
  const txtArr = (v) => arr(v, E);

  for (const q of m.questions) {
    chunk.push(`insert into public.questions (
  id, module_id, type, title, question, scenario, situation, explanation,
  correct_answer, correct_answers, correct_order, correct_blanks, correct_path,
  word_bank, sentence, image_url, video_url, image_key, image_desc, display_order
) values (
  ${E(q.id)}, ${E(q.module_id)}, ${E(q.type)}, ${E(q.title)}, ${E(q.question)},
  ${E(q.scenario)}, ${E(q.situation)}, ${E(q.explanation)},
  ${q.correct_answer ?? 'null'}, ${intArr(q.correct_answers)}::integer[],
  ${intArr(q.correct_order)}::integer[], ${txtArr(q.correct_blanks)}::text[],
  ${intArr(q.correct_path)}::integer[], ${txtArr(q.word_bank)}::text[],
  ${E(q.sentence)}, ${E(q.image_url)}, ${E(q.video_url)},
  ${E(q.image_key)}, ${E(q.image_desc)}, ${q.display_order}
) on conflict (id) do update set
  type=excluded.type, title=excluded.title, question=excluded.question,
  scenario=excluded.scenario, situation=excluded.situation, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  correct_order=excluded.correct_order, correct_blanks=excluded.correct_blanks,
  correct_path=excluded.correct_path, word_bank=excluded.word_bank,
  sentence=excluded.sentence, image_url=excluded.image_url, video_url=excluded.video_url,
  image_key=excluded.image_key, image_desc=excluded.image_desc,
  display_order=excluded.display_order, updated_at=now();`);
  }

  const qIdsM = m.questions.map(q => E(q.id)).join(',');
  chunk.push(`delete from public.question_options        where question_id in (${qIdsM});`);
  chunk.push(`delete from public.question_items          where question_id in (${qIdsM});`);
  chunk.push(`delete from public.question_pairs          where question_id in (${qIdsM});`);
  chunk.push(`delete from public.question_categories     where question_id in (${qIdsM});`);
  chunk.push(`delete from public.question_category_items where question_id in (${qIdsM});`);
  chunk.push(`delete from public.question_decision_steps where question_id in (${qIdsM});`);

  for (const q of m.questions) {
    q.options?.forEach((opt, i) =>
      chunk.push(`insert into public.question_options (question_id, option_index, option_text) values (${E(q.id)}, ${i}, ${E(opt)});`));
    q.items?.forEach((it, i) =>
      chunk.push(`insert into public.question_items (question_id, item_index, item_text) values (${E(q.id)}, ${i}, ${E(it)});`));
    q.pairs?.forEach((p, i) => {
      const left = p.left ?? p.from ?? p[0];
      const right = p.right ?? p.to ?? p[1];
      chunk.push(`insert into public.question_pairs (question_id, pair_index, left_text, right_text) values (${E(q.id)}, ${i}, ${E(left)}, ${E(right)});`);
    });
    q.categories?.forEach((c, i) => {
      const cid = c.id ?? c.key ?? `cat-${i}`;
      const lbl = c.label ?? c.name ?? String(c);
      chunk.push(`insert into public.question_categories (question_id, category_index, category_id, category_label) values (${E(q.id)}, ${i}, ${E(cid)}, ${E(lbl)});`);
    });
    q.category_items?.forEach((it, i) => {
      const txt = it.text ?? it.item ?? String(it);
      const cat = it.category ?? it.cat;
      chunk.push(`insert into public.question_category_items (question_id, item_index, item_text, correct_category) values (${E(q.id)}, ${i}, ${E(txt)}, ${E(cat)});`);
    });
    q.decision_steps?.forEach((s, i) => {
      const sq = s.question ?? s.q ?? '';
      const opts = JSON.stringify(s.options ?? []).replace(/'/g, "''");
      chunk.push(`insert into public.question_decision_steps (question_id, step_index, step_question, options) values (${E(q.id)}, ${i}, ${E(sq)}, '${opts}'::jsonb);`);
    });
  }
  chunk.push('commit;');
  const f = path.join(chunkDir, `${m.id}.sql`);
  fs.writeFileSync(f, chunk.join('\n') + '\n');
  console.log(`Wrote ${path.relative(root, f)} (${chunk.length} statements)`);
}
