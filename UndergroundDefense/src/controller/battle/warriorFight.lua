
local gameTip = require("src/view/gameTip")

local warriorView = require("src/view/role/warrior")

local soldierView = require("src/view/role/soldier")

local coordinate = require("src/util/coordinate")

local warriorFight = class("warriorFight")
--[[
先调用soldierFight的小兵互斗函数，
]]

local function removeSoldier(tab, tag)
    for key, var in ipairs(tab) do
        if var.tag == tag then
            table.remove(tab,key)
            return
        end
    end
end

local function getModelByTag(tab, tag)
    for key, var in ipairs(tab) do
        if (var.tag == tag) then
            return var
        end
    end
end

local timeSpace = 0

function warriorFight.bitSoldier(map)
    if(Warrior_P [4]) then  --warrior stop 表示和小兵战斗
        local warriorLayer = map:getChildByTag(5000)
        local warrior = warriorLayer:getChildByTag(1000)
        local blood =warriorLayer:getChildByTag(1001)
        local blooding =warriorLayer:getChildByTag(1002)
        local blood_txt =warriorLayer:getChildByTag(1003)
        local warriorX,warriorY = warrior:getPosition()
        
        local warriorPoint = {x = warriorX , y = warriorY}
        local item = coordinate.getItem(map, warriorPoint)
        if((item.x == 5 and item.y == 57)or ((item.x == 10 and item.y == 17)))then
           return   --不打小兵
        end

        for key, soldier in ipairs(soldierTab) do
            local soldierX,soldierY = soldier.layer:getChildByTag(100):getPosition()
            local absX = math.abs(soldierX - warriorX)
            local absY = math.abs(soldierY - warriorY)
            if (absX< Soldier.Viewrang and absY < Soldier.Viewrang) then
                blood:stopAllActions()
                blooding:stopAllActions()
                blood_txt:stopAllActions()
                warrior:stopActionByTag(1010);
                Warrior_P [4] = false
                Warrior_P[10] = soldier.tag -- 攻击目标

                if(not soldier.isStop) then  -- stop soldier
                    soldier.isStop = true
                    soldier.bitTarget = 5000 -- 目标为勇士
                    local soldierModel = soldier.layer:getChildByTag(100)
                    local sblood =soldier.layer:getChildByTag(101)
                    local sblooding =soldier.layer:getChildByTag(102)
                    local sblood_txt =soldier.layer:getChildByTag(103)
                    sblood:stopAllActions()
                    sblooding:stopAllActions()
                    sblood_txt:stopAllActions()
                    soldierModel:stopAllActions();
                end

                if(not Warrior_P[5]) then
                    Warrior_P[5] = true

                    local function bitSoldier(node, data)
                        local beaten = data.beaten

                        timeSpace = timeSpace +   Warrior.time
                        if(timeSpace > Warrior.skill_time) then  --技能
                            timeSpace = 0
                            local type = require("src/controller/skill").type()

                            if(type == 1)then
                                --显示技能名
                                local skill_tip = gameTip.warriorTip("暴击-"..Warrior.skill_type1,map,300,10,cc.c3b(0,125,0))
                                map:addChild(skill_tip,0,300)

                                beaten.remaindBlood = beaten.remaindBlood - Warrior.skill_type1 ;
                                soldierView.updateBlood(beaten.tag)

                            else
                                --显示技能名
                                local skill_tip = gameTip.warriorTip("治疗术+".. Warrior.skill_type2,map,300,10,cc.c3b(0,125,0))
                                map:addChild(skill_tip,0,300)
                                Warrior_P [2] = Warrior_P [2] + Warrior.skill_type2
                                require("src/View/role/warrior").updateBlood() -- 更新血条
                            end
                        else   --普攻
                            beaten.remaindBlood = beaten.remaindBlood - Warrior_P[8] ;
                            soldierView.updateBlood(beaten.tag)
                        end

                        --判断小兵生死
                        if(beaten.remaindBlood > 0)then
                            local w_action = cc.Sequence:create(cc.DelayTime:create(Warrior.time),
                                cc.CallFunc:create(bitSoldier,data))
                            w_action:setTag(888)
                            warrior:runAction(w_action)
                        else
                            require("src/model/monsterModel"):isDisappear(beaten.type)
                            warrior:stopActionByTag(888);
                            map:removeChildByTag(beaten.tag)
                            removeSoldier(soldierTab, beaten.tag) -- 移除该小兵
                            Warrior_P[5] = false
                            
                            warriorView.move(map) -- move会死Warrior_P[4]=false
                        end
                    end

                    local data = { beaten = soldier}
                    bitSoldier(warrior,data)
                end

                break
            end
        end
    end
end

function warriorFight.bitWarrior(map)

    local warriorLayer = map:getChildByTag(5000)
    local warrior = warriorLayer:getChildByTag(1000)
    local blood =warriorLayer:getChildByTag(1001)
    local blooding =warriorLayer:getChildByTag(1002)
    local blood_txt =warriorLayer:getChildByTag(1003)
    local warriorX,warriorY = warrior:getPosition()

    for key, soldier in ipairs(soldierTab) do
        if(not soldier.isStop)then
            local soldierX,soldierY = soldier.layer:getChildByTag(100):getPosition()
            local absX = math.abs(soldierX - warriorX)
            local absY = math.abs(soldierY - warriorY)
            if (absX< Soldier.Viewrang and absY < Soldier.Viewrang) then
                soldier.isStop = true
                soldier.bitTarget = 5000 -- 目标为勇士
                local soldierModel = soldier.layer:getChildByTag(100)
                local sblood =soldier.layer:getChildByTag(101)
                local sblooding =soldier.layer:getChildByTag(102)
                local sblood_txt =soldier.layer:getChildByTag(103)
                sblood:stopAllActions()
                sblooding:stopAllActions()
                sblood_txt:stopAllActions()
                soldierModel:stopAllActions();
            end
        end
    end

    --攻击勇士，包含为勇士停止的solider
    for key, soldier in ipairs(soldierTab) do
        if(soldier.bitTarget == 5000 and (not soldier.isBit))then

            soldier.isBit = true
            local function bitWarrior(node, data)
              
                local bit = data.bit

                Warrior_P[2] = Warrior_P[2] - bit.hurt
                --勇士死亡
                if(Warrior_P[2] <= 0)then
                    map:removeChildByTag(5000) --移除勇士
                    isExistWarrior = false
                    for key1, var1 in ipairs(soldierTab) do
                        if(var1.bitTarget == 5000)then
                            var1.layer:getChildByTag(100):stopAllActions() --勇士死亡，停止攻击活动
                            var1.isStop = false --没遇到勇士
                            var1.isPatrol = true  --从新巡逻
                            var1.isBit = false --没有攻击勇士活动
                            var1.bitTarget = 0
                        end
                    end
                    soldierView.move(map)
                else

                    --显示扣血效果
                    local tip =  gameTip.create(Warrior_P[1]:getChildByTag(1000),"-"..bit.hurt,map,5555,1)

                    map:addChild(tip,0,5555)
                    require("src/View/role/warrior").updateBlood() -- 更新血条

                    bit.layer:getChildByTag(100):runAction(cc.Sequence:create(cc.DelayTime:create(Soldier.time),
                        cc.CallFunc:create(bitWarrior,data)))
                end
            end
            
            local data = { bit = soldier}
            bitWarrior(soldier, data)
        end
    end
end

return warriorFight