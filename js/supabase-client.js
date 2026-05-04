// =====================================================================
// Challenge Cup SSIAP — Supabase client
// Replaces Firebase Realtime Database. Loaded as an ES module.
//
// Usage in index.html:
//   <script type="module">
//     import { initSupabase, supa } from './js/supabase-client.js';
//     await initSupabase();
//     // then call supa.sessions.create(...), supa.teams.subscribe(...), etc.
//   </script>
// =====================================================================

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const SUPABASE_URL = 'https://uojhwuwplpodgnwvwvmm.supabase.co';
const SUPABASE_KEY = 'sb_publishable_D0J8NNAGuXqy0u1lQ2qqhg_WZrLAzWk';

export let client = null;

export function initSupabase() {
  if (client) return client;
  client = createClient(SUPABASE_URL, SUPABASE_KEY, {
    auth: { persistSession: false },
    realtime: { params: { eventsPerSecond: 10 } },
  });
  return client;
}

// ---------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------

const c = () => client ?? initSupabase();

async function ok(promise, label) {
  const { data, error } = await promise;
  if (error) {
    console.error(`[supabase] ${label}:`, error);
    throw error;
  }
  return data;
}

// ---------------------------------------------------------------------
// AUTH (supervisor login via RPC)
// ---------------------------------------------------------------------

export const auth = {
  async login(email, password) {
    const data = await ok(
      c().rpc('verify_supervisor', { p_email: email, p_password: password }),
      'verify_supervisor',
    );
    return Array.isArray(data) ? (data[0] ?? null) : data;
  },
};

// ---------------------------------------------------------------------
// MODULES + QUESTIONS catalogue
// ---------------------------------------------------------------------

export const catalogue = {
  // Returns full question with all sub-tables joined.
  async questionWithAll(questionId) {
    return ok(
      c().from('questions').select(`
        *,
        question_options(option_index, option_text),
        question_items(item_index, item_text),
        question_pairs(pair_index, left_text, right_text),
        question_categories(category_index, category_id, category_label),
        question_category_items(item_index, item_text, correct_category),
        question_decision_steps(step_index, step_question, options)
      `).eq('id', questionId).single(),
      'questionWithAll',
    );
  },

  // Returns all modules (active) for a level, ordered, with their questions.
  async modulesForLevel(level) {
    const modules = await ok(
      c().from('modules')
        .select('*')
        .eq('level', level)
        .eq('is_active', true)
        .order('display_order', { ascending: true }),
      'modulesForLevel',
    );
    const moduleIds = modules.map(m => m.id);
    if (!moduleIds.length) return [];

    const questions = await ok(
      c().from('questions').select(`
        *,
        question_options(option_index, option_text),
        question_items(item_index, item_text),
        question_pairs(pair_index, left_text, right_text),
        question_categories(category_index, category_id, category_label),
        question_category_items(item_index, item_text, correct_category),
        question_decision_steps(step_index, step_question, options)
      `).in('module_id', moduleIds).eq('is_active', true).eq('status', 'published')
        .order('display_order', { ascending: true }),
      'questionsForModules',
    );

    // Reshape sub-tables into legacy shape used by the renderer.
    const byModule = Object.fromEntries(modules.map(m => [m.id, { ...m, games: [] }]));
    for (const q of questions) {
      byModule[q.module_id].games.push(reshapeQuestion(q));
    }
    return modules.map(m => byModule[m.id]);
  },
};

function sortBy(arr, key) {
  return [...(arr ?? [])].sort((a, b) => a[key] - b[key]);
}

// Reshape a Supabase question row (with joined sub-tables) into the legacy
// shape expected by the renderer (BOXES_LEVEL_X structure).
export function reshapeQuestion(q) {
  const opts  = sortBy(q.question_options,        'option_index').map(o => o.option_text);
  const items = sortBy(q.question_items,          'item_index'  ).map(i => i.item_text);
  const pairs = sortBy(q.question_pairs,          'pair_index'  ).map(p => ({ left: p.left_text, right: p.right_text }));
  const cats  = sortBy(q.question_categories,     'category_index').map(c => ({ id: c.category_id, label: c.category_label }));
  const cItems= sortBy(q.question_category_items, 'item_index'  ).map(i => ({ text: i.item_text, category: i.correct_category }));
  const steps = sortBy(q.question_decision_steps, 'step_index'  ).map(s => ({ question: s.step_question, options: s.options }));

  const out = {
    id:             q.id,
    type:           q.type,
    title:          q.title,
    question:       q.question,
    scenario:       q.scenario,
    situation:      q.situation,
    explanation:    q.explanation,
    correctAnswer:  q.correct_answer,
    correctAnswers: q.correct_answers,
    correctOrder:   q.correct_order,
    correctBlanks:  q.correct_blanks,
    correctPath:    q.correct_path,
    wordBank:       q.word_bank,
    sentence:       q.sentence,
    imageUrl:       q.image_url,
    videoUrl:       q.video_url,
    imageKey:       q.image_key,
    imageDesc:      q.image_desc,
  };
  if (opts.length)   out.options    = opts;
  if (items.length)  out.items      = items;
  if (pairs.length)  out.pairs      = pairs;
  if (cats.length)   out.categories = cats;
  if (cItems.length) out.items      = cItems; // categories type uses {text, category}
  if (steps.length)  out.steps      = steps;
  return out;
}

// ---------------------------------------------------------------------
// SESSIONS
// ---------------------------------------------------------------------

