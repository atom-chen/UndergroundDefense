--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : character.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年7月31日   下午3:23:46
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************


local soldierModel = class(
    "soldierModel"
)

function soldierModel:ctor()

    self.layer         = nil   --表示物体视图
    
    self.isPatrol      = nil   --一次目标点巡逻是否完成
    
    self.moveNum       = nil   --表示移动的次数
    
    self.path          = {}    --表示移动的路径
    
    self.isStop        = nil   --是否停止巡逻（攻击敌方）
    
    self.remaindBlood  = nil   --剩余血量
    
    self.tag           = nil   --view的tag
    
    self.isBeaten      = nil   --是否遭受攻击
    
    self.isBit         = nil   --是否在攻击状态
    
    self.hurt          = nil   --攻击伤害值
    
    self.blood         = nil   --总血量
end

function soldierModel.create(layer,isPatrol,moveNum,path,isStop,remaindBlood,tag,isBeaten,isBit,hurt,blood)
   
    local soldier = soldierModel.new()
    
    soldierModel:init(layer,isPatrol,moveNum,path,isStop,remaindBlood,tag,isBeaten,isBit,hurt,blood)
    return soldier
end

function soldierModel:init(layer,isPatrol,moveNum,path,isStop,remaindBlood,tag,isBeaten,isBit,hurt,blood)
    --初始化值
    self.layer         = layer
    
    self.isPatrol      = isPatrol
    
    self.moveNum       = moveNum

    self.path          = path

    self.isStop        = isStop   

    self.remaindBlood  = remaindBlood

    self.tag           = tag

    self.isBeaten      = isBeaten

    self.isBit         = isBit

    self.hurt          = hurt

    self.blood         = blood
    
end

return soldierModel

    