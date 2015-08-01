
local bosView = require("src/view/role/bos")

local soldierView = require("src/view/role/soldier")

local enemySoldier = require("src/view/role/enemySoldier")

local warriorView = require("src/view/role/warrior")

local userTouch = require("src/controller/userTouch")

local soldierFight = require("src/controller/battle/soldierFight")

local brithplace = require("src/view/birthplace")

local gameTip = require("src/view/gameTip")

local attackBirth = require("src/controller/battle/attackBirth")

local attackBoss = require("src/controller/battle/attackBoss")

local updateMenu = require("src/controller/updateMenu")

local leftMenu = require("src/view/menu/leftMenu")

local upMenu = require("src/view/menu/upMenu")

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

    whichWarrior = 0      -- 第几个勇士

    Boss_blood = Boss.blood

    birthplace_blood = result.birthplace_blood
    
    Money = result.money.init --金币数,通过点击开辟道路获取
    
    _WarriorLifeTime = result.Warrior_LiftTime  --勇士生存时间值
    
    soldierTab={}  -- 小兵集合
    
    warriorTab = {}   --勇士小兵集合
    
    soldierKey = 30000  -- 小兵的key
end


-----------使用地图编辑器
function GameScene:createMap()

    local layerMap=cc.Layer:create()
    
    ---加载tmx显示地图
    local  map = cc.TMXTiledMap:create("map/map.tmx") ---每个TMXTiledMap都被当作一个精灵
    layerMap:addChild(map, 0, 1)
    

    ----bos视图显示
    --local object = require("Util.getObjectLayerData") --全局已加载
    local bospoint = object.getPoint(map,"object","Bospoint")    --加载对象层数据
    local bos = bosView.create(bospoint.x,bospoint.y)
    map:addChild(bos,0,10000)


    local soldierPoint = object.getPoint(map,"object","soldierpoint")
    local soldierSpace = 0;
    
    local warriorPoint = object.getPoint(map,"object","warriorpoint")
    local warriorSpace = 0 ;
    local enemySoldierSpace = 0
    
    ---添加出生地血量
    local birth_blood = brithplace.create(soldierPoint.x,soldierPoint.y)
    map:addChild(birth_blood,0,250)
  
    math.randomseed(os.time()) 
    
    --上级菜单
    local upmenu = upMenu.create(60,600)
    layerMap:addChild(upmenu,0,10086)
    
    --左级菜单
    local leftmenu = leftMenu.create(45,360,map)
    layerMap:addChild(leftmenu,0,10087)
 
    --监听地图层 -在map上的坐标
    local layerBg=map:getLayer("layerMap")
    local bitNode;
    
    
    local function onTouchBegan(touche,event)
        bitNode = touche:getLocation()        
        return true
    end   

    local function onTouchEnd(touche,event)
        local diff = touche:getLocation()
        local x=bitNode.x-diff.x

        if(x < 5 and x > -5)then    --误差5
            userTouch.bitBlock(layerBg,diff,layerMap:getChildByTag(1):getPositionX(),
                layerMap:getChildByTag(1):getPositionY(),map)
        end
    end

    local listener1 = cc.EventListenerTouchOneByOne:create()
    listener1:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener1:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher1 = layerBg:getEventDispatcher()
    eventDispatcher1:addEventListenerWithSceneGraphPriority(listener1, layerBg)



    local function onTouchBegan_map(touche, event)
    	return true
    end

    ---移动地图layer
    local function onToucheMoved_map(touche, event)
        local diff =touche:getDelta() 
        local node = layerMap:getChildByTag(1)
       
        --print("diff: ".. touches[1]:getLocation().x,touches[1]:getLocation().y)
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

    end

    --监听地图成
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan_map,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onToucheMoved_map,cc.Handler.EVENT_TOUCH_MOVED )
    local eventDispatcher = layerMap:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerMap)
    
          
    --更新方法
    local function update()    
        ---更新upMenu
        updateMenu.upMenu(upmenu)
        updateMenu.leftMenu(leftmenu)
       
        --小兵数量result.SoldierNum，创建小兵       
        if(table.getn(soldierTab)< result.SoldierNum and birthplace_blood > 0)then
            soldierSpace = soldierSpace + 0.5;
            if(soldierSpace > Soldier.space)then 
                local soldier = soldierView.create(soldierPoint.x,soldierPoint.y)
                map:addChild(soldier,0,soldierKey)
                soldierKey =soldierKey +1
                soldierSpace = 0;
            end    
        end 
        
        --敌方小兵
        if(table.getn(warriorTab)< result.enemySoldierNum and birthplace_blood > 0)then
            enemySoldierSpace = enemySoldierSpace + 0.5;
            if(enemySoldierSpace > result.enemySoldier.space)then 
                local soldier = enemySoldier.create(warriorPoint.x,warriorPoint.y)
                map:addChild(soldier,0,soldierKey)
                soldierKey =soldierKey +1
                enemySoldierSpace = 0;
            end    
        end 
        
                  
        --勇士数量result.WarriorNum，地图没勇士创建勇士
        if(not isExistWarrior )then
            warriorSpace = warriorSpace + 0.5
            if(warriorSpace > Warrior.space)then
                whichWarrior = whichWarrior + 1 --表示第几个勇士
               
                if(whichWarrior > result.WarriorNum)then
                    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedulerId)
                    gameResult = true
                    local scene = require("ResultScene")
                    local gameScene = scene.create()
                    cc.Director:getInstance():replaceScene(gameScene)  
                else
                    ---添加勇士                 
                    local warrior = warriorView.create(warriorPoint.x,warriorPoint.y, math.mod(whichWarrior,2))
                    map:addChild(warrior,0,5000)           
                    isExistWarrior=true --存在勇士
                    _WarriorLifeTime = result.Warrior_LiftTime  --更新勇士生存时间值
                    --移动勇士
                    warriorView.move(map)

                    warriorSpace = 0
                end

            end
        end
        
        ---小兵巡逻
        soldierView.move(map)       
        enemySoldier.move(map)
        
        ---对战  
        
        if(isExistWarrior) then   -- 勇士相关的战斗
            soldierFight.warriorVsSoldier(map) 
            --
            attackBirth.soldierBirth(map)

            attackBoss.bitBoss(map)     
        end        
          
    end
     
    --调度器，0代表每帧更新
    schedulerId = cc.Director:getInstance():getScheduler():scheduleScriptFunc(update, 0.2, false)
    
    
    return layerMap      
  
end



return GameScene
