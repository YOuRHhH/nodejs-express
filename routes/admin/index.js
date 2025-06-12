var express = require('express');
var router = express.Router();
var adminMiddleware = require('../../middleware/router/admin.middleware');
var validateParamMiddleware  = require('../../middleware/validate.middleware');


var loginController = require('../../modules/login/login.controller');
var captchaController = require('../../modules/captcha/captcha.controller');
var productController = require('../../modules/product/product.controller');
var categoryController = require('../../modules/category/category.controller');
var loginValidator = require('../../modules/login/login.validator');

router.use(adminMiddleware)

router.post('/login',[validateParamMiddleware(loginValidator.adminLogin)], loginController.adminLogin);
router.post('/captcha', captchaController.getCaptcha)
router.post('/logout', loginController.adminLogout);

router.post('/category/getCategory', categoryController.getCategory);
router.post('/category/addCategory', categoryController.addCategory);

router.post('/product/getProductList', productController.getProductList);


module.exports = router;
