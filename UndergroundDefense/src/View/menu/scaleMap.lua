--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : scaleMap.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年8月24日 下午10:34:16
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************

---实现游戏开始引导流程

local  scaleMap= class("scaleMap",function()
    return cc.Layer:create()
end)

scaleMap.gameTipState = 1

scaleMap.gameTipStr = {
    bitBlock = "请敲碎砖块设计可走路径，完成后请点击右下角的确定",
    moveBoss = "请选择移动boss设置其位置，完成后请点击右下角的确定",
    cannotAvrrive = "魔王位置需要与勇士巢穴连通",
    setSuccess = "设置成功，游戏即将开始",
    soldierLaunch = "我方小兵出击"
}

---游戏引导放到放大缩小的layer--最上层
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
    
    ------引导文字
    local x = cc.Director:getInstance():getVisibleSize().width/2
    local y = cc.Director:getInstance():getVisibleSize().height/2

    local gameTip = cc.Label:createWithTTF(scaleMap.gameTipStr.bitBlock, "fonts/menu_format.ttf", 25)
    gameTip:setPosition(x,y)
    --gameTip:setScale(0.1)
    layer:addChild(gameTip, 0, 100)
    
    -----确定按钮
    local button = cc.Sprite:create("res/ok.png")
    button:setPosition(810, 50)
    button:setScale(0.6)
    layer:addChild(button,0, 101)
    
    ----查看属性文字按钮
    local textCheck = cc.Label:createWithTTF("查看人物属性", "fonts/menu_format.ttf", 20)
    textCheck:setPosition(x, textCheck:getContentSize().height+ 10)
    textCheck:setColor(cc.c3b(0, 0 ,0))
    layer:addChild(textCheck, 0, 102)

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

        ---确定按钮
        if(cc.rectContainsPoint(button:getBoundingBox(),bitPoint) and scaleMap.gameTipState < 5) then
            listener:setSwallowTouches(true) 
            scaleMap.clickButton(layer, map)                    
        end
        
        --查看属性
        if(cc.rectContainsPoint(textCheck:getBoundingBox(),bitPoint))then
            listener:setSwallowTouches(true) 
            scaleMap.clickTextCheck(layer, map)   
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

function scaleMap.clickButton(layer, map)   

    if scaleMap.gameTipState == 2 then
        scaleMap.gameTipState = scaleMap.gameTipState + 1
        local textStr = layer:getChildByTag(100)
        textStr:setString(scaleMap.gameTipStr.moveBoss)
        textStr:setVisible(true)
    end

    if scaleMap.gameTipState == 4  then
        local bossLayer = map:getChildByTag(10000)
        local boss = bossLayer:getChildByTag(1000)
        local bossX,bossY = boss:getPosition()

        local soldierPoint = object.getPoint(map,"object","soldierpoint")--勇士出生点

        local coordinate = require("src/util/coordinate")
        local bossPoint = cc.p(bossX, bossY)           
        local endItem = coordinate.getItem(map, bossPoint)
        local startItem = coordinate.getItem(map, soldierPoint)
        
        local result = require("src/Util/A_start").findPath(startItem,endItem,map)
        if result == 0 then --不连通
            local textStr = layer:getChildByTag(100)
            textStr:setString(scaleMap.gameTipStr.cannotAvrrive)
            textStr:setVisible(true)
            scaleMap.gameTipState = scaleMap.gameTipState - 1
        else 
            scaleMap.gameTipState = scaleMap.gameTipState +1 
            BossItem = endItem -- 设置Boss位置
            
            print("BossItem.................",BossItem.x, BossItem.y)
            
            print("游戏开始。。。。。。。")
            local textStr = layer:getChildByTag(100)
            textStr:setString(scaleMap.gameTipStr.setSuccess)
            textStr:setVisible(true)
            
            local button =layer:getChildByTag(101)
            button:setVisible(false)
            --button:setEnable(false)
            
            local  countDown = 5 
            local callAction = cc.Sequence:create(
                cc.CallFunc:create(
                    function()
                        if countDown <= 0 then
                            textStr:setString(scaleMap.gameTipStr.soldierLaunch) --提示我方士兵出击
                            textStr:setScale(1)
                        else
                            textStr:setString(countDown)
                            textStr:setScale(2)
                        end
                        countDown = countDown - 1
                    end
                    
                ),
                cc.DelayTime:create(1)
            )
            local repeatAction = cc.Repeat:create(callAction, countDown + 1)
            
            local startGameAction = cc.CallFunc:create(
                function()
                    textStr:setVisible(false)
                    gameStart = true
                end
            )
            
            local squenceAction = cc.Sequence:create(cc.DelayTime:create(2), repeatAction, startGameAction)
            layer:runAction(squenceAction)
        end
    end
end

--查看人物属性
function scaleMap.clickTextCheck(layer, map)
    local ok = layer:getChildByName("detilLayer")
    if ok then return end
    
    local detilLayer = require("src/view/attributeView").create(layer, map)
    local x = cc.Director:getInstance():getVisibleSize().width/2
    local y = cc.Director:getInstance():getVisibleSize().height/2
	detilLayer:setPosition(100, 100)
	detilLayer:setName("detilLayer")
	layer:addChild(detilLayer)
	
end

--显示提示的函数
function scaleMap.showMessage(message, map)
	
	local layer = map:getChildByTag(10088)
	
	local textStr = layer:getChildByTag(100)
	
	textStr:setString(message)
	textStr:setVisible(true)
	
	local squenceAction = cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(
	   function()
	       textStr:setVisible(false)
	   end
	))
	textStr:runAction(squenceAction)
end

return scaleMap
