

local ResultScene = class("ResultScene",function()
    return cc.Scene:create()
end)

function ResultScene.create()
  
    local scene = ResultScene.new()
    scene:addChild(scene:Result())   
    return scene
end

function ResultScene:ctor()

    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
end

local function onTouchBegan(touch, event)
    local location = touch:getLocation()
    local target=event:getCurrentTarget()


    if(cc.rectContainsPoint(target:getBoundingBox(),location))then


        local scene = require("GameScene")
        
        local gameScene = scene.create()
        cc.Director:getInstance():replaceScene(gameScene)
    end
end


function ResultScene:Result()

    local layerResult = cc.Layer:create()
  
    local spriteLand 
    if(gameResult)then
        spriteLand= cc.Sprite:create("success.png")
    else
        spriteLand= cc.Sprite:create("defeat.png")
    end

    spriteLand:setPosition(self.visibleSize.width/2,self.visibleSize.height/2)
    layerResult:addChild(spriteLand)

    local testLabel = cc.Label:createWithTTF("Play Again", "fonts/Marker Felt.ttf", 35)
    
    testLabel:setPosition(self.visibleSize.width/2,180)

    layerResult:addChild(testLabel,1,100)--tag:100

    ---为Label添加监听
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    local eventDispatcher = testLabel:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, testLabel)
    
    return layerResult
end

return ResultScene
