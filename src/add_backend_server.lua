--------------------------------------
--@desc:监听端口动态增加或移除后端服务
--@author:coder_czp
--@date:2016/1/1
--------------------------------------

local uv = require('uv')
local server = uv.new_tcp()


local function on_connected(error)
  local client   = uv.new_tcp()
  server:accept(client)
  client:read_start(function(err, data)
    if  err then print("Client error:" .. err) end
    if data then  print(data) return end
    client:close()
  end)
end

function start_backend_ser(port)
  server:bind("0.0.0.0",port)
  server:listen(128,on_connected)
  print("server_manager runing at",port)
end

start_backend_ser(1234)
