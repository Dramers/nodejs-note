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

####实例方法

* addListener(event, listener) 为指定事件添加一个监听器到监听器数组的尾部。
* removeListener(event, listener) 移除指定事件的某个监听器，监听器 必须是该事件已经注册过的监听器。
* once(event, listener) 为指定事件注册一个单次监听器，即 监听器最多只会触发一次，触发后立刻解除该监听器。
* removeAllListeners([event]) 移除所有事件的所有监听器， 如果指定事件，则移除指定事件的所有监听器。
* setMaxListeners(n) 默认情况下， EventEmitters 如果你添加的监听器超过 10 个就会输出警告信息。 setMaxListeners 函数用于提高监听器的默认限制的数量。
* listeners(event) 返回指定事件的监听器数组。

####类方法
* listenerCount(emitter, event) 返回指定事件的监听器数量。

##继承EventEmitter用法
大多数时候我们不会直接使用 EventEmitter，而是在对象中继承它。包括 fs、net、 http 在内的，只要是支持事件响应的核心模块都是 EventEmitter 的子类。

为什么要这样做呢？原因有两点：

首先，具有某个实体功能的对象实现事件符合语义， 事件的监听和发射应该是一个对象的方法。

其次 JavaScript 的对象机制是基于原型的，支持 部分多重继承，继承 EventEmitter 不会打乱对象原有的继承关系。

##error事件
EventEmitter 定义了一个特殊的事件 error，它包含了错误的语义，我们在遇到 异常的时候通常会触发 error 事件。

当 error 被触发时，EventEmitter 规定如果没有响 应的监听器，Node.js 会把它当作异常，退出程序并输出错误信息。

我们一般要为会触发 error 事件的对象设置监听器，避免遇到错误后整个程序崩溃。例如：

	var events = require('events'); 
	var emitter = new events.EventEmitter(); 
	emitter.emit('error'); 

##buffer操作

###创建buffer
	// 创建10个字节的空buffer
	var buf = new Buffer(10);
	
	// 通过数组创建buffer
	var buf = new Buffer([10, 20, 30, 40, 50]);
	
	// 通过字符串创建buffer  
	// utf-8 是默认的编码方式，此外它同样支持以下编码："ascii", "utf8", "utf16le", "ucs2", "base64" 和 "hex"。
	var buf = new Buffer("www.runoob.com", "utf-8");
	
###字符串写入buffer
	buf.write(string[, offset][, length][, encoding])
	
	buf = new Buffer(256);
	len = buf.write("www.runoob.com");
	// 如果buffer空间不足 则len为部分长度
	
	console.log("写入字节数 : "+  len);
	
###buffer to string
	buf.toString([encoding][, start][, end])
	
###buffer to JSON
	buf.toJSON()
	
###合并两个buffer
	Buffer.concat(list[, totalLength])
	
###比较两个buffer
	buf.compare(otherBuffer);
比较asc码，小于0为升序，等于0为相等，大于0为降序。

###拷贝buffer
	buf.copy(targetBuffer[, targetStart][, sourceStart][, sourceEnd])
	
###裁剪buffer
	buf.slice([start][, end])
返回一个新的缓冲区，它和旧缓冲区指向同一块内存，但是从索引 start 到 end 的位置剪切。

###获取长度
	buf.length;

##stream操作
stream的种类

* **Readable** 可读操作。
* **Writable** 可写操作。
* **Duplex** 可读可写操作。
* **Transform** 操作被写入数据，然后读出结果。

stream可监听的事件

* **data** 当有数据可读时触发。
* **end** 没有更多的数据可读时触发。
* **error** 在接收和写入过程中发生错误时触发。
* **finish** 所有数据已被写入到底层系统时触发。

###读入stream数据
	var fs = require("fs");
	var data = '';

	// 创建可读流
	var readerStream = fs.createReadStream('input.txt');
	
	// 设置编码为 utf8。
	readerStream.setEncoding('UTF8');
	
	// 处理流事件 --> data, end, and error
	readerStream.on('data', function(chunk) {
	   data += chunk;
	});
	
	readerStream.on('end',function(){
   		console.log(data);
	});
	
	readerStream.on('error', function(err){
   		console.log(err.stack);
	});
	
	console.log("程序执行完毕");

###写入流
	var fs = require("fs");
	var data = '菜鸟教程官网地址：www.runoob.com';
	
	// 创建一个可以写入的流，写入到文件 output.txt 中
	var writerStream = fs.createWriteStream('output.txt');
	
	// 使用 utf8 编码写入数据
	writerStream.write(data,'UTF8');
	
	// 标记文件末尾
	writerStream.end();
	
	// 处理流事件 --> data, end, and error
	writerStream.on('finish', function() {
	    console.log("写入完成。");
	});
	
	writerStream.on('error', function(err){
	   console.log(err.stack);
	});
	
	console.log("程序执行完毕");

###管道流
	var fs = require("fs");
	
	// 创建一个可读流
	var readerStream = fs.createReadStream('input.txt');
	
	// 创建一个可写流
	var writerStream = fs.createWriteStream('output.txt');
	
	// 管道读写操作
	// 读取 input.txt 文件内容，并将内容写入到 output.txt 文件中
	readerStream.pipe(writerStream);
	
	console.log("程序执行完毕");

###链式流
感觉就是管道流中，中间对流再次进行处理的一部分管道，位于管道流中间

* **压缩文件**

		var fs = require("fs");
		var zlib = require('zlib');
		
		// 压缩 input.txt 文件为 input.txt.gz
		fs.createReadStream('input.txt')
		  .pipe(zlib.createGzip())
		  .pipe(fs.createWriteStream('input.txt.gz'));
		  
		console.log("文件压缩完成。");
* **解压文件**

		var fs = require("fs");
		var zlib = require('zlib');
		
		// 解压 input.txt.gz 文件为 input.txt
		fs.createReadStream('input.txt.gz')
		  .pipe(zlib.createGunzip())
		  .pipe(fs.createWriteStream('input.txt'));
		  
		console.log("文件解压完成。");


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