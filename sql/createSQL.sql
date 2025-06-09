-- 创建后台用户表
DROP TABLE IF EXISTS user_role,roles,role_menu,menus,backend_users;
CREATE TABLE backend_users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  platform ENUM('admin', 'business') NOT NULL DEFAULT 'business' COMMENT '平台类型，如 admin、business',
  email VARCHAR(255),
  status ENUM('1', '0') DEFAULT '0' COMMENT '状态，如 1:active、0:inactive',
  type ENUM('business', 'admin') NOT NULL COMMENT '用户类型，如 business、admin',
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP DEFAULT NULL
)COMMENT '后台用户表';
-- 插入数据
INSERT INTO backend_users (username, password, email, type, first_name, last_name) VALUES
 ('admin', '123123', 'admin@example.com', 'admin', 'Admin', 'User'),
 ('editor', '123123', 'editor@example.com', 'admin', 'Editor', 'User'); 

-- 菜单表
CREATE TABLE menus (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL COMMENT '菜单名称',
  url VARCHAR(255) DEFAULT NULL COMMENT '菜单路径',
  type ENUM('directory', 'menu', 'button') NOT NULL COMMENT '菜单类型',
  permission_code VARCHAR(100) DEFAULT NULL COMMENT '权限标识(如 menu/add)',
  icon VARCHAR(255) DEFAULT NULL COMMENT '图标',
  platform ENUM('admin', 'business','all') DEFAULT NULL COMMENT  '平台类型，如 admin、business',
  parent_id INT DEFAULT NULL COMMENT '父菜单ID',
  sort INT DEFAULT 0,
  visible BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (parent_id) REFERENCES menus(id) ON DELETE SET NULL
);
-- 插入数据
INSERT  INTO menus (id, name, url, type, permission_code, platform, parent_id, sort, visible) VALUES
 (1,'首页', NULL, 'menu', NULL, 'admin', NULL, 1, TRUE),

 (10,'商户管理', NULL, 'menu', NULL, 'admin', NULL, 2, TRUE),
 (11,'商户列表', NULL, 'menu', NULL, 'admin', 10, 1, TRUE),
 (12,'认证申请', NULL, 'menu', NULL, 'admin', 10, 2, TRUE),
 (13,'入驻申请', NULL, 'menu', NULL, 'admin', 10, 3, TRUE),

 (20,'数据管理', NULL, 'menu', NULL, 'admin', NULL, 5, TRUE),
 (21,'数据看板', NULL, 'menu', NULL, 'admin', 20, 1, TRUE),
 
 (50,'用户管理', NULL, 'menu', NULL, 'admin', NULL, 4, TRUE),
 (51,'用户列表', NULL, 'menu', NULL, 'admin', 50, 1, TRUE),

 (40,'权限管理', NULL, 'menu', NULL, 'admin', NULL, 6, TRUE),
 (41,'角色管理', NULL, 'menu', NULL, 'admin', 40, 1, TRUE),

 (30,'配置管理', NULL, 'menu', NULL, 'admin', NULL, 7, TRUE),
 (31,'分类配置', NULL, 'menu', NULL, 'admin', 30, 1, TRUE),
 (32,'公告配置', NULL, 'menu', NULL, 'admin', 30, 2, TRUE),
 (33,'系统配置', NULL, 'menu', NULL, 'admin', 30, 3, TRUE),
 (34,'常见问题配置', NULL, 'menu', NULL, 'admin', 30, 4, TRUE),

 (60,'订单管理', NULL, 'menu', NULL, 'admin', NULL, 3, TRUE),
 (61,'订单列表', NULL, 'menu', NULL, 'admin', 60, 1, TRUE),

 (70,'商品管理', NULL, 'menu', NULL, 'admin', NULL, 8, TRUE),
 (71,'商品列表', NULL, 'menu', NULL, 'admin', 70, 1, TRUE),
