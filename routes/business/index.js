var express = require('express');
var router = express.Router();
var businessMiddleware = require('../../middleware/router/business.middleware');
var requestMiddleware = require('../../middleware/request.middleware');
var validateParamMiddleware  = require('../../middleware/validate.middleware');



router.use(businessMiddleware)

router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});
// router.post('/login',[requestMiddleware,validateParamMiddleware(userValidator.login)], userApp.login);
// router.post('/captcha',[requestMiddleware], userApp.getCaptcha)


module.exports = router;
