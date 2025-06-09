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
const responseHelper = require("./utils/responseHelper");
const statusCodes = require("./constants/statusCodes");
const redis = require("./utils/redis");


var app = express();

// view engine setup 不需要view
// app.set('views', path.join(__dirname, 'views'));
// app.set('view engine', 'jade');
app.locals.redis = redis;

app.set('trust proxy', true);
app.use('/',function(req, res, next){
  if(req.path === '/'){
    const content = `<!DOCTYPE html><html lang="zh-CN"><head><meta charset="UTF-8"><title>祝福</title><style>      body {        margin: 0;        height: 100vh;        display: flex;        justify-content: center;        align-items: center;        background: #f5f5f5;        font-family: "微软雅黑", sans-serif;      }        p{          margin: 0;          padding: 0;        }      .message {        font-size: 20px;        line-height: 1.8;        text-align: center;        color: #333;        padding: 20px;        background: #fff;        border-radius: 12px;        box-shadow: 0 4px 20px rgba(0,0,0,0.1);      }</style></head><body><div class="message"><p>我们是匆匆的行者，祝福如春雨，滋润心田间。</p><p>愿你笑容常开，生活美满甜。</p><p>事业步步高，前程似锦绣。</p><p>健康快乐伴你左右，幸福永远与你相伴。</p></div></body></html>  `;
    res.send(content)
  }else{
    next()
  }
})
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
  return responseHelper.error(res, statusCodes.HTTP_NOT_FOUND,'接口未找到');
  // next(createError(404,'接口未找到'));
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
