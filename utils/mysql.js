const config = require('../config/db.config.js');
// db.js
const mysql = require('mysql2/promise') ;

// if(config.env == 'production'){
//     // console.log("生产环境");
// }else if(config.env == "development"){
//     // console.log("开发环境");
// }

const pool = mysql.createPool(config);

// 封装 query
async function query(sql, params) {
    const connection = await pool.getConnection();
    try {
        const [rows] = await connection.query(sql, params);
        return rows;
    } catch (err) {
        throw err;
    } finally {
        connection.release();
    }
}

// 封装事务
async function transaction(task) {
    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();
        const result = await task(connection);
        await connection.commit();
        return result;
    } catch (err) {
        await connection.rollback();
        throw err;
    } finally {
        connection.release();
    }
}

module.exports = {
    query,
    pool,
    transaction
};