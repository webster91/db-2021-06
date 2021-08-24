EXPLAIN
SELECT B.street, B.house
FROM entity.Build AS B
where B.cityid = 3;

analyze entity.Build;
--- Поиск по тексту
explain analyze
SELECT cityid, street, house
FROM entity.Build
WHERE cityid = 3;
--- Поиск по тексту
CREATE INDEX idx_build_street_rus ON entity.Build USING GIN (to_tsvector('russian', street));
explain analyse select * from entity.Build where to_tsvector('russian', street) @@ to_tsquery('Гагарина');

CREATE INDEX upper_street_upper_idx ON entity.Build (upper(street));
EXPLAIN SELECT id FROM entity.Build WHERE upper(street) = upper('ГагАрина');

CREATE INDEX idx_user_telephone ON entity."user" (telephone, password);
