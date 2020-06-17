/*
Navicat MySQL Data Transfer

Source Server         : store
Source Server Version : 50018
Source Host           : localhost:3306
Source Database       : store

Target Server Type    : MYSQL
Target Server Version : 50018
File Encoding         : 65001

Date: 2019-12-17 01:31:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `buyerinfo`
-- ----------------------------
DROP TABLE IF EXISTS `buyerinfo`;
CREATE TABLE `buyerinfo` (
  `memberID` varchar(10) NOT NULL COMMENT '用户ID',
  `memberName` char(20) NOT NULL COMMENT '用户名称',
  `pwd` varchar(20) NOT NULL default '密码',
  `logontimes` int(11) default '1' COMMENT '登陆次数',
  `phoneCode` varchar(11) default NULL COMMENT '电话',
  `email` varchar(255) default NULL COMMENT '邮箱\r\n',
  PRIMARY KEY  (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of buyerinfo
-- ----------------------------
INSERT INTO `buyerinfo` VALUES ('1', '1', '1', '64', 'hhhhh', 'hhh');
INSERT INTO `buyerinfo` VALUES ('12', '123', '1234', '1', '12345', '123456');
INSERT INTO `buyerinfo` VALUES ('123', '123', '123', '4', '123', '123');
INSERT INTO `buyerinfo` VALUES ('2017211167', 'smallsmart', '123456', '16', '17347800520', '1346683197@qq.com');
INSERT INTO `buyerinfo` VALUES ('hhhh', 'hghhhh', 'hhhh', '0', 'hhhh', 'hhhh');

-- ----------------------------
-- Table structure for `cominfo`
-- ----------------------------
DROP TABLE IF EXISTS `cominfo`;
CREATE TABLE `cominfo` (
  `comKey` varchar(20) NOT NULL default '' COMMENT '商品编号',
  `comName` varchar(255) default NULL COMMENT '商品名',
  `sellerName` varchar(255) default NULL COMMENT '卖家名',
  `price` float(255,2) default NULL COMMENT '价格',
  `introduce` varchar(255) default NULL COMMENT '简介',
  PRIMARY KEY  (`comKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cominfo
-- ----------------------------
INSERT INTO `cominfo` VALUES ('000', 'hhh', 'hhhh', '11.00', 'hhh');
INSERT INTO `cominfo` VALUES ('123', '经管啤酒', '经管足球队', '2.50', '巴适得很');
INSERT INTO `cominfo` VALUES ('124', '经管之星足球', '经管足球队', '70.00', '踢踢踢');
INSERT INTO `cominfo` VALUES ('125', '电话', '通信', '10.00', 'smartphone');
INSERT INTO `cominfo` VALUES ('900', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('901', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('902', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('903', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('904', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('905', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('906', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('907', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('908', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('909', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('910', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('911', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('912', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('913', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('914', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('915', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('916', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('917', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('918', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('919', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('920', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('921', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('922', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('923', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('924', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('925', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('926', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('927', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('928', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('929', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('930', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('931', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('932', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('933', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('934', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('935', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('936', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('937', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('938', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('939', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('940', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('941', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('942', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('943', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('944', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('945', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('946', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('947', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('948', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('949', '示例 ', '示例', '1.25', '示例');
INSERT INTO `cominfo` VALUES ('999', 'sdasd ', 'sdasd sas', '111.00', 'dasd a');

-- ----------------------------
-- Table structure for `orderdetail`
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail` (
  `orderID` int(10) NOT NULL default '0' COMMENT '订单号',
  `comKey` varchar(255) NOT NULL default '' COMMENT '商品号',
  `comcount` int(10) default NULL,
  PRIMARY KEY  (`orderID`,`comKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES ('31', '123', '1');
INSERT INTO `orderdetail` VALUES ('31', '124', '1');
INSERT INTO `orderdetail` VALUES ('32', '123', '1');
INSERT INTO `orderdetail` VALUES ('33', '123', '1');
INSERT INTO `orderdetail` VALUES ('34', '123', '1');
INSERT INTO `orderdetail` VALUES ('35', '125', '1');
INSERT INTO `orderdetail` VALUES ('36', '123', '1');
INSERT INTO `orderdetail` VALUES ('36', '124', '1');
INSERT INTO `orderdetail` VALUES ('37', '123', '1');
INSERT INTO `orderdetail` VALUES ('38', '000', '1');
INSERT INTO `orderdetail` VALUES ('38', '124', '1');

-- ----------------------------
-- Table structure for `orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `orderinfo`;
CREATE TABLE `orderinfo` (
  `orderID` int(11) NOT NULL auto_increment,
  `userID` varchar(255) default NULL COMMENT '会员ID',
  `receiverName` varchar(255) default NULL COMMENT '接收者姓名',
  `receiverAddress` varchar(255) default NULL COMMENT '接收者地址',
  `receiverZip` varchar(255) NOT NULL default '' COMMENT '接收者邮编',
  `orderRem` varchar(255) default NULL COMMENT '备注',
  `orderPrice` float(255,2) default NULL,
  `orderDate` varchar(255) default NULL,
  `memo` varchar(255) default NULL COMMENT '备注',
  PRIMARY KEY  (`orderID`,`receiverZip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderinfo
-- ----------------------------
INSERT INTO `orderinfo` VALUES ('3', '1', '', '1', '1', 'null', '72.50', '2019-12-06', 'null');
INSERT INTO `orderinfo` VALUES ('4', '1', '', '1', '1', 'null', '70.00', '2019-12-06', 'null');
INSERT INTO `orderinfo` VALUES ('5', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('6', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('7', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('8', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('9', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('10', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('11', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('12', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('13', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('14', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('15', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('16', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('17', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '111');
INSERT INTO `orderinfo` VALUES ('18', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '111');
INSERT INTO `orderinfo` VALUES ('19', '1', '', '1', '1', 'null', '70.00', '2019-12-06', '111');
INSERT INTO `orderinfo` VALUES ('20', '1', '', '1', '1', 'null', '72.50', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('21', '1', '', '1', '1', 'null', '72.50', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('22', '1', '', '1', '1', 'null', '72.50', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('23', '1', '', '1', '1', 'null', '72.50', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('24', '1', '', '1', '1', 'null', '72.50', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('25', '1', '', '', '', 'null', '72.50', '2019-12-06', '');
INSERT INTO `orderinfo` VALUES ('26', '1', '', '1', '1', 'null', '72.50', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('27', '1', '', '1', '1', 'null', '72.50', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('28', '1', '', '1', '1', 'null', '72.50', '2019-12-06', '1');
INSERT INTO `orderinfo` VALUES ('29', '1', '', '2', '2', 'null', '72.50', '2019-12-06', '2');
INSERT INTO `orderinfo` VALUES ('30', '1', '', '2', '2', 'null', '72.50', '2019-12-06', '2');
INSERT INTO `orderinfo` VALUES ('31', '2017211167', '', 'ç»ç®¡æ¥¼', '561000', 'null', '72.50', '2019-12-06', 'ååååååååååææææææ');
INSERT INTO `orderinfo` VALUES ('32', '123', '', 'sss', 'sss', 'null', '2.50', '2019-12-08', '');
INSERT INTO `orderinfo` VALUES ('33', '1', '', '', '2', 'null', '2.50', '2019-12-13', '1');
INSERT INTO `orderinfo` VALUES ('34', '1', '', '', '2', 'null', '2.50', '2019-12-13', '1');
INSERT INTO `orderinfo` VALUES ('35', '2017211167', '', '', '', 'null', '10.00', '2019-12-17', '');
INSERT INTO `orderinfo` VALUES ('36', '123', '', '', '', 'null', '72.50', '2019-12-17', '');
INSERT INTO `orderinfo` VALUES ('37', '2017211167', '', '', '', 'null', '2.50', '2019-12-17', '');
INSERT INTO `orderinfo` VALUES ('38', '2017211167', '', 'hhhhhhhhhh', '561000', 'null', '81.00', '2019-12-17', 'hhhhhh');
