CREATE TABLE shopping_records (
    id SERIAL PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    quantity FLOAT NOT NULL,
    unit VARCHAR(20) NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    total_cost DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * price_per_unit) STORED,
    store_name VARCHAR(100),
    date_of_purchase DATE NOT NULL,
    notes TEXT
);

select * from shopping_records;
alter table shopping_records drop column notes;
alter table shopping_records drop column brand;
alter table shopping_records alter column date_of_purchase set data type timestamptz;
insert into shopping_records(category, product_name, quantity, unit, price_per_unit, store_name, date_of_purchase)
values
('Household','Toilet paper',1,'PACK',336,'Eastmart','2023-08-14 14:30:50 EAT'),
('Household','Steel wool',1,'PCS',45,'Eastmart','2023-08-14 14:30:50 EAT'),
('Household','Steel bright',1,'PACK',97,'Eastmart','2023-08-14 14:30:50 EAT'),
('Food','Rina vegetable oil 2L',1,'PCS',569,'Eastmart','2023-08-14 14:30:50 EAT'),
('Personal care','Bathing sponge',1,'PCS',165,'Eastmart','2023-08-14 14:30:50 EAT'),
('Food','Gibson Inst coffee',2,'SATCHET',35,'Eastmart','2023-08-14 14:30:50 EAT'),
('Personal care','Versman classic',1,'PCS',399,'Eastmart','2023-08-14 14:30:50 EAT'),
('Food','Faraja tangawizi tea 250G',1,'PCS',150,'Eastmart','2023-08-14 14:30:50 EAT'),
('Household','Menengai bar soap 800G',1,'PCS',211,'Eastmart','2023-08-14 14:30:50 EAT'),
('Food','Long grain rice',2,'PACK',125,'Eastmart','2023-08-14 14:30:50 EAT'),
('Food','Two Ten Home Baking Flour 2KG',1,'PACK',175,'Eastmart','2023-08-14 14:30:50 EAT'),
('Food','Two Ten Maize Meal 2KG',1,'PACK',155,'Eastmart','2023-08-14 14:30:50 EAT'),
('Food','Brown sugar',2,'KG',215,'Eastmart','2023-08-14 14:30:50 EAT'),
('Personal Care','Imperial Leather Bathing Soap Value Pack X 3',1,'PACK',315,'Eastmart','2023-08-14 14:30:50 EAT'),
('Personal Care','Dettol Antiseptic 50G',1,'PACK',97,'Eastmart','2023-08-14 14:30:50 EAT'),
('Food','Soda Fanta Passion 2L',1,'PCS',165,'Eastmart','2023-09-09 19:05:02 EAT'),
('Food','Long Grain Rice',1,'KG',125,'Eastmart','2023-09-09 19:05:02 EAT'),
('Food','Brown sugar',1,'KG',215,'Eastmart','2023-09-09 19:05:02 EAT'),
('Food','Drinking Chocolate 225G',1,'JAR',213,'Eastmart','2023-09-09 19:05:02 EAT'),
('Food','Cooking Fat',1,'KG',335,'Eastmart','2023-09-09 19:05:02 EAT'),
('Food','Ajab Home Baking 2KG',1,'PACK',189,'Eastmart','2023-09-09 19:05:02 EAT'),
('Food','Soko Maize Meal 2KG',2,'PACK',177,'Eastmart','2023-09-09 19:05:02 EAT'),
('Household','Shine Scrubs 2PACK',1,'PCS',85,'Eastmart','2023-09-09 19:05:02 EAT'),
('Food','Soda Fanta Passion 2L',1,'PCS',165,'Eastmart','2024-03-01 10:42:02 EAT'),
('Personal Care','Bella White Tissue 4S',1,'PCS',100,'Eastmart','2024-03-01 10:42:02 EAT'),
('Food','Indomie Chicken Noodles 5 IN 1',1,'PCS',140,'Eastmart','2024-03-01 10:42:02 EAT'),
('Food','Soko Maize Meal 2KG',2,'PACK',149,'Eastmart','2024-03-01 10:42:02 EAT'),
('Food','Prestige 500G Original Spread',1,'PCS',215,'Eastmart','2024-03-01 10:42:02 EAT'),
('Food','Festive White Bread 600G',1,'PCS',100,'Eastmart','2024-03-01 10:42:02 EAT'),
('Food','Eastmatt Branded Sugar 2KG',1,'PACK',340,'Eastmart','2024-03-01 10:42:02 EAT'),
('Food','Eden Tea 250G',1,'PACK',150,'Eastmart','2024-03-01 10:42:02 EAT'),
('Food','Choco Muffins 6PC 300GMS',1,'PCS',143,'Quickmart','2024-04-01 06:20 EAT'),
('Personal Care','Imperial Japanese SPA 150G 2+1',1,'PACK',298,'Quickmart','2024-04-01 06:20 EAT'),
('Personal Care','Pepsodent TP Herbal',2,'PCS',150,'Quickmart','2024-04-01 06:20 EAT'),
('Food','Minute Maid Delight 1L',1,'PCS',122,'Quickmart','2024-04-01 06:20 EAT'),
('Food','Top Fry Vegetable Oil 3L',1,'PCS',773,'Eastmart','2024-06-11 11:05:14 EAT'),
('Food','C.I.L Blended Rice 2KG',1,'PACK',366,'Eastmart','2024-06-11 11:05:14 EAT'),
('Food','Kabras Sugar 2KG',1,'PACK',295,'Eastmart','2024-06-11 11:05:14 EAT'),
('Household','Menengai Cream 1KG',1,'PCS',212,'Eastmart','2024-06-11 11:05:14 EAT'),
('Food','Exe All Purpose 2KG',1,'PACK',380,'Eastmart','2024-06-11 11:05:14 EAT'),
('Food','Soko Maize Meal 2KG',4,'PCS',135,'Eastmart','2024-06-11 11:05:14 EAT'),
('Household','Ariel F,Springs 500G',1,'PCS',199,'Eastmart','2024-10-01 19:47:12 EAT'),
('Household','Sokoni Steel Wool 20G',5,'PCS',15,'Eastmart','2024-10-01 19:47:12 EAT'),
('Food','Indomie Chicken Noodles 5 IN 1',1,'PCS',140,'Eastmart','2024-10-01 19:47:12 EAT'),
('Personal Care','Imperial Leather B/Soap Uplifting 150G X 3',1,'PCS',298,'Eastmart','2024-10-01 19:47:12 EAT'),
('Food','Mumias Sugar 1KG',2,'PCS',129,'Eastmart','2024-10-01 19:47:12 EAT'),
('Food','Eastmart White Bread 600G',1,'PCS',89,'Eastmart','2024-10-01 19:47:12 EAT'),
('Food','Blue Band Choco Spread 500G',1,'PCS',280,'Eastmart','2024-10-01 19:47:12 EAT'),
('Food','Two Ten Maize Meal 2KG',3,'PACK',117,'Eastmart','2024-10-01 19:47:12 EAT'),
('Personal Care','Pepsodent Herbal T/Paste 150G Twin Pack',1,'PCS',375,'Eastmart','2024-10-01 19:47:12 EAT'),
('Pesonal Care','Amara Body Lotion 400ML For Men',1,'PCS',250,'Eastmart','2024-10-01 19:47:12 EAT'),
('Personal Care','Eastmart Toilet Paper Twin Pack',1,'PCS',75,'Eastmart','2024-10-01 19:47:12 EAT'),
('Food','Pembe Pure Wimbi 1KG',2,'PACK',140,'Eastmart','2024-10-01 19:47:12 EAT'),
('Personal Care','Vaseline PJ Fresh For Men 45ML',1,'PCS',85,'Eastmart','2024-10-01 19:47:12 EAT'),
('Personal Care','ORS O/Oil Sheen Spray 80ML',1,'PCS',185,'Bestlady','2024-12-09 12:55:39 EAT'),
('Personal Care','Urbo Freestyler For Men 150ML',1,'PCS',375,'Bestlady','2024-12-09 12:55:39 EAT'),
('Personal Care','Luron Men Revitalize Roll On 50ML',1,'PCS',210,'Bestlady','2024-12-09 12:55:39 EAT'),
('Personal Care','Bamsi Babylove Anti-Dandruff 250G',1,'PCS',185,'Bestlady','2024-12-09 12:55:39 EAT'),
('Personal Care','Rasta Sponge Curler',1,'PCS',300,'Bestlady','2024-12-09 12:55:39 EAT'),
('Personal Care','Amela Crystal Clear Shampoo 1L',1,'PCS',130,'Bestlady','2024-12-09 12:55:39 EAT');

