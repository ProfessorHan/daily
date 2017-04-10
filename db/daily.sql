/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : daily

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2016-11-25 07:42:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `sys_createjava`
-- ----------------------------
DROP TABLE IF EXISTS `sys_createjava`;
CREATE TABLE `sys_createjava` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `rootPath` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '工程路径',
  `actionPath` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'action路径',
  `tableName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '数据库表名',
  `codeName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '模块中文注释',
  `modName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '模块名称',
  `templateBasePath` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '获取文件模板根路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_createjava
-- ----------------------------
INSERT INTO `sys_createjava` VALUES ('1', 'D:\\code', 'D:\\code\\src', 'tb_project', '项目表', 'business', 'D:\\workspace\\daily\\WebContent\\template');
INSERT INTO `sys_createjava` VALUES ('2', 'D:\\code', 'D:\\code\\src', 'tb_msg', '消息提醒', 'business', 'D:\\workspace\\daily\\WebContent\\template');

-- ----------------------------
-- Table structure for `sys_dept`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '单位id',
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '单位名称',
  `p_id` int(11) unsigned DEFAULT NULL,
  `p_guanxi` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '全部', '0', '1');
INSERT INTO `sys_dept` VALUES ('73', '市局', '1', '1/73');
INSERT INTO `sys_dept` VALUES ('105', '县市局', '73', '1/73/105');
INSERT INTO `sys_dept` VALUES ('106', '邢台县局', '105', '1/73/105/106');
INSERT INTO `sys_dept` VALUES ('107', '沙河市局', '73', '1/73/107');
INSERT INTO `sys_dept` VALUES ('108', '内丘县局', '105', '1/73/105/108');

-- ----------------------------
-- Table structure for `sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `dict_name` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `dict_key` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_user` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('29', '客户等级', 'cust_level', '2015-09-07 09:02:49', null);
INSERT INTO `sys_dict` VALUES ('30', '客户信用度', 'cust_star', '2015-09-07 09:06:31', null);

-- ----------------------------
-- Table structure for `sys_dict_value`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_value`;
CREATE TABLE `sys_dict_value` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `data_value` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `dict_id` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_dict_value
-- ----------------------------
INSERT INTO `sys_dict_value` VALUES ('1', '请假', '1');
INSERT INTO `sys_dict_value` VALUES ('2', '外出', '1');
INSERT INTO `sys_dict_value` VALUES ('3', '调休', '1');
INSERT INTO `sys_dict_value` VALUES ('4', '加班', '1');
INSERT INTO `sys_dict_value` VALUES ('5', '开车', '2');
INSERT INTO `sys_dict_value` VALUES ('6', '电动车', '2');
INSERT INTO `sys_dict_value` VALUES ('7', '自行车', '2');
INSERT INTO `sys_dict_value` VALUES ('8', '公交', '2');
INSERT INTO `sys_dict_value` VALUES ('9', '其他', '2');

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(100) DEFAULT NULL COMMENT '系统url',
  `parentId` int(10) DEFAULT NULL COMMENT ' 父id 关联sys_menu.id',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否删除,0=未删除，1=已删除',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '修改时间',
  `rank` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `actions` varchar(500) DEFAULT '0' COMMENT '注册Action 按钮|分隔',
  `relevance` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '', null, '0', '2012-12-23 17:21:58', '2015-11-03 08:21:25', '3', '', '1');
