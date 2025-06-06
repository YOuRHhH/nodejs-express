const loginDao = require('./login.dao');
const { cryptojsAESDecrypt } = require("../../utils/index");

exports.adminLogin = async (param) => { 
  const session_id = cryptojsAESDecrypt(param.session_id);
  // if(session_id !== param.captcha) throw new Error('验证码错误');
  const user = await loginDao.adminLogin(param);
  if(!user) throw new Error('用户名或密码错误');
  return user;
};



