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
###1.立即下线或移除[紧急模式]
###2.完成当前事务后下线或移除[安全模式]

###安装步骤
	1.在bin目录下载对应的版本:windows or linux
	2.windows直接点击exe文件安装,linux直接解压后运行run.sh
	3.windows下64位比32位具有更好的性能,用redis-benchmark测试,性能比nginx略高

###添加后端服务
![github](https://raw.githubusercontent.com/coderczp/MycatLB/master/img/lb_add_ser.png "github")
###查看路由日志
![github](https://raw.githubusercontent.com/coderczp/MycatLB/master/img/lb_log.png "github")