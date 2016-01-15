##创建模块
nodejs中一个js文件就是一个模块，如hello.js就是一个模块。

在这个js文件中，我们提供方法给外部调用

##引入模块
  var hello = require('./hello');
  
引入模块用require方法，参数传模块js文件的地址，不用带后缀，./是当前文件的目录。
