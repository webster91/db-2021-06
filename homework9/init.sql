-- создание базы
CREATE DATABASE hestia;
USE hestia;

-- создание таблиц
CREATE TABLE BuildType
(
    id    int          NOT NULL AUTO_INCREMENT,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_build_type_id PRIMARY KEY (id)
);

CREATE TABLE City
(
    id   int         NOT NULL AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    CONSTRAINT pk_city_id PRIMARY KEY (id)
);

CREATE TABLE Build
(
    id     int         NOT NULL AUTO_INCREMENT,
    typeId int         NOT NULL,
    cityId int         NOT NULL,
    street varchar(50) NULL,
    house  varchar(20) NOT NULL,
    CONSTRAINT pk_build_id PRIMARY KEY (id),
    CONSTRAINT fk_build_city_id FOREIGN KEY (cityId) REFERENCES City (id),
    CONSTRAINT fk_build_type_id FOREIGN KEY (typeId) REFERENCES BuildType (id)
);
CREATE INDEX idx_build_city_id ON Build (cityId);

CREATE TABLE Role
(
    id    int          NOT NULL AUTO_INCREMENT,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_role_id PRIMARY KEY (id)
);

CREATE TABLE Gender
(
    id    int          NOT NULL AUTO_INCREMENT,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_gender_id PRIMARY KEY (id)
);

CREATE TABLE User
(
    id         int          NOT NULL AUTO_INCREMENT,
    name       varchar(100) NULL,
    surname    varchar(100) NULL,
    patronymic varchar(100) NULL,
    telephone  varchar(20)  NOT NULL,
    username   varchar(100) NOT NULL,
    password   varchar(50)  NOT NULL,
    email      varchar(50)  NULL,
    rolesIds   int          NOT NULL,
    genderId   int          NOT NULL,
    valid      boolean      NOT NULL,
    CONSTRAINT pk_user_id PRIMARY KEY (id),
    CONSTRAINT fk_user_gender_id FOREIGN KEY (genderId) REFERENCES Gender (id),
    CONSTRAINT fk_user_roles_ids FOREIGN KEY (rolesIds) REFERENCES Role (id)
);
CREATE INDEX idx_user_telephone_password ON User (telephone, password);

CREATE TABLE Address
(
    id        int         NOT NULL AUTO_INCREMENT,
    buildId   int         NOT NULL,
    userId    int         NOT NULL,
    flat      int         NULL,
    apartment varchar(20) NULL,
    balance   decimal     NOT NULL,
    CONSTRAINT pk_address_id PRIMARY KEY (id),
    CONSTRAINT fk_address_build_id FOREIGN KEY (buildId) REFERENCES Build (id),
    CONSTRAINT fk_address_userid FOREIGN KEY (userId) REFERENCES User (id)
);
CREATE INDEX idx_address_buildId ON Address (buildId);
CREATE INDEX idx_address_userId ON Address (userId);

CREATE TABLE TicketStatus
(
    id    int          NOT NULL AUTO_INCREMENT,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_ticket_status_id PRIMARY KEY (id)
);

CREATE TABLE TicketType
(
    id    int          NOT NULL AUTO_INCREMENT,
    name  varchar(50)  NOT NULL,
    descr varchar(100) NOT NULL,
    CONSTRAINT pk_ticket_type_id PRIMARY KEY (id)
);

CREATE TABLE Claim
(
    id           int           NOT NULL AUTO_INCREMENT,
    header       varchar(100)  NOT NULL,
    descr        varchar(4000) NOT NULL,
    statusId     int           NOT NULL,
    authorId     int           NOT NULL,
    userAssignId int           NOT NULL,
    buildId      int           NOT NULL,
    typeId       int           NOT NULL,
    createDate   timestamp     NOT NULL,
    endDate      timestamp     NULL,
    active       boolean       NOT NULL,
    CONSTRAINT pk_claim_ticket_id PRIMARY KEY (id),
    CONSTRAINT fk_claim_status_id FOREIGN KEY (statusId) REFERENCES TicketStatus (id),
    CONSTRAINT fk_claim_author_id FOREIGN KEY (authorId) REFERENCES User (id),
    CONSTRAINT fk_claim_build_id FOREIGN KEY (buildId) REFERENCES Build (id),
    CONSTRAINT fk_claim_type_id FOREIGN KEY (typeId) REFERENCES TicketType (id),
    CONSTRAINT fk_claim_user_assign_id FOREIGN KEY (userAssignId) REFERENCES User (id)
);
CREATE INDEX idx_claim_status_id ON Claim (statusId);
CREATE INDEX idx_claim_author_id ON Claim (authorId);
CREATE INDEX idx_claim_build_id ON Claim (buildId);

CREATE TABLE MeterType
(
    id   int          NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    CONSTRAINT PK_meter_type_id PRIMARY KEY (id)
);

CREATE TABLE Meter
(
    id           int         NOT NULL AUTO_INCREMENT,
    name         varchar(50) NULL,
    typeId       int         NOT NULL,
    addressId    int         NOT NULL,
    validDate    date        NULL,
    value        decimal     NULL,
    prevValue    decimal     NULL,
    serialNumber varchar(50) NULL,
    valid        boolean     NOT NULL,
    CONSTRAINT pk_meter_id PRIMARY KEY (id),
    CONSTRAINT fk_meter_address_id FOREIGN KEY (addressId) REFERENCES Address (id),
    CONSTRAINT fk_meter_type_id FOREIGN KEY (typeId) REFERENCES MeterType (id)
);
CREATE INDEX idx_meter_address_id ON Meter (addressId);
CREATE INDEX idx_meter_serial_number ON Meter (serialNumber);

CREATE TABLE Receipt
(
    id             int     NOT NULL AUTO_INCREMENT,
    addressId      int     NOT NULL,
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
    CONSTRAINT pk_receipt_id PRIMARY KEY (id),
    CONSTRAINT fk_receipt_address_id FOREIGN KEY (addressId) REFERENCES Address (id)
);
CREATE INDEX idx_receipt_address_id ON Receipt (addressId);



