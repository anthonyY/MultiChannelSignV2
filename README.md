#Android多渠道打包V2签名自动化脚本  

##介绍  

基于walle的多渠道打包，Walle本身是做好的，但是上传到360加固后v2签名就被干掉了，所以要重新签名，重新写入渠道  
具体实现步骤参考http://18e0c209.wiz01.com/share/s/0oUc890scQDx2tkMAj02NI0c3Ubmms31ckdr2UwE0E2X-bzY  
Jay-Goo写了个python脚本，非常棒，但是不是所有人都安装了python环境，所以我基于 Jay-Goo的代码改成bat脚本，那么没有安装python的同学就有福了

##使用方法
1. 首先下载本项目的代码；
2. 把apk文件复制到当前目录下；
3. 改config.properties 的内容；
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

##鸣谢  

#####感谢 Walle  
 
提供多渠道打包解决方案，美团团队付出是最大的，从V1打包到  

#####感谢 子勰bihe0832  https://github.com/bihe0832/Android-GetAPKInfo  

#####感谢 Jay-Goo 用python语言写了 https://github.com/Jay-Goo/ProtectedApkResignerForWalle  


#####不感谢 360加固  

因为360加固把我们的V2签名给去掉了，所以我们才需要写这些东西，开玩笑啦！！！  
因为加固的工作就是要往apk里加入加密的东西，如果不去掉V2就没法加固了，所以：  

#####也应该感谢360加固等第三方加固平台，免费为我们的apk安全保驾护航！

