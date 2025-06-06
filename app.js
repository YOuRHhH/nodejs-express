var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors = require('cors');
require('dotenv').config(); // 引入环境变量
require('./utils/redis.js');
var routes = require('./routes/config.js');
var MiddlewareGlobal = require('./middleware/index.js');
const redis = require("./utils/redis");



var app = express();

// view engine setup 不需要view
// app.set('views', path.join(__dirname, 'views'));
// app.set('view engine', 'jade');
app.locals.redis = redis;

app.set('trust proxy', true);

app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// middleware
MiddlewareGlobal(app)
// router
routes.init(app)

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404,'接口未找到'));
});

// error handler
app.use(function(err, req, res, next) {
  console.error('全局错误:', err);
  // 返回 JSON 错误响应
  res.status(err.status || 500).json({
    success: false,
    message: err.message || 'Internal Server Error',
    code: err.status || 500,
  });
});

module.exports = app;
