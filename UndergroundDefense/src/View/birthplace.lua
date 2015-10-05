

local  birthplace= class("birthplace",function()
    return cc.Layer:create()
end)

function birthplace.create(x,y)

    local layer = birthplace.new()
      
    ------添加血条    
    local blood = cc.Sprite:create("monster_blood_frame.png")
    blood:setPosition(x-32 ,y + 70 )
    
    if soldierState == "right" then blood:setPosition(x+48 ,y + 70 ) end
    layer:addChild(blood)

    local blooding = cc.Sprite:create("monster_blood.png")
    local progress1 = cc.ProgressTimer:create(blooding)
    progress1:setType(1)--设成横向
    progress1:setMidpoint(cc.p(0,0))
    progress1:setBarChangeRate(cc.p(1,0))--左往右
    progress1:setPercentage(100)--设置0%
    progress1:setPosition(x-32,y+70)   
    
    if soldierState == "right" then progress1:setPosition(x+48 ,y + 70 ) end
    layer:addChild(progress1,0,20)

    local bd_txt = birthplace_blood .. "/".. birthplace_blood

    ----添加血量文字
    local blood_txt = cc.Label:createWithTTF(bd_txt,"fonts/arial.ttf",14)
    blood_txt:setColor(cc.c3b(0,0,0))
    blood_txt:setPosition(x-32,y+80)
    
    if soldierState == "right" then blood_txt:setPosition(x+48 ,y + 80 ) end
    layer:addChild(blood_txt,0,21)

    return layer
end

return birthplace