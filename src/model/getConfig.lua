
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

_soldierNum = result.SoldierNum  --小兵总数量

_WarriorNum = result.WarriorNum

Boss = result.Boss

Soldier = result.Soldier

Warrior = result.Warrior

_soldierPoint = result.SoldierPoint -- 小兵巡逻点集合

_soldierView = Soldier.Viewrang  --小兵视野

_soldierHurt = Soldier.hurt

_soldierTime = Soldier.time

_soldierSpace = Soldier.space

_warriorSpeed = Warrior.speed  --勇士的速度

_WarriorHurt = Warrior.hurt

_warriorTime = Warrior.time

------------定义全局参数
object=require("Util.getObjectLayerData")-- 加载地图对象层属性获取类

tiled=require("Util/getTiledData") -- 加载地图指定point图块是否能移动

birthplace_blood = 0;

soldierTab={}  --小兵集合

Warrior_P = {} --现在的勇士

soldierPoint={} --小兵巡查点

isExistWarrior = false  --每次只有一个勇士存在

whichWarrior = 0 --表示当前是第几个勇士

WarriorType = 0 --当前勇士的类型
--


