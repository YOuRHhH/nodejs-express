const db = require('../../utils/mysql');


exports.adminLogin = async (param) => {
  const sql = 'SELECT id,username,status,type,email,first_name,last_name FROM backend_users WHERE username = ? AND password = ?';
  const [rows] = await db.query(sql, [param.account, param.password]);
  return rows;
};





// /**
//  * 分页获取用户数据
//  * @param {Object} params - 分页参数
//  * @param {number} params.page - 当前页码（默认1）
//  * @param {number} params.pageSize - 每页条数（默认10）
//  * @returns {Promise<Object>} - 分页结果
//  */
// exports.getUserList = async ({ page = 1, pageSize = 10 } = {}) => {
//   try {
//     const offset = (page - 1) * pageSize;
//     // 获取当前页数据
//     const sql = 'SELECT * FROM users ORDER BY id LIMIT ? OFFSET ?';
//     const user = await db.query(sql,[pageSize, offset]);
//     // 获取总数
//     const countSql = 'SELECT COUNT(*) as total FROM users';
//     const total = await db.query(countSql);
//     return {
//       data: user,
//       page,
//       pageSize,
//       total:total[0].total,
//       totalPages: Math.ceil(total[0].total / pageSize),
//     };
//   } catch (err) {
//     throw err;
//   }
// };