-- Lumen · esquema do Supabase v2 (login, níveis de acesso e baralhos)
-- Rode no Supabase: SQL Editor > New query > cole tudo > Run.
-- Este esquema foi escrito mas AINDA NÃO foi executado num Supabase real: se aparecer erro, me envie a mensagem.
--
-- Se você já rodou a versão anterior deste arquivo, rode primeiro (apaga as tabelas antigas):
--   drop table if exists public.card_progress, public.cards, public.decks, public.profiles cascade;

-- ===== Tabelas =====
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  role text not null default 'starter' check (role in ('admin','starter','prime')),
  created_at timestamptz not null default now()
);

create table if not exists public.decks (
  id uuid primary key default gen_random_uuid(),
  owner uuid references auth.users(id) on delete cascade,   -- null = baralho do sistema
  name text not null,
  description text,
  is_shared boolean not null default false,                  -- true = visível para todos os usuários logados
  created_at timestamptz not null default now()
);

create table if not exists public.cards (
  id uuid primary key default gen_random_uuid(),
  deck_id uuid not null references public.decks(id) on delete cascade,
  position int not null default 0,
  question text not null,
  answer text not null
);
create index if not exists cards_deck_idx on public.cards(deck_id);

create table if not exists public.card_progress (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  card_id uuid not null references public.cards(id) on delete cascade,
  difficulty text check (difficulty in ('easy','medium','hard')),
  seen int not null default 0,
  correct int not null default 0,
  wrong int not null default 0,
  last text check (last in ('right','wrong')),
  updated_at timestamptz not null default now(),
  primary key (user_id, card_id)
);

-- ===== Nível do usuário logado (sem recursão nas regras) =====
create or replace function public.my_role() returns text
language sql stable security definer set search_path = public as $$
  select role from public.profiles where id = auth.uid()
$$;

-- ===== Todo novo usuário nasce Starter =====
create or replace function public.handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, email) values (new.id, new.email) on conflict do nothing;
  return new;
end $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
  for each row execute function public.handle_new_user();

-- usuários que já existiam antes deste script
insert into public.profiles (id, email) select id, email from auth.users on conflict do nothing;

-- ===== Segurança por linha (RLS) =====
alter table public.profiles enable row level security;
alter table public.decks enable row level security;
alter table public.cards enable row level security;
alter table public.card_progress enable row level security;

-- profiles: cada um vê o seu; admin vê e altera todos (só admin muda níveis)
drop policy if exists "profiles_select" on public.profiles;
create policy "profiles_select" on public.profiles for select
  using (id = auth.uid() or public.my_role() = 'admin');
drop policy if exists "profiles_update_admin" on public.profiles;
create policy "profiles_update_admin" on public.profiles for update
  using (public.my_role() = 'admin') with check (public.my_role() = 'admin');

-- decks: starter vê só os compartilhados; prime vê os compartilhados + os seus; admin vê tudo
drop policy if exists "decks_select" on public.decks;
create policy "decks_select" on public.decks for select
  using (is_shared or owner = auth.uid() or public.my_role() = 'admin');
drop policy if exists "decks_insert" on public.decks;
create policy "decks_insert" on public.decks for insert
  with check (public.my_role() = 'admin'
    or (public.my_role() = 'prime' and owner = auth.uid() and is_shared = false));
drop policy if exists "decks_update" on public.decks;
create policy "decks_update" on public.decks for update
  using (public.my_role() = 'admin' or (public.my_role() = 'prime' and owner = auth.uid() and is_shared = false))
  with check (public.my_role() = 'admin' or (public.my_role() = 'prime' and owner = auth.uid() and is_shared = false));
drop policy if exists "decks_delete" on public.decks;
create policy "decks_delete" on public.decks for delete
  using (public.my_role() = 'admin' or (public.my_role() = 'prime' and owner = auth.uid() and is_shared = false));

-- cards: seguem o baralho a que pertencem
drop policy if exists "cards_select" on public.cards;
create policy "cards_select" on public.cards for select
  using (exists (select 1 from public.decks d where d.id = cards.deck_id));
drop policy if exists "cards_write" on public.cards;
create policy "cards_write" on public.cards for all
  using (exists (select 1 from public.decks d where d.id = cards.deck_id
    and (public.my_role() = 'admin' or (public.my_role() = 'prime' and d.owner = auth.uid() and d.is_shared = false))))
  with check (exists (select 1 from public.decks d where d.id = cards.deck_id
    and (public.my_role() = 'admin' or (public.my_role() = 'prime' and d.owner = auth.uid() and d.is_shared = false))));

-- progresso: cada pessoa só enxerga e altera o próprio
drop policy if exists "progress_own" on public.card_progress;
create policy "progress_own" on public.card_progress for all
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- ===== Depois de criar a sua conta no app, torne-se administrador (troque o e-mail) =====
-- update public.profiles set role = 'admin' where email = 'SEU_EMAIL@exemplo.com';
