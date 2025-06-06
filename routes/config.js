var indexRouter = require('./index');
var webRouter = require('./web/index');
var businessRouter = require('./business/index');
var adminRouter = require('./admin/index');

/**
 * 初始化路由 校验权限
 */
function init(app){
  app.use('/', indexRouter);
  app.use('/api/web', webRouter);
  app.use('/api/business', businessRouter);
  app.use('/api/admin',adminRouter)
}

exports.init = init;