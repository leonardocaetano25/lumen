-- Lumen · esquema inicial do Supabase (PRÓXIMA ETAPA: ainda não ligado ao app)
-- Rode no Supabase: SQL Editor > New query > cole tudo > Run.
-- Este esquema NÃO foi testado ainda: ao rodar, me avise se aparecer algum erro.

create table if not exists public.decks (
  id uuid primary key default gen_random_uuid(),
  owner uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  description text,
  is_public boolean not null default false,   -- true = qualquer pessoa pode estudar este conjunto
  created_at timestamptz not null default now()
);

create table if not exists public.cards (
  id uuid primary key default gen_random_uuid(),
  deck_id uuid not null references public.decks(id) on delete cascade,
  position int not null default 0,
  question text not null,
  answer text not null
);

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

alter table public.decks enable row level security;
alter table public.cards enable row level security;
alter table public.card_progress enable row level security;

-- Conjuntos: o dono gerencia; qualquer pessoa vê os públicos
create policy "decks: ver proprios ou publicos" on public.decks for select using (owner = auth.uid() or is_public);
create policy "decks: criar proprios" on public.decks for insert with check (owner = auth.uid());
create policy "decks: editar proprios" on public.decks for update using (owner = auth.uid());
create policy "decks: apagar proprios" on public.decks for delete using (owner = auth.uid());

-- Cartas: seguem as regras do conjunto a que pertencem
create policy "cards: ver" on public.cards for select
  using (exists (select 1 from public.decks d where d.id = deck_id and (d.owner = auth.uid() or d.is_public)));
create policy "cards: gerenciar do dono" on public.cards for all
  using (exists (select 1 from public.decks d where d.id = deck_id and d.owner = auth.uid()))
  with check (exists (select 1 from public.decks d where d.id = deck_id and d.owner = auth.uid()));

-- Progresso: cada pessoa só enxerga e altera o próprio
create policy "progresso: so o proprio" on public.card_progress for all
  using (user_id = auth.uid()) with check (user_id = auth.uid());
