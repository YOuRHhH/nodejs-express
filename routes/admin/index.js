var express = require('express');
var router = express.Router();
var adminMiddleware = require('../../middleware/admin.middleware');
var validateParamMiddleware  = require('../../middleware/validate.middleware');


var loginController = require('../../modules/login/login.controller');
var captchaController = require('../../modules/captcha/captcha.controller');
var loginValidator = require('../../modules/login/login.validator');

router.use(adminMiddleware)

router.post('/login',[validateParamMiddleware(loginValidator.adminLogin)], loginController.adminLogin);
router.post('/captcha', captchaController.getCaptcha)


module.exports = router;
