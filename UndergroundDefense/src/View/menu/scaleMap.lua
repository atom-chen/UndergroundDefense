--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : scaleMap.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年8月24日 下午10:34:16
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************

local  scaleMap= class("scaleMap",function()
    return cc.Layer:create()
end)



function scaleMap.create(x,y,map)

    local layer = scaleMap.new()
    
    --------放大
    local  scaleUp = cc.Sprite:create("res/scaleup.png")
    scaleUp:setScale(0.4)
    scaleUp:setPosition(x,y)
    layer:addChild(scaleUp)   

    --------缩小
    local scaleDown = cc.Sprite:create("res/scaledown.png")
    scaleDown:setScale(0.2)
    scaleDown:setPosition(x ,y - 120)   
    layer:addChild(scaleDown) 
  
    local listener = cc.EventListenerTouchOneByOne:create()
    
    local function onTouchBegan(touche, event)
        local bitPoint = touche:getLocation()
        
        if(cc.rectContainsPoint(scaleUp:getBoundingBox(),bitPoint) and ScaleRate <= 1 )then
            listener:setSwallowTouches(true) --吞噬点击事件，不往下层传递，记得返回true
            ScaleRate = ScaleRate + 0.1
            local scaleAction = cc.ScaleTo:create(1,ScaleRate)
            map:runAction(scaleAction)
            
            
        end
        
        if(cc.rectContainsPoint(scaleDown:getBoundingBox(),bitPoint) and ScaleRate >= 0.4 )then
            listener:setSwallowTouches(true)
            ScaleRate = ScaleRate - 0.1
            if ScaleRate < 0.33 then ScaleRate = 0.33 end
            local scaleAction = cc.ScaleTo:create(1,ScaleRate)
            --解决缩小题图无法移动问题，即移动地图缩小出现黑区
            local mapX, mapY = map:getPosition()
            
            if mapX < 0 or mapY < 0 then
                local pointX = map:getContentSize().width * ScaleRate + mapX
                local pointY = map:getContentSize().height * ScaleRate + mapY
                
                if pointX < 960 or pointY < 640 then
                    scaleAction = cc.Spawn:create(cc.MoveTo:create(1,cc.p(0,0)),cc.ScaleTo:create(1,ScaleRate))
                end
            end
            map:runAction(scaleAction)
        end       
        return true
    end       
    
    local function onTouchEnd(touche, event)
        listener:setSwallowTouches(false)
    end 
    
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
    
    return layer
end


return scaleMap