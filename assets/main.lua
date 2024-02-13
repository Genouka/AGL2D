--GenOuka 2024.02.12
local nnt=activity.newTask(function(activity)
  require "import"
  local function decode(nn)
    local bitmapArray
    xpcall(function()
      local Base64=luajava.bindClass("android.util.Base64")
      bitmapArray = Base64.decode(nn, Base64.DEFAULT);
      bitmapArray=String(bitmapArray)
    end,
    function(e)
      bitmapArray=nil
    end)
    return tostring(bitmapArray or nn)
  end
  --Thread.sleep(1000)
  socket = require("socket") --调用socket包
  ip = "127.0.0.18" --程序设置自己为Server端，设置自己的ip地址
  port = 39016 --设置端口

  ack = "ack\n"
  while 1 do
    local server=nil
    if !pcall(function()
        server= socket.bind(ip, port)
        server:settimeout(5)
      end) then
      print("LLS Server cannot create!")
    end
    if server==nil or this.isCancelled() then
      print("[C1]LLS Server Down!")
      if server ~= nil then server:close() end
      return
    end
    print("LLS Server: waiting for client connection...")
    local control=nil
    if xpcall(function()
        control = server:accept() --等待客户端的连接，因此这个程序只能同时连接一个TCP客户端设备
      end,
      function(e)
        print(e)
      end) then
      if control~=nil then
        local code=""
        while 1 do
          local command, status = control:receive() --等待字符信号发送过来
          if server==nil or this.isCancelled() then
            print("[C2]LLS Server Down!")
            if server ~= nil then server:close() end
            return
          end
          --print(command)

          if command == "closed" then
            if server ~= nil then server:close() end
            return
            --[[
           elseif command == "LLS_codeEND" then
            xpcall(function()
              --activity.runOnUiThread(function()
              --  log.text=command
              --end)
              print(code)
              --loadstring(code)()
              --loadstring(decode(command))()
            end,
            function(e)
              print("LLS Code Error:"..e)
            end)
            code=""
            control:send(ack)
]]
           else
            xpcall(function()
              --activity.runOnUiThread(function()
              --  log.text=command
              --end)
              --print(decode(command))
              --loadstring(code)()
              loadstring(decode(command))()
            end,
            function(e)
              print("LLS Code Error:"..e)
            end)
            control:send(ack)
            --code=code..(decode(command))
            --break
          end
        end
       else
        if server ~= nil then server:close() end
      end
    end
  end
end).execute({activity})
function onDestroy()
  nnt.cancel(true)
  luajava.clear(nnt)
  nnt=nil
end
require "import"
import "android.content.Intent"
local w1 = Intent(activity, luajava.bindClass("org.love2d.android.GameActivity"))
activity.startActivity(w1)