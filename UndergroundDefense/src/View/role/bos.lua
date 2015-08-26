-----Bos 的Layer

local BosLayer = class("BosLayer",function()
    return cc.Layer:create()
end)

function BosLayer.create(x,y)
    
    local layer = BosLayer.new()
    -----把cocosStudio生成的csb和资源图片导入的res目录下
    -----添加Bos模型
    local Bos = cc.CSLoader:createNode("csb/generalshark.csb") 
    Bos:setScale(0.3)  
    Bos:setRotationSkewY(180)
    Bos:setPosition(x,y)

    local action = cc.CSLoader:createTimeline("csb/generalshark.csb")--获取帧动画活动
    action:setTag(10005)
    action:gotoFrameAndPlay(0,60,true)--设置运行0-13fps,true为无线循环
    ---  14--22攻击动画
    ---  23--67死亡动画
    Bos:runAction(action)
    layer:addChild(Bos,0,1000)
    
    print("Bos size: ".. Bos:getContentSize().width)
    ------添加Bos血条    
    local blood = cc.Sprite:create("monster_blood_frame.png")
    blood:setPosition(x,y+120)
    layer:addChild(blood)
    
    local blooding = cc.Sprite:create("monster_blood.png")
    local progress1 = cc.ProgressTimer:create(blooding)
    progress1:setType(1)--设成横向
    progress1:setMidpoint(cc.p(0,0))
    progress1:setBarChangeRate(cc.p(1,0))--左往右
    progress1:setPercentage(100)--设置0%
    progress1:setPosition(x,y+120)   
    layer:addChild(progress1,0,100001)
    
    local bd_txt = Boss.blood .. "/".. Boss.blood
    
    ----添加血量文字
    local blood_txt = cc.Label:createWithTTF(bd_txt,"fonts/arial.ttf",12)
    blood_txt:setColor(cc.c3b(0,0,0))
    blood_txt:setPosition(x,y+130)
    layer:addChild(blood_txt,0,100002)
    
    ---true表示是否打勇士
   
    My_Boss={layer,action,true}
    
    
    local listener = cc.EventListenerTouchOneByOne:create()
    local isbitBoss = false
    local function onTouchBegan(touche, event)
        local bitPoint = touche:getLocation()       
        local BossX = Bos:getPositionX() 
        local BossY = Bos:getPositionY()
        ---map position
        local bit_pointx= (bitPoint.x - 0) / ScaleRate;
        local bit_pointy= (bitPoint.y - 0) / ScaleRate
        
        local absX = math.abs(BossX - bitPoint.x)
        local absY = math.abs(BossY - bitPoint.y)
        local rang = 50
        
        print(bit_pointx, bit_pointy)
        if(absX <rang and absY < rang) then
            listener:setSwallowTouches(true) 
            print("boskkkkkkkkkkk")
            isbitBoss = true           
        end
        return true
    end  
    
    local function onToucheMoved(touche, event)
        if isbitBoss then
            local bitPoint = touche:getLocation()
            Bos:setPosition(bitPoint.x, bitPoint.y)
            blood:setPosition(bitPoint.x, bitPoint.y)
            progress1:setPosition(bitPoint.x, bitPoint.y)
            blood_txt:setPosition(bitPoint.x, bitPoint.y)
        end
    end     

    local function onTouchEnd(touche, event)
        listener:setSwallowTouches(false)
        isbitBoss = false 
    end 
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onToucheMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
    
    return layer
end

return BosLayer