-- 商家从500开始添加menu_id
-- 权限id从1000开始添加 上传功能统一使用OSS
 (1000,  "首页数据统计", NULL, 'button', 'admin/index', 'admin', 1, 0, TRUE),
 (1010,  "商户列表", NULL, 'button', 'admin/business/list', 'admin', 11, 0, TRUE),
 (1011,  "商户添加", NULL, 'button', 'admin/business/add', 'admin', 11, 0, TRUE),
 (1012,  "商户详情", NULL, 'button', 'admin/business/detail', 'admin', 11, 0, TRUE),
 (1013,  "商户编辑详情信息", NULL, 'button', 'admin/business/editInfo', 'admin', 11, 0, TRUE),
 (1014,  "商户删除", NULL, 'button', 'admin/business/delete', 'admin', 11, 0, TRUE),
 (1015,  "商户修改账号信息", NULL, 'button', 'admin/business/edit', 'admin', 11, 0, TRUE),
 (1050,  "商户认证列表", NULL, 'button', 'admin/business/auth/list', 'admin', 12, 0, TRUE),
 (1051,  "商户认证详情", NULL, 'button', 'admin/business/auth/detail', 'admin', 12, 0, TRUE),
 (1052,  "商户认证审核", NULL, 'button', 'admin/business/auth/examine', 'admin', 12, 0, TRUE),
 (1100,  "商户入驻申请", NULL, 'button', 'admin/business/registration/list', 'admin', 13, 0, TRUE),
 (1101,  "商户入驻详情", NULL, 'button', 'admin/business/registration/detail', 'admin', 13, 0, TRUE),
 (1102,  "商户入驻审核", NULL, 'button', 'admin/business/registration/examine', 'admin', 13, 0, TRUE),
 
 (1150,  "数据看板", NULL, 'button', 'admin/data/data', 'admin', 21, 0, TRUE),
 
 (1200,  "用户列表", NULL, 'button', 'admin/user/list', 'admin', 51, 0, TRUE),
 (1201,  "用户详情", NULL, 'button', 'admin/user/detail', 'admin', 51, 0, TRUE),
 (1202,  "用户删除", NULL, 'button', 'admin/user/delete', 'admin', 51, 0, TRUE),
 (1203,  "用户编辑", NULL, 'button', 'admin/user/edit', 'admin', 51, 0, TRUE),
 
 (1250,  "角色列表", NULL, 'button', 'admin/role/list', 'admin', 41, 0, TRUE),
 (1251,  "角色添加", NULL, 'button', 'admin/role/add', 'admin', 41, 0, TRUE),
 (1252,  "角色详情", NULL, 'button', 'admin/role/detail', 'admin', 41, 0, TRUE),
 (1253,  "角色编辑", NULL, 'button', 'admin/role/edit', 'admin', 41, 0, TRUE),
 (1254,  "角色删除", NULL, 'button', 'admin/role/delete', 'admin', 41, 0, TRUE),
 (1255,  "角色权限获取", NULL, 'button', 'admin/role/getPermission', 'admin', 41, 0, TRUE),
 (1256,  "角色权限修改", NULL, 'button', 'admin/role/setPermission', 'admin', 41, 0, TRUE),
 (1257,  "角色菜单获取", NULL, 'button', 'admin/role/getMenu', 'admin', 41, 0, TRUE),
 (1258,  "角色菜单修改", NULL, 'button', 'admin/role/setMenu', 'admin', 41, 0, TRUE),
 (1259,  "角色状态修改", NULL, 'button', 'admin/role/setStatus', 'admin', 41, 0, TRUE),

 (1300,  "分类列表", NULL, 'button', 'admin/category/list', 'admin', 31, 0, TRUE),
 (1301,  "分类添加", NULL, 'button', 'admin/category/add', 'admin', 31, 0, TRUE),
 (1302,  "分类详情", NULL, 'button', 'admin/category/detail', 'admin', 31, 0, TRUE),
 (1303,  "分类编辑", NULL, 'button', 'admin/category/edit', 'admin', 31, 0, TRUE),
 (1304,  "分类删除", NULL, 'button', 'admin/category/delete', 'admin', 31, 0, TRUE),
 (1305,  "分类排序", NULL, 'button', 'admin/category/sort', 'admin', 31, 0, TRUE),
 (1306,  "分类状态修改", NULL, 'button', 'admin/category/status', 'admin', 31, 0, TRUE),
 (1350,  "公告列表", NULL, 'button', 'admin/notice/list', 'admin', 32, 0, TRUE),
 (1351,  "公告添加", NULL, 'button', 'admin/notice/add', 'admin', 32, 0, TRUE),
 (1352,  "公告详情", NULL, 'button', 'admin/notice/detail', 'admin', 32, 0, TRUE),
 (1353,  "公告编辑", NULL, 'button', 'admin/notice/edit', 'admin', 32, 0, TRUE),
 (1354,  "公告删除", NULL, 'button', 'admin/notice/delete', 'admin', 32, 0, TRUE),
 (1355,  "公告状态修改", NULL, 'button', 'admin/notice/status', 'admin', 32, 0, TRUE),
 (1356,  "公告排序", NULL, 'button', 'admin/notice/sort', 'admin', 32, 0, TRUE),
 (1400,  "系统配置", NULL, 'button', 'admin/system/config', 'admin', 33, 0, TRUE),
 (1401,  "系统配置修改", NULL, 'button', 'admin/system/setConfig', 'admin', 33, 0, TRUE),
 
 (1450,  "常见问题列表", NULL, 'button', 'admin/question/list', 'admin', 34, 0, TRUE),
 (1451,  "常见问题添加", NULL, 'button', 'admin/question/add', 'admin', 34, 0, TRUE),
 (1452,  "常见问题详情", NULL, 'button', 'admin/question/detail', 'admin', 34, 0, TRUE),
 (1453,  "常见问题编辑", NULL, 'button', 'admin/question/edit', 'admin', 34, 0, TRUE),
 (1454,  "常见问题删除", NULL, 'button', 'admin/question/delete', 'admin', 34, 0, TRUE),
 (1455,  "常见问题排序", NULL, 'button', 'admin/question/sort', 'admin', 34, 0, TRUE),
 (1456,  "常见问题状态修改", NULL, 'button', 'admin/question/status', 'admin', 34, 0, TRUE),

 (1500,  "订单列表", NULL, 'button', 'admin/order/list', 'admin', 61, 0, TRUE),
 (1501,  "订单详情", NULL, 'button', 'admin/order/detail', 'admin', 61, 0, TRUE),
 (1502,  "订单状态修改", NULL, 'button', 'admin/order/status', 'admin', 61, 0, TRUE),
 (1503,  "订单删除", NULL, 'button', 'admin/order/delete', 'admin', 61, 0, TRUE),
 (1504,  "订单导出", NULL, 'button', 'admin/order/export', 'admin', 61, 0, TRUE),

 (1550,  "商品列表", NULL, 'button', 'admin/goods/list', 'admin', 71, 0, TRUE),
 (1551,  "商品添加", NULL, 'button', 'admin/goods/add', 'admin', 71, 0, TRUE),
 (1552,  "商品详情", NULL, 'button', 'admin/goods/detail', 'admin', 71, 0, TRUE),
 (1553,  "商品编辑", NULL, 'button', 'admin/goods/edit', 'admin', 71, 0, TRUE),
 (1554,  "商品删除", NULL, 'button', 'admin/goods/delete', 'admin', 71, 0, TRUE),
 (1555,  "商品排序", NULL, 'button', 'admin/goods/sort', 'admin', 71, 0, TRUE),
 (1556,  "商品状态修改", NULL, 'button', 'admin/goods/status', 'admin', 71, 0, TRUE);
  
