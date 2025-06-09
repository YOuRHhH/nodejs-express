var express = require('express');
var router = express.Router();
var middleware = require('../../middleware/router/web.middleware');
var {success,error}  = require('../../utils/responseHelper')

router.use(middleware)
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;