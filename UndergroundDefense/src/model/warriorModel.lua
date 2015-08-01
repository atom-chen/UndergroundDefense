--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : warriorModel.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年8月1日 下午10:05:24
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************

--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : soldierModel.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年7月31日 下午11:26:09
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************


local warriorModel = class(
    "warriorModel"
)

function warriorModel.create(layer,type,remaindBlood,blood,isMove,isAttack)
    local myWarrior            = {}

    myWarrior.layer            = layer             --勇士视图
    
    myWarrior.type             = type              --勇士类型
    
    myWarrior.remaindBlood     = remaindBlood      --剩余血量
    
    myWarrior.blood            = blood             --总血量
    
    myWarrior.isMove           = isMove            --是否在运动
     
    myWarrior.isAttack         = isAttack          --是否在攻击
    
    return myWarrior
end

return warriorModel
