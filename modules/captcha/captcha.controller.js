const responseHelper = require("../../utils/responseHelper");
const statusCodes = require("../../constants/statusCodes");
const { getCaptcha } = require("../../utils/index");

exports.getCaptcha = async (req, res, next) => {
  try {
    responseHelper.success(res, getCaptcha(), "获取成功");
  } catch (e) {
    responseHelper.error(res, statusCodes.HTTP_ERROR, "获取失败");
  }
};
