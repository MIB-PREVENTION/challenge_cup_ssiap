-- Missing CRUD policies that the live game (and the future admin UI) need.

create policy "sessions insert" on public.sessions for insert with check (true);
create policy "sessions delete" on public.sessions for delete using (true);

create policy "teams delete" on public.teams for delete using (true);

create policy "modules insert" on public.modules for insert with check (true);
create policy "modules update" on public.modules for update using (true) with check (true);
create policy "modules delete" on public.modules for delete using (true);

create policy "questions insert" on public.questions for insert with check (true);
create policy "questions update" on public.questions for update using (true) with check (true);
create policy "questions delete" on public.questions for delete using (true);

create policy "options insert" on public.question_options for insert with check (true);
create policy "options update" on public.question_options for update using (true) with check (true);
create policy "options delete" on public.question_options for delete using (true);
create policy "items insert" on public.question_items for insert with check (true);
create policy "items update" on public.question_items for update using (true) with check (true);
create policy "items delete" on public.question_items for delete using (true);
create policy "pairs insert" on public.question_pairs for insert with check (true);
create policy "pairs update" on public.question_pairs for update using (true) with check (true);
create policy "pairs delete" on public.question_pairs for delete using (true);
create policy "categories insert" on public.question_categories for insert with check (true);
create policy "categories update" on public.question_categories for update using (true) with check (true);
create policy "categories delete" on public.question_categories for delete using (true);
create policy "cat items insert" on public.question_category_items for insert with check (true);
create policy "cat items update" on public.question_category_items for update using (true) with check (true);
create policy "cat items delete" on public.question_category_items for delete using (true);
create policy "decision steps insert" on public.question_decision_steps for insert with check (true);
create policy "decision steps update" on public.question_decision_steps for update using (true) with check (true);
create policy "decision steps delete" on public.question_decision_steps for delete using (true);

create policy "team_answers update" on public.team_answers for update using (true) with check (true);
create policy "team_answers delete" on public.team_answers for delete using (true);
