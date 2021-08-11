-- Индексы

-- Meter
-- поиск по адресу
CREATE INDEX meter_address_id ON meter (addressId);
-- поиск по типу и серийному номеру
CREATE INDEX meter_type_id_serial_number ON meter (typeId, serialNumber);
------------------------------------------------------
-- Address
-- поиск по номеру здания
CREATE INDEX address_count ON address (buildId);
-- поиск по пользователю
CREATE INDEX address_user ON address (userId);
------------------------------------------------------
-- Build
-- поиск улице и номеру дома
CREATE INDEX build_street_house ON build (street, house);
------------------------------------------------------
-- Claim
-- поиск по статусу
CREATE INDEX claim_status ON claim (statusId);
-- поиск по назначенным пользователю заявкам
CREATE INDEX claim_user_assign ON claim (userAssignId);
-- поиск дому
CREATE INDEX claim_build ON claim (buildId);
------------------------------------------------------
-- User
-- поиск по номеру телефона
CREATE INDEX user_status ON user (telephone, password);
------------------------------------------------------

-- Ограничения

-- BuildType
ALTER TABLE buildtype
    ADD CONSTRAINT build_type_name CHECK (length(name) >= 2)
    ADD CONSTRAINT build_type_desc CHECK (length(desc) >= 2);
-- City
ALTER TABLE city
    ADD CONSTRAINT city_name CHECK (length(name) >= 2);
-- Build
ALTER TABLE build
    ADD CONSTRAINT build_street CHECK (length(street) >= 2);
-- Meter
ALTER TABLE meter
    ADD CONSTRAINT meter_value CHECK (value >= 0)
    ADD CONSTRAINT meter_prev_value CHECK (prevValue >= 0);
-- User
ALTER TABLE user
    ADD CONSTRAINT user_unique UNIQUE telephone
    ADD CONSTRAINT user_unique UNIQUE email
    ADD CONSTRAINT user_name CHECK (length(name) >= 2)
    ADD CONSTRAINT user_telephone CHECK (length(telephone) == 11)
    ADD CONSTRAINT user_password CHECK (length(password) >= 5)
    ADD CONSTRAINT user_email CHECK (length(email) >= 5);