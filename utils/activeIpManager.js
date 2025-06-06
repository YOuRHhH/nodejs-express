const KEY_PREFIX = 'user:active_ips';

function getKey(userId) {
  return `${KEY_PREFIX}:${userId}`;
}

/**
 * 判断当前 IP 是否已经在用户的活动 IP 中
 */
async function canLogin(redis, userId, ip) {
  const key = getKey(userId);
  return await redis.zscore(key, ip);
}

/**
 * 记录当前 IP，如果超过限制，先移除一个旧的 IP
 */
async function recordIP(redis, userId, ip) {
  const key = getKey(userId);
  const maxIPs = process.env.ACCOUNT_LOGIN_TIMES;

  const expire = process.env.ACCOUNT_EXPIRESIN;
  const oldest = await redis.zrange(key, 0, 0);
  const count = await redis.zcount(key, '-inf', '+inf')

  if (count >= maxIPs) {
    await redis.zrem(key, oldest[0])
  }
  await redis.zadd(key, Date.now(),ip);
  await redis.expire(key, expire); // 设置过期时间，单位秒
}

module.exports = {
  canLogin,
  recordIP,
};