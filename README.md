基于walle的多渠道打包，Walle本身是做好的，但是上传到360加固后v2签名就被干掉了，所以要重新签名， 重新写入渠道
具体实现步骤参考http://18e0c209.wiz01.com/share/s/0oUc890scQDx2tkMAj02NI0c3Ubmms31ckdr2UwE0E2X-bzY
 Jay-Goo写了个python脚本，非常棒，但是不是所有人都安装了python环境，所以我基于 Jay-Goo的代码改成bat脚本，那么没有安装python的同学就有福了
感谢Walle 
感谢子勰bihe0832  https://github.com/bihe0832/Android-GetAPKInfo
感谢 Jay-Goo 用python语言写了 https://github.com/Jay-Goo/ProtectedApkResignerForWalle