const menuDao = require('./menu.dao');

const {toTree} = require("@zzcpt/zztool")
/**
 * 获取用户菜单
 * @param {Object} param 账号ID
 */
exports.getUserMenu = async (param) => { 
  let menu = await menuDao.getUserMenu(param);
  menu = removeNotVisible(menu);
  menu = toTree(menu,'parent_id');
  if(!menu || menu.length === 0) throw new Error('该账号角色未完成');
  return menu;
};
/**
 * 获取用户权限代码列表
 * @param {Object} param 账户ID
 */
exports.getUserMenuPermissionCode = async (param) => {
  const user = await menuDao.getUserMenuPermissionCode(param);
  if(!user || user.length === 0) throw new Error('该账号角色未完成');
  return user;
};

/**
 * 去除不可见的菜单
 * @param {*} menu 
 * @description
 * 只处理一级菜单数组
 * @returns  {Array}
 */
function removeNotVisible(menu) { 
  const menuClone = [...menu];
  const notVisibleIDs = [];
  for(let i = 0; i < menuClone.length; i++){
    const item = menuClone[i];
    if (item.parent_id === null && item.visible === 0) {
      notVisibleIDs.push(item.id);
      menuClone.splice(i, 1);
      i--;
      continue;
    }
    if (item.visible === 0 || (item.parent_id && notVisibleIDs.includes(item.parent_id))) {
      menuClone.splice(i, 1);
      i--;
    }
  }
  return menuClone;
}
