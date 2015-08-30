--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : touchTrap.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年8月5日 下午11:15:47
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************


local touchTrap = class("touchTrap")

local time = 0

function touchTrap.trigger(map)
    --debuff的time控制
    time = time + 0.2 
    if(time >= result.trap.trap1.time and Warrior_P[6])then --解除debuff
        Warrior_P[7] = Warrior_P[7] - result.trap.trap1.downmove
        Warrior_P[8] = Warrior_P[8] + result.trap.trap1.downhurt
        time = 0
        Warrior_P[6] = false
    end
    
    if(isExistWarrior)then
        local warriorRect = Warrior_P[1]:getChildByTag(1000):getBoundingBox()                
        for key, trap in ipairs(trapTab) do
            local trapRect = trap.sprite:getBoundingBox()
            if(cc.rectIntersectsRect(warriorRect,trapRect))then
                if(trap.type == 1)then
                    time = 0       --每次踩到更新为时间         
                    if(not Warrior_P[6])then -- 还没被debuff
                        Warrior_P[7] = Warrior_P[7] + result.trap.trap1.downmove
                        Warrior_P[8] = Warrior_P[8] - result.trap.trap1.downhurt
                    end     
                    Warrior_P[6] = true 
                    local tarpTip = require("src/view/gameTip").warriorTip(result.trap.trap1.description,map,300,10,cc.c3b(0,125,0))
                    map:addChild(tarpTip,0,300)            
                end
                if(trap.type == 2)then
                    Warrior_P[2] = Warrior_P[2] - result.trap.trap2.hurt                    
                    require("src/view/role/warrior").updateBlood() -- 更新血条
                    local tarpTip = require("src/view/gameTip").warriorTip(result.trap.trap2.description,map,300,10,cc.c3b(0,125,0))
                    map:addChild(tarpTip,0,300)
                end
                local trapLayer = map:getChildByTag(400)                
                trapLayer:removeChildByTag(trap.tag)
                table.remove(trapTab,key)
                
                break;
            end
        end
    end
end

return touchTrap