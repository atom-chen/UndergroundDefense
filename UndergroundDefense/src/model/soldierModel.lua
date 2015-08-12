--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : soldierModel.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年7月31日 下午11:26:09
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************


--local soldierModel = class(
--    "soldierModel"
--)
local soldierModel = {}

function soldierModel.create(layer,isPatrol,moveNum,path,isStop,remaindBlood,tag,isBit,hurt,blood,type,speed)
    local mySoldier    = {}

    mySoldier.layer         = layer            --表示物体视图

    mySoldier.isPatrol      = isPatrol         --一次目标点巡逻是否完成

    mySoldier.moveNum       = moveNum          --表示移动的次数

    mySoldier.path          = path             --表示移动的路径

    mySoldier.isStop        = isStop           --是否停止巡逻（攻击敌方）

    mySoldier.remaindBlood  = remaindBlood     --剩余血量

    mySoldier.tag           = tag              --view的tag

    mySoldier.isBit         = isBit            --是否在攻击状态

    mySoldier.hurt          = hurt             --攻击伤害值

    mySoldier.blood         = blood            --总血量
    
    mySoldier.type          = type             --士兵类型,0士兵，1-moster1,2-moster2,3-moster3，4敌方小兵
    
    mySoldier.speed         = speed            --移动速度
    
    --mySoldier.bitTarget     = bitTagert        --攻击目标，为谁停下就攻击谁

    return mySoldier
end

return soldierModel
