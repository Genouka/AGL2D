# AGL2D
(Androlua Genouka LOVE2D)

> [!NOTE]
> Here is only Chinese documents now.

We’re open to accept PRs that translate our README into English. You’re welcome to submit one.

# 简介
这是个把LOVE2D 11.4和Androlua(lua 5.3)融合的游戏引擎！

### 本项目可以做什么？

它可以支持在你的项目中：

* 轻松弹出Toast框（见示例）
* 访问外部储存（见示例）
* 使用WebView截取网页内容
* 下载文件
* 做你能想到的任何事情！

这个项目起抛砖引玉的作用，欢迎提交PR充实本项目。

**如果你有更好的办法完全重构，我也非常愿意开启新分支与你们一起贡献这个项目！**

你可以在这个引擎里自由的调用Androlua代码！

本项目的一部分是基于`LOVE2D 11.4 embed`版本的二进制文件反编译而来的，以便和Androlua的项目进行融合。


# 示例

**本仓库的文件就是本项目的示例，你可以克隆本仓库直接使用！**

> [!TIP]
> 本项目的编译、二次修改方法请参见下一节。

game.love是一个压缩包格式文件，请解压以查看源码。

`assets/game.love/main.lua`
```lua
--GenOuka 2024.02.12
--AGL2D：让LOVE2D和Androlua产生爱的火花
--轻松完成原生LOVE2D做不到的事情！
--如果您将本项目以任何方式用于自己的游戏，请在游戏中提到GenOuka和AGL2D的名字（两者都要！）

lls=require("lls")
lg=love.graphics

function love.load()
  --初始化必须调用一次且只能调用一次
  lls.init()

  local a=[====[
--AGL使用示例

--显示字符串
print("AGL2D GenOuka")

--读取sdcard目录下文件数量
import "java.io.File"
print("/sdcard/目录下的文件数目："..#(File("/sdcard/").list()))

--想玩出更多花样请去了解Androlua的知识！
]====]
  --由于是跨线程调用，无法使用当前环境的变量！
  --调用是阻塞式的，如果不想阻塞请自行新建线程
  lls.run(a)
end
function love.draw()
  lg.print([[AGL2D Example ( Bilibili: @GenOuka)
  You will see a Toast showed by Androlua.
  You have boundless power to do what you want to do!]],50,50)
end

function love.quit()
  --关闭程序时必须调用一次，不然下次无法使用，调用后不能再使用lls.run运行代码！
  lls.close()
  return false
end
```

# 如何使用、编译、修改

## 法一：修改安装包（推荐）

从Release下载安装包，修改assets内文件后重新签名。

建议只修改`assets/game.love`内的文件。

## 法二：直接修改源码

克隆仓库，使用Apktool M工具进行回编译即可。

建议只修改`assets/game.love`内的文件。

assets下所有文件会被当做Androlua的代码，会被提取到`/data/data/<package_name>/files/`目录下（包括game.love）

game.love内的所有文件会被LOVE2D引擎进行解析。

Androlua代码和LOVE2D代码目前使用Socket进行通信，如果有更好的实现欢迎PR和issue！

# 接口
提供了一系列接口方便快速调用Androlua代码。

这些接口由lls.lua导出。

下面介绍提供的接口：

### lls.init()
初始化socket，只能调用一次，否则会出现意外的问题。

### lls.run(code)
运行Androlua代码，支持多行。

code是字符串，可参考示例。

阻塞调用，如果需要非阻塞请在线程中使用。

本函数线程安全。

## lls.close()
关闭socket，一旦关闭在本次游戏中将无法再开启

# 许可证/LICENSE

本项目使用的Androlua源码部分使用MIT协议进行授权，因此本项目可以直接使用其源码。

本项目使用的LOVE2D源码部分使用zlib协议进行授权。 **由于本项目是由LOVE2D二进制文件的反编译项目生成而来，可能已经丢失原本的LICENSE文件，在此致歉！** 根据zlib协议，以下协议应该是不与其冲突的。

本项目除了assets目录以外，均使用木兰宽松许可证2授权，详见`LICENSE`文件。

本项目的assets目录使用MIT协议授权，详见`assets/LICENSE`文件。


**我不是律师，如果有任何问题请咨询你的律师！**

# LICENSE 之外的承诺
如需要使用此项目，请尽量满足下列条件：

1.在其他开源项目中，遵守其 LICENSE；

2.不以「不开源」为理由，对任何闭源，或开源转为闭源项目发起辱骂或对其作者施行人身攻击；

以上承诺不具备法律效力，但希望您能够遵守。
