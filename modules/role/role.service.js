const roleDao = require('./role.dao');

/**
 * 获取用户角色
 * @param {*} param 用户ID 
 * @returns 
 */
exports.getRole = async (param) => { 
  const user = await roleDao.getRole(param);
  if(!user || user.length === 0) throw new Error('该账号未设置角色');
  return user;
};

/**
 * 获取角色菜单id列表
 * @param {*} param 角色ID
 * @returns
 */
exports.getRoleMenuId = async (param) => { 
  const RoleMenuId = await roleDao.getRoleMenuId(param);
  if(!RoleMenuId || RoleMenuId.length === 0) throw new Error('该账号角色未完成');
  return RoleMenuId;
};

