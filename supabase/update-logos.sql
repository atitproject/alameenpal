-- Set brand logos (run in Supabase SQL Editor)
update public.brands set logo_url='https://atitproject.github.io/alameenpal/brands/logo-wefaq.png' where slug='wefaq';
update public.brands set logo_url='https://atitproject.github.io/alameenpal/brands/logo-kitco.png' where slug='kitco';
-- Arizona & Hero logos: upload via the Admin dashboard (Brands → Edit → Brand Logo),
-- or add here once the files are in brands/logo-arizona.png and brands/logo-hero.png:
-- update public.brands set logo_url='https://atitproject.github.io/alameenpal/brands/logo-arizona.png' where slug='arizona';
-- update public.brands set logo_url='https://atitproject.github.io/alameenpal/brands/logo-hero.png' where slug='hero';
