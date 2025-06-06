// utils/limitLoginAttempts.js

const MAX_RETRY = 5;
const WINDOW_SECONDS = 60;

/**
 * 检查是否超过最大登录尝试次数
 * @param {object} redis - Redis 实例
 * @param {string} ip - 客户端 IP 地址
 * @returns {object} - { allowed: Boolean, attempts: Number, ttl: Number }
 */
async function checkLoginAttempt(redis, ip) {
  const key = `login:fail:ip:${ip}`;
  const attempts = parseInt(await redis.get(key)) || 0;
  const ttl = await redis.ttl(key);
  return {
    allowed: attempts < MAX_RETRY,
    attempts,
    ttl: ttl > 0 ? ttl : WINDOW_SECONDS
  };
}

/**
 * 登录失败时增加失败计数
 * @param {object} redis - Redis 实例
 * @param {string} ip - 客户端 IP 地址
 */
async function increaseLoginAttempt(redis, ip) {
  const key = `login:fail:ip:${ip}`;
  const attempts = parseInt(await redis.get(key)) || 0;
  await redis.set(key, attempts + 1, WINDOW_SECONDS);
}

/**
 * 登录成功时重置计数
 * @param {object} redis - Redis 实例
 * @param {string} ip - 客户端 IP 地址
 */
async function resetLoginAttempt(redis, ip) {
  const key = `login:fail:ip:${ip}`;
  await redis.del(key);
}


module.exports = {
  checkLoginAttempt,
  increaseLoginAttempt,
  resetLoginAttempt
};