INSERT INTO `sys_menu` VALUES ('2', '菜单管理', '/sysMenu/menu.do', '1', '0', '2012-12-23 18:18:32', '2015-08-08 15:02:50', '0', 'dataList.do', '1/2');
INSERT INTO `sys_menu` VALUES ('6', '用户管理', '/sysUser/list.do', '1', '0', '2012-12-23 22:15:33', '2015-08-13 10:48:43', '0', 'dataList.do', '1/6');
INSERT INTO `sys_menu` VALUES ('7', '角色管理', '/sysRole/role.do', '1', '0', '2012-12-24 22:17:51', '2015-07-21 14:23:32', '0', 'dataList.do|/sysMenu/getMenuTree.do', '1/7');
INSERT INTO `sys_menu` VALUES ('11', '代码自动生成', '', null, '0', '2015-07-21 16:27:10', null, '1', '', '');
INSERT INTO `sys_menu` VALUES ('16', 'java代码自动生成', '/sysCreatejava/list.do', '11', '0', '2015-08-12 17:00:01', '2015-08-12 17:57:03', '0', 'dataList.do', null);
INSERT INTO `sys_menu` VALUES ('46', '统计报表', '', null, '1', '2015-10-11 10:58:02', '2015-11-03 08:20:43', '4', '', null);
INSERT INTO `sys_menu` VALUES ('47', '基础管理', null, null, '0', '2016-11-22 08:32:12', null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('48', '分组管理', '/tbGroup/list.do', '47', '0', '2016-11-22 08:36:03', null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('49', '请假管理', '/tbLeave/list.do', '47', '0', '2016-11-22 08:37:14', null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('50', '调休管理', '/tbOff/list.do', '47', '0', '2016-11-22 08:38:09', null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('51', '外出管理', '/tbOut/list.do', '47', '0', '2016-11-22 08:38:39', null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('52', '加班管理', '/tbOvertime/list.do', '47', '0', '2016-11-22 08:39:18', null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('53', '项目管理', '/tbProject/list.do', '47', '0', '2016-11-22 08:40:00', null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('54', '晨报管理', '/tbDay/list.do', '47', '1', '2016-11-22 09:27:11', null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('55', '消息提醒', '/tbMsg/list.do', '47', '0', '2016-11-22 09:53:50', null, '0', null, null);
INSERT INTO `sys_menu` VALUES ('56', '晨报管理', '/tbDay/list.do', '47', '0', '2016-11-23 13:34:02', null, '0', null, null);

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(12) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `roleName` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '角色名称',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `createBy` int(11) DEFAULT NULL COMMENT '创建人',
  `updateTime` datetime DEFAULT NULL COMMENT '修改时间',
  `updateBy` int(11) DEFAULT NULL COMMENT '修改人',
  `state` int(1) DEFAULT NULL COMMENT '状态0=可用 1=禁用',
  `descr` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('21', '发布人', '2015-09-24 14:34:54', null, '2015-11-25 09:22:47', null, '0', null);
INSERT INTO `sys_role` VALUES ('22', '办理人', '2015-10-14 10:59:18', null, '2015-10-14 15:52:38', null, '0', null);
INSERT INTO `sys_role` VALUES ('28', '项目经理', '2016-11-22 09:19:03', '0', '2016-11-22 09:19:03', null, '0', '就是经理');

-- ----------------------------
-- Table structure for `sys_role_rel`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_rel`;
CREATE TABLE `sys_role_rel` (
  `roleId` int(11) NOT NULL COMMENT '角色主键 sys_role.id',
  `objId` int(11) NOT NULL COMMENT '关联主键 type=0管理sys_menu.id, type=1关联sys_user.id',
  `relType` int(1) DEFAULT NULL COMMENT '关联类型 0=菜单,1=用户'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_role_rel
-- ----------------------------
INSERT INTO `sys_role_rel` VALUES ('22', '17', '1');
INSERT INTO `sys_role_rel` VALUES ('22', '21', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '22', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '23', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '45', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '50', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '40', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '41', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '42', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '89', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '94', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '95', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '96', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '19', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '20', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '21', '1');
INSERT INTO `sys_role_rel` VALUES ('22', '22', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '25', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '27', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '28', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '29', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '30', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '31', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '32', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '33', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '34', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '35', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '36', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '37', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '38', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '39', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '40', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '41', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '42', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '43', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '44', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '45', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '46', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '47', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '48', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '49', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '50', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '51', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '52', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '53', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '54', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '8', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '55', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '56', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '57', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '58', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '59', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '60', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '61', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '62', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '63', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '64', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '65', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '66', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '67', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '68', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '69', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '70', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '71', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '72', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '73', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '74', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '75', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '76', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '77', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '78', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '79', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '80', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '81', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '82', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '83', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '84', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '85', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '86', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '87', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '88', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '89', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '90', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '91', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '92', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '93', '1');
INSERT INTO `sys_role_rel` VALUES ('22', '94', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '24', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '21', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '22', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '23', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '34', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '45', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '50', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '47', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '48', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '49', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '6', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '8', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '33', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '1', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '43', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '44', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '45', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '97', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '40', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '99', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '42', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '67', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '89', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '94', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '95', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '96', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '91', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '92', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '93', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '8', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '9', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '10', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '11', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '15', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '66', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '95', '1');
INSERT INTO `sys_role_rel` VALUES ('22', '17', '1');
INSERT INTO `sys_role_rel` VALUES ('22', '21', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '22', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '23', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '45', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '50', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '19', '0');
INSERT INTO `sys_role_rel` VALUES ('22', '40', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '41', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '42', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '89', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '94', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '95', '2');
INSERT INTO `sys_role_rel` VALUES ('22', '96', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '19', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '20', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '21', '1');
INSERT INTO `sys_role_rel` VALUES ('22', '22', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '25', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '1', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '2', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '6', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '7', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '8', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '33', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '21', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '22', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '23', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '24', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '34', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '45', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '50', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '46', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '47', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '48', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '49', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '19', '0');
INSERT INTO `sys_role_rel` VALUES ('21', '5', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '6', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '7', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '8', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '9', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '10', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '11', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '12', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '13', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '14', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '15', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '66', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '40', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '41', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '42', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '43', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '44', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '45', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '97', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '67', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '89', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '94', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '95', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '96', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '91', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '92', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '93', '2');
INSERT INTO `sys_role_rel` VALUES ('21', '27', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '28', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '29', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '30', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '31', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '32', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '33', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '34', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '35', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '36', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '37', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '38', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '39', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '40', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '41', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '42', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '43', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '44', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '45', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '46', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '47', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '48', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '49', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '50', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '51', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '52', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '53', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '54', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '8', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '55', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '56', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '57', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '58', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '59', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '60', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '61', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '62', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '63', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '64', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '65', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '66', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '67', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '68', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '69', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '70', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '71', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '72', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '73', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '74', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '75', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '76', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '77', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '78', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '79', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '80', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '81', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '82', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '83', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '84', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '85', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '86', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '87', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '88', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '89', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '90', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '91', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '92', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '93', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '95', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '94', '1');
INSERT INTO `sys_role_rel` VALUES ('10000', '10', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '10', '1');
INSERT INTO `sys_role_rel` VALUES ('22', '10', '1');
INSERT INTO `sys_role_rel` VALUES ('28', '10', '1');
INSERT INTO `sys_role_rel` VALUES ('10000', '9', '1');
INSERT INTO `sys_role_rel` VALUES ('21', '9', '1');
INSERT INTO `sys_role_rel` VALUES ('22', '9', '1');
INSERT INTO `sys_role_rel` VALUES ('28', '9', '1');
INSERT INTO `sys_role_rel` VALUES ('28', '10000', '0');
INSERT INTO `sys_role_rel` VALUES ('28', '47', '0');
INSERT INTO `sys_role_rel` VALUES ('28', '48', '0');
INSERT INTO `sys_role_rel` VALUES ('28', '49', '0');
INSERT INTO `sys_role_rel` VALUES ('28', '50', '0');
INSERT INTO `sys_role_rel` VALUES ('28', '51', '0');
INSERT INTO `sys_role_rel` VALUES ('28', '52', '0');
INSERT INTO `sys_role_rel` VALUES ('28', '53', '0');
INSERT INTO `sys_role_rel` VALUES ('28', '55', '0');
INSERT INTO `sys_role_rel` VALUES ('28', '56', '0');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `email` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '邮箱也是登录帐号',
  `pwd` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '登录密码',
  `nickName` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '昵称',
  `mobile_phone` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '手机',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '状态 0=可用,1=禁用',
  `loginCount` int(11) DEFAULT NULL COMMENT '登录总次数',
  `loginTime` datetime DEFAULT NULL COMMENT '最后登录时间',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '删除状态 0=未删除,1=已删除',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '修改时间',
  `createBy` int(11) DEFAULT NULL COMMENT '创建人',
  `updateBy` int(11) DEFAULT NULL COMMENT '修改人',
  `superAdmin` int(1) NOT NULL DEFAULT '0' COMMENT '是否超级管理员 0= 不是，1=是',
  `dept_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('0', 'admin', '81DC9BDB52D04DC20036DBD8313ED055', '系统管理员', null, '0', '0', '2016-11-24 17:40:12', '0', '2015-07-30 15:06:11', '2016-11-24 17:40:12', null, null, '1', '1');
INSERT INTO `sys_user` VALUES ('9', 'zgh', '81DC9BDB52D04DC20036DBD8313ED055', '张国宏', null, '0', null, '2016-11-24 17:35:04', '0', '2016-11-22 09:08:02', '2016-11-24 17:35:04', null, null, '0', null);
INSERT INTO `sys_user` VALUES ('10', 'mxt', '81DC9BDB52D04DC20036DBD8313ED055', '孟学廷', null, '0', null, '2016-11-24 17:37:43', '0', '2016-11-22 09:10:04', '2016-11-24 17:37:43', null, null, '0', null);

-- ----------------------------
-- Table structure for `tb_day`
-- ----------------------------
DROP TABLE IF EXISTS `tb_day`;
CREATE TABLE `tb_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `day_user_ud` int(11) DEFAULT NULL COMMENT '用户id',
  `day_project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `day_context` varchar(1000) DEFAULT NULL COMMENT '日报内容',
  `day_schedule` int(11) DEFAULT NULL COMMENT '晨报进度：0：未完成，1：完成',
  `day_schedule_context` varchar(1000) DEFAULT NULL COMMENT '未完成内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_day
-- ----------------------------
INSERT INTO `tb_day` VALUES ('9', '0', '1', '晨报管理模块功能实现', '1', '');
INSERT INTO `tb_day` VALUES ('10', '0', '1', '消息提醒模块功能实现', '0', '已读人和接受人名字获取不到');
INSERT INTO `tb_day` VALUES ('11', '9', '1', '晨报管理模块功能实现', '1', '');
INSERT INTO `tb_day` VALUES ('12', '10', '1', '晨报管理模块功能实现', '0', '晨报管理模块功能实现');

-- ----------------------------
-- Table structure for `tb_dispatch`
-- ----------------------------
DROP TABLE IF EXISTS `tb_dispatch`;
CREATE TABLE `tb_dispatch` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `dispatch_plan_id` int(11) DEFAULT NULL COMMENT '计划id',
  `dispatch_project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `dispatch_user_id` int(11) DEFAULT NULL COMMENT '调用人',
  `dispatch_context` varchar(1000) DEFAULT NULL COMMENT '调用任务内容',
  `dispatch_expect_result` varchar(1000) DEFAULT NULL COMMENT '预计结果',
  `dispatch_level` int(11) DEFAULT NULL COMMENT '重要程度，1：重要，2：紧急，3：一般，4：酌情安排',
  `dispatch_createdate` varchar(55) DEFAULT NULL COMMENT '申请日期',
  `dispatch_do_user_id` int(11) DEFAULT NULL COMMENT '任务承担人id',
  `dispatch_expect_date` varchar(55) DEFAULT NULL COMMENT '预计完成日期',
  `dispatch_expect_time` double DEFAULT NULL COMMENT '预计工时',
  `dispatch_do_begin_date` varchar(55) DEFAULT NULL COMMENT '任务开始日期',
  `dispatch_reality_type` int(11) DEFAULT NULL COMMENT '任务完成类型，字典表数据',
  `dispatch_reality_date` varchar(55) DEFAULT NULL COMMENT '任务实际完成日期',
  `dispatch_reality_result` varchar(1000) DEFAULT NULL COMMENT '任务验收结果',
  `dispatch_delay_reason` varchar(1000) DEFAULT NULL COMMENT '任务延期或终止原因',
  `dispatch_delay_enddate` varchar(55) DEFAULT NULL COMMENT '延期完成时间',
  `dispatch_enddate` varchar(55) DEFAULT NULL COMMENT '调用单最终完成时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_dispatch
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_group`
-- ----------------------------
DROP TABLE IF EXISTS `tb_group`;
CREATE TABLE `tb_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) DEFAULT NULL COMMENT '分组名称',
  `group_num` int(11) DEFAULT NULL COMMENT '成员数',
  `group_create` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `group_create_user` int(11) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group
-- ----------------------------
INSERT INTO `tb_group` VALUES ('1', '晨报组', '2', '2016-11-22 09:04:31', '0');
INSERT INTO `tb_group` VALUES ('2', '月报组', '4', '2016-11-22 03:12:24', '0');

-- ----------------------------
-- Table structure for `tb_group_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_group_user`;
CREATE TABLE `tb_group_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户表id',
  `group_id` int(11) DEFAULT NULL COMMENT '小组id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group_user
-- ----------------------------
INSERT INTO `tb_group_user` VALUES ('1', '0', '1');
INSERT INTO `tb_group_user` VALUES ('2', '9', '2');
INSERT INTO `tb_group_user` VALUES ('3', '10', '2');

-- ----------------------------
-- Table structure for `tb_leave`
-- ----------------------------
DROP TABLE IF EXISTS `tb_leave`;
CREATE TABLE `tb_leave` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leave_userid` int(11) DEFAULT NULL COMMENT '用户id',
  `leave_type` int(11) DEFAULT NULL COMMENT '请假类型，字典表数据',
  `leave_context` varchar(1000) DEFAULT NULL COMMENT '请假内容',
  `leave_createdate` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `leave_begintime` varchar(255) DEFAULT NULL COMMENT '请假开始时间',
  `leave_endtime` varchar(255) DEFAULT NULL COMMENT '请假结束时间',
  `leave_hour` double DEFAULT NULL COMMENT '请假时长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_leave
-- ----------------------------
INSERT INTO `tb_leave` VALUES ('1', '9', '1', '就是想请假', '2016-11-22 09:08:36', '2016-11-22 09:00:00', '2016-11-30 09:00:00', '8');
INSERT INTO `tb_leave` VALUES ('2', '0', '1', '还是想请假', '2016-11-22 09:09:01', '2016-11-22 09:00:00', '2016-11-30 09:00:00', '8');

-- ----------------------------
-- Table structure for `tb_matter`
-- ----------------------------
DROP TABLE IF EXISTS `tb_matter`;
CREATE TABLE `tb_matter` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `matter_context` varchar(1000) DEFAULT NULL COMMENT '事项内容',
  `matter_user_id` int(11) DEFAULT NULL COMMENT '事项提交人id',
  `matter_create_time` varchar(255) DEFAULT NULL COMMENT '事项创建时间',
  `matter_type` int(11) DEFAULT NULL COMMENT '事项类型，字典表取数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_matter
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_msg`
-- ----------------------------
DROP TABLE IF EXISTS `tb_msg`;
CREATE TABLE `tb_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `msg_tittle` varchar(1000) DEFAULT NULL COMMENT '标题',
  `msg_context` varchar(2000) DEFAULT NULL COMMENT '消息通知内容',
  `msg_publish_id` int(11) DEFAULT NULL COMMENT '发布人id',
  `msg_publish_time` varchar(255) DEFAULT NULL COMMENT '发布时间',
  `msg_receive_ids` varchar(1000) DEFAULT NULL COMMENT '接受人ids，","做分割',
  `msg_read_ids` varchar(1000) DEFAULT NULL COMMENT '已读人ids，","做分割',
  `msg_level` int(11) DEFAULT NULL COMMENT '消息等级，1、2、3数字越小等级越高',
  `msg_top` int(11) DEFAULT NULL COMMENT '是否指定,1:置顶，0:不置顶',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_msg
-- ----------------------------
INSERT INTO `tb_msg` VALUES ('69', '我是这个屯', '土生土长的人', '0', '2016-11-24 03:38:42', '张国宏,孟学廷,', '系统管理员', '2', '0');
INSERT INTO `tb_msg` VALUES ('70', '我的老家', '就住在这个屯', '0', '2016-11-24 04:03:09', '张国宏,', '系统管理员', '1', '1');

-- ----------------------------
-- Table structure for `tb_off`
-- ----------------------------
DROP TABLE IF EXISTS `tb_off`;
CREATE TABLE `tb_off` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `off_userid` int(11) DEFAULT NULL COMMENT '用户id',
  `off_projectid` int(11) DEFAULT NULL COMMENT '项目id',
  `off_begintime` varchar(255) DEFAULT NULL COMMENT '调休开始时间',
  `off_endtime` varchar(255) DEFAULT NULL COMMENT '调休结束时间',
  `off_createdate` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `off_context` varchar(1000) DEFAULT NULL COMMENT '调休内容',
  `off_hour` double DEFAULT NULL COMMENT '调休时长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_off
-- ----------------------------
INSERT INTO `tb_off` VALUES ('1', '9', '1', '2016-11-22 09:00:00', '2016-11-30 09:00:00', '2016-11-22 09:15:10', '就是想调休', '8');

-- ----------------------------
-- Table structure for `tb_out`
-- ----------------------------
DROP TABLE IF EXISTS `tb_out`;
CREATE TABLE `tb_out` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `out_userid` int(11) DEFAULT NULL COMMENT '外出人',
  `out_projectid` int(11) DEFAULT NULL COMMENT '项目id',
  `out_begintime` varchar(255) DEFAULT NULL COMMENT '外出时间',
  `out_endtime` varchar(255) DEFAULT NULL COMMENT '回岗时间',
  `out_context` varchar(1000) DEFAULT NULL COMMENT '外出事由',
  `out_vehicle` int(11) DEFAULT NULL COMMENT '交通工具，字典表数据',
  `out_remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_out
-- ----------------------------
INSERT INTO `tb_out` VALUES ('1', '9', '1', '2016-11-22 09:00:00', '2017-05-31 09:00:00', '就是想外出', '5', null);
INSERT INTO `tb_out` VALUES ('2', '10', '1', '2016-11-22 09:00:00', '2018-01-31 09:00:00', '就是想外出', '7', null);

-- ----------------------------
-- Table structure for `tb_overtime`
-- ----------------------------
DROP TABLE IF EXISTS `tb_overtime`;
CREATE TABLE `tb_overtime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `overtime_userid` int(11) DEFAULT NULL COMMENT '加班人',
  `overtime_context` varchar(1000) DEFAULT NULL COMMENT '加班事由',
  `overtime_begintime` varchar(255) DEFAULT NULL COMMENT '开始时间',
  `overtime_endtime` varchar(255) DEFAULT NULL COMMENT '结束时间',
  `overtime_createdate` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `overtime_hour` double DEFAULT NULL COMMENT '加班时长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_overtime
-- ----------------------------
INSERT INTO `tb_overtime` VALUES ('1', '9', '就是想加班', '2016-11-22 09:00:00', '2016-11-30 09:00:00', '2016-11-22 09:13:59', '8');
INSERT INTO `tb_overtime` VALUES ('2', '0', '就是想加班', '2016-12-01 09:00:00', '2016-12-31 09:00:00', '2016-11-22 09:14:32', '30');

-- ----------------------------
-- Table structure for `tb_plan`
-- ----------------------------
DROP TABLE IF EXISTS `tb_plan`;
CREATE TABLE `tb_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `plan_project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `plan_user_id` int(11) DEFAULT NULL COMMENT '项目负责人id',
  `plan_type` int(11) DEFAULT NULL COMMENT '计划类型，字典表数据',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_plan
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_plan_context`
-- ----------------------------
DROP TABLE IF EXISTS `tb_plan_context`;
CREATE TABLE `tb_plan_context` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `plan_id` int(11) DEFAULT NULL COMMENT '计划表id',
  `plan_user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `plan_user_type` int(11) DEFAULT NULL COMMENT '用户类型，字典表数据',
  `plan_task` varchar(1000) DEFAULT NULL COMMENT '工作计划',
  `plan_expect_result` varchar(1000) DEFAULT NULL COMMENT '预计结果',
  `plan_expect_enddate` varchar(55) DEFAULT NULL COMMENT '预计结束时间',
  `plan_expect_time` double DEFAULT NULL COMMENT '预计工时',
  `plan_reality_enddate` varchar(55) DEFAULT NULL COMMENT '实际完成时间',
  `plan_reality_time` double DEFAULT NULL COMMENT '实际工时',
  `plan_reality_type` int(11) DEFAULT NULL COMMENT '完成状态',
  `plan_reality_result` varchar(1000) DEFAULT NULL COMMENT '实际结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_plan_context
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_project`
-- ----------------------------
DROP TABLE IF EXISTS `tb_project`;
CREATE TABLE `tb_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `project_name` varchar(255) DEFAULT NULL COMMENT '项目名称',
  `project_manager` int(11) DEFAULT NULL COMMENT '项目经理id',
  `project_director` int(11) DEFAULT NULL COMMENT '项目指导人id',
  `project_unit` varchar(255) DEFAULT NULL COMMENT '建设单位',
  `project_contacts` varchar(255) DEFAULT NULL COMMENT '联系人',
  `project_create` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `project_create_user` int(11) DEFAULT NULL COMMENT '创建人',
  `project_type` int(11) DEFAULT NULL COMMENT '项目状态：0：正在进行，1：已完结',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_project
-- ----------------------------
INSERT INTO `tb_project` VALUES ('1', '晨报系统', '10', '10', '河北时代电子', '孟学廷', '2016-11-22 09:09:41', '0', '0');

-- ----------------------------
-- Table structure for `tb_project_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_project_user`;
CREATE TABLE `tb_project_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `project_id` int(11) DEFAULT NULL COMMENT '项目id',
  `user_type` int(11) DEFAULT NULL COMMENT '人员状态：0：组员，1：负责人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_project_user
-- ----------------------------
INSERT INTO `tb_project_user` VALUES ('1', '10', '1', '1');
INSERT INTO `tb_project_user` VALUES ('2', '9', '1', '0');
