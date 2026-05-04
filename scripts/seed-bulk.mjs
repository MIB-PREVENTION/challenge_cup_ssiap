// Bulk-seed all SSIAP levels into Supabase using the bulk_seed_level RPC.
// One RPC call per level; the function wipes old rows and inserts new ones.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');

const SUPABASE_URL = 'https://uojhwuwplpodgnwvwvmm.supabase.co';
const KEY = 'sb_publishable_D0J8NNAGuXqy0u1lQ2qqhg_WZrLAzWk';

const ICONS  = ['🔥','🏛️','⚙️','👨‍🚒','🎯','📋','🛡️'];
const COLORS = [
  'from-red-500 to-orange-600',
  'from-blue-600 to-indigo-700',
  'from-cyan-500 to-blue-600',
  'from-emerald-500 to-teal-600',
  'from-purple-500 to-pink-600',
  'from-amber-500 to-orange-600',
];

function buildPayload(level, data) {
  const modules = [];
  const questions = [];
  const options = [];
  const groups = new Map();
  for (const q of data.questions) {
    if (!groups.has(q.partie)) groups.set(q.partie, { label: q.partieLabel, questions: [] });
    groups.get(q.partie).questions.push(q);
  }
  let partieIdx = 0;
  for (const [partieKey, group] of groups) {
    const moduleId = `ssiap${level}-${partieKey}`;
    modules.push({
      id: moduleId,
      title: group.label,
      subtitle: `${group.questions.length} questions`,
      icon: ICONS[partieIdx % ICONS.length],
      color: COLORS[partieIdx % COLORS.length],
      display_order: partieIdx,
      is_active: true,
    });
    group.questions.forEach((q, i) => {
      const qId = `ssiap${level}-q${q.id}`;
      const isMulti = q.correctAnswers.length > 1;
      questions.push({
        id: qId,
        module_id: moduleId,
        type: isMulti ? 'multiple-select' : 'quiz',
        question: q.question,
        explanation: q.explanation?.complete ?? null,
        correct_answer:  isMulti ? null : q.correctAnswers[0],
        correct_answers: isMulti ? q.correctAnswers : null,
        tags: [q.theme, q.sequence, q.themeLabel, q.sequenceLabel].filter(Boolean),
        display_order: i,
      });
      q.options.forEach((opt, idx) => options.push({
        question_id: qId, option_index: idx, option_text: opt,
      }));
    });
    partieIdx++;
  }
  return { modules, questions, options };
}

async function callRPC(level, payload) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/rpc/bulk_seed_level`, {
    method: 'POST',
    headers: {
      apikey: KEY,
      Authorization: `Bearer ${KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ p_level: level, p_payload: payload }),
  });
  if (!res.ok) {
    throw new Error(`SSIAP ${level}: ${res.status} ${res.statusText}\n${await res.text()}`);
  }
  return res.json();
}

const levels = process.argv.slice(2).map(Number).filter(n => [1,2,3].includes(n));
const target = levels.length ? levels : [1, 2, 3];

for (const level of target) {
  const file = path.join(root, 'data', `ssiap${level}_FINAL_200.json`);
  const data = JSON.parse(fs.readFileSync(file, 'utf8'));
  console.log(`SSIAP ${level}: building payload from ${data.questions.length} questions...`);
  const payload = buildPayload(level, data);
  console.log(`  modules: ${payload.modules.length}, questions: ${payload.questions.length}, options: ${payload.options.length}`);
  const r = await callRPC(level, payload);
  console.log(`  result:`, r);
}
console.log('All done.');
