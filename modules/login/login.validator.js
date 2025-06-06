const Joi = require("joi");
module.exports = {
  adminLogin: Joi.object({
    account: Joi.string().required().messages({
      "string.empty": "用户名不能为空",
      "any.required": "用户名不能为空",
    }),
    password: Joi.string().min(6).required().messages({
      "string.empty": "密码不能为空",
      "string.min": "密码长度不能小于6位",
      "any.required": "密码不能为空",
    }),
    captcha: Joi.string().required().messages({
      "string.empty": "验证码不能为空",
      "any.required": "验证码不能为空",
    }),
    session_id: Joi.string().required().messages({
      "string.empty": "session_id不能为空",
      "any.required": "session_id不能为空",
    }),
  }),
};