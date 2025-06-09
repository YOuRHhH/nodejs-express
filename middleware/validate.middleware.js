const responseHelper = require('../utils/responseHelper');
const statusCodes = require('../constants/statusCodes');

/**
 * 参数校验中间件
 * @param {*} schema 
 * @returns 
 */
module.exports = function validateMiddleware(schema) {
  return (req, res, next) => {
    const { error } = schema.validate(req.body)
    if (error) {
      return responseHelper.error(res, statusCodes.HTTP_ERROR, error.details[0].message);
    }
    next()
  }
}