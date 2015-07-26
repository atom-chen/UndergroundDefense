
local soldierView = require("View/soldier")

local  leftMenu= class("leftMenu",function()
    return cc.LayerColor:create()
end)



function leftMenu.create(x,y,map)

    local layer = leftMenu.new()
    --------妖怪1 
    local  monster1 = cc.Sprite:create("monster/monster_head1.png")
    monster1:setScale(1.5)
    monster1:setPosition(x,y)
    layer:addChild(monster1,0,1)   

    monster1:setColor(cc.c3b(120,120,120))

    --------妖怪2
    local monster2 = cc.Sprite:create("monster/monster_head2.png")
    monster2:setScale(1.5)
    monster2:setPosition(x ,y - 80)   
    layer:addChild(monster2,0,2) 
    monster2:setColor(cc.c3b(120,120,120))

    --------妖怪3
    local monster3 = cc.Sprite:create("monster/RobotState4.png")
    monster3:setScale(1.3)
    monster3:setPosition(x ,y -160)   
    layer:addChild(monster3,0,3) 
    monster3:setColor(cc.c3b(120,120,120))

    local whichmonster = nil   
    local tag = nil 
    local listener_left = cc.EventListenerTouchOneByOne:create()
    local function onTouchBegan_left(touche, event)       
        local location = touche:getLocation()
        ---是否点中怪物
        if(cc.rectContainsPoint(monster1:getBoundingBox(),location) or 
               cc.rectContainsPoint(monster2:getBoundingBox(),location) or 
               cc.rectContainsPoint(monster3:getBoundingBox(),location)
          )then
                 
           listener_left:setSwallowTouches(true) --吞噬点击事件，不往下层传递，记得返回true
           
           if(cc.rectContainsPoint(monster1:getBoundingBox(),location))then
                if(Money >= result.monster.monster1.cost)then
                    tag = 100
                    whichmonster = leftMenu.createMonster1(monster1:getPositionX(),monster1:getPositionY())
                    whichmonster:setOpacity(120)
                    layer:addChild(whichmonster,0,tag)
                else
                  return false
                end
           end
           
           if(cc.rectContainsPoint(monster2:getBoundingBox(),location))then
                if(Money >= result.monster.monster2.cost)then
                    tag = 200
                    whichmonster = leftMenu.createMonster2(monster2:getPositionX(),monster2:getPositionY())
                    whichmonster:setOpacity(120)
                    layer:addChild(whichmonster,0,tag)
                else
                   return false
                end
           end
            
           if(cc.rectContainsPoint(monster3:getBoundingBox(),location))then
                if(Money >= result.monster.monster3.cost)then
                    tag = 300
                    whichmonster = leftMenu.createMonster3(monster3:getPositionX(),monster3:getPositionY())
                    whichmonster:setOpacity(120)
                    layer:addChild(whichmonster,0,tag)
                else
                    return false
                end
           end
           
            return true  ---setSwallowTouches能吞噬触屏，记得要返回true才行
        else
           
            return false -- 不触发move，end       
        end
              
        
    end
    
    local function onTouchesMove_left(touche, event)
        whichmonster:setPosition(touche:getLocation())                        
    end
    
    local function onTouchEnd_left(touche, event)
        listener_left:setSwallowTouches(false) --取消吞噬点击事件
        whichmonster:setOpacity(255)
        
        local clonesprite
        local map_x = whichmonster:getPositionX()-map:getPositionX()
        local map_y = whichmonster:getPositionY()-map:getPositionY()
        if(tag == 100)then
            clonesprite = soldierView.create(map_x,map_y,"monster/monster1.png",result.monster.monster1.blood,result.monster.monster1.hurt)
            
            Money = Money - result.monster.monster1.cost
        end
        if(tag == 200)then
            clonesprite = soldierView.create(map_x,map_y,"monster/monster2.png",result.monster.monster2.blood,result.monster.monster2.hurt)
            Money =Money - result.monster.monster2.cost
        end
        
        if(tag == 300)then
            clonesprite = soldierView.create(map_x,map_y,"monster/RobotRun3.png",result.monster.monster3.blood,result.monster.monster3.hurt)
            
            Money = Money - result.monster.monster3.cost
        end        
        map:addChild(clonesprite,0,soldierKey)
        soldierKey =soldierKey +1
        layer:removeChildByTag(tag)
       
        ----把该怪兽添加到士兵集合
        
        
    end

    

    ----监听leftMenu       
    listener_left:registerScriptHandler(onTouchBegan_left,cc.Handler.EVENT_TOUCH_BEGAN )
    listener_left:registerScriptHandler(onTouchEnd_left,cc.Handler.EVENT_TOUCH_ENDED )
    listener_left:registerScriptHandler(onTouchesMove_left,cc.Handler.EVENT_TOUCH_MOVED )
    local eventDispatcher_left = layer:getEventDispatcher()
    eventDispatcher_left:addEventListenerWithSceneGraphPriority(listener_left, layer)
   
    return layer
end

function leftMenu.createMonster3(x,y)
     local sprite = cc.Sprite:create("monster/RobotRun3.png")
     
     sprite:setPosition(x,y)
     
     sprite:setScale(0.3)
--     local animation =cc.Animation:create()  
--     animation:addSpriteFrameWithFile("monster/RobotRun1.png")
--     animation:addSpriteFrameWithFile("monster/RobotRun2.png")
--     animation:addSpriteFrameWithFile("monster/RobotRun3.png")
--     animation:addSpriteFrameWithFile("monster/RobotRun4.png")
--     animation:addSpriteFrameWithFile("monster/RobotRun5.png")
--     animation:addSpriteFrameWithFile("monster/RobotRun6.png")
--     
--     animation:setDelayPerUnit(0.15)          --设置两个帧播放时间                      ⑥  
--     animation:setRestoreOriginalFrame(true)    --动画执行后还原初始状态   
--     
--     local action =cc.Animate:create(animation)                                                              
--     sprite:runAction(cc.RepeatForever:create(action))  
     
     return sprite     
end

function leftMenu.createMonster1(x,y)
    local sprite = cc.Sprite:create("monster/monster1.png")

    sprite:setPosition(x,y)

    sprite:setScale(0.6)
    
    return sprite     
end

function leftMenu.createMonster2(x,y)
    local sprite = cc.Sprite:create("monster/monster2.png")

    sprite:setPosition(x,y)

    sprite:setScale(0.6)

    return sprite     
end
return leftMenu