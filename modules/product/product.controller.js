// modules/menu/menu.controller.js
const responseHelper = require("../../utils/responseHelper");
const statusCodes = require("../../constants/statusCodes");

exports.getProductList = async (req, res, next) => { 
  try{
    responseHelper.success(res, {123:123}, "获取成功");
  }catch(err){
    responseHelper.error(res, statusCodes.HTTP_ERROR, err.message);
  }
};