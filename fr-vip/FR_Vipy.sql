/*
Navicat MySQL Data Transfer

Source Server         : OwnPlay
Source Server Version : 50541
Source Host           : sql-waw1.ServerProject.pl:3306
Source Database       : db_9591

Target Server Type    : MYSQL
Target Server Version : 50541
File Encoding         : 65001

Date: 2015-02-02 19:21:44
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `FR_Vipy`
-- ----------------------------
DROP TABLE IF EXISTS `FR_Vipy`;
CREATE TABLE `FR_Vipy` (
  `Login` varchar(255) DEFAULT NULL,
  `Termin` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of FR_Vipy
-- ----------------------------