update shopping_records
set date_of_purchase = '2023-08-14 14:30:50 EAT'
where id=1;

insert into shopping_records(category, product_name, quantity, unit, price_per_unit, store_name, date_of_purchase)
values
('Household', 'Sunlight Pink Powder 500G', 1, 'JAR', 240, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Household', 'Menengai Cream Soap 800G', 1, 'PCS', 184, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Food', 'Fresh Blend Pure Tea 250G', 1, 'PCS', 110, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Food', 'Top Fry Cooking Oil 3L', 1, 'PCS', 873, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Food', 'Magunas Rice 2KG', 1, 'PCS', 220, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Household', 'Magunas Printed Gunia Bags Large', 1, 'PCS', 40, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Food', 'Magunas Brown Bread 600G', 1, 'PCS', 90, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Beverage', 'Predator Gold Energy Drink 400ML', 1, 'PCS', 65, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Food', 'Ellicts Atta Mark 1 Flour 2KG', 2, 'PCS', 160, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Food', 'Ajab All Purpose Ngano', 1, 'PCS', 154, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT'),
('Personal Care', 'Bella White Toilet Paper 4PACK', 1, 'PCS', 155, 'Magunas Super Stores', '2025-03-15 20:19:34 EAT');

insert into shopping_records(category, product_name, quantity, unit, price_per_unit, store_name, date_of_purchase)
values
('Personal Care', 'Vaseline Men Perfumed Petroleum Jelly 95ML', 1, 'PC', 150, 'Quick Mart', '2025-04-01 13:08:34 EAT'),
('Food', 'Tictac Strawberry', 1, 'PC', 50, 'Quick Mart', '2025-04-01 13:08:34 EAT'),
('Food', 'adury Dairymilk 80G', 1, 'PC', 249, 'Quick Mart', '2025-04-01 13:08:34 EAT'),
('Personal Care', 'Imperial Ivory Classic 125G', 1, 'PC', 90, 'Quick Mart', '2025-04-01 13:08:34 EAT'),
('Personal Care', 'Pepsodent Cavity Fighter 65G', 1, 'PC', 85, 'Pick & Save Mini Mart', '2025-04-03 11:31:08 EAT'),
('Personal Care', 'Bella Tissue 2PACK', 1, 'PC', 70, 'Pick & Save Mini Mart', '2025-04-03 11:31:08 EAT'),
('Food', 'Eggs', 4, 'PC', 15, 'Pick & Save Mini Mart', '2025-04-03 11:31:08 EAT'),
('Food', 'Brookside Dairy Milk', 1, 'PC', 60, 'Pick & Save Mini Mart', '2025-04-03 11:31:08 EAT'),
('Personal Care', 'Bella Tissue 4PACK', 2, 'PC', 123, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Prestige Margarine 1KG', 1, 'PC', 383, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Soko Uji Pure Wimbi 1KG', 1, 'PC', 183, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Personal Care', 'Pepsodent Cavity Fighter Value Pack', 1, 'PC', 351, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Personal Care', 'Amara Lotion For Men 400ML', 1, 'PC', 256, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Personal Care', 'Omo Extra Fresh 500G', 1, 'PC', 217, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Soko Uji Pure Wimbi 1KG', 1, 'PC', 183, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Personal Care', 'Imperial Leather Classic 150G 3 IN 1', 1, 'PC', 349, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Household', 'Sky Bryte S/Pad Sponge', 1, 'PC', 87, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Soko Maize Meal 2KG', 2, 'PC', 150, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Elliots Atta Mark 1 Flour 2KG', 1, 'PC', 156, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Royco Mchuzi Mix 200G', 1, 'PC', 166, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Kabras Sugar 2KG', 1, 'PC', 318, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Household', 'Safisha Pot Scrub', 1, 'PC', 122, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Chirag Pilau Masala 100G', 1, 'PC', 322, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Chirag Ginger 100G', 1, 'PC', 298, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Daawat Red Label Spagheti 500G', 2, 'PC', 148, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Kensalt 1KG', 1, 'PC', 41, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Indomie Chicken Noodles 5 IN 1', 1, 'PC', 129, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Top Fry Vegetable Oil 3L', 1, 'PC', 834, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Fanta Passion 2L ', 1, 'PC', 169, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Powerstar White Bread 800G', 1, 'PC', 110, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Household', 'Nuru Dish Washer 250G', 1, 'PC', 89, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Food', 'Raha Chocolate 200G', 1, 'PC', 210, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Household', 'Sky Britw Steel wool', 1, 'PC', 33, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT'),
('Household', 'Bottom Bag', 1, 'PC', 35, 'Powerstar Kitengela', '2025-04-14 20:27:52 EAT');


insert into shopping_records(category, product_name, quantity, unit, price_per_unit, store_name, date_of_purchase)
values
('Clothing', 'FX Original Design Straight Fit Navy Blue', 1, 'PC', 1000, 'Mandera G-49', '2025-04-17 14:51:21 EAT'),
('Clothing', 'A1 Jeans Slim Fit Black ', 1, 'PC', 1000, 'Mandera G-49', '2025-04-17 14:51:21 EAT'),
('Clothing', 'Polo Tee Long Sleeve Sky Blue', 1, 'PC', 550, 'Mandera G-49', '2025-04-17 14:51:21 EAT'),
('Clothing', 'Tee Shirt', 1, 'PC', 500, 'Mandera G-49', '2025-04-17 14:51:21 EAT'),
('Food', 'Energy Drink', 1, 'PC', 70, 'Magunas', '2025-04-17 20:25:21 EAT'),
('Shoe Care', 'Kiwi Suede Dark Brown 100ML', 2, 'PC', 185, 'Magunas', '2025-04-18 19:28:21 EAT'),
('Personal Care', 'ORS Olive Oil Sheen Spray 472ML', 1, 'PC', 500, 'Magunas', '2025-04-18 19:28:21 EAT'),
('Personal Care', 'Colgate Herbal 2*140G VP', 1, 'PC', 500, 'Magunas', '2025-04-22 14:50:17 EAT'),
('Bath & Bedding', 'Towel', 1, 'PC', 800, 'Talyn Enterprises', '2025-05-06 14:28:21 EAT'),
('Electrical Accessories', '9W RGB Bulb', 1, 'PC', 130, 'Blueline Electricals & Supplies', '2025-05-06 14:28:21 EAT'),
('Electrical Accessories', 'Extension', 1, 'PC', 500, 'Blueline Electricals & Supplies', '2025-05-06 14:28:21 EAT'),
('Electrical Accessories', 'Pink LED Snake Light 3M', 1, 'PC', 450, 'Blueline Electricals & Supplies', '2025-05-06 14:28:21 EAT'),
('Electrical Accessories', '2 Pin Adapter', 1, 'PC', 200, 'Blueline Electricals & Supplies', '2025-05-06 14:28:21 EAT'),
('Furniture', 'L 5S', 1, 'PC', 34500, 'Dignified Furniture', '2025-05-06 19:43:56 EAT'),
('Household', 'Egg Tray Plastic Family', 2, 'PC', 115, 'Eastmatt', '2025-05-06 19:36:50 EAT'),
('Bath & Bedding', 'Woolen Duvet', 1, 'PC', 1400, 'Talyn Enterprises', '2025-01-31 14:28:21 EAT'),
('Bath & Bedding', 'Pillowcases', 1, 'PC', 500, 'Talyn Enterprises', '2025-01-31 14:28:21 EAT'),
('Bath & Bedding', 'Masai Shuka', 1, 'PC', 600, 'Janwan Baby Shop', '2024-12-13 14:28:21 EAT'),
('Food', 'Fresh Chapati Boerwores Rolls', 1, 'PC', 170, 'Quick Mart', '2025-05-15 07:02:11 EAT'),
('Food', 'Fresh Packed ASSRTD Queencake 6-Pack', 1, 'PC', 180, 'Quick Mart', '2025-05-15 07:02:11 EAT'),
('Food', 'Tuzo Yoghurt 500ML', 2, 'PC', 115, 'Quick Mart', '2025-05-15 07:02:11 EAT'),
('Food', 'Zesta Red Plum Jam 300G', 1, 'PC', 169, 'Quick Mart', '2025-05-15 07:02:11 EAT'),
('Food', 'Zesta Peanut Smooth Butter 400G', 1, 'PC', 270, 'Quick Mart', '2025-05-15 07:02:11 EAT'),
('Food', 'Minute Maid Delight Apple 1L', 1, 'PC', 150, 'Quick Mart', '2025-05-15 07:02:11 EAT'),
('Food', 'Nuvita Nice 375G', 1, 'PC', 180, 'Quick Mart', '2025-05-15 07:02:11 EAT'),
('Food', 'Juice Fruit Strawberry', 1, 'PC', 27, 'Quick Mart', '2025-05-15 07:02:11 EAT'),
('Household', 'Non Woven Plain Bag', 1, 'PC', 20, 'Quick Mart', '2025-05-15 07:02:11 EAT')



insert into shopping_records(category, product_name, quantity, unit, price_per_unit, store_name, date_of_purchase)
values
('Beverages', 'Fanta Passion 2L', 1, 'PC', 179, 'Powerstar', '2025-05-17 19:26:57 EAT'),
('Spreads', 'Nuteez Peanut Crunch', 1, 'PC', 180, 'Powerstar', '2025-05-17 19:26:57 EAT'),
('Beverages', 'Fanta Passion 2L', 1, 'PC', 179, 'Powerstar', '2025-05-17 19:26:57 EAT'),
('Food', 'Famila Pure Wimbi 1KG', 1, 'PC', 185, 'Powerstar', '2025-05-17 19:26:57 EAT'),
('Bakery', 'Powerstar White Bread 600G', 1, 'PC', 86, 'Powerstar', '2025-05-17 19:26:57 EAT'),
('Bakery', 'Nuvita Nice 375G', 1, 'PC', 182, 'Powerstar', '2025-05-17 19:26:57 EAT'),
('Hot Beverages', 'Melvins Black Chai', 1, 'PC', 46, 'Powerstar', '2025-05-17 19:26:57 EAT'),
('Dairy', 'Brookside Dairy 500ML', 2, 'PC', 56, 'Powerstar', '2025-05-17 19:26:57 EAT'),
('Household', 'Non Woven Plain Bag', 1, 'PC', 15, 'Powerstar', '2025-05-17 19:26:57 EAT')


insert into shopping_records(category, product_name, quantity, unit, price_per_unit, store_name, date_of_purchase)
values
('Clothing', 'Blazer Suit', 1, 'PC', 1300, 'Pink Mall', '2025-03-30 12:34:48 EAT'),
('Clothing', 'Sweat Shirt', 1, 'PC', 1300, 'Pink Mall', '2025-03-30 12:34:48 EAT'),
('Clothing', 'Belt', 1, 'PC', 800, 'Pink Mall', '2025-03-30 12:34:48 EAT'),
('Clothing', 'FX Original Design Straight Fit', 3, 'PC', 1000, 'Mandera G-49', '2025-05-30 14:57:09 EAT'),
('Clothing', 'Polo Tee Long Sleeve', 2, 'PC', 700, 'Mandera G-49',  '2025-05-30 14:57:09 EAT'),
('Clothing', 'Tuff Design Tee Long Sleeve', 1, 'PC', 500, 'Mandera G-49',  '2025-05-30 14:57:09 EAT'),

delete from shopping_records where id=135;
select * from shopping_records;
select sum(total_cost)from shopping_records where date_of_purchase='2025-05-17 19:26:57 EAT';