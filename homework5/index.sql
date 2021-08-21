----- SELECT WITH REGULAR EXP
SELECT house
FROM entity.Build
WHERE house ~* '[a-z]$';

----- SELECT
SELECT C.name, B.street, B.house, BT.name
FROM entity.Build AS B
         LEFT JOIN type.BuildType AS BT
                   ON B.typeId = BT.id
         LEFT JOIN type.City AS C
                   ON B.cityId = C.id;

INSERT INTO entity.Build (id, typeid, cityid, street, house)
VALUES (default, 1, 1, 'Ленина', '1б')
RETURNING id;

----- UPDATE
UPDATE entity.Build
SET house = '32'
WHERE id = 4;

----- DELETE
DELETE
FROM entity.Build AS B
    USING type.City AS C
WHERE B.cityId = C.id
  and C.name = 'Казань';

----- COPY
COPY (
    SELECT C.name, B.street, B.house, BT.name
    FROM entity.Build AS B
             LEFT JOIN type.BuildType AS BT
                       ON B.typeId = BT.id
             LEFT JOIN type.City AS C
                       ON B.cityId = C.id
    )
    TO '/build.csv'
    WITH CSV;
