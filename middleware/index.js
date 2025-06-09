const requestMiddleware = require('./request.middleware.js')
const jwtMiddleware = require('./JWT.middleware');
const responseMiddleware = require('./response.middleware.js');

/**
 * @author: zzh
 * @date: 2025-05-30
 */
module.exports = function (app) { 
  
  app.use(jwtMiddleware)
  app.use(requestMiddleware);
  app.use(responseMiddleware);
}