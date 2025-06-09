const responseHelper = require('../utils/responseHelper');
const statusCodes = require('../constants/statusCodes');

const {decryptJWT} = require('../utils/index');

// 白名单
const whiteList = [
  '/api/admin/captcha',
  '/api/admin/login'
];

// JWT 中间件
module.exports = function (req, res, next) {
  if (whiteList.includes(req.path)) return next();

  const token = req.headers['admin-token'];
  if (!token) return responseHelper.error(res, statusCodes.HTTP_NOT_LOGIN, '请先登录')

  try {
    const decoded = decryptJWT(token)
    req.user = decoded;
    return next();
  } catch (err) {
    responseHelper.error(res, statusCodes.HTTP_INVALID_TOKEN, '无效的令牌，请重新登录')
  }
}

