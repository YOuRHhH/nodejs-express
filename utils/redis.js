// utils/redis.js
const Redis = require('ioredis');
const redisConfig = require('../config/redis.config');

class RedisUtil {
  constructor() {
    this.client = new Redis(redisConfig);

    this.client.on('error', (err) => {
      console.log('Redis Error ' + err);
    });
    this.client.on('connect', () => {
      console.log('Redis connected');
    });
    this.client.on('close', () => {
      console.log('Redis close');
    });
  }
  // 添加基础类型数据元素
  async set(key, value, expireTime = 0) {
    if (expireTime > 0) {
      await this.client.set(key, value, 'EX', expireTime);
    } else {
      await this.client.set(key, value);
    }
  }
  // 
  // 获取剩余时间
  async ttl(key) {
    return await this.client.ttl(key);
  }
  // 添加有序集合元素
  async zadd(key, score, value){
    return await this.client.zadd(key, score, value);
  }
  // 获取有序集合元素
  async zrange(key, start, end){
    return await this.client.zrange(key, start, end);
  }
  // 获取有序集合元素数量
  async zcount(key, min, max){
    return await this.client.zcount(key, min, max);
  }
  // 删除有序集合元素
  async zrem(key, value){
    return await this.client.zrem(key, value);
  }
  // 获取有序集合元素分数
  async zscore(key, value){
    return await this.client.zscore(key, value);
  }
  // 设置过期时间
  async expire(key, expireTime) {
    return await this.client.expire(key, expireTime);
  }
  // 获取集合元素个数
  async scard(key){
    return await this.client.scard(key);
  }
  // 获取集合元素
  async smembers(key) {
    return await this.client.smembers(key);
  }
  // 判断元素是否存在 
  async sismember(key, value){
    return await this.client.sismember(key, value);
  }
  // 集合添加元素
  async sadd(key, value) {
    return await this.client.sadd(key, value);
  }
  async srem(key, value) {
    return await this.client.srem(key, value);
  }
  // 获取元素
  async get(key) {
    return await this.client.get(key);
  }
  // 删除元素
  async del(key) {
    await this.client.del(key);
  }

  async close() {
    await this.client.quit();
  }
}

module.exports = new RedisUtil();  // 👈 单例导出
