-- ================================================================
--  Al Amin Pal — Supabase schema (brands / categories / products)
--  Run this in: Supabase Dashboard → SQL Editor → New query → Run
-- ================================================================

-- ---------- TABLES ----------
create table if not exists public.brands (
  id          bigint generated always as identity primary key,
  slug        text unique not null,
  name        text not null,
  logo_url    text,
  sort        int  default 0,
  active      boolean default true,
  created_at  timestamptz default now()
);

create table if not exists public.categories (
  id          bigint generated always as identity primary key,
  brand_id    bigint references public.brands(id) on delete cascade,
  slug        text unique not null,
  name        text not null,
  cover_url   text,
  sort        int  default 0,
  active      boolean default true,
  created_at  timestamptz default now()
);

create table if not exists public.products (
  id           bigint generated always as identity primary key,
  category_id  bigint references public.categories(id) on delete cascade,
  name         text not null,
  description  text,
  image_url    text,
  sort         int  default 0,
  active       boolean default true,
  created_at   timestamptz default now()
);

create index if not exists idx_categories_brand on public.categories(brand_id);
create index if not exists idx_products_category on public.products(category_id);

-- ---------- ROW LEVEL SECURITY ----------
alter table public.brands     enable row level security;
alter table public.categories enable row level security;
alter table public.products   enable row level security;

-- Public (anon) can READ everything — needed for the public website
drop policy if exists "public read brands" on public.brands;
create policy "public read brands" on public.brands for select using (true);
drop policy if exists "public read categories" on public.categories;
create policy "public read categories" on public.categories for select using (true);
drop policy if exists "public read products" on public.products;
create policy "public read products" on public.products for select using (true);

-- Only logged-in admins can INSERT / UPDATE / DELETE
drop policy if exists "auth write brands" on public.brands;
create policy "auth write brands" on public.brands for all to authenticated using (true) with check (true);
drop policy if exists "auth write categories" on public.categories;
create policy "auth write categories" on public.categories for all to authenticated using (true) with check (true);
drop policy if exists "auth write products" on public.products;
create policy "auth write products" on public.products for all to authenticated using (true) with check (true);

-- ---------- STORAGE (images bucket) ----------
insert into storage.buckets (id, name, public)
values ('media', 'media', true)
on conflict (id) do nothing;

drop policy if exists "public read media" on storage.objects;
create policy "public read media" on storage.objects
  for select using (bucket_id = 'media');

drop policy if exists "auth upload media" on storage.objects;
create policy "auth upload media" on storage.objects
  for insert to authenticated with check (bucket_id = 'media');

drop policy if exists "auth update media" on storage.objects;
create policy "auth update media" on storage.objects
  for update to authenticated using (bucket_id = 'media');

drop policy if exists "auth delete media" on storage.objects;
create policy "auth delete media" on storage.objects
  for delete to authenticated using (bucket_id = 'media');

-- Done. Next: create an admin user in Authentication → Users → Add user.
