const db = require('../../utils/mysql');


exports.getCategoryList = async (param) => {
  const sql = 'SELECT id,name,status,type,parent_id FROM categories';
  const [rows] = await db.query(sql);
  return rows;
};

exports.addCategory = async (param) => {
  return db.transaction(async (connection) => { 
    const insert_sql = `
      INSERT INTO categories(name,description,status,is_show_index,img_url,type,parent_id) VALUES(?,?,?,?)
    `;
    const [result] = await connection.query(insert_sql, [param.name, param.description, param.status, param.is_show_index, param.img_url, param.type, param.parent_id]);
    return result;
  });
};