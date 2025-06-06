const fs = require('fs');
const path = require('path');
const responseHelper = require('../utils/responseHelper');
const statusCodes = require('../constants/statusCodes');
const skipRecordUrl = require('../constants/skipRecordUrl');
const {decryptJWT} = require('../utils/index');
const {getDate} = require("@zzcpt/zztool")
const LOG_DIR = path.resolve(__dirname, '../logs/request'); // 你可以根据项目结构调整路径

const { canLogin } = require('../utils/activeIpManager');

/**
 * 请求中间件
 * @description 
 * 1. 请求中间件记录请求日志
 * 2. 判断单账号多用户请求
 */
module.exports = async function (req, res, next) {
  try{
    const dateStr = getDate('Y-M-D');
    const signDate = getDate('Y-M-D h:m:s');
    const logFile = path.join(LOG_DIR, `${dateStr}.log`);
    const userInfo = req.user;
    const token = req.headers['admin-token'];

    if(!userInfo && token){
      try{
        const decoded = decryptJWT(token);
        req.user = decoded;
      }catch{
        return responseHelper.error(res, statusCodes.HTTP_INVALID_TOKEN, '无效的令牌，请重新登录')
      }
    }
    if(req.user?.id){
      const canloginVar = await canLogin(req.app.locals.redis,req.user.id,req.ip);
      if(!canloginVar){
        return responseHelper.error(res, statusCodes.HTTP_ERROR, `当前账号已在多个设备上登录，请重新登录。`);
      }
    }
    
    if(!skipRecordUrl.includes(req.originalUrl)){
      const logContent = [
        `[${signDate}]`,
        `${req.method} ${req.originalUrl}`,
        `Status: ${res.statusCode}`,
        `IP: ${req.ip}`,
        `UA: ${req.headers['user-agent']}`,
        `UserInfo:${JSON.stringify(req.user)}`,
        `RequestParam:${JSON.stringify(req.body)}`
      ].join(' - ') + '\n';
      if (!fs.existsSync(LOG_DIR)) {
        fs.mkdirSync(LOG_DIR, { recursive: true });
      }
      // 异步追加日志（不阻塞请求）
      fs.appendFile(logFile, logContent, (err) => {
        if (err) {
          console.error('写入日志失败:', err);
        }
      });
    }

  }catch(e){
    console.error(e)
  }
  next();
}