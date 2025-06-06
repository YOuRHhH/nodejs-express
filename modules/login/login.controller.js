// modules/login/login.controller.js

const responseHelper = require("../../utils/responseHelper");
const statusCodes = require("../../constants/statusCodes");
const { createJWT } = require("../../utils/index");
const loginService = require("./login.service");
const menuService = require("../menu/menu.service");
const roleService = require("../role/role.service");

const {
  checkLoginAttempt,
  increaseLoginAttempt,
  resetLoginAttempt
} = require("../../utils/limitLoginAttempts");
const { canLogin, recordIP } = require('../../utils/activeIpManager');

/**
 * 管理员登录
 * @description 
 * 1. 登录功能
 * 2. 限制登录失败次数
 * 3. 登录成功清除失败计数
 * 4. 登录成功设置用户信息缓存
 * 5. 账号限制登录次数
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 * @returns 
 */
exports.adminLogin = async (req, res, next) => {
  const redis = req.app.locals.redis;
  const param = req.body;
  const ip = req.ip;

  // 1. 登录尝试检查
  const { allowed, ttl } = await checkLoginAttempt(redis, ip);
  if (!allowed) {
    return responseHelper.error(
      res,
      statusCodes.HTTP_ERROR,
      `登录失败次数过多，请 ${ttl} 秒后再试`
    );
  }

  let user;
  try{
    user = await loginService.adminLogin(param); // 登录
  }catch(err){
    // 累加登录尝试次数
    await increaseLoginAttempt(redis, ip);
    return responseHelper.error(res, statusCodes.HTTP_ERROR, err.message)
  }
  try{
    // 记录账号登录信息
    await recordIP(redis, user.id, ip); 
    // 重置登录失败次数
    await resetLoginAttempt(redis, ip);

    const userMenu = await menuService.getUserMenu(user.id); // 获取用户菜单
    const role = await roleService.getRole(user.id); // 获取用户角色
    const menuPermission = await menuService.getUserMenuPermissionCode(role.id);

    const token = createJWT(user,process.env.JWT_EXPIRESIN);
    const resolveData = {
      menu:userMenu,
      code:menuPermission,
      token
    }
    const setData = {
      user,
      code:menuPermission
    }
    redis.set(`user:token:${user.id}`,JSON.stringify(setData),process.env.ACCOUNT_EXPIRESIN)
    responseHelper.success(res, resolveData, '登录成功')
  }catch(err){
    return responseHelper.error(res, statusCodes.HTTP_ERROR, '用户数据加载失败: ' + err.message);
  }
};
