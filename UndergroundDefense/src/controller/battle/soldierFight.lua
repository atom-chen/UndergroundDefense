
local warriorView = require("src/view/role/warrior")

local soldierView = require("src/view/role/soldier")

local enemySoldierView = require("src/view/role/enemySoldier")

local gameTip = require("src/view/gameTip")

local coordinate = require("src/util/coordinate")

local skill = require("src/controller/skill")

local soldierFight = class("soldierFight")

local time_space = 0

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

-- enemySoldier bit soldier,找到第一个相遇的攻击
function soldierFight.bitSoldier(map)
    for key, enemy in ipairs(warriorTab) do

        if(not enemy.isStop) then
            local enemyX,enemyY = enemy.layer:getChildByTag(100):getPosition()

            for key, var in ipairs(soldierTab) do
                local varX,varY = var.layer:getChildByTag(100):getPosition()
                local absX = math.abs(varX - enemyX)
                local absY = math.abs(varY - enemyY)
                --遇到后停止运动
                if(absX < Soldier.Viewrang and absY < Soldier.Viewrang)then
                    enemy.isStop = true
                    enemy.bitTarget =  var.tag

                    local soldier = enemy.layer:getChildByTag(100)
                    local sblood =enemy.layer:getChildByTag(101)
                    local sblooding =enemy.layer:getChildByTag(102)
                    local sblood_txt =enemy.layer:getChildByTag(103)
                    sblood:stopAllActions()
                    sblooding:stopAllActions()
                    sblood_txt:stopAllActions()
                    soldier:stopAllActions();

                    local soldier1 = var.layer:getChildByTag(100)
                    local sblood1 =var.layer:getChildByTag(101)
                    local sblooding1 =var.layer:getChildByTag(102)
                    local sblood_txt1 =var.layer:getChildByTag(103)
                    if(not var.isStop)then
                        var.isStop = true
                        var.bitTarget = enemy.tag
                        sblood1:stopAllActions()
                        sblooding1:stopAllActions()
                        sblood_txt1:stopAllActions()
                        soldier1:stopAllActions();
                    end

                    --attack
                    if (not enemy.isBit)then
                        enemy.isBit = true
                        local function bitSoldier(node, data)
                            local beaten   = data.beaten
                            local bit      = data.bit

                            beaten.remaindBlood = beaten.remaindBlood - bit.hurt

                            if(beaten.remaindBlood <= 0)then -- 死亡
                            --检查魔将特效是否消失
                                local isDiss = require("src/model/monsterModel"):isDisappear(beaten.type)                                                              
                                removeSoldier(soldierTab, beaten.tag)
                                map:removeChildByTag(beaten.tag)

                                bit.isStop = false
                                bit.isPatrol = true
                                bit.isBit = false
                                bit.bitTarget = 0
                                bit.layer:getChildByTag(100):stopActionByTag(bit.tag);
                                if not isDiss then -- 死的不是魔将
                                    local moneyControl = require("src/util/money")
                                    moneyControl.addMoney("soldier")
                                end
                            else
                                soldierView.updateBlood(beaten.tag)
                                local s_action = cc.Sequence:create(cc.DelayTime:create(result.enemySoldier.time),
                                    cc.CallFunc:create(bitSoldier,data))
                                s_action:setTag(bit.tag)
                                bit.layer:getChildByTag(100):runAction(s_action)

                            end

                        end

                        local data = { beaten = var, bit = enemy}

                        bitSoldier("" ,data)
                    end
                    break
                end
            end

        end
    end
end


