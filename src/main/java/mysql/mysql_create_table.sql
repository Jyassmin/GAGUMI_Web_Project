﻿DROP DATABASE gagumi_db;
CREATE DATABASE gagumi_db;
USE gagumi_db;

CREATE TABLE `customer` (
    `cid` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(40) NOT NULL,
    `email` VARCHAR(40) NOT NULL UNIQUE,
    `pw` VARCHAR(40) NOT NULL,
    `phone` CHAR(11) NOT NULL,
    `gender` INT NULL,
    `birthday` VARCHAR(10) NULL,
    `address` VARCHAR(50) NOT NULL,
    CONSTRAINT `chk_gender` CHECK (`gender` IN (0, 1))
);

CREATE TABLE `product` (
    `pid` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `sid` INT NOT NULL,
    `ca2id` INT NOT NULL,
    `name` VARCHAR(40) NOT NULL,
    `stock` INT NOT NULL DEFAULT 0,
    `cost` INT NOT NULL,
    `desc` VARCHAR(300) NOT NULL DEFAULT 'NONE',
    `pimage` VARCHAR(100) NULL DEFAULT '../images/empty-image.png',
    `size` VARCHAR(40) NOT NULL DEFAULT 0
);

CREATE TABLE `shoppingcart` (
    `sid` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cid` INT NOT NULL,
    `pid` INT NOT NULL,
    `quantity` INT NOT NULL
);

CREATE TABLE `history` (
    `hid` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cid` INT NOT NULL,
    `pid` INT NOT NULL,
    `oid` INT NOT NULL,
    `quantity` INT NOT NULL,
    `pname` VARCHAR(40) NOT NULL,
    `cost` INT NOT NULL,
    `datetime` DATETIME NOT NULL
);

CREATE TABLE `seller` (
    `sid` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(40) NOT NULL,
    `email` VARCHAR(40) NOT NULL UNIQUE,
    `pw` VARCHAR(40) NOT NULL,
    `phone` CHAR(11) NOT NULL,
    `company` VARCHAR(40) NOT NULL,
    `address` VARCHAR(50) NOT NULL
);

CREATE TABLE `review` (
    `rid` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `hid` INT NOT NULL UNIQUE,
    `title` VARCHAR(20) NOT NULL,
    `text` VARCHAR(300) NOT NULL,
    `datetime` DATETIME NOT NULL,
    `like` INT NOT NULL
);

CREATE TABLE `comment` (
    `comid` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `rid` INT NOT NULL,
    `cid` INT NOT NULL,
    `text` VARCHAR(300) NOT NULL,
    `datetime` DATETIME NOT NULL,
    `like_yn` INT NOT NULL DEFAULT 0,
    CONSTRAINT `chk_like_yn` CHECK (`like_yn` IN (0, 1))
);

CREATE TABLE `category1` (
    `ca1id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `ca1_name` VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE `category2` (
    `ca2id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `ca1id` INT NOT NULL,
    `ca2_name` VARCHAR(20) NOT NULL UNIQUE
);

ALTER TABLE product ADD CONSTRAINT K_seller_TO_product_1 FOREIGN KEY (sid) REFERENCES seller (sid);
ALTER TABLE product ADD CONSTRAINT K_category2_TO_product_1 FOREIGN KEY (ca2id) REFERENCES category2 (ca2id);

ALTER TABLE shoppingcart ADD CONSTRAINT K_customer_TO_shoppingcart_1 FOREIGN KEY (cid) REFERENCES customer (cid);
ALTER TABLE shoppingcart ADD CONSTRAINT K_product_TO_shoppingcart_1 FOREIGN KEY (pid) REFERENCES product (pid);

ALTER TABLE history ADD CONSTRAINT K_customer_TO_history_1 FOREIGN KEY (cid) REFERENCES customer (cid);
ALTER TABLE history ADD CONSTRAINT K_product_TO_history_1 FOREIGN KEY (pid) REFERENCES product (pid);

ALTER TABLE review ADD CONSTRAINT K_history_TO_review_1 FOREIGN KEY (hid) REFERENCES history (hid);

ALTER TABLE comment ADD CONSTRAINT K_customer_TO_comment_1 FOREIGN KEY (cid) REFERENCES customer (cid);
ALTER TABLE comment ADD CONSTRAINT K_review_TO_comment_1 FOREIGN KEY (rid) REFERENCES review (rid);

ALTER TABLE category2 ADD CONSTRAINT K_category1_TO_category2_1 FOREIGN KEY (ca1id) REFERENCES category1 (ca1id);
