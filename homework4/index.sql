--- создание ролей
create role administrator login createdb password 'administrator';
create role support login password 'support';

-- создание табличных пространств
CREATE TABLESPACE ts_type OWNER administrator LOCATION 'E:/db/1';
CREATE TABLESPACE ts_entity OWNER administrator LOCATION 'E:/db/2';

--- создание базы
create database hestia TABLESPACE ts_entity;

-- создание схемы
create schema type;
create schema entity;

-- создание таблиц
CREATE TABLE entity.Address
(
    "id"      serial      NOT NULL,
    buildId   integer     NOT NULL,
    userId    integer     NOT NULL,
    flat      integer     NULL,
    apartment varchar(20) NULL,
    balance   decimal     NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY ("id"),
    CONSTRAINT fk_build_id FOREIGN KEY (buildId) REFERENCES Build ("id"),
    CONSTRAINT fk_userid FOREIGN KEY (userId) REFERENCES User ("id")
);
CREATE INDEX idx_address_buildId ON entity.Address (buildId);
CREATE INDEX idx_address_userId ON entity.Address (userId);

CREATE TABLE type.BuildType
(
    "id"   serial       NOT NULL,
    name   varchar(50)  NOT NULL,
    "desc" varchar(100) NOT NULL,
    CONSTRAINT id PRIMARY KEY ("id")
        USING INDEX TABLESPACE ts_type
);

CREATE TABLE entity.Build
(
    "id"   serial      NOT NULL,
    typeId integer     NOT NULL,
    cityId integer     NOT NULL,
    street varchar(50) NULL,
    house  varchar(20) NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY ("id"),
    CONSTRAINT fk_city_id FOREIGN KEY (cityId) REFERENCES type.City ("id"),
    CONSTRAINT fk_type_id FOREIGN KEY (typeId) REFERENCES type.BuildType ("id")
);
CREATE INDEX idx_build_city_id ON entity.Build (cityId);
CREATE INDEX idx_build_type_id ON entity.Build (typeId);

CREATE TABLE type.City
(
    "id" serial      NOT NULL,
    name varchar(50) NOT NULL,
    CONSTRAINT PK_city PRIMARY KEY ("id")
        USING INDEX TABLESPACE ts_type
);

CREATE TABLE entity.Claim
(
    "id"         serial        NOT NULL,
    header       varchar(100)  NOT NULL,
    "desc"       varchar(4000) NOT NULL,
    statusId     integer       NOT NULL,
    authorId     integer       NOT NULL,
    userAssignId integer       NOT NULL,
    buildId      integer       NOT NULL,
    typeId       integer       NOT NULL,
    createDate   timestamp     NOT NULL,
    endDate      timestamp     NULL,
    active       boolean       NOT NULL,
    CONSTRAINT pk_ticket PRIMARY KEY ("id"),
    CONSTRAINT fk_status_id FOREIGN KEY (statusId) REFERENCES TicketStatus ("id"),
    CONSTRAINT fk_author_id FOREIGN KEY (authorId) REFERENCES User ("id"),
    CONSTRAINT fk_build_id FOREIGN KEY (buildId) REFERENCES Build ("id"),
    CONSTRAINT fk_type_id FOREIGN KEY (typeId) REFERENCES TicketType ("id"),
    CONSTRAINT fk_user_assign_id FOREIGN KEY (userAssignId) REFERENCES User ("id")
);
CREATE INDEX idx_claim_status_id ON entity.Claim (statusId);
CREATE INDEX idx_claim_author_id ON entity.Claim (authorId);
CREATE INDEX idx_claim_build_id ON entity.Claim (buildId);
CREATE INDEX idx_claim_type_id ON entity.Claim (typeId);
CREATE INDEX idx_claim_user_assign_id ON entity.Claim (userAssignId);


