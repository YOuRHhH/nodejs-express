const statusCodes = require('../constants/statusCodes');

module.exports = {
  success(res, data, message = '请求成功') {
    return res.status(statusCodes.HTTP_OK).json({
      statusCode: statusCodes.HTTP_OK,
      message,
      data,
    });
  },

  error(res, statusCode = statusCodes.HTTP_ERROR, message = '请求失败') {
    return res.status(statusCodes.HTTP_OK).json({
      statusCode,
      message,
    });
  },

  // 处理其他类型的响应
  created(res, data, message = '资源创建成功') {
    return res.status(statusCodes.HTTP_CREATED).json({
      statusCode: statusCodes.HTTP_CREATED,
      message,
      data,
    });
  },
};
