// Transform data/ssiap{1,2,3}_FINAL_200.json into Supabase seed SQL chunks.
// One SQL file per (level, partie) module — each chunk fits in a single
// execute_sql call.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');

const E = (v) => v === null || v === undefined
  ? 'null'
  : typeof v === 'number' || typeof v === 'boolean'
    ? String(v)
    : `'${String(v).replace(/'/g, "''")}'`;

// Generic icons + colors per partie order
const ICONS  = ['🔥','🏛️','⚙️','👨‍🚒','🎯','📋','🛡️'];
const COLORS = [
  'from-red-500 to-orange-600',
  'from-blue-600 to-indigo-700',
  'from-cyan-500 to-blue-600',
  'from-emerald-500 to-teal-600',
  'from-purple-500 to-pink-600',
  'from-amber-500 to-orange-600',
];

const chunkDir = path.join(root, 'scripts', 'seed-final-chunks');
fs.rmSync(chunkDir, { recursive: true, force: true });
fs.mkdirSync(chunkDir, { recursive: true });

const QUESTIONS_PER_CHUNK = 20; // keeps each chunk under ~30KB

const allChunks = [];

function buildModuleSQL(moduleId, level, label, total, partieIdx) {
  return `insert into public.modules (id, level, title, subtitle, icon, color, display_order, is_active)
values (${E(moduleId)}, ${level}, ${E(label)}, ${E(`${total} questions`)}, ${E(ICONS[partieIdx % ICONS.length])}, ${E(COLORS[partieIdx % COLORS.length])}, ${partieIdx}, true)
on conflict (id) do update set title=excluded.title, subtitle=excluded.subtitle, icon=excluded.icon, color=excluded.color, display_order=excluded.display_order;`;
}

function buildQuestionsSQL(moduleId, level, questions, baseDisplayIdx) {
  const valueRows = questions.map((q, i) => {
    const qId = `ssiap${level}-q${q.id}`;
    const isMulti = q.correctAnswers.length > 1;
    const type = isMulti ? 'multiple-select' : 'quiz';
    const correctAnswer  = isMulti ? 'null' : String(q.correctAnswers[0]);
    const correctAnswers = isMulti
      ? `array[${q.correctAnswers.join(',')}]::integer[]`
      : 'null::integer[]';
    const explanation = q.explanation?.complete ?? null;
    const tags = `array[${[q.theme, q.sequence, q.themeLabel, q.sequenceLabel]
      .filter(Boolean).map(E).join(',')}]::text[]`;
    return `(${E(qId)}, ${E(moduleId)}, ${E(type)}, ${E(q.question)}, ${E(explanation)}, ${correctAnswer}, ${correctAnswers}, ${tags}, ${baseDisplayIdx + i})`;
  });
  const optRows = [];
  for (const q of questions) {
    const qId = `ssiap${level}-q${q.id}`;
    q.options.forEach((opt, i) => optRows.push(`(${E(qId)}, ${i}, ${E(opt)})`));
  }
  const qIds = questions.map(q => E(`ssiap${level}-q${q.id}`)).join(',');
  return `insert into public.questions (
  id, module_id, type, question, explanation, correct_answer, correct_answers, tags, display_order
) values
${valueRows.join(',\n')}
on conflict (id) do update set
  type=excluded.type, question=excluded.question, explanation=excluded.explanation,
  correct_answer=excluded.correct_answer, correct_answers=excluded.correct_answers,
  tags=excluded.tags, display_order=excluded.display_order, updated_at=now();
delete from public.question_options where question_id in (${qIds});
insert into public.question_options (question_id, option_index, option_text) values
${optRows.join(',\n')};`;
}

for (const level of [1, 2, 3]) {
  const file = path.join(root, 'data', `ssiap${level}_FINAL_200.json`);
  const data = JSON.parse(fs.readFileSync(file, 'utf8'));

  const groups = new Map();
  for (const q of data.questions) {
    if (!groups.has(q.partie)) groups.set(q.partie, { label: q.partieLabel, questions: [] });
    groups.get(q.partie).questions.push(q);
  }

  let partieIdx = 0;
  for (const [partieKey, group] of groups) {
    const moduleId = `ssiap${level}-${partieKey}`;
    const total = group.questions.length;
    const sub = [];
    for (let off = 0; off < total; off += QUESTIONS_PER_CHUNK) {
      sub.push(group.questions.slice(off, off + QUESTIONS_PER_CHUNK));
    }
    sub.forEach((subset, idx) => {
      const sql = ['begin;'];
      sql.push(`-- SSIAP ${level} — ${group.label} (partie ${partieIdx+1}, sub ${idx+1}/${sub.length}, ${subset.length} questions)`);
      if (idx === 0) sql.push(buildModuleSQL(moduleId, level, group.label, total, partieIdx));
      sql.push(buildQuestionsSQL(moduleId, level, subset, idx * QUESTIONS_PER_CHUNK));
      sql.push('commit;');
      const fname = `${moduleId}-sub${String(idx+1).padStart(2,'0')}.sql`;
      fs.writeFileSync(path.join(chunkDir, fname), sql.join('\n') + '\n');
      const size = fs.statSync(path.join(chunkDir, fname)).size;
      allChunks.push({ name: fname, size, questions: subset.length });
    });
    partieIdx++;
  }
}

console.log('Wrote', allChunks.length, 'chunks to', path.relative(root, chunkDir));
const max = Math.max(...allChunks.map(c => c.size));
const totalQ = allChunks.reduce((s, c) => s + c.questions, 0);
console.log(`Total questions: ${totalQ}, Max chunk size: ${max} bytes`);
