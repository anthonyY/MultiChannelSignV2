#多渠道打包自动化脚本 
##介绍
基于walle的多渠道打包，Walle本身是做好的，但是上传到360加固后v2签名就被干掉了，所以要重新签名，重新写入渠道  
具体实现步骤参考http://18e0c209.wiz01.com/share/s/0oUc890scQDx2tkMAj02NI0c3Ubmms31ckdr2UwE0E2X-bzY  
Jay-Goo写了个python脚本，非常棒，但是不是所有人都安装了python环境，所以我基于 Jay-Goo的代码改成bat脚本，那么没有安装python的同学就有福了
##鸣谢
#####感谢 Walle 
提供多渠道打包解决方案，美团团队付出是最大的，从V1打包到
#####感谢 子勰bihe0832  https://github.com/bihe0832/Android-GetAPKInfo
#####感谢 Jay-Goo 用python语言写了 https://github.com/Jay-Goo/ProtectedApkResignerForWalle

#####不感谢 360加固
因为360加固把我们的V2签名给去掉了，所以我们才需要写这些东西，开玩笑啦！！！  
因为加固的工作就是要往apk里加入加密的东西，如果不去掉V2就没法加固了，所以：
#####也应该感谢360加固等第三方加固平台，免费为我们的apk安全保驾护航！

