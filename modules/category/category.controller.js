// modules/menu/menu.controller.js
const responseHelper = require("../../utils/responseHelper");
const statusCodes = require("../../constants/statusCodes");

const caategoryService = require("./category.service");

exports.getCategory = async (req, res, next) => { 
  try{
    const result = await caategoryService.getCategoryList(req.query);
    responseHelper.success(res, result, "获取成功");
  }catch(err){
    responseHelper.error(res, statusCodes.HTTP_ERROR, err.message);
  }
};
exports.addCategory = async (req, res, next) => { 
  try{
    const param = req.body;
    const result = await caategoryService.addCategory(param);
    responseHelper.success(res, result, "添加成功");
  }catch(err){
    responseHelper.error(res, statusCodes.HTTP_ERROR, err.message);
  }
};