const svgCaptcha = require('svg-captcha');
const jwt = require('jsonwebtoken');
const JWT_EXPIRESIN = process.env.JWT_EXPIRESIN;
const CryptoJS = require('crypto-js');
/**
 * 生成JWT TOKEN
 * @param {*} data 数据
 * @param {*} expiresIn 时效
 * @returns
 */
function createJWT(data,expiresIn = JWT_EXPIRESIN) { 
  const SECRET_KEY = process.env.JWT_SECRET;
  const token = jwt.sign(data, SECRET_KEY, { expiresIn })
  return cryptojsAESEncrypt(token);
}
/**
 * 解密JWT TOKEN
 * @param {*} token 
 * @returns 
 */
function decryptJWT(token){
  const JWT_SECRET = process.env.JWT_SECRET;
  const decryptToken = jwt.verify(cryptojsAESDecrypt(token), JWT_SECRET);
  return decryptToken;
}
/**
 * AES加密
 * @param {*} data 
 * @returns 
 */
function cryptojsAESEncrypt(data) { 
  const CRYPTO_IV = CryptoJS.enc.Utf8.parse(process.env.CRYPTO_IV)
  const CRYPTO_SECRET = CryptoJS.enc.Utf8.parse(process.env.CRYPTO_SECRET)
  const encryptData = CryptoJS.AES.encrypt(data, CRYPTO_SECRET, { iv: CRYPTO_IV,mode: CryptoJS.mode.CBC,padding: CryptoJS.pad.Pkcs7 });
  return encryptData.toString();
}
/**
 * AES解密
 * @param {*} data 
 * @returns
 */
function cryptojsAESDecrypt(data){
  const CRYPTO_IV = CryptoJS.enc.Utf8.parse(process.env.CRYPTO_IV)
  const CRYPTO_SECRET = CryptoJS.enc.Utf8.parse(process.env.CRYPTO_SECRET)
  const decrypted = CryptoJS.AES.decrypt(data, CRYPTO_SECRET, {iv: CRYPTO_IV,mode: CryptoJS.mode.CBC,padding: CryptoJS.pad.Pkcs7,})
  return decrypted.toString(CryptoJS.enc.Utf8) || null;
}

/**
 * 获取图形验证码
 * @param {*} size 
 * @description 不区分大小写
 * @returns {data: {text: '验证码文本', data: '验证码图片数据'}}
 */
function getCaptcha(size = 6) {
  const captcha = svgCaptcha.create({
    size: 4,
    noise: 2,
    color: true,
    background: '#ffffff',
    width: 120,
    height: 48,
  })

  const svgString = captcha.data  // SVG XML 字符串
  const base64 = Buffer.from(svgString).toString('base64')
  const base64Image = `data:image/svg+xml;base64,${base64}`
  const text = captcha.text.toLocaleLowerCase()
  return {
    text: text,        // 验证码文本
    captcha: base64Image,        // Base64 图片
    session_id: cryptojsAESEncrypt(text),
  }
}


module.exports = {
  getCaptcha,
  createJWT,
  decryptJWT,
  cryptojsAESEncrypt,
  cryptojsAESDecrypt,
}