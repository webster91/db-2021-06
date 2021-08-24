INSERT INTO type.BuildType (id, name, descr)
VALUES (default, 'Многоэтажная постройка', 'Жилое многоэтажное здание'),
       (default, 'Частный дом', 'Частный дом'),
       (default, 'Частный дом2', 'Частный дом'),
       (default, 'Частный дом3', 'Частный дом'),
       (default, 'Частный дом4', 'Частный дом'),
       (default, 'Частный дом5', 'Частный дом'),
       (default, 'Частный дом6', 'Частный дом'),
       (default, 'Частный дом7', 'Частный дом'),
       (default, 'Частный дом8', 'Частный дом'),
       (default, 'Частный дом9', 'Частный дом');


INSERT INTO type.city (id, name)
VALUES (default, 'Москва'),
       (default, 'Санкт-Петербург'),
       (default, 'Казань'),
       (default, 'Новосибирск'),
       (default, 'Екатеринбург'),
       (default, 'Нижний Новгород'),
       (default, 'Челябинск'),
       (default, 'Самара'),
       (default, 'Омск'),
       (default, 'Уфа'),
       (default, 'Красноярск'),
       (default, 'Воронеж'),
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

Create or replace function my_random_string(length integer) returns text as $$
declare
    chars text[] := '{А,Б,В,Г,Д,Е,Ж,З,И,К,Л,М,Н,О,П,Р,С,Т,У,Ф,Х,Ч,Ш,Щ,Э,Ю,Я,а,б,в,г,д,е,ж,з,и,к,л,м,н,о,п,р,с,т,у,ф,х,ч,щ,ю,я}';
    result text := '';
    i integer := 0;
begin
    if length < 0 then
        raise exception 'Given length cannot be less than 0';
    end if;
    for i in 1..length loop
            result := result || chars[1+random()*(array_length(chars, 1)-1)];
        end loop;
    return result;
end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION random_between(low INT ,high INT)
    RETURNS INT AS
$$
BEGIN
    RETURN floor(random()* (high-low + 1) + low);
END;
$$ language 'plpgsql' STRICT;

insert into entity.Build (typeid, cityid, street, house)
select random_between(1,10), random_between(1,12), my_random_string(10) || ' ' || my_random_string(10), my_random_string(15)
from generate_series(1,1000000) as s(id)
order by random();

analyze entity.build;

select attname, correlation from pg_stats where tablename = 'build';