INSERT INTO type.BuildType (id, name, descr)
VALUES (default, 'Многоэтажная постройка', 'Жилое многоэтажное здание'),
       (default, 'Частный дом', 'Частный дом');


INSERT INTO type.city (id, name)
VALUES (default, 'Москва'),
       (default, 'Санкт-Петербург'),
       (default, 'Казань');

INSERT INTO entity.Build (id, typeid, cityid, street, house)
VALUES (default, 1, 1, 'Ленина', '1a'),
       (default, 1, 1, 'Ленина', '2'),
       (default, 1, 1, 'Ленина', '2w'),
       (default, 1, 1, 'Ленина', '3a'),
       (default, 1, 2, 'Ленина', '1'),
       (default, 1, 2, 'Социалистическая', '22'),
       (default, 2, 2, 'Социалистическая', '33a'),
       (default, 2, 2, 'Социалистическая', '33'),
       (default, 1, 3, 'Гагарина', '1'),
       (default, 1, 3, 'Гагарина', '2'),
       (default, 1, 3, 'Гагарина', '3');