
local bosView = require("View/bos")

local soldierView = require("View/soldier")

local warriorView = require("View/warrior")

local bitBlock = require("controller/bitBlock")

local fight = require("controller/fight")

local brithplace = require("View/birthplace")

local bloodTip = require("View/bloodTip")

local attackBirth = require("controller/attackBirth")

local attackBoss = require("controller/attackBoss")

local updateMenu = require("controller/updateMenu")

local upMenu = require("View/upMenu")

local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)

local screeWidth,screeHeight

function GameScene.create()
    local scene = GameScene.new()
    scene:addChild(GameScene:createMap())
    return scene
end


function GameScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    screeWidth,screeHeight=self.visibleSize.width,self.visibleSize.height
    print(screeWidth,screeHeight)
    ----数据初始化
    isExistWarrior = false

    whichWarrior = 0

    Boss_blood = Boss.blood

    birthplace_blood = result.birthplace_blood
    
    Money = result.money.init --金币数,通过点击开辟道路获取
    
    _WarriorLifeTime = result.Warrior_LiftTime  --勇士生存时间值
    
    soldierTab={}  -- 小兵集合
    
    soldierKey = 300  -- 小兵的key
end


-----------使用地图编辑器
function GameScene:createMap()
    local layerMap=cc.Layer:create()
    ---加载tmx显示地图
    local  map = cc.TMXTiledMap:create("map/map.tmx") ---每个TMXTiledMap都被当作一个精灵
    layerMap:addChild(map, 0, 1)
    
    ---需要添加到layerMap上，添加的map上会随地图移动而移动
    --上级菜单
    local upmenu = upMenu.create(60,600)
    layerMap:addChild(upmenu,0,10086)

    --根据名字获取map的layer
    --local layerBg=map:getLayer("layerMap") layerBg:addChild(robber,0,11) addChild: is not supported on TMXLayer

    
    ----bos视图显示
    --local object = require("Util.getObjectLayerData") --全局已加载
    local bospoint = object.getPoint(map,"object","Bospoint")    --加载对象层数据
    local bos = bosView.create(bospoint.x,bospoint.y)
    map:addChild(bos,0,10000)
           
    ----添加小兵
  
    local soldierpoint = object.getPoint(map,"object","soldierpoint")
    local space = 0;
    
    ---添加出生地血量
    local birth_blood = brithplace.create(soldierpoint.x,soldierpoint.y)
    map:addChild(birth_blood,0,250)
  
    math.randomseed(os.time()) 
    
    local wspace = 0 ;
          
    --更新方法
    local function update()
    
        ---更新upMenu
        updateMenu.upMenu(upmenu)

        --小兵数量_soldierNum，创建小兵       
        if(table.getn(soldierTab)< _soldierNum and birthplace_blood > 0)then
            space = space + 0.5;
            if(space > _soldierSpace)then 
                local soldier = soldierView.create(soldierpoint.x,soldierpoint.y,soldierKey)
                map:addChild(soldier,0,soldierKey)
                
                soldierKey = soldierKey +1
                space = 0;
            end    
        end 
                  
        --勇士数量_WarriorNum，地图没勇士创建勇士
        if(not isExistWarrior )then
            wspace = wspace + 0.5
            if(wspace > Warrior.space)then
                whichWarrior = whichWarrior + 1 --表示第几个勇士
               
                if(whichWarrior > _WarriorNum)then
                    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedulerId)
                    gameResult = true
                    local scene = require("ResultScene")
                    local gameScene = scene.create()
                    cc.Director:getInstance():replaceScene(gameScene)  
                else
                        ---添加勇士
                    local warriorpoint = object.getPoint(map,"object","warriorpoint")

                    WarriorType = math.mod(whichWarrior,2)
                    local warrior = warriorView.create(warriorpoint.x,warriorpoint.y, WarriorType)
                    map:addChild(warrior,0,5000)           
                    isExistWarrior=true --存在勇士
                    _WarriorLifeTime = result.Warrior_LiftTime  --更新勇士生存时间值
                    --移动勇士
                    warriorView.move(map)
    
                    wspace = 0
                end

            end
        end
        
        ---小兵巡逻
        soldierView.move(map)
        
         ---对战  
        if(isExistWarrior) then
            fight.follow(map) 
            --
            attackBirth.soldierBirth(map)

            attackBoss.bitBoss(map)     
        end        
          
    end
      
    --调度器，0代表每帧更新
    schedulerId = cc.Director:getInstance():getScheduler():scheduleScriptFunc(update, 0.2, false)
    
        
    --监听地图层
    local layerBg=map:getLayer("layerMap")
    local bitNode;
    local function onTouchBegan(touche,event)
        bitNode = touche:getLocation()        

        return true
    end
    
    local function onTouchEnd(touche,event)
        local diff = touche:getLocation()
        local x=bitNode.x-diff.x
      
        if(x<5 and x>-5)then    --误差5
          bitBlock.change(layerBg,diff,layerMap:getChildByTag(1):getPositionX(),
                 layerMap:getChildByTag(1):getPositionY(),map)
        end
    end
    
    local listener1 = cc.EventListenerTouchOneByOne:create()
    listener1:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener1:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher1 = layerBg:getEventDispatcher()
    eventDispatcher1:addEventListenerWithSceneGraphPriority(listener1, layerBg)
    
    ---移动地图layer
    local function onTouchesMoved(touches, event)
        local diff = touches[1]:getDelta()
        local node = layerMap:getChildByTag(1)
        local currentPosX, currentPosY= node:getPosition()
        local Mx = currentPosX + diff.x
        local My = currentPosY + diff.y
        ---不能移出边框
        if(Mx < 0 and Mx > -1920)then
            node:setPositionX(Mx)
        end 
        if(My < 0 and My > -1280)then
            node:setPositionY(My)
        end
--        if( (Mx < 0 and Mx > -1920) and (My < 0 and My > -1280))then --不能移出边框
--           node:setPosition(cc.p(Mx, My))
--        end 
        --print("X : " ..Mx,"Y : "..My)
    end
      

    local listener = cc.EventListenerTouchAllAtOnce:create()
    listener:registerScriptHandler(onTouchesMoved,cc.Handler.EVENT_TOUCHES_MOVED )
    local eventDispatcher = layerMap:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerMap)
    return layerMap
end


return GameScene
