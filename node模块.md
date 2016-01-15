##创建模块

nodejs中一个js文件就是一个模块，如hello.js就是一个模块。

在这个js文件中，我们提供方法给外部调用

##引入模块

    var hello = require('./hello');
  
引入模块用require方法，参数传模块js文件的地址，不用带后缀，./是当前文件的目录。

##定义外部方法（模块公开接口）

###将模块内某个方法属性公开接口

    exports.world = function() {
        console.log('Hello World');
    }

这样就可以在外部以下面这种方式调用模块内方法：
	
	// 会输出 “Hello World”
	hello.world()
	
###将模块整个对象公开接口

	module.exports = function() {
  		// ...
	}
	
下面这个例子 Hello对象公开了出去，在外部直接使用对象：
	
	//hello.js 
	function Hello() { 
		var name; 
		this.setName = function(thyName) { 
			name = thyName; 
		}; 
		this.sayHello = function() { 
			console.log('Hello ' + name); 
		}; 
	}; 
	module.exports = Hello;
	
在外部使用方式为：
	
	//main.js 
	var Hello = require('./hello'); 
	hello = new Hello(); 
	hello.setName('BYVoid'); 
	hello.sayHello(); 