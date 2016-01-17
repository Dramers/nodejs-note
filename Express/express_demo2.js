var express = require('express');
var app = express();

app.get('/', function (req, res) {
	res.send('Hello World');
})

app.post('/', function (req, res) {
	console.log("主页 POST 请求");
	res.send('Hello POST');
})

app.delete('/del_user', function (req, res) {
	console.log("/del_user 响应 DELETE请求");
	res.send('删除界面');
})

app.get('/list_user', function (req, res) {
	console.log("/list_user GET 请求");
	res.send('用户列表界面');
})

app.get('/ab*cd', function (req, res) {
	console.log('/ab*cd GET 请求');
	res.send('正则匹配');
})

var server = app.listen(8081, function () {
	var host = server.address().address
	var port = server.address().port

	console.log("应用实例,访问地址: http://%s:%s", host,port)
})