-- 角色表
CREATE TABLE roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL COMMENT '角色名称',
  code VARCHAR(50) NOT NULL UNIQUE COMMENT '角色编码，如 admin、editor',
  description VARCHAR(255) DEFAULT NULL COMMENT '描述',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP DEFAULT NULL
)COMMENT '角色表';
-- 插入数据
INSERT INTO roles (id, name, code, description) VALUES
 (1,'管理员', 'admin', '拥有所有权限'),
 (2,'编辑', 'editor', '可编辑内容');

--  用户与角色关联表
CREATE TABLE user_role (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  deleted_at TIMESTAMP DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, role_id),
  FOREIGN KEY (user_id) REFERENCES backend_users(id) ON DELETE CASCADE,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
)COMMENT '用户与角色关联表';
-- 插入数据
INSERT INTO user_role (user_id, role_id) VALUES
 (1, 1);

-- 角色与菜单关联表
CREATE TABLE role_menu (
  role_id INT NOT NULL,
  menu_id INT NOT NULL,
  PRIMARY KEY (role_id, menu_id),
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (menu_id) REFERENCES menus(id) ON DELETE CASCADE
)COMMENT '角色与菜单关联表';
-- 插入数据
INSERT INTO role_menu (role_id, menu_id) VALUES
 (1,1),
 (1,10),
 (1,11),
 (1,12),
 (1,13),
 (1,20),
 (1,21),
 (1,30),
 (1,31),
 (1,32),
 (1,33),
 (1,34),
 (1,40),
 (1,41),
 (1,50),
 (1,51),
 (1,60),
 (1,61),
 (1,70),
 (1,71),
 (1,1000),
 (1,1010),
 (1,1011),
 (1,1012),
 (1,1013),
 (1,1014),
 (1,1015),
 (1,1050),
 (1,1051),
 (1,1052),
 (1,1100),
 (1,1101),
 (1,1102),
 (1,1150),
 (1,1200),
 (1,1201),
 (1,1202),
 (1,1250),
 (1,1251),
 (1,1252),
 (1,1253),
 (1,1254),
 (1,1255),
 (1,1256),
 (1,1257),
 (1,1258),
 (1,1259),
 (1,1300),
 (1,1301),
 (1,1302),
 (1,1303),
 (1,1304),
 (1,1305),
 (1,1306),
 (1,1350),
 (1,1351),
 (1,1352),
 (1,1353),
 (1,1354),
 (1,1355),
 (1,1356),
 (1,1400),
 (1,1401),
 (1,1450),
 (1,1451),
 (1,1452),
 (1,1453),
 (1,1454),
 (1,1455),
 (1,1456),
 (1,1500),
 (1,1501),
 (1,1502),
 (1,1503),
 (1,1504),
 (1,1550),
 (1,1551),
 (1,1552),
 (1,1553),
 (1,1554),
 (1,1555),
 (1,1556);



