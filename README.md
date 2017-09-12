# 创建签名文件自动化脚本  createKeystore.bat  
## 使用方法 
1. 只需要两个文件createKeystore.bat  和 ctreateConfig.properties
2. 修改ctreateConfig.properties 的内容；
    * keyPath： keystore的文件路径  
    * alias： 别名
    * keyPassword： key的密码
    * storePassword： store的密码    
    * day=20000 有效期（天）  
	* name=Anthony Yang 姓名  
	* organizationalUnit=aiitec  组织单位  
	* organization=aiitec 组织
	* city=guangzhou  城市
	* province=guangdong  省份或区域  
	* countryCode=cn  国家代码


3. 双击createKeystore.bat 执行就自动生成了一个keystore文件


# Android多渠道打包V2签名自动化脚本  sign.bat

## 介绍  

基于walle的多渠道打包，Walle本身是做好的，但是上传到360加固后v2签名就被干掉了，所以要重新签名，重新写入渠道  
具体实现步骤参考http://18e0c209.wiz01.com/share/s/0oUc890scQDx2tkMAj02NI0c3Ubmms31ckdr2UwE0E2X-bzY  
Jay-Goo写了个python脚本，非常棒，但是不是所有人都安装了python环境，所以我基于 Jay-Goo的代码改成bat脚本，那么没有安装python的同学就有福了

## 使用方法
1. 首先下载本项目的代码；
2. 把apk文件复制到当前目录下；
3. 修改改signConfig.properties 的内容；
    * sdkPath： Android SDK buildTool 的目录，必须25以上  
    * keyPath： keystore的文件路径  
    * alias： 别名
    * keyPassword： key的密码
    * storePassword： store的密码，一般这两个都习惯使用相同密码，以至于我都忘了哪个是先输入的哪个是后输入的  
    * filePath： apk文件路径 对齐和签名后的文件会生成在跟此文件同一目录下
    * isZipalign： 是否需要对齐，如果项目不需要对齐，设置成false就行
    * isWriteChannel： 是否需要写入渠道 有的人是没有集成Walle的，纯粹就是想重新签名而已，那就是设置为false
4. 添加渠道文件channel, 不需要后缀名，需要多少个渠道一行一行写上去就行，如果纯粹想重新签名，不需要分渠道的，请忽略这一步；
5. 双击sign.bat 等待执行完成就可以了，输入任意键退出。

## 鸣谢  

##### 感谢 Walle  
 
提供多渠道打包解决方案，美团团队付出是最大的，从V1打包到  

##### 感谢 子勰bihe0832  https://github.com/bihe0832/Android-GetAPKInfo  

##### 感谢 Jay-Goo 用python语言写了 https://github.com/Jay-Goo/ProtectedApkResignerForWalle  


##### 不感谢 360加固  

因为360加固把我们的V2签名给去掉了，所以我们才需要写这些东西，开玩笑啦！！！  
因为加固的工作就是要往apk里加入加密的东西，如果不去掉V2就没法加固了，所以：  

##### 也应该感谢360加固等第三方加固平台，免费为我们的apk安全保驾护航！



#  获取keystore文件的md5签名脚本  GetMd5FromKeystore.bat  
##  使用方法 
1. 只需要两个文件GetMd5FromKeystore.bat   和 GetMd5Config.properties
2. 修改 GetMd5Config.properties 的内容；
    * keyPath： keystore的文件路径  
    * alias： 别名
    * storePassword： store的密码    
3. 双击GetMd5FromKeystore.bat 执行就自动生成了一个md5AndSha1.txt文件  
里面内容包含
md5 1cfcc9b5351280db9955b4207ee8cb23                                                       
SHA1: BA:F8:BB:E8:EA:13:94:69:BB:26:1B:34:7E:C7:F5:84:07:CB:FD:30 
SHA256: 7E:EC:2D:88:BA:3F:0C:3C:9F:77:18:72:54:0C:59:35:E7:82:41:57:C3:EB:41:C0:97:98:32:C8:CC:EB:A6:D7 




#  检查apk是否是V2签名的自动化脚本  checkV2.bat 
##  使用方法 
1. 依赖libs\CheckAndroidV2Signature.jar 一个文件checkV2.bat  
2. 修把apk文件拖动到checkV2.bat即可打开命令行窗口，  
输出{"ret":0,"msg":"ok","isV2":true,"isV2OK":true}就对了，如果不是V2则是isV2OK:false  
记住是拖动apk哦，不是双击打开。

  
  
  
  
  