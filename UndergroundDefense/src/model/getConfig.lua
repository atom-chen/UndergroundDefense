
local json=require("json")

-- 读取文件  
local data = cc.FileUtils:getInstance():getStringFromFile("gameConfig.json");  

--字符串过滤
data = string.gsub(data, " ", "") 
data = string.gsub(data,"\r","")
data = string.gsub(data,"\n","")
data = string.gsub(data,"\t","")

result = json.decode(data)      --table转json  

--获取对应配置

Boss = result.Boss

Soldier = result.Soldier

Warrior = result.Warrior


------------定义全局参数
object=require("src/util/getObjectLayerData")-- 加载地图对象层属性获取类

tiled=require("src/util/getTiledData") -- 加载地图指定point图块是否能移动


soldierTab     = {}      -- 魔王小兵集合

warriorTab     = {}      --勇士小兵集合

trapTab        = {}      --陷阱集合

--   --缩放因子
ScaleRate      = nil
ScaleRateMin   = nil
ScaleRateMax   = 1

BlockWidth     = 32

MapY           = 59      --地图y坐标最大值
MapX           = 89      --地图x坐标最大值
