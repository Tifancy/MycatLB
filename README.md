##[CzpLB是具备动态伸缩的负载均衡器,支持特性:](http://htmlsocket.sinaapp.com/lb.html)
###1.服务负载均衡
	a.基于hash的负载均衡[可配置权重]
	b.基于轮询的负载均衡[可配置权重]
###2.路由链路管理
	a.客户端路由信息跟踪
	b.主机路由信息统计
	c.断开异常的客户端连接
###3.主机动态上下线
	a.动态上线主机
	b.动态下线或移除主机
	c.立即下线或移除[紧急模式] 
	d.完成当前事务后下线或移除[安全模式]
###4.性能测试(基于redis-benchmark):nginx_tcp vs czplb
	nginx
		====== LRANGE_500 (first 450 elements) ======
		100000 requests completed in 17.05 seconds
		5856.48 requests per second
		====== LRANGE_600 (first 600 elements) ======
		100000 requests completed in 20.78 seconds
		4811.62 requests per second
		====== MSET (10 keys) ======
		100000 requests completed in 4.25 seconds
		23529.41 requests per second
	czplb
		====== LRANGE_500 (first 450 elements) ======
		100000 requests completed in 17.03 seconds
		5856.86 requests per second
		====== LRANGE_600 (first 600 elements) ======
		100000 requests completed in 22.17 seconds
		4509.79 requests per second
		====== MSET (10 keys) ======
		100000 requests completed in 4.07 seconds
		24557.96 requests per second
		
###安装步骤
	1.在bin目录下载对应的版本:windows or linux
	2.windows直接点击exe文件安装,linux直接解压后运行run.sh
	3.64位比32位具有更好的性能,用redis-benchmark测试,比nginx不相上下

###添加后端服务
![github](https://raw.githubusercontent.com/coderczp/MycatLB/master/img/lb_add_ser.png "github")
###查看路由日志
![github](https://raw.githubusercontent.com/coderczp/MycatLB/master/img/lb_log.png "github")