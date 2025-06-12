const responseHelper = require('../../utils/responseHelper');
const statusCodes = require('../../constants/statusCodes');



module.exports = function (req, res, next) {
  const user = req.user;
  if(user && user.type !== 'admin'){
    return responseHelper.error(res, statusCodes.HTTP_NOT_LOGIN, '请先登录1')
  }
  next()
}