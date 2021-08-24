# Домашнее задание №6

Индексы PostgreSQL

## Цель:

Знать и уметь применять основные виды индексов PostgreSQL Построить и анализировать план выполнения запроса Уметь оптимизировать запросы для с использованием индексов

Создать индексы на БД, которые ускорят доступ к данным. В данном задании тренируются навыки:

* определения узких мест
* написания запросов для создания индекса
* оптимизации 

Необходимо:
* Создать индекс к какой-либо из таблиц вашей БД
* Прислать текстом результат команды explain, в которой используется данный индекс
* Реализовать индекс для полнотекстового поиска
* Реализовать индекс на часть таблицы или индекс на поле с функцией
* Создать индекс на несколько полей
* Написать комментарии к каждому из индексов
* Описать что и как делали и с какими проблемами столкнулись

### Создать индекс к какой-либо из таблиц вашей БД
```
CREATE INDEX build_city_id_idx ON entity.Build (cityId);
```

### Прислать текстом результат команды explain, в которой используется данный индекс
```
SELECT cityid, street, house
FROM entity.Build
WHERE cityid = 3;

Bitmap Heap Scan on build  (cost=906.39..16227.81 rows=82834 width=77) (actual time=4.148..28.178 rows=82786 loops=1)
  Recheck Cond: (cityid = 3)
  Heap Blocks: exact=14254
  ->  Bitmap Index Scan on idx_build_city_id  (cost=0.00..885.68 rows=82834 width=0) (actual time=2.567..2.567 rows=82786 loops=1)
        Index Cond: (cityid = 3)
Planning Time: 0.055 ms
Execution Time: 30.628 ms
```

### Реализовать индекс для полнотекстового поиска
```
-Создаем индекс
CREATE INDEX idx_build_street_rus ON entity.Build USING GIN (to_tsvector('russian', street));

- Поиск по индексу
explain analyse select * from entity.Build where to_tsvector('russian', street) @@ to_tsquery('Гагарина');

Bitmap Heap Scan on build  (cost=63.00..12680.53 rows=5000 width=85) (actual time=0.056..0.056 rows=0 loops=1)
"  Recheck Cond: (to_tsvector('russian'::regconfig, (street)::text) @@ to_tsquery('Гагарина'::text))"
  ->  Bitmap Index Scan on idx_build_street_rus  (cost=0.00..61.75 rows=5000 width=0) (actual time=0.055..0.055 rows=0 loops=1)
"        Index Cond: (to_tsvector('russian'::regconfig, (street)::text) @@ to_tsquery('Гагарина'::text))"
Planning Time: 0.128 ms
Execution Time: 0.071 ms
```

### Реализовать индекс на часть таблицы или индекс на поле с функцией
```
-Создаем индекс
create index upper_street_upper_idx on entity.Build (upper(street));

- Поиск по индексу
explain  select id from entity.Build where upper(street) = upper('ГагАрина');

Bitmap Heap Scan on build  (cost=207.18..10337.21 rows=5000 width=4)
  Recheck Cond: (upper((street)::text) = 'ГАГАРИНА'::text)
  ->  Bitmap Index Scan on upper_street_upper_idx  (cost=0.00..205.93 rows=5000 width=0)
        Index Cond: (upper((street)::text) = 'ГАГАРИНА'::text)
```

### Создать индекс на несколько полей
- Для авторизации пользователя по номеру телефона и паролю
```
CREATE INDEX idx_user_telephone ON entity."user" (telephone, password);
```

### Написать комментарии к каждому из индексов

- Для нахождения строений по городу (при формировании списка строений в городе)
```
CREATE INDEX idx_build_city_id ON entity.Build (cityId);
```

- Для нахождения пользователей по телефону и паролю при авторизации
```
CREATE INDEX idx_user_telephone_password ON entity."user" (telephone, password);
```

- Для нахождения здания к которому прикреплен адрес и адерса закрепленные за пользователем
```
CREATE INDEX idx_address_buildId ON entity.Address (buildId);
CREATE INDEX idx_address_userId ON entity.Address (userId);
```

- Для нахождения заявок по статусу (активные, завершенные заявки и т.д.), заявки пользователя, заявки по адресу
```
CREATE INDEX idx_claim_status_id ON entity.Claim (statusId);
CREATE INDEX idx_claim_author_id ON entity.Claim (authorId);
CREATE INDEX idx_claim_build_id ON entity.Claim (buildId);
```

- Счётчики привязанные к адресу и поиск по серийнику
```
CREATE INDEX idx_meter_address_id ON entity.Meter (addressId);
CREATE INDEX idx_meter_serial_number ON entity.Meter (serialNumber);

```

- Поиск квитанций по адресу
```
CREATE INDEX idx_receipt_address_id ON entity.Receipt (addressId);
```

###  Описать что и как делали и с какими проблемами столкнулись

Создал заполнение БД рандомными значениями и тестировал несколько таблиц с данным наполнением.

Столкнулся с проблемой при полнотекстовом поиске, было не очень понятно, почему мой запрос не использует индекс.
Проблема заключалась, что при поиске не указывал язык поиска, а индекс был создан вместе с ним.