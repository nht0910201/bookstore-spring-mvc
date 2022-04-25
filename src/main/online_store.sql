/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 100424
 Source Host           : localhost:3306
 Source Schema         : online_store

 Target Server Type    : MySQL
 Target Server Version : 100424
 File Encoding         : 65001

 Date: 25/04/2022 22:17:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `id` int NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account_username_uindex`(`username`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `account_user_email_id_fk`(`username`, `id`) USING BTREE,
  CONSTRAINT `account_user_email_id_fk` FOREIGN KEY (`username`, `id`) REFERENCES `user` (`email`, `id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci;

-- ----------------------------
-- Records of account
-- ----------------------------
BEGIN;
INSERT INTO `account` VALUES (1, 'huutri0910@gmail.com', '091020t.', 0);
COMMIT;

-- ----------------------------
-- Table structure for bill
-- ----------------------------
DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `account_id` int NOT NULL,
  `total_price` decimal(15, 0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order2___fk`(`total_price`) USING BTREE,
  INDEX `order1___fk`(`account_id`) USING BTREE,
  CONSTRAINT `order1___fk` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci;

-- ----------------------------
-- Records of bill
-- ----------------------------
BEGIN;
INSERT INTO `bill` VALUES (1, 'incomplete', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `pro_id` int NULL DEFAULT NULL,
  `pro_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(15, 0) NOT NULL,
  `quantity` int NOT NULL,
  `account_id` int NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`id`, `account_id`) USING BTREE,
  INDEX `cart1___fk`(`pro_id`) USING BTREE,
  INDEX `cart3___fk`(`account_id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  CONSTRAINT `cart1___fk` FOREIGN KEY (`pro_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cart3___fk` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci;

-- ----------------------------
-- Records of cart
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(15, 0) NOT NULL,
  `discount` int NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sup_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_supplier_id_fk`(`sup_id`) USING BTREE,
  CONSTRAINT `product_supplier_id_fk` FOREIGN KEY (`sup_id`) REFERENCES `supplier` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci;

-- ----------------------------
-- Records of product
-- ----------------------------
BEGIN;
INSERT INTO `product` VALUES (1, 'Samsung Samsung Galaxy A13 4GB', 5, 1234568, 5, 'Màn hình:\nPLS TFT LCD6.6\"Full HD+\nHệ điều hành:Android 12\nCamera sau:\nChính 50 MP & Phụ 5 MP, 2 MP, 2 MP\nCamera trước:\n8 MP\nChip:\nExynos 850\nRAM:\n4 GB\nBộ nhớ trong:\n128 GB\nSIM:\n2 Nano SIMHỗ trợ 4G\nPin, Sạc:\n5000 mAh15 W', 2), (2, 'Iphone', 5, 1234568, 5, 'Màn hình:\nPLS TFT LCD6.6\"Full HD+\nHệ điều hành:Android 12\nCamera sau:\nChính 50 MP & Phụ 5 MP, 2 MP, 2 MP\nCamera trước:\n8 MP\nChip:\nExynos 850\nRAM:\n4 GB\nBộ nhớ trong:\n128 GB\nSIM:\n2 Nano SIMHỗ trợ 4G\nPin, Sạc:\n5000 mAh15 W', 1), (3, 'Samsung Galaxy A11', 5, 1234569, 5, 'Màn hình:\nPLS TFT LCD6.6\"Full HD+\nHệ điều hành:Android 12\nCamera sau:\nChính 50 MP & Phụ 5 MP, 2 MP, 2 MP\nCamera trước:\n8 MP\nChip:\nExynos 850\nRAM:\n4 GB\nBộ nhớ trong:\n128 GB\nSIM:\n2 Nano SIMHỗ trợ 4G\nPin, Sạc:\n5000 mAh15 W', 2);
COMMIT;

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci;

-- ----------------------------
-- Records of supplier
-- ----------------------------
BEGIN;
INSERT INTO `supplier` VALUES (1, 'Iphone'), (2, 'Samsung');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_email_uindex`(`email`) USING BTREE,
  INDEX `email`(`email`, `id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'Nguyễn Hữu Trí', 'huutri0910@gmail.com', 'abc', '0912592574');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
