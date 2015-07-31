local  upMenu= class("upMenu",function()
    return cc.Layer:create()
end)



function upMenu.create(x,y)

    local layer = upMenu.new()
    --------金币 
    local  money = cc.Sprite:create("icon/money.png")
    money:setScale(0.6)
    money:setPosition(x,y)
    layer:addChild(money)   
         
    local money_txt = cc.Label:createWithTTF(Money,"fonts/arial.ttf",15)
    money_txt:setPosition(x+30,y)
    money_txt:setColor(cc.c3b(0,0,0))
    layer:addChild(money_txt,0,1)
    --------时间
    local time = cc.Sprite:create("icon/time.png")
    time:setScale(0.6)
    time:setPosition(x + 90,y)   
    layer:addChild(time) 
    
    local time_txt = cc.Label:createWithTTF(0,"fonts/arial.ttf",15)
    time_txt:setColor(cc.c3b(0,0,0))
    time_txt:setPosition(x + 120,y)   
    layer:addChild(time_txt,0,2) 
    --------第几波勇士
    local warrior = cc.Sprite:create("icon/warrior.png")
    warrior:setScale(0.8)
    warrior:setPosition(x + 180,y)   
    layer:addChild(warrior) 
    
    local warrior_txt = cc.Label:createWithTTF(whichWarrior,"fonts/arial.ttf",15)
    warrior_txt:setColor(cc.c3b(0,0,0))
    warrior_txt:setPosition(x + 210,y)   
    layer:addChild(warrior_txt,0,3) 
    
    --------小兵数量
    local soldier = cc.Sprite:create("icon/soldier.png")
    soldier:setScale(0.8)
    soldier:setPosition(x + 270,y)   
    layer:addChild(soldier) 
    
    local soldier_txt = cc.Label:createWithTTF(table.getn(soldierTab),"fonts/arial.ttf",15)
    soldier_txt:setColor(cc.c3b(0,0,0))
    soldier_txt:setPosition(x + 300,y)   
    layer:addChild(soldier_txt,0,4) 
    
    
     
    return layer
end


return upMenu