

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

--

function gameTip.awardMoney(node, tip, map, key)
    local layer = gameTip.new()
    local x = node:getPositionX()
    local y = node:getPositionY()

    local money_tip = cc.Label:createWithTTF(tip,"fonts/menu_format.ttf",10)
    money_tip:setColor(cc.c3b(0,125,0))
    money_tip:setPosition(x,y)
    money_tip:setScale(0.1)

    local function handler()
        map:removeChildByTag(key)
    end
    local effect =cc.Spawn:create(cc.ScaleTo:create(1, 1.5),cc.MoveBy:create(1.5, cc.p(0,30)))
    local action = cc.Sequence:create(effect,cc.CallFunc:create(handler,{}));
    money_tip:runAction(action) 
    layer:addChild(money_tip)

    return layer
end

return gameTip