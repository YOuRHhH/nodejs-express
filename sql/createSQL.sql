-- 创建后台用户表
DROP TABLE IF EXISTS 
user_role,
roles,
role_menu,
menus,
backend_users,
coupons,
members,
members_finance,
members_financials,
member_address,
categories,
product_skus,
product_images,
product_specs,
product_categories,
product_tags,
products,
tenants,
platform_finance,
platform_financials,
tenants_finance,
tenants_financials,
tenants_enterprise_info,
orders,
order_items,
tags
;
CREATE TABLE backend_users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  platform ENUM('admin', 'business') NOT NULL DEFAULT 'business' COMMENT '平台类型，如 admin、business',
  email VARCHAR(255),
  status ENUM('1', '0') DEFAULT '0' COMMENT '状态，如 1:active、0:inactive',
  type ENUM('admin', 'business') DEFAULT 'business' COMMENT '用户类型，如 admin、business',
  -- 是否为子账户
  sub_account ENUM('1', '0') DEFAULT '0' COMMENT '是否为子账户，如 1:yes、0:no',
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT NULL COMMENT '软删除字段'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '后台用户表';
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
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT NULL,
  FOREIGN KEY (parent_id) REFERENCES menus(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '菜单表';
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
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '角色表';
-- 插入数据
INSERT INTO roles (id, name, code, description) VALUES
 (1,'管理员', 'admin', '拥有所有权限'),
 (2,'编辑', 'editor', '可编辑内容');

--  用户与角色关联表
CREATE TABLE user_role (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  deleted_at DATETIME DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, role_id),
  FOREIGN KEY (user_id) REFERENCES backend_users(id) ON DELETE CASCADE,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '用户与角色关联表';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '角色与菜单关联表';
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

-- 优惠券表
CREATE TABLE coupons (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '优惠券ID',
  code VARCHAR(64) NOT NULL UNIQUE COMMENT '优惠券码',
  type TINYINT NOT NULL COMMENT '优惠券类型（1满减 2折扣 3现金券等）',
  amount DECIMAL(10, 2) DEFAULT NULL COMMENT '优惠金额或折扣比例',
  min_order_amount DECIMAL(10, 2) DEFAULT 0 COMMENT '最低使用订单金额',
  start_time DATETIME NOT NULL COMMENT '有效开始时间',
  end_time DATETIME NOT NULL COMMENT '有效结束时间',
  total_quantity INT UNSIGNED DEFAULT 0 COMMENT '总发行数量',
  used_quantity INT UNSIGNED DEFAULT 0 COMMENT '已使用数量',
  status TINYINT DEFAULT 1 COMMENT '状态（0无效 1有效 2已过期）',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  INDEX idx_code (code),
  INDEX idx_status (status),
  INDEX idx_start_end_time (start_time, end_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='优惠券表';

-- 会员表
CREATE TABLE members (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  tenant_id BIGINT UNSIGNED DEFAULT NULL COMMENT '租户ID（多商户支持）',
  username VARCHAR(64) NOT NULL COMMENT '用户名',
  password VARCHAR(255) NOT NULL COMMENT '密码',
  open_id VARCHAR (100) DEFAULT NULL COMMENT '小程序openid',
  nickname VARCHAR(64) DEFAULT NULL COMMENT '昵称',
  email VARCHAR(128) DEFAULT NULL COMMENT '邮箱',
  phone VARCHAR(20) DEFAULT NULL COMMENT '手机号',
  avatar VARCHAR(255) DEFAULT NULL COMMENT '头像URL',
  gender TINYINT DEFAULT 0 COMMENT '性别（0未知 1男 2女）',
  level TINYINT DEFAULT 1 COMMENT '会员等级',
  status TINYINT DEFAULT 1 COMMENT '状态（1正常 0禁用）',
  platform VARCHAR(20) DEFAULT 'member' COMMENT ' 所属平台（如：admin/business/member）',
  last_login_at DATETIME DEFAULT NULL COMMENT '最后登录时间',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted_at DATETIME DEFAULT NULL COMMENT '软删除字段',
  PRIMARY KEY (id),
  UNIQUE KEY uniq_username (username, platform),
  UNIQUE KEY uniq_phone (phone),
  UNIQUE KEY uniq_email (email),
  KEY idx_tenant_id (tenant_id),
  KEY idx_open_id (open_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员表';
-- 会员财务表
CREATE TABLE members_finance (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  member_id BIGINT UNSIGNED NOT NULL COMMENT '会员ID',
  balance DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '余额',

  coupon_count BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '优惠券数量',
  point_count BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '积分数量',
  exchange_count BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '积分兑换数量',
  coupon_ids JSON DEFAULT NULL COMMENT '待使用优惠券IDs',

  frozen_balance DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '冻结余额',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员财务表';
-- 会员财务流水表
CREATE TABLE members_financials (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  member_id BIGINT UNSIGNED NOT NULL COMMENT '会员ID',
  members_finance_id  BIGINT UNSIGNED NOT NULL COMMENT '会员财务ID',
  type TINYINT DEFAULT 0 COMMENT '流水类型（0退款 10充值 20订单支出 30退款）',
  amount DECIMAL(10,2) NOT NULL COMMENT '金额',
  balance DECIMAL(10,2) NOT NULL COMMENT '余额',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员财务表';
-- 会员地址表
CREATE TABLE member_address (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  member_id BIGINT UNSIGNED NOT NULL COMMENT '所属会员ID',
  tenant_id BIGINT UNSIGNED DEFAULT NULL COMMENT '租户ID（多商户支持）',
  name VARCHAR(64) NOT NULL COMMENT '收货人姓名',
  phone VARCHAR(20) NOT NULL COMMENT '收货人手机号',
  province VARCHAR(64) DEFAULT NULL COMMENT '省',
  city VARCHAR(64) DEFAULT NULL COMMENT '市',
  district VARCHAR(64) DEFAULT NULL COMMENT '区/县',
  address VARCHAR(255) NOT NULL COMMENT '详细地址',
  postal_code VARCHAR(10) DEFAULT NULL COMMENT '邮政编码',
  is_default TINYINT DEFAULT 0 COMMENT '是否默认地址（1是 0否）',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted_at DATETIME DEFAULT NULL COMMENT '软删除字段',
  PRIMARY KEY (id),
  KEY idx_member_id (member_id),
  KEY idx_tenant_id (tenant_id),
  CONSTRAINT fk_address_member FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员收货地址表';

-- 标签表
CREATE TABLE tags (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  name VARCHAR(50) NOT NULL COMMENT '标签名称',
  description TEXT DEFAULT NULL COMMENT '标签描述',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='标签表';
-- 分类表
CREATE TABLE categories (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  name VARCHAR(50) NOT NULL COMMENT '分类名称',
  description TEXT DEFAULT NULL COMMENT '分类描述',
  status TINYINT DEFAULT 1 COMMENT '状态：1正常 0禁用',
  img_url VARCHAR(255) DEFAULT NULL COMMENT '分类图片URL',
  is_show_index TINYINT DEFAULT 0 COMMENT '是否首页展示（1是 0否）',
  sort INT DEFAULT 0 COMMENT '排序字段',
  type ENUM('business', 'member') DEFAULT 'member' COMMENT '所属平台：business/member member用户端展示 business商家展示',
  operate_user_name VARCHAR(50) DEFAULT NULL COMMENT '操作者名称',
  operate_user_id BIGINT UNSIGNED DEFAULT NULL COMMENT '操作者ID',
  parent_id BIGINT UNSIGNED DEFAULT NULL COMMENT '父级分类ID',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_parent_id (parent_id),
  FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分类表';

-- 商品表
CREATE TABLE products (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  tenant_id BIGINT UNSIGNED DEFAULT NULL COMMENT '租户ID',
  platform VARCHAR(50) NOT NULL DEFAULT 'admin' COMMENT '所属平台：admin/business/member',
  category_id BIGINT UNSIGNED DEFAULT NULL COMMENT '商品分类ID,为最后一层id',
  name VARCHAR(255) NOT NULL COMMENT '商品名称',
  spu VARCHAR(100) DEFAULT NULL COMMENT '商品SPU编号',
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '参考价格（最低价）',
  sale decimal(10,2) DEFAULT NULL COMMENT '价格原价（划横线）',
  stock INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '总库存',
  status TINYINT(1) NOT NULL DEFAULT 1 COMMENT '状态(1启用，0禁用)',
  cover_img VARCHAR(500) DEFAULT NULL COMMENT '封面图URL',
  description TEXT COMMENT '商品描述',
  sort INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  deleted_at DATETIME DEFAULT NULL COMMENT '软删除标记',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY uniq_tenant_spu (tenant_id, spu),
  KEY idx_tenant_id (tenant_id),
  KEY idx_category_id (category_id),
  KEY idx_status (status),
  KEY idx_deleted_at (deleted_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';
-- 商品分类表
CREATE TABLE product_categories (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  tenant_id BIGINT UNSIGNED DEFAULT NULL COMMENT '租户ID',
  product_name VARCHAR(100) NOT NULL COMMENT '商品名称',
  product_cover_img VARCHAR(500) DEFAULT NULL COMMENT '商品封面图URL',
  sale decimal(10,2) DEFAULT NULL COMMENT '价格原价（划横线）',
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '参考价格（最低价）',
  parent_id BIGINT UNSIGNED DEFAULT NULL COMMENT '父级分类ID',


  sort INT NOT NULL DEFAULT 0 COMMENT '排序值',
  deleted_at DATETIME DEFAULT NULL COMMENT '软删除',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY uniq_tenant_name (tenant_id, product_name),
  KEY idx_parent_id (parent_id),
  KEY idx_deleted_at (deleted_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';
-- 商品tag表
CREATE TABLE product_tags (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  product_id BIGINT UNSIGNED NOT NULL COMMENT '商品ID',
  tag_id BIGINT UNSIGNED NOT NULL COMMENT '标签ID',
  PRIMARY KEY (id),
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品tag表';



-- 商品图片/视频表
CREATE TABLE product_images (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  product_id BIGINT UNSIGNED NOT NULL COMMENT '所属商品ID',
  img_url VARCHAR(500) DEFAULT NULL COMMENT '图片链接',
  video_url VARCHAR(500) DEFAULT NULL COMMENT '视频链接',
  is_video TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否为视频（0否，1是）',
  sort INT NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (id),
  KEY idx_product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品图片表';

-- 商品规格表
CREATE TABLE product_specs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  product_id BIGINT UNSIGNED NOT NULL COMMENT '所属商品ID',
  spec_name VARCHAR(100) NOT NULL COMMENT '规格名（如颜色）',
  spec_value VARCHAR(100) NOT NULL COMMENT '规格值（如红色）',
  sort INT NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (id),
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品规格（SPU级）表';

-- 商品SKU表
CREATE TABLE product_skus (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  product_id BIGINT UNSIGNED NOT NULL COMMENT '所属商品ID',
  sku_code VARCHAR(100) NOT NULL COMMENT 'SKU编号',
  specs JSON NOT NULL COMMENT '规格值组合（JSON，例如：{"颜色":"红","尺码":"L"}）',
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '销售价格',
  stock INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '库存数量',
  cover_img VARCHAR(500) DEFAULT NULL COMMENT 'SKU图',
  deleted_at DATETIME DEFAULT NULL COMMENT '软删除',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uniq_sku_code (sku_code),
  KEY idx_product_id (product_id),
  KEY idx_deleted_at (deleted_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品SKU表';

-- 创建商户信息表
CREATE TABLE tenants (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  backend_users_id INT NOT NULL COMMENT '关联后台用户ID',
  business_name VARCHAR(255) NOT NULL COMMENT '店铺名称',
  customer_service_phone VARCHAR(20) NOT NULL COMMENT '店铺客服电话',
  contact_name VARCHAR(100) NOT NULL COMMENT '店铺联系人姓名',
  contact_phone VARCHAR(50) NOT NULL COMMENT '店铺联系人电话',
  contact_email VARCHAR(255) NOT NULL COMMENT '店铺联系人邮箱',
  contact_describe VARCHAR(255) DEFAULT NULL COMMENT '店铺描述',
  contact_logo VARCHAR(255) DEFAULT NULL COMMENT '店铺logo',
  contact_address VARCHAR(255) NOT NULL COMMENT '店铺联系地址',
  province VARCHAR(255) NOT NULL COMMENT '省',
  city VARCHAR(255) NOT NULL COMMENT '市',
  county VARCHAR(255) NOT NULL COMMENT '县/区',
  address VARCHAR(255) NOT NULL COMMENT '详细地址',  
  bank_account VARCHAR(255) NOT NULL COMMENT '银行账户',
  bank_owner VARCHAR(255) NOT NULL COMMENT '银行卡归属人',
  bank_name VARCHAR(255) NOT NULL COMMENT '开户银行名称',
  latitude DECIMAL(9,6) DEFAULT NULL COMMENT '纬度',
  longitude DECIMAL(9,6) DEFAULT NULL COMMENT '经度',
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending' COMMENT '商户状态',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT NULL,
  FOREIGN KEY (backend_users_id) REFERENCES backend_users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户信息表';
-- 创建平台端财务表
CREATE TABLE platform_finance (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  balance DECIMAL(10, 2) DEFAULT 0.00 COMMENT '账户余额',
  total_revenue DECIMAL(10, 2) DEFAULT 0.00 COMMENT '总收入',
  total_expenses DECIMAL(10, 2) DEFAULT 0.00 COMMENT '总支出',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台财务表';
-- 创建平台端财务表明细
CREATE TABLE platform_financials (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
  amount DECIMAL(10,2) NOT NULL COMMENT '金额',
  type TINYINT DEFAULT NULL COMMENT '类型（1收入 2支出）',
  tenant_id BIGINT UNSIGNED DEFAULT NULL COMMENT '商户ID',
  tenant_financials_id BIGINT UNSIGNED DEFAULT NULL COMMENT '商户财务流水ID',
  operate_user_name VARCHAR(64) DEFAULT NULL COMMENT '操作人名称',
  tenant_operate_user_name VARCHAR(64) DEFAULT NULL COMMENT '商户操作人名称',
  bank_name VARCHAR(64) DEFAULT NULL COMMENT '银行名称',
  bank_account VARCHAR(64) DEFAULT NULL COMMENT '银行账号',
  status TINYINT NOT NULL DEFAULT 0 COMMENT '状态（0待处理 10打款成功 20打款失败 30撤销 40拒绝）',
  operate_time DATETIME DEFAULT NULL COMMENT '操作时间',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_tenant_id (tenant_id),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='平台端财务流水表';
-- 创建商户财务表
CREATE TABLE tenants_finance (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  tenant_id BIGINT UNSIGNED NOT NULL COMMENT '商户ID',
  balance DECIMAL(10, 2) DEFAULT 0.00 COMMENT '账户余额',
  total_revenue DECIMAL(10, 2) DEFAULT 0.00 COMMENT '总收入',
  total_expenses DECIMAL(10, 2) DEFAULT 0.00 COMMENT '总支出',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_tenant_id (tenant_id),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户财务表';
-- 创建商户财务表明细
CREATE TABLE tenants_financials (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  tenants_finance_id BIGINT UNSIGNED NOT NULL COMMENT '财务表ID',
  type TINYINT NOT NULL COMMENT '类型（10订单收入 20退款扣除 30提现支出）',
  related_id BIGINT UNSIGNED DEFAULT NULL COMMENT '关联ID（订单ID或提现ID）',
  amount DECIMAL(10,2) NOT NULL COMMENT '金额（正值为进账，负值为出账）',
  balance DECIMAL(10,2) NOT NULL COMMENT '变动后账户余额（快照）',
  remark VARCHAR(255) DEFAULT NULL COMMENT '备注',
  status TINYINT NOT NULL DEFAULT 10 COMMENT '状态（0拒绝 10审核中 20通过 30撤销 40拒绝）',
  operate_user_name VARCHAR(64) DEFAULT NULL COMMENT '操作人',
  operate_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (id),
  KEY idx_tenant_merchant (tenants_finance_id),
  KEY idx_type (type),
  KEY idx_status (status),
  FOREIGN KEY (tenants_finance_id) REFERENCES tenants_finance(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户财务流水表';

-- 创建企业信息表
CREATE TABLE tenants_enterprise_info (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  tenant_id BIGINT UNSIGNED DEFAULT NULL COMMENT '商户ID',
  name VARCHAR(100) NOT NULL COMMENT '企业名称',
  address VARCHAR(255) DEFAULT NULL COMMENT '企业地址',
  license_name  VARCHAR(255) NOT NULL COMMENT '企业名称',
  license_money DECIMAL(10,2) NOT NULL COMMENT '企业注册资金',
  license_address VARCHAR(500) NOT NULL COMMENT '营业执照地址',
  license_img VARCHAR(500) NOT NULL COMMENT '营业执照图片',
  license_number VARCHAR(100) NOT NULL COMMENT '营业执照号',
  legal_name VARCHAR(255) NOT NULL COMMENT '法人姓名',
  legal_phone VARCHAR(20) NOT NULL COMMENT '法人手机号',
  legal_idcard VARCHAR(100) NOT NULL COMMENT '法人身份证号',
  legal_idcard_front VARCHAR(500) NOT NULL COMMENT '法人身份证正面',
  legal_idcard_back VARCHAR(500) NOT NULL COMMENT '法人身份证反面',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商户企业信息表';

-- 创建订单表 
-- 退款则不会退优惠券
CREATE TABLE orders (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  tenant_id BIGINT UNSIGNED DEFAULT NULL COMMENT '租户ID',
  order_no VARCHAR(64) NOT NULL COMMENT '订单编号',
  user_id BIGINT UNSIGNED NOT NULL COMMENT '下单用户ID',
  status TINYINT DEFAULT 10 COMMENT '订单状态（10待支付 20待发货 30待收货 40评论 50取消订单 60售后）',
  points INT DEFAULT 0 COMMENT '订单增加的积分',
  money DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '订单商品总金额',
  discount_money DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '积分抵扣金额',
  coupon_id BIGINT UNSIGNED DEFAULT NULL COMMENT '使用的优惠券ID',
  coupon_money DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '优惠券抵扣金额',
  freight_money DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '运费金额',
  actual_money DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '实际支付金额（最终付款金额）',
  pay_amount DECIMAL(10,2) DEFAULT 0.00 COMMENT '支付金额（含运费）',
  pay_type TINYINT DEFAULT 0 COMMENT '支付类型（0其他 10微信 20支付宝 30余额）',
  pay_time DATETIME DEFAULT NULL COMMENT '支付时间',
  
  delivery_time DATETIME DEFAULT NULL COMMENT '发货时间',
  receive_time DATETIME DEFAULT NULL COMMENT '收货时间',
  comment_time DATETIME DEFAULT NULL COMMENT '评论时间',
  cancel_time DATETIME DEFAULT NULL COMMENT '取消时间',
  deleted_at DATETIME DEFAULT NULL COMMENT '软删除字段',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_status` (`status`),
  KEY idx_tenant_status (tenant_id, status),
  KEY idx_tenant_user (tenant_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单商品明细表
CREATE TABLE order_items (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  order_id BIGINT UNSIGNED NOT NULL COMMENT '订单ID',
  product_id BIGINT UNSIGNED DEFAULT NULL COMMENT '商品ID',
  sku_id BIGINT UNSIGNED DEFAULT NULL COMMENT 'SKU ID',
  quantity INT NOT NULL DEFAULT 1 COMMENT '购买数量',
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '单价',
  total_price DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT '总价 = price * quantity',
  product_name VARCHAR(255) NOT NULL COMMENT '商品名称快照',
  product_cover VARCHAR(255) DEFAULT NULL COMMENT '商品封面图快照',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY idx_order_id (order_id),
  KEY idx_product_id (product_id),
  CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单商品明细表';
