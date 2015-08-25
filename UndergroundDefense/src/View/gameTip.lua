

local  gameTip= class("gameTip",function()
    return cc.Layer:create()
end)

function gameTip.create(node,tip,map,key,type)

    local layer = gameTip.new()
    --[[
      1: warrior
      2: soldier
      3: Boss
      4: birth
    ]]
    local x = node:getPositionX()
    local y = node:getPositionY()
    if(type == 1)then
        y = y + 55
    elseif(type == 2)then
        y = y + 20
    elseif(type == 3)then
        y = y + 120
    else
        y = y 
    end
    local blood_tip = cc.Label:createWithTTF(tip,"fonts/tahoma.ttf",10)
    blood_tip:setColor(cc.c3b(255,0,0))
    blood_tip:setPosition(x,y)
    blood_tip:setScale(0.1)

    local function handler()
        map:removeChildByTag(key)
    end
    local effect =cc.Spawn:create(cc.ScaleTo:create(1,1.5),cc.MoveBy:create(1.5,cc.p(0,30)))
    local action = cc.Sequence:create(effect,cc.CallFunc:create(handler,{}));
    blood_tip:runAction(action) 
    layer:addChild(blood_tip)
    return layer
end

--warrior tip
function gameTip.warriorTip(tipContent,map,key,size,color)
    if(isExistWarrior)then
        local layer = gameTip.new()
        local node = Warrior_P[1]:getChildByTag(1000)
        local x = node:getPositionX()
        local y = node:getPositionY() + 55  
    
        local blood_tip = cc.Label:createWithTTF(tipContent,"fonts/menu_format.ttf",size)
        blood_tip:setColor(color)
        blood_tip:setPosition(x,y)
        blood_tip:setScale(0.1)
    
        local function handler()
            map:removeChildByTag(key)
        end
        local effect =cc.Spawn:create(cc.ScaleTo:create(1,2.5),cc.MoveBy:create(2.5,cc.p(0,50)))
        local action = cc.Sequence:create(effect,cc.CallFunc:create(handler,{}));
        blood_tip:runAction(action) 
        layer:addChild(blood_tip)
        return layer
    end
end

--brith摧毁提示
function gameTip.brith(node,tip,map,key)
    local layer = gameTip.new()
    local x = node:getPositionX()
    local y = node:getPositionY()

    local blood_tip = cc.Label:createWithTTF(tip,"fonts/menu_format.ttf",12)
    blood_tip:setColor(cc.c3b(0,125,0))
    blood_tip:setPosition(x,y)
    blood_tip:setScale(0.1)

    local function handler()
        map:removeChildByTag(key)
    end
    local effect =cc.Spawn:create(cc.ScaleTo:create(1,2.5),cc.MoveBy:create(2.5,cc.p(0,20)))
    local action = cc.Sequence:create(effect,cc.CallFunc:create(handler,{}));
    blood_tip:runAction(action) 
    layer:addChild(blood_tip)
    return layer
end

--游戏引导提示
function gameTip.gameProcess(str, color, time, size, map, key)
	local layer = gameTip.new()
    local x = cc.Director:getInstance():getVisibleSize().width/2
    local y = cc.Director:getInstance():getVisibleSize().height/2

    local game_tip = cc.Label:createWithTTF(str, "fonts/menu_format.ttf", size)
    game_tip:setColor(color)
    game_tip:setPosition(x,y)
    game_tip:setScale(0.1)

    local function handler()
        local gameTipLayer = map:getChildByTag(key)
        --gameTipLayer
    end
    
    local effect =cc.Spawn:create(cc.ScaleTo:create(1,2.5))
    local action = cc.Sequence:create(effect,cc.CallFunc:create(handler));
    game_tip:runAction(action) 
    layer:addChild(game_tip)
    
    return layer
end

return gameTip