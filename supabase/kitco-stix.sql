-- Replace Kitco Stix (kitco-1) products with the 6 flavours (run in Supabase SQL Editor)
delete from public.products where category_id = (select id from public.categories where slug='kitco-1');

insert into public.products (category_id, name, description, image_url, sort) values
((select id from public.categories where slug='kitco-1'), 'Lightly Salted', 'Crunchy original potato sticks, lightly salted. 40g can.', 'https://atitproject.github.io/alameenpal/brands/kitco-1/p1.jpeg', 1),
((select id from public.categories where slug='kitco-1'), 'Grilled Chicken', 'Potato sticks with a savoury grilled chicken flavour. 40g can.', 'https://atitproject.github.io/alameenpal/brands/kitco-1/p2.jpeg', 2),
((select id from public.categories where slug='kitco-1'), 'Hot & Spicy', 'Potato sticks with a hot & spicy kick. 40g can.', 'https://atitproject.github.io/alameenpal/brands/kitco-1/p3.jpeg', 3),
((select id from public.categories where slug='kitco-1'), 'Paprika', 'Potato sticks seasoned with sweet paprika. 40g can.', 'https://atitproject.github.io/alameenpal/brands/kitco-1/p4.jpeg', 4),
((select id from public.categories where slug='kitco-1'), 'Tomato Ketchup', 'Potato sticks with a tangy tomato ketchup flavour. 40g can.', 'https://atitproject.github.io/alameenpal/brands/kitco-1/p5.jpeg', 5),
((select id from public.categories where slug='kitco-1'), 'Tabasco', 'Potato sticks with a zesty Tabasco pepper-sauce flavour. 40g can.', 'https://atitproject.github.io/alameenpal/brands/kitco-1/p6.jpeg', 6);