-- soldier bit enemySoldier
function soldierFight.bitEnemySoldier(map)

    for key, soldier in ipairs(soldierTab) do

        if(not soldier.isStop) then

            local soldierX,soldierY = soldier.layer:getChildByTag(100):getPosition()

            for key, var in ipairs(warriorTab) do
                local varX,varY = var.layer:getChildByTag(100):getPosition()
                local absX = math.abs(varX - soldierX)
                local absY = math.abs(varY - soldierY)
                --遇到后停止运动
                if(absX < Soldier.Viewrang and absY < Soldier.Viewrang)then
                    soldier.isStop = true
                    soldier.bitTarget =var.tag
                    local soldierModel = soldier.layer:getChildByTag(100)
                    local sblood  = soldier.layer:getChildByTag(101)
                    local sblooding =soldier.layer:getChildByTag(102)
                    local sblood_txt =soldier.layer:getChildByTag(103)
                    sblood:stopAllActions()
                    sblooding:stopAllActions()
                    sblood_txt:stopAllActions()
                    soldierModel:stopAllActions();

                    local soldier1 = var.layer:getChildByTag(100)
                    local sblood1 =var.layer:getChildByTag(101)
                    local sblooding1 =var.layer:getChildByTag(102)
                    local sblood_txt1 =var.layer:getChildByTag(103)
                    if(not var.isStop)then
                        var.isStop = true
                        var.bitTarget = soldier.tag
                        sblood1:stopAllActions()
                        sblooding1:stopAllActions()
                        sblood_txt1:stopAllActions()
                        soldier1:stopAllActions();
                    end

                    --attack
                    if (not soldier.isBit)then
                        soldier.isBit = true

                        local function bitEnemySoldier(node, data)
                            local beaten   = data.beaten
                            local bit = data.bit

                            beaten.remaindBlood = beaten.remaindBlood - bit.hurt

                            if(beaten.remaindBlood <= 0)then  --死亡

                                removeSoldier(warriorTab, beaten.tag)
                                map:removeChildByTag(beaten.tag)
                                bit.isStop = false
                                bit.isPatrol = true
                                bit.isBit = false
                                bit.bitTarget = 0
                                bit.layer:getChildByTag(100):stopActionByTag(bit.tag);
                                
                                local moneyControl = require("src/util/money")
                                moneyControl.addMoney("enemySoldier")
                            else
                                enemySoldierView.updateBlood(beaten.tag)
                                local s_action = cc.Sequence:create(cc.DelayTime:create(result.enemySoldier.time),
                                    cc.CallFunc:create(bitEnemySoldier,data))
                                s_action:setTag(bit.tag)
                                bit.layer:getChildByTag(100):runAction(s_action)

                            end

                        end
                        local data = { beaten = var, bit = soldier}
                        bitEnemySoldier("" ,data)
                    end
                    break
                end
            end
        else   --遇到enemy已经停止运到，而还没执行攻击的soldier
            if (not soldier.isBit and soldier.bitTarget ~= 5000)then
                soldier.isBit = true
                local function bitEnemySoldier(node, data)
                    local beaten   = data.beaten
                    local bit = data.bit

                    beaten.remaindBlood = beaten.remaindBlood - bit.hurt

                    if(beaten.remaindBlood <= 0)then

                        removeSoldier(warriorTab, beaten.tag)
                        map:removeChildByTag(beaten.tag)
                        bit.isStop = false
                        bit.isPatrol = true
                        bit.isBit = false
                        bit.bitTarget = 0
                        bit.layer:getChildByTag(100):stopActionByTag(bit.tag);
                        
                        local moneyControl = require("src/util/money")
                        moneyControl.addMoney("enemySoldier")
                    else
                        enemySoldierView.updateBlood(beaten.tag)
                        local s_action = cc.Sequence:create(cc.DelayTime:create(result.enemySoldier.time),
                            cc.CallFunc:create(bitEnemySoldier,data))
                        s_action:setTag(bit.tag)
                        bit.layer:getChildByTag(100):runAction(s_action)

                    end

                end
                
                local data = { beaten = getModelByTag(warriorTab, soldier.bitTarget), bit = soldier}
                bitEnemySoldier("" ,data)
            end
        end
    end

end

return soldierFight
