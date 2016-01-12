##自定义事件驱动
Node.js 使用事件驱动模型，当web server接收到请求，就把它关闭然后进行处理，然后去服务下一个web请求。
当这个请求完成，它被放回处理队列，当到达队列开头，这个结果被返回给用户。
这个模型非常高效可扩展性非常强，因为webserver一直接受请求而不等待任何读写操作。（这也被称之为非阻塞式IO或者事件驱动IO）
在事件驱动模型中，会生成一个主循环来监听事件，当检测到事件时触发回调函数。

	// 引入 events 模块
	var events = require('events');
	// 创建 eventEmitter 对象
	var eventEmitter = new events.EventEmitter();
	
	// 定义连接成功事件的handler
	var connectHandler = function connected() {
		// 打印控制台
		console.log('连接成功');
		
		// 触发 data_received 事件
		eventEmitter.emit('data_received');
	}
	
	// 绑定 connection 事件处理程序
	eventEmitter.on('connection', connectHandler);
	
	// 使用函数内方法定义处理
	eventEmitter.on('data_received', function() {
		console.log('数据接收成功。');
	});
	
	// 触发connection事件
	eventEmitter.emit('connection');
	
	console.log("程序执行完毕")；	

##读取文件
	// 引入文件模块
	var fs = require('fs');
	
	// 读取文件方法
	fs.readFile('input.txt', function (err, data) {
	
		// 判断是否读取成功
		if (err) {
		
			// 控制台打印错误栈信息
			console.log(err.stack);
			return;
		}
		
		// 将读取的信息转为字符串打印到控制台
		console.log(data.toString);
	});

## 延时执行
	// 延迟一秒 执行方法 打印 something
	setTimeout( funcion () {
		console.log("something")
	}, 1000);

## 初始化一个模块(引入模块)
	var module = require("os");

## 一个简单的小例子