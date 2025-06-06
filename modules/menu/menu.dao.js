const db = require('../../utils/mysql');

exports.getUserMenu = async (param) => {
  const sql = `
    SELECT DISTINCT m.*
    FROM menus m
    JOIN role_menu rm ON m.id = rm.menu_id
    JOIN user_role ur ON rm.role_id = ur.role_id
    WHERE ur.user_id = ? and m.type = 'menu'
  `;
  const rows = await db.query(sql, [param]);
  return rows;
}


exports.getUserMenuPermissionCode = async  (param) => { 
  const sql = `
    SELECT DISTINCT m.permission_code
    FROM menus m
    JOIN role_menu rm ON m.id = rm.menu_id
    JOIN user_role ur ON rm.role_id = ur.role_id
    WHERE ur.user_id = ? and m.type = 'button' and m.visible = 1
  `
  const rows = await db.query(sql, [param]);
  return rows.map(item => item.permission_code)
}
