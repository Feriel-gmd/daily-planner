-- Run this once in Supabase: SQL Editor > New query > paste > Run.
-- One table holds every record of the app (tasks, boards, challenges, routines, goals, events, profile).

create table if not exists public.items (
  id         text primary key,
  user_id    uuid not null default auth.uid() references auth.users(id) on delete cascade,
  type       text not null,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

create index if not exists items_user_idx on public.items (user_id, type);

-- Privacy: each user can only see and change their own rows.
alter table public.items enable row level security;

create policy "read own items"   on public.items for select using (auth.uid() = user_id);
create policy "insert own items" on public.items for insert with check (auth.uid() = user_id);
create policy "update own items" on public.items for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "delete own items" on public.items for delete using (auth.uid() = user_id);

-- Live sync between your phone and laptop.
alter publication supabase_realtime add table public.items;
