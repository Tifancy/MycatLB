--------------------------------------
--@desc:监听端口动态增加或移除后端服务
--@author:coder_czp
--@date:2016/1/1
--------------------------------------

local uv     = require('uv')
local server = uv.new_tcp()
local public = {}

-----------------------------------
-- 添加后端链接.必须是以下JSON格式:
-- json:{"cpu":10,"mem":100,"io":xx}
-- 负载服务器会根据这几个参数选择最优后端服务进行路由
------------------------------------
function public.start_server(port,lb_server)

  server:bind("0.0.0.0",port)
  server:listen(128,function(error)
    local client   = uv.new_tcp()
  	server:accept(client)
  	
  	local cli_add = uv.tcp_getpeername(client)
    local server  = {cli_add.ip,cli_add.port,1}
    
  	--后端服务关闭后从配置中摘除
  	--client:on_close(function(err)
  	 -- lb_server.del_backend_ser(server)
  	--end)
  	
  	--Todo 读取CPU MEM IO等参数计算权重
  	client:read_start(function(err, data)
	    if err or  data == nil then 
	      print("add backendser client error:",err)
	      client:close()
	    return end
	    
	    local rsp = {code=2000,info='successed'}
	    local req = Json.decode(data)
	    if  type(ser) ~= 'table' then 
	       rsp = {code=4003,info='not json'} 
	    elseif not ser.cpu or not ser.mem or not ser.io then
	       rsp = {code=4003,info='content error'} 
	    end
	        lb_server.add_backend_ser(server)
	    	client:write(Json.encode(rsp))
	 	 end)
 	 
  end)
  print("add_server_manager runing at",port)
end

return public