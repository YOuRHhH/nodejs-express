const responseHelper = require('../utils/responseHelper');
const statusCodes = require('../constants/statusCodes');
const getUserPermissions = require('../services/permissionService');
/**
 * 校验用户权限
 * @param {*} permissionCode 
 * @returns 
 */
module.exports = function checkPermission(permissionCode) {
  return async (req, res, next) => {
    try {
      const userId = req.user.id; // JWT 中间件中解析并注入
      const permissions = await getUserPermissions(userId);

      if (!permissions.includes(permissionCode)) {
        return responseHelper.error(res, statusCodes.HTTP_NOT_PERMISSION, '无权限访问此接口');
        // return res.status(403).json({ message: '无权限访问此接口' });
      }

      next();
    } catch (err) {
      console.error('权限校验失败', err);
      responseHelper.error(res, statusCodes.HTTP_ERROR, '权限校验异常');
    }
  };
}