

local  leftMenu= class("leftMenu",function()
    return cc.LayerColor:create()
end)



function leftMenu.create(x,y)

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
    
   
    
    local listener_left = cc.EventListenerTouchOneByOne:create()
    local function onTouchBegan_left(touche, event)
        print("statr")
    end
    local function onTouchesMove_left(touche, event)
        print("oooo")
    end
    local function onTouchEnd_left(touche, event)

    end


    ----监听leftMenu       
    listener_left:registerScriptHandler(onTouchBegan_left,cc.Handler.EVENT_TOUCH_BEGAN )
    listener_left:registerScriptHandler(onTouchEnd_left,cc.Handler.EVENT_TOUCH_ENDED )
    listener_left:registerScriptHandler(onTouchesMove_left,cc.Handler.EVENT_TOUCHES_MOVED )
    local eventDispatcher_left = layer:getEventDispatcher()
    eventDispatcher_left:addEventListenerWithSceneGraphPriority(listener_left, layer)
    
    return layer
end


return leftMenu