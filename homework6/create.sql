--- создание ролей
create role administrator login createdb password 'administrator';
create role support login password 'support';

-- создание табличных пространств
CREATE TABLESPACE ts_type OWNER administrator LOCATION '/var/lib/postgresql/data/1';
CREATE TABLESPACE ts_entity OWNER administrator LOCATION '/var/lib/postgresql/data/2';

--- создание базы
create database hestia TABLESPACE ts_entity;

-- создание схемы
create schema type;
create schema entity;

-- создание таблиц
CREATE TABLE type.BuildType
(
    id    serial       NOT NULL,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_build_type_id PRIMARY KEY (id)
        USING INDEX TABLESPACE ts_type
);

CREATE TABLE type.City
(
    id   serial      NOT NULL,
    name varchar(50) NOT NULL,
    CONSTRAINT pk_city_id PRIMARY KEY (id)
        USING INDEX TABLESPACE ts_type
);

CREATE TABLE entity.Build
(
    id     serial      NOT NULL,
    typeId integer     NOT NULL,
    cityId integer     NOT NULL,
    street varchar(50) NULL,
    house  varchar(20) NOT NULL,
    CONSTRAINT pk_build_id PRIMARY KEY (id),
    CONSTRAINT fk_city_id FOREIGN KEY (cityId) REFERENCES type.City (id),
    CONSTRAINT fk_type_id FOREIGN KEY (typeId) REFERENCES type.BuildType (id)
);
CREATE INDEX idx_build_city_id ON entity.Build (cityId);

CREATE TABLE type.Role
(
    id    serial       NOT NULL,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_role PRIMARY KEY (id)
);

CREATE TABLE type.Gender
(
    id    serial       NOT NULL,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_gender PRIMARY KEY (id)
);

CREATE TABLE entity."user"
(
    id         serial       NOT NULL,
    name       varchar(100) NULL,
    surname    varchar(100) NULL,
    patronymic varchar(100) NULL,
    telephone  varchar(20)  NOT NULL,
    username   varchar(100) NOT NULL,
    password   varchar(50)  NOT NULL,
    email      varchar(50)  NULL,
    rolesIds   integer      NOT NULL,
    genderId   integer      NOT NULL,
    valid      boolean      NOT NULL,
    CONSTRAINT pk_user PRIMARY KEY (id),
    CONSTRAINT fk_gender_id FOREIGN KEY (genderId) REFERENCES type.Gender (id),
    CONSTRAINT fk_roles_ids FOREIGN KEY (rolesIds) REFERENCES type.Role (id)
);
CREATE INDEX idx_user_telephone_password ON entity."user" (telephone, password);

CREATE TABLE entity.Address
(
    id        serial      NOT NULL,
    buildId   integer     NOT NULL,
    userId    integer     NOT NULL,
    flat      integer     NULL,
    apartment varchar(20) NULL,
    balance   decimal     NOT NULL,
    CONSTRAINT pk_address_id PRIMARY KEY (id),
    CONSTRAINT fk_build_id FOREIGN KEY (buildId) REFERENCES entity.Build (id),
    CONSTRAINT fk_userid FOREIGN KEY (userId) REFERENCES entity."user" (id)
);
CREATE INDEX idx_address_buildId ON entity.Address (buildId);
CREATE INDEX idx_address_userId ON entity.Address (userId);

CREATE TABLE type.TicketStatus
(
    id    serial       NOT NULL,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_ticket_status PRIMARY KEY (id)
);

CREATE TABLE type.TicketType
(
    id    serial       NOT NULL,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_ticket_type PRIMARY KEY (id)
);

CREATE TABLE entity.Claim
(
    id           serial        NOT NULL,
    header       varchar(100)  NOT NULL,
    descr        varchar(4000) NOT NULL,
    statusId     integer       NOT NULL,
    authorId     integer       NOT NULL,
    userAssignId integer       NOT NULL,
    buildId      integer       NOT NULL,
    typeId       integer       NOT NULL,
    createDate   timestamp     NOT NULL,
    endDate      timestamp     NULL,
    active       boolean       NOT NULL,
    CONSTRAINT pk_ticket PRIMARY KEY (id),
    CONSTRAINT fk_status_id FOREIGN KEY (statusId) REFERENCES type.TicketStatus (id),
    CONSTRAINT fk_author_id FOREIGN KEY (authorId) REFERENCES entity."user" (id),
    CONSTRAINT fk_build_id FOREIGN KEY (buildId) REFERENCES entity.Build (id),
    CONSTRAINT fk_type_id FOREIGN KEY (typeId) REFERENCES type.TicketType (id),
    CONSTRAINT fk_user_assign_id FOREIGN KEY (userAssignId) REFERENCES entity."user" (id)
);
CREATE INDEX idx_claim_status_id ON entity.Claim (statusId);
CREATE INDEX idx_claim_author_id ON entity.Claim (authorId);
CREATE INDEX idx_claim_build_id ON entity.Claim (buildId);

CREATE TABLE type.MeterType
(
    id   serial       NOT NULL,
    name varchar(100) NOT NULL,
    CONSTRAINT PK_meter_type PRIMARY KEY (id)
);

CREATE TABLE entity.Meter
(
    id           serial      NOT NULL,
    name         varchar(50) NULL,
    typeId       integer     NOT NULL,
    addressId    integer     NOT NULL,
    validDate    date        NULL,
    value        decimal     NULL,
    prevValue    decimal     NULL,
    serialNumber varchar(50) NULL,
    valid        boolean     NOT NULL,
    CONSTRAINT pk_meter PRIMARY KEY (id),
    CONSTRAINT fk_address_id FOREIGN KEY (addressId) REFERENCES entity.Address (id),
    CONSTRAINT fk_type_id FOREIGN KEY (typeId) REFERENCES type.MeterType (id)
);
CREATE INDEX idx_meter_address_id ON entity.Meter (addressId);
CREATE INDEX idx_meter_serial_number ON entity.Meter (serialNumber);

CREATE TABLE entity.Receipt
(
    id             serial  NOT NULL,
    addressId      integer NOT NULL,
    dateInterest   date    NOT NULL,
    arrears        decimal NULL,
    hotWater       decimal NULL,
    coldWater      decimal NULL,
    electricity    decimal NULL,
    security       decimal NULL,
    overhaul       decimal NULL,
    other          decimal NULL,
    garbageRemoval decimal NULL,
    paid           boolean NULL,
    CONSTRAINT pk_receipt PRIMARY KEY (id),
    CONSTRAINT fk_address_id FOREIGN KEY (addressId) REFERENCES entity.Address (id)
);
CREATE INDEX idx_receipt_address_id ON entity.Receipt (addressId);



