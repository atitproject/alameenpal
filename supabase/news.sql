-- ================================================================
--  Al Amin Pal — News & Events table
--  Run this in: Supabase Dashboard → SQL Editor → New query → Run
-- ================================================================

create table if not exists public.news (
  id          bigint generated always as identity primary key,
  title       text not null,
  description text,
  cover_url   text,
  images      jsonb default '[]'::jsonb,   -- up to 12 sub-image URLs
  sort        int  default 0,
  active      boolean default true,
  created_at  timestamptz default now()
);

create index if not exists idx_news_sort on public.news(sort);

-- ---------- ROW LEVEL SECURITY ----------
alter table public.news enable row level security;

-- Public (anon) can READ — needed for the public website
drop policy if exists "public read news" on public.news;
create policy "public read news" on public.news for select using (true);

-- Only logged-in admins can INSERT / UPDATE / DELETE
drop policy if exists "auth write news" on public.news;
create policy "auth write news" on public.news for all to authenticated using (true) with check (true);

-- Done. The "media" storage bucket from schema.sql is reused for the images.
