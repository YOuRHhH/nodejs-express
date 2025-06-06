const fs = require('fs');
const path = require('path');
const {getDate} = require("@zzcpt/zztool")
const skipRecordUrl = require('../constants/skipRecordUrl');
const LOG_DIR = path.join(__dirname, '../logs/response');

module.exports = function (req, res, next) {
  const start = Date.now();
  const originalSend = res.send;
  const dateStr = getDate('Y-M-D');
  const signDate = getDate('Y-M-D h:m:s');
  const logFile = path.join(LOG_DIR, `${dateStr}.log`);
  // 拦截 res.send
  res.send = function (body) {
    const duration = Date.now() - start;
    if(!skipRecordUrl.includes(req.originalUrl)){
      const log = [
        `[${signDate}]`,
        `${req.method} ${req.originalUrl}`,
        `URL: ${req.originalUrl}`,
        `IP: ${req.ip}`,
        `duration: ${duration}ms`,
        `body: ${JSON.stringify(req.body)}`,
        `response: ${body}`,
      ].join(' - ') + '\n';
      if (!fs.existsSync(LOG_DIR)) {
        fs.mkdirSync(LOG_DIR, { recursive: true });
      }
  
      fs.appendFile(logFile, log, (err) => {
        if (err) console.error('写日志失败:', err);
      });
    }

    // 恢复原始 send 方法
    return originalSend.call(this, body);
  };

  next();
};
