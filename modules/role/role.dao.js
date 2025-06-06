const db = require('../../utils/mysql');


exports.getRole = async (param) => {
  const sql = `
    SELECT DISTINCT r.id, r.name AS roleName, r.code
    FROM roles r
    JOIN user_role ur ON r.id = ur.role_id
    WHERE ur.user_id = ?
  `
  const [rows] = await db.query(sql, [param]);
  return rows;
}
exports.getRoleMenuId = async (param) => { 
  const sql = `
    SELECT menu_id FROM role_menu WHERE role_id = ?
  `
  const rows = await db.query(sql, [param]);
  return rows.map(item => item.menu_id);
}
