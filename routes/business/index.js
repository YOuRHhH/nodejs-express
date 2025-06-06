var express = require('express');
var router = express.Router();
var businessMiddleware = require('../../middleware/business.middleware');
var requestMiddleware = require('../../middleware/request.middleware');
var validateParamMiddleware  = require('../../middleware/validate.middleware');



router.use(businessMiddleware)

// router.post('/login',[requestMiddleware,validateParamMiddleware(userValidator.login)], userApp.login);
// router.post('/captcha',[requestMiddleware], userApp.getCaptcha)


module.exports = router;
