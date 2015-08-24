--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : GameScene.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年7月25日 下午11:41:46
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************


local bosView = require("src/view/role/bos")

local soldierView = require("src/view/role/soldier")

local enemySoldier = require("src/view/role/enemySoldier")

local warriorView = require("src/view/role/warrior")

local userTouch = require("src/controller/userTouch")

local soldierFight = require("src/controller/battle/soldierFight")

local warriorFight = require("src/controller/battle/warriorFight")

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

    math.randomseed(os.time()) 
    
    GameScene:init()
    
    local layerMap = GameScene:createMap()
    scene:addChild(layerMap)
    
    local map = layerMap:getChildByTag(1)
    map:setScale(ScaleRate)
    
    print(map:getContentSize().width, map:getContentSize().height) -- 2880  1920不变
    return scene
end

local function cteateTrap()
    local tag = 300
    for var=1, result.trap.trapNum do
        tag = tag + 1 
        local trap = nil 
    	if(math.random(1,2) == 1)then
            trap = require("src/model/trapModel").create(cc.Sprite:create("res/trap1.png"),tag,1)                
        else
            trap = require("src/model/trapModel").create(cc.Sprite:create("res/trap2.png"),tag,2)
        end
        table.insert(trapTab,trap)
    end
end

function GameScene:init()
    ----数据初始化
    isExistWarrior = false

    whichWarrior = 1      -- 第几个勇士

    Boss_blood = Boss.blood

    birthplace_blood = result.birthplace_blood

    Money = result.money.init --金币数,通过点击开辟道路获取

    WarriorLifeTime = result.Warrior_LiftTime  --勇士生存时间值

    soldierTab={}  -- 小兵集合

    warriorTab = {}   --勇士小兵集合
    
    trapTab    = {} 
    
    soldierKey = 30000  -- 小兵的key
        
    --随机陷阱
    cteateTrap()    
    
    require("src/model/monsterModel"):init()
end

function GameScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    screeWidth,screeHeight=self.visibleSize.width,self.visibleSize.height

end


-----------使用地图编辑器
function GameScene:createMap()

    local layerMap=cc.Layer:create()

    ---加载tmx显示地图
    local  map = cc.TMXTiledMap:create("map/map.tmx") ---每个TMXTiledMap都被当作一个精灵
    layerMap:addChild(map, 0, 1)
    
    --陷阱产生
    local trap = require("src/view/trapView").create(map)
    map:addChild(trap,0,400)

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
    
    --上级菜单
    local upmenu = upMenu.create(60,600)
    layerMap:addChild(upmenu,0,10086)
    
    --左级菜单
    local leftmenu = leftMenu.create(45,360,map)
    layerMap:addChild(leftmenu,0,10087)
    
    --放大缩小
    local scaleMenu = require("src/View/menu/scaleMap").create(900, 450,map)
    layerMap:addChild(scaleMenu,0,10088)

    local bitNode;
    local function onTouchBegan_map(touche, event)
        bitNode = touche:getLocation()  
        return true
    end

    ---移动地图layer
    local function onToucheMoved_map(touche, event)
        local diff =touche:getDelta() 
        local node = layerMap:getChildByTag(1)
       
        local currentPosX, currentPosY= node:getPosition()
        local Mx = currentPosX + diff.x
        local My = currentPosY + diff.y
        ---不能移出边框
        local mxMax = map:getContentSize().width * ScaleRate - screeWidth
        local myMax = map:getContentSize().height * ScaleRate - screeHeight
        if(Mx < 0 and Mx > - mxMax)then
            node:setPositionX(Mx)
        end 
        if(My < 0 and My > - myMax)then
            node:setPositionY(My)
        end

    end
    
    local function onTouchEnd_map(touche, event)
        local diff = touche:getLocation()
        local x=bitNode.x-diff.x
        -- 解锁砖块
        if(x < 5 and x > -5)then    --误差5
            userTouch.bitBlock(diff,map:getPositionX(),
                map:getPositionY(),map)
        end
    end

    --监听地图成
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan_map,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onToucheMoved_map,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnd_map,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layerMap:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerMap)
             
    --更新方法
    local function update()   

        ---更新upMenu
        updateMenu.upMenu(upmenu)
        updateMenu.leftMenu(leftmenu)
        
        require("src/controller/touchTrap").trigger(map)
       
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
                    WarriorLifeTime = result.Warrior_LiftTime  --更新勇士生存时间值
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
        soldierFight.bitSoldier(map)
        soldierFight.bitEnemySoldier(map)   
        
        if(isExistWarrior) then
            warriorFight.bitSoldier(map)
            warriorFight.bitWarrior(map)
            
            attackBirth.soldierBirth(map)
            attackBoss.bitBoss(map)   
        end     
    end
     
    --调度器，0代表每帧更新
    schedulerId = cc.Director:getInstance():getScheduler():scheduleScriptFunc(update, 0.2, false)
        
    return layerMap        
end



return GameScene
