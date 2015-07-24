
local coordinate = require("Util/ coordinate")

local bloodTip = require("View/bloodTip")

local warriorView = require("View/warrior")

local skill = require("controller/skill")

local attackBoss = class("attackBoss")

----攻击Boss
function attackBoss.bitBoss(map)

    if(isExistWarrior and (not Warrior_P[5]) )then  --没有攻击士兵才能攻击Boss

        ---勇士打Boss
        local warrior = map:getChildByTag(5000):getChildByTag(1000)
        local pointx,pointy = warrior:getPosition()

        local point = {x = pointx, y = pointy}

        local item = coordinate.getItem(map,point)
        if(item.x == 10 and item.y == 17)then --到达Boss
            Warrior_P[5] =true -- 攻击Boss状态
            local time_space = 0
            local bossLayer = map:getChildByTag(10000)
            local boss = bossLayer:getChildByTag(1000)
            local progress = bossLayer:getChildByTag(100001)
            local txt = bossLayer:getChildByTag(100002)

            local function attack()
                
                time_space = time_space + Warrior.time

                if(time_space > Warrior.skill_time) then  --技能
                    local type = skill.type()
                    time_space = 0
     
                    if(type == 1)then
                        --显示技能名
                        local skill_tip =  bloodTip.skill(Warrior_P[1]:getChildByTag(1000),"暴击-"..Warrior.skill_type1 ,map,123)
                        map:addChild(skill_tip,0,123)
                   
                        Boss_blood = Boss_blood - Warrior.skill_type1 ;
                        progress:setPercentage(math.floor(Boss_blood/Boss.blood*100))
                        txt:setString(Boss_blood.. "/" .. Boss.blood)
                    else
                        --显示技能名
                        local skill_tip =  bloodTip.skill(Warrior_P[1]:getChildByTag(1000),"治疗术+".. Warrior.skill_type2,map,123)
                        map:addChild(skill_tip,0,123)
                        Warrior_P [2] = Warrior_P [2] + Warrior.skill_type2

                        local warriorLayer = map:getChildByTag(5000)
                        local blooding_ok =warriorLayer:getChildByTag(1002)
                        local blood_txtok =warriorLayer:getChildByTag(1003)
                        blooding_ok:setPercentage(math.floor(Warrior_P[2]/Warrior.blood*100))
                        blood_txtok:setString(Warrior_P[2].. "/" .. Warrior.blood)
                    end
                else
                    Boss_blood = Boss_blood - Warrior.hurt 
                    --显示扣血效果
                    local Bosstip =  bloodTip.create(progress,"-"..Warrior.hurt,map,1001,4)
                    map:addChild(Bosstip,0,1001)
                end
                
                if( Boss_blood > 0)then
                    
                    progress:setPercentage(math.floor(Boss_blood/Boss.blood*100))
                    txt:setString(Boss_blood.. "/" .. Boss.blood)

                    local w_action = cc.Sequence:create(cc.DelayTime:create(Warrior.time),
                        cc.CallFunc:create(attack,{}))
                    w_action:setTag(1003)
                    warrior:runAction(w_action)
                else
                    print("游戏结束")
                    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedulerId)
                    isExistWarrior = false
                    gameResult = false
                    local scene = require("ResultScene")
                    local gameScene = scene.create()
                    cc.Director:getInstance():replaceScene(gameScene)
                end
            end

            attack()

            ---Boss打勇士
            local warriorLayer = map:getChildByTag(5000)
            local warrior = warriorLayer:getChildByTag(1000)
            local blood =warriorLayer:getChildByTag(1001)
            local blooding =warriorLayer:getChildByTag(1002)
            local blood_txt =warriorLayer:getChildByTag(1003)

            local function attackWarrior()
                Warrior_P[2] = Warrior_P[2] - Boss.hurt
                if(Warrior_P[2] > 0)then
                    print("Boss_time" .. Boss.time)
                    --显示扣血效果
                    local tip =  bloodTip.create(Warrior_P[1]:getChildByTag(1000),"-"..Boss.hurt,map,585,1)
                    map:addChild(tip,0,585)
                    blooding:setPercentage(math.floor(Warrior_P[2]/Warrior.blood*100))
                    blood_txt:setString(Warrior_P[2].. "/" .. Warrior.blood)

                    local action =cc.Sequence:create(
                        cc.DelayTime:create(Boss.time),                       
                        cc.CallFunc:create(attackWarrior,{})
                    )
                    action:setTag(1008)
                    print("" ..Boss.hurt)
                    boss:runAction(action)
                                   
                else
                    boss:stopActionByTag(1008)
                    map:removeChildByTag(5000) --移除勇士
                    isExistWarrior = false
                end

            end
            
            attackWarrior()

        end


    end
end


return attackBoss