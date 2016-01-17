#Express
Express 框架核心特性：

* 可以设置中间件来响应 HTTP 请求。
* 定义了路由表用于执行不同的 HTTP 请求动作。
* 可以通过向模板传递参数来动态渲染 HTML 页面。

##安装express
	$ npm install express --save
	
以下几个重要的模块是需要与 express 框架一起安装的：

* body-parser - node.js 中间件，用于处理 JSON, Raw, Text 和 URL 编码的数据。
* cookie-parser - 这就是一个解析Cookie的工具。通过req.cookies可以取到传过来的cookie，并把它们转成对象。
* multer - node.js 中间件，用于处理 enctype="multipart/form-data"（设置表单的MIME编码）的表单数据。

命令

	$ npm install body-parser --save
	$ npm install cookie-parser --save
	$ npm install multer --save
	
##基础程序
开启监听小程序
[expressDemo](./express_demo.js)

##请求和响应对象
Express 应用使用回调函数的参数： request 和 response 对象来处理请求和响应的数据。

request 和 response 对象的具体介绍：

**Request 对象** - request 对象表示 HTTP 请求，包含了请求查询字符串，参数，内容，HTTP 头部等属性。

属性 | 描述
--- | ---
req.app | 当callback为外部文件时，用req.app访问express的实例
req.baseUrl | 获取路由当前安装的URL路径
req.body/req.cookies | 获得「请求主体」/ Cookies
req.fresh/req.stale | 判断请求是否还「新鲜」
req.hostname/req.ip | 获取主机名和IP地址
req.originalUrl | 获取原始请求URL
req.params | 获取路由的parameters
req.path | 获取请求路径
req.protocol | 获取协议类型
req.query | 获取URL的查询参数串
req.route | 获取当前匹配的路由
req.subdomains | 获取子域名
req.accpets() | 检查请求的Accept头的请求类型
req.acceptsCharsets/req.acceptsEncodings/req.acceptsLanguages |
req.get() | 获取指定的HTTP请求头
req.is() | 判断请求头Content-Type的MIME类型

**Response 对象** - response 对象表示 HTTP 响应，即在接收到请求时向客户端发送的 HTTP 响应数据。常见属性有：

属性 | 描述
--- | ---
res.app | 同req.app一样
res.append() | 追加指定HTTP头
res.set | 后将重置之前设置的头
res.cookie(name, value[, option]) | 设置Cookie opition: domain / expires / httpOnly / maxAge / path / secure / signed
res.clearCookie | 清除Cookie
res.download | 传送指定路径的文件
res.get | 返回指定的HTTP头
res.json | 传送JSON响应
res.jsonp | 传送JSONP响应
res.location | 只设置响应的Location HTTP头，不设置状态码或者close response
res.redirect | 设置响应的Location HTTP头，并且设置状态码302
res.send | 传送HTTP响应
res.sendFile(path[, option][, fn]) | 传送指定路径的文件 -会自动根据文件extension设定Content-Type
res.set |  设置HTTP头，传入object可以一次设置多个头
res.status | 设置HTTP状态码
res.type | 设置Content-Type的MIME类型

## 路由

我们已经了解了 HTTP 请求的基本应用，而路由决定了由谁(指定脚本)去响应客户端请求。

在HTTP请求中，我们可以通过路由提取出请求的URL以及GET/POST参数。

接下来我们扩展 Hello World，添加一些功能来处理更多类型的 HTTP 请求。

[expressDemo2](./express_demo2.js)

##静态文件

Express 提供了内置的中间件 express.static 来设置静态文件如：图片， CSS, JavaScript 等。
你可以使用 express.static 中间件来设置静态文件路径。例如，如果你将图片， CSS, JavaScript 文件放在 public 目录下，你可以这么写：

	app.use(express.static('public'));
	
修改代码
[expressDemo3](./express_demo3.js)

##获取请求参数
	app.post('/process_post', urlencodedParser, function (req, res) {
	
	   // 输出 JSON 格式
	   response = {
	       first_name:req.body.first_name,
	       last_name:req.body.last_name
	   };
	   console.log(response);
	   res.end(JSON.stringify(response));
	})
	
##文件上传
修改代码
[expressUploadDemo4](./express_demo4.js)

##cookie管理
	// express_cookie.js 文件
	var express      = require('express')
	var cookieParser = require('cookie-parser')
	
	var app = express()
	app.use(cookieParser())
	
	app.get('/', function(req, res) {
	  console.log("Cookies: ", req.cookies)
	})
	
	app.listen(8081)