-----------------is me
local Scree_width,Scree_height

local result


local ResultScene = class("ResultScene",function()
    return cc.Scene:create()
end)

function ResultScene.create()
    result=cc.UserDefault:getInstance():getBoolForKey("result")
    if(result)then
       print("srrrr :    Success")
    end
    local scene = ResultScene.new()
    scene:addChild(scene:Result())
    
    return scene
end

function ResultScene:ctor()

    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    --获取屏幕宽高
    Scree_height=self.visibleSize.height
    Scree_width=self.visibleSize.width
end

local function onTouchBegan(touch, event)
    local location = touch:getLocation()
    local target=event:getCurrentTarget()
    
    --local txt=target:getChildByTag(100);
    --print("++++++++++ ".. target)
    if(cc.rectContainsPoint(target:getBoundingBox(),location))then
        local scene = require("Sence")
        local gameScene = scene.create()
        cc.Director:getInstance():replaceScene(gameScene)
    end
end


function ResultScene:Result()

    local layerResult = cc.Layer:create()
  
    local spriteLand 
    if(result)then
        spriteLand= cc.Sprite:create("success.png")
    else
        spriteLand= cc.Sprite:create("defeat.png")
    end
    spriteLand:setPosition(Scree_width/2,Scree_height/2)
    layerResult:addChild(spriteLand)

    local testLabel = cc.Label:createWithTTF("Play Again", "fonts/Marker Felt.ttf", 35)
    
    testLabel:setPosition(Scree_width/2,180)

    layerResult:addChild(testLabel,1,100)--tag:100

    ---为Label添加监听
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    local eventDispatcher = testLabel:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, testLabel)
    
    return layerResult
end

return ResultScene
