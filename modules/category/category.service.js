const categoryDao = require('./category.dao');

exports.getCategoryList = async (param) => { 
  const data = await categoryDao.getCategoryList(param);
  return data;
}
exports.addCategory = async (param) => { 
  const data = await categoryDao.addCategory(param);
  return;
}