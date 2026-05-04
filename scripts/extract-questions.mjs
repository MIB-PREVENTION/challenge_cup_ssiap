// Extract BOXES_LEVEL_1 from index.html and save as data/questions-ssiap1.json
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(__dirname, '..');
const html = fs.readFileSync(path.join(root, 'index.html'), 'utf8');

// Locate the literal: const BOXES_LEVEL_1=[ ... ];
const startTok = 'const BOXES_LEVEL_1=';
const startIdx = html.indexOf(startTok);
if (startIdx < 0) throw new Error('BOXES_LEVEL_1 not found');

// Find matching closing bracket of the array literal
const arrStart = html.indexOf('[', startIdx);
let depth = 0, i = arrStart, inStr = null, esc = false;
for (; i < html.length; i++) {
  const c = html[i];
  if (inStr) {
    if (esc) { esc = false; continue; }
    if (c === '\\') { esc = true; continue; }
    if (c === inStr) inStr = null;
    continue;
  }
  if (c === '"' || c === "'" || c === '`') { inStr = c; continue; }
  if (c === '[') depth++;
  else if (c === ']') { depth--; if (depth === 0) { i++; break; } }
}
const literal = html.slice(arrStart, i);

// Evaluate the literal in a safe Function scope (it's pure data)
const data = new Function(`return (${literal});`)();

// Normalize boxes → modules with stable ids
const modules = data.map((box, bIdx) => ({
  id:            `ssiap1-box-${bIdx + 1}`,
  level:         1,
  title:         box.title,
  subtitle:      box.subtitle,
  icon:          box.icon,
  color:         box.color,
  display_order: bIdx,
  is_active:     true,
  questions: (box.games || []).map((q, qIdx) => ({
    id: `ssiap1-b${bIdx + 1}-q${qIdx + 1}`,
    module_id: `ssiap1-box-${bIdx + 1}`,
    display_order: qIdx,
    type:            q.type,
    title:           q.title ?? null,
    question:        q.question,
    scenario:        q.scenario ?? null,
    situation:       q.situation ?? null,
    explanation:     q.explanation ?? null,
    correct_answer:  q.correctAnswer ?? null,
    correct_answers: q.correctAnswers ?? null,
    correct_order:   q.correctOrder ?? null,
    correct_blanks:  q.correctBlanks ?? null,
    correct_path:    q.correctPath ?? null,
    word_bank:       q.wordBank ?? null,
    sentence:        q.sentence ?? null,
    image_url:       q.imageUrl ?? null,
    video_url:       q.videoUrl ?? null,
    image_key:       q.imageKey ?? null,
    image_desc:      q.imageDesc ?? null,
    options:         q.options ?? null,
    // 'items' for sequence/ranking are plain strings; for 'categories' they are
    // {text, category} pairs and must be split into category_items below.
    items:           q.type === 'categories' ? null : (q.items ?? null),
    pairs:           q.pairs ?? null,
    categories:      q.categories ?? null,
    category_items:  q.type === 'categories' ? (q.items ?? null) : null,
    // 'decision' uses `steps`, not `decisionSteps`.
    decision_steps:  q.steps ?? q.decisionSteps ?? null,
  })),
}));

// Sanity log
let totalQ = 0;
const types = new Set();
for (const m of modules) {
  totalQ += m.questions.length;
  for (const q of m.questions) types.add(q.type);
}

const out = path.join(root, 'data', 'questions-ssiap1.json');
fs.writeFileSync(out, JSON.stringify({ level: 1, modules }, null, 2));
console.log(`Wrote ${out}`);
console.log(`Modules: ${modules.length}, Questions: ${totalQ}`);
console.log(`Types found: ${[...types].join(', ')}`);