export const sessions = {
  async create(level, config = {}) {
    const data = await ok(
      c().rpc('create_session', { p_level: level, p_config: config }),
      'create_session',
    );
    return Array.isArray(data) ? data[0] : data;
  },
  async getByCode(code) {
    return ok(
      c().from('sessions').select('*').eq('session_code', code).maybeSingle(),
      'sessions.getByCode',
    );
  },
  async getById(id) {
    return ok(
      c().from('sessions').select('*').eq('id', id).maybeSingle(),
      'sessions.getById',
    );
  },
  async update(id, patch) {
    return ok(
      c().from('sessions').update(patch).eq('id', id),
      'sessions.update',
    );
  },
  async setStatus(id, status) {
    return this.update(id, { status });
  },
  async setCurrent(id, { module_id, q_idx, started_at }) {
    return this.update(id, {
      current_module_id: module_id,
      current_q_idx: q_idx,
      question_started_at: started_at ?? new Date().toISOString(),
      answers_count: 0,
    });
  },
  async incrementAnswers(id) {
    // Two-step: read then write (Supabase has no atomic increment without rpc)
    const s = await this.getById(id);
    return this.update(id, { answers_count: (s?.answers_count ?? 0) + 1 });
  },
  async setRandomizedGames(id, randomized_games) {
    return this.update(id, { randomized_games });
  },
  async addOpenedModule(id, moduleId) {
    const s = await this.getById(id);
    const opened = Array.from(new Set([...(s?.opened_modules ?? []), moduleId]));
    return this.update(id, { opened_modules: opened });
  },
  async reset(id) {
    // Cascade-deletes teams + team_answers (FK on delete cascade)
    return ok(c().from('sessions').delete().eq('id', id), 'sessions.reset');
  },

  // Realtime subscription on a single session row.
  // Returns the channel; call .unsubscribe() to clean up.
  subscribe(id, onChange) {
    const chan = c().channel(`session:${id}`)
      .on('postgres_changes',
          { event: '*', schema: 'public', table: 'sessions', filter: `id=eq.${id}` },
          payload => onChange(payload.new ?? payload.old, payload))
      .subscribe();
    return chan;
  },
};

// ---------------------------------------------------------------------
// TEAMS
// ---------------------------------------------------------------------

export const teams = {
  async list(sessionId) {
    return ok(
      c().from('teams').select('*').eq('session_id', sessionId).order('joined_at'),
      'teams.list',
    );
  },
  async join(sessionId, name, avatar = '👷') {
    return ok(
      c().from('teams').insert({ session_id: sessionId, name, avatar })
        .select().single(),
      'teams.join',
    );
  },
  async update(id, patch) {
    return ok(c().from('teams').update(patch).eq('id', id), 'teams.update');
  },
  async setOnline(id, online) {
    return this.update(id, { online, last_seen_at: new Date().toISOString() });
  },
  async resetAnswerFlags(sessionId) {
    return ok(
      c().from('teams').update({ has_answered: false }).eq('session_id', sessionId),
      'teams.resetAnswerFlags',
    );
  },
  async remove(id) {
    return ok(c().from('teams').delete().eq('id', id), 'teams.remove');
  },

  // Realtime: subscribe to all teams in a session.
  subscribe(sessionId, onChange) {
    return c().channel(`teams:${sessionId}`)
      .on('postgres_changes',
          { event: '*', schema: 'public', table: 'teams', filter: `session_id=eq.${sessionId}` },
          payload => onChange(payload))
      .subscribe();
  },
};

// ---------------------------------------------------------------------
// ANSWERS
// ---------------------------------------------------------------------

export const answers = {
  async submit({ session_id, team_id, question_id, module_id, q_idx, answer,
                 is_correct, answer_time_ms, base_points, speed_bonus, total_points }) {
    return ok(
      c().from('team_answers').insert({
        session_id, team_id, question_id, module_id, q_idx, answer,
        is_correct, answer_time_ms, base_points, speed_bonus, total_points,
      }).select().single(),
      'answers.submit',
    );
  },
  async countForCurrent(sessionId, questionId) {
    const { count, error } = await c().from('team_answers')
      .select('*', { count: 'exact', head: true })
      .eq('session_id', sessionId)
      .eq('question_id', questionId);
    if (error) throw error;
    return count;
  },
  subscribe(sessionId, onChange) {
    return c().channel(`answers:${sessionId}`)
      .on('postgres_changes',
          { event: '*', schema: 'public', table: 'team_answers', filter: `session_id=eq.${sessionId}` },
          payload => onChange(payload))
      .subscribe();
  },
};

// ---------------------------------------------------------------------
// LOGS
// ---------------------------------------------------------------------

export const logs = {
  async push({ session_id, level = 'info', category, message, team_name, metadata = {} }) {
    return ok(
      c().from('logs').insert({ session_id, level, category, message, team_name, metadata }),
      'logs.push',
    );
  },
  async list(sessionId, limit = 200) {
    return ok(
      c().from('logs').select('*').eq('session_id', sessionId)
        .order('created_at', { ascending: false }).limit(limit),
      'logs.list',
    );
  },
};

// ---------------------------------------------------------------------
// STORAGE (for question media uploads — used by the future admin UI)
// ---------------------------------------------------------------------

export const media = {
  bucket: 'question-media',
  async upload(file, path) {
    return ok(
      c().storage.from(this.bucket).upload(path, file, { upsert: true }),
      'media.upload',
    );
  },
  publicUrl(path) {
    return c().storage.from(this.bucket).getPublicUrl(path).data.publicUrl;
  },
};

// ---------------------------------------------------------------------
// AGGREGATE EXPORT
// ---------------------------------------------------------------------

export const supa = { auth, catalogue, sessions, teams, answers, logs, media };
export default supa;
