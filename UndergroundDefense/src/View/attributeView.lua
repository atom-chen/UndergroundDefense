
--显示角色属性
local  attributeView= class("attributeView",function()
    return cc.Layer:create()
end)

local m_tList = {
    {name = "Boss",          path = "res/csb/generalshark.csb", isNode = true,  scale = 0.1},
    {name = "warrior1",      path = "res/csb/captain_jack.csb", isNode = true,  scale = 0.3},
    {name = "warrior1",      path = "res/csb/pharaoh.csb",      isNode = true,  scale = 0.3},
    
    {name = "monster1",      path = "res/monster/monster1.png", isNode = false, scale = 0.6},
    {name = "monster2",      path = "res/monster/monster2.png", isNode = false, scale = 0.6},
    {name = "monster3",      path = "res/monster/RobotRun3.png",isNode = false, scale = 0.25},
    {name = "soldier",       path = "res/soldier.png",          isNode = false, scale = 1},
    {name = "enemySoldier",  path = "res/enemy.png",            isNode = false, scale = 1},
    {name = "trap1",         path = "res/trap1.png",            isNode = false, scale = 1},
    {name = "trap2",         path = "res/trap2.png",            isNode = false, scale = 1}
}

local m_tName ={
"blood", "speed",
}

local function initLayer(detilLayer)
    local positionX = 20
    local positionY = detilLayer:getContentSize().height
    
    local eachHeight = detilLayer:getContentSize().height / #m_tList - 5
    print("blood",m_tList[1].blood)
    for key, var in ipairs(m_tList) do
        local position = cc.p(positionX, positionY - key * eachHeight)
        local node = nil 
    	if var.isNode then
    	    node = cc.CSLoader:createNode(var.path)
    	else
            node = cc.Sprite:create(var.path)            
    	end
        node:setScale(var.scale)
        node:setPosition(position)
        detilLayer:addChild(node)
        
        local str = ""
        local textStr = nil
        ---文字描述
        if var.name == "Boss" then
            str = "血量: " .. result.Boss.blood.. " 攻击力: ".. result.Boss.hurt .. " 攻击频率: ".. result.Boss.time
            str = "名字： " .. var.name .. " " ..str
        end
        
        if var.name == "warrior1" then
            str = "血量: " .. result.Warrior.blood.. " 攻击力: ".. result.Warrior.hurt .. " 攻击频率: ".. result.Warrior.time ..
                " 速度: ".. result.Warrior.speed .. "攻击目标：Boss 技能：治疗术+" .. result.Warrior.skill_type2 .. " 暴击 -"..result.Warrior.skill_type1   
            str = "名字： " .. var.name .. " " ..str         
        end
        if var.name == "warrior2" then
            str = "血量: " .. result.Warrior.blood.. " 攻击力: ".. result.Warrior.hurt .. " 攻击频率: ".. result.Warrior.time ..
                " 速度: ".. result.Warrior.speed .. "攻击目标：巢穴  技能：治疗术+" .. result.Warrior.skill_type2 .. " 暴击 -"..result.Warrior.skill_type1    
            str = "名字： " .. var.name .. " " ..str        
        end
        if var.name == "monster1" then
            local data = result.monster.monster1
            str = "血量: " .. data.blood.. " 攻击力: ".. data.hurt .. " 速度: ".. data.speed .. " 金币: ".. data.cost .. " 冷却CD: ".. data.cd.. " 最大数量: ".. data.maxNum ..
                " 效果：强化士兵  blood +" .. data.soldierBlood .. " hurt + ".. data.soldierHurt
            str = "名字： " .. var.name .. " " ..str
        end
        
        if var.name == "monster2" then
            local data = result.monster.monster2
            str = "血量: " .. data.blood.. " 攻击力: ".. data.hurt .. " 速度: ".. data.speed .. " 金币: ".. data.cost .. " 冷却CD: ".. data.cd.. " 最大数量: ".. data.maxNum ..
                " 效果：弱化敌方士兵  blood -" .. data.enemysoldierBlood .. " \n hurt - ".. data.enemysoldierHurt
            str = "名字： " .. var.name .. " " ..str
        end
        
        if var.name == "monster3" then
            local data = result.monster.monster3
            str = "血量: " .. data.blood.. " 攻击力: ".. data.hurt .. " 速度: ".. data.speed .. " 金币: ".. data.cost .. " 冷却CD: ".. data.cd.. " 最大数量: ".. data.maxNum ..
                " 效果：弱化敌方勇士   blood -" .. data.warriorBlood .. " \n hurt - ".. data.warriorHurt .. " speed - " ..data.warriorSpeed
            str = "名字： " .. var.name .. " " ..str
        end
        
        if var.name == "soldier" then
            local data = result.Soldier
            str = "血量: " .. data.blood.. " 攻击力: ".. data.hurt .. " 速度: ".. data.speed .. " 攻击频率: ".. data.time .. " 最大数量: ".. result.SoldierNum 
            str = "名字： " .. var.name .. " " ..str
                
        end
        
        if var.name == "enemySoldier" then
            local data = result.enemySoldier
            str = "血量: " .. data.blood.. " 攻击力: ".. data.hurt .. " 速度: ".. data.speed .. " 攻击频率: ".. data.time 
            str = "名字： " .. var.name .. " " ..str
        end
        
        if var.name == "trap1" then
            local data = result.trap.trap1
            str = "trap1效果: 削弱勇士   speed - " .. data.downmove .. " hurt - " .. data.downhurt .. " 持续时间：" .. data.time
            str = "名字： " .. var.name .. " " ..str
        end
        
        if var.name == "trap2" then
            local data = result.trap.trap2
            str = "trap2效果: 对勇士直接造成伤害   blood - " .. data.hurt
            str = "名字： " .. var.name .. " " ..str
        end

        textStr = cc.Label:createWithTTF(str, "fonts/menu_format.ttf", 12)
        textStr:setPosition(position.x + 20 , position.y)
        textStr:setAnchorPoint(0, 0)
        
        if var.name == "monster2" or var.name == "monster3" then
            textStr:setAnchorPoint(0, 0.5)
        end
       
        detilLayer:addChild(textStr)
    end
    
end

--scaleMap的layer
function attributeView.create(layer, map)

    local detilLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 188), 760, 440)
    
    local width = detilLayer:getContentSize().width
    local height = detilLayer:getContentSize().height   

    local textOK = cc.Label:createWithTTF("确定", "fonts/menu_format.ttf", 20)
    textOK:setPosition(width / 2, textOK:getContentSize().height+ 10)
    detilLayer:addChild(textOK, 0, 104)
   
    initLayer(detilLayer)
    
    local listener = cc.EventListenerTouchOneByOne:create()   
    local function onTouchBegan(touche, event)
        local bitPoint = touche:getLocation()
        local bitPoint = cc.p(bitPoint.x -100, bitPoint.y - 100) -- touche:getLocation()为openGL坐标
        listener:setSwallowTouches(true)  -- 吞噬点击事件
        if(cc.rectContainsPoint(textOK:getBoundingBox(), bitPoint)) then
            layer:removeChildByName("detilLayer")
        end
        
        return true
    end  
     
    local function onTouchEnd(touche, event)
        listener:setSwallowTouches(false)
    end 
    
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = detilLayer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, detilLayer)
    
    return detilLayer
end

return attributeView
