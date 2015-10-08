-----soldier 的Layer

local A_start = require("src/util/A_start")
local coordinate = require("src/util/coordinate")
local soldierModel = require("src/model/soldierModel")
local monsterModel = require("src/model/monsterModel")

local soldierLayer = class("soldiersLayer",function()
    return cc.Layer:create()
end)

function soldierLayer.create(x,y,sprite,blood_num,hurt,type,speed)
    
    local layer = soldierLayer.new()
        
    local soldier

    if(sprite)then 
        soldier = cc.Sprite:create(sprite)
        if(sprite == "monster/RobotRun3.png")then
            soldier:setScale(0.25)
        else
            soldier:setScale(0.6)
        end
    else
        soldier = cc.Sprite:create("soldier.png")
    end    
    
    soldier:setPosition(x,y)
    layer:addChild(soldier,0,100)
    
    ------添加血条    
    local blood = cc.Sprite:create("monster_blood_frame.png")
    blood:setPosition(x,y+20)
    blood:setScaleX(0.5)
    layer:addChild(blood,0,101)
    
    
    local blooding = cc.Sprite:create("monster_blood.png")

    local progress1 = cc.ProgressTimer:create(blooding)
    progress1:setType(1)--设成横向
    progress1:setMidpoint(cc.p(0,0))
    progress1:setBarChangeRate(cc.p(1,0))--左往右
    progress1:setPercentage(100)
    progress1:setPosition(x,y+20)   
    progress1:setScaleX(0.5)
    layer:addChild(progress1,0,102)
    
    local soldierBlood ,soldierHurt
    local bd_txt
    
    if(blood_num)then --monster
        soldierBlood = blood_num
        soldierHurt  = hurt
        bd_txt = blood_num .."/" ..blood_num
    else
        soldierBlood = Soldier.blood
        soldierHurt  = Soldier.hurt
        --moster1 effect
        if(monsterModel.monsterTab.monster1.currentMosterNum > 0) then
            soldierBlood = soldierBlood + result.monster.monster1.soldierBlood
            soldierHurt  =  soldierHurt + result.monster.monster1.soldierHurt
        end
        
        bd_txt = soldierBlood .. "/".. soldierBlood
    end
    
    ----添加血量文字
    local blood_txt = cc.Label:createWithTTF(bd_txt,"fonts/arial.ttf",10)
    blood_txt:setColor(cc.c3b(0,0,0))
    blood_txt:setPosition(x,y+30)
    layer:addChild(blood_txt,1,103)
    
    local soldier_model
    if(sprite)then   --moster
        soldier_model = soldierModel.create(layer,true,0,{},false,soldierBlood,soldierKey,false,soldierHurt,soldierBlood,type,speed,0)
        table.insert(soldierTab,soldier_model)
    else --soldier的type为0
        soldier_model = soldierModel.create(layer,true,0,{},false,soldierBlood,soldierKey,false,soldierHurt,soldierBlood,0,Soldier.speed,0)
        table.insert(soldierTab,soldier_model)      
    end 
	
  
    return layer
end

local function Noderun(var, userData)
    local node = userData.var
    local map  = userData.map
    
    if(node.moveNum< table.getn(node.path))then
        node.moveNum = node.moveNum +1; 
        
        --判断是否在巡逻半径内
        local currentItem = node.path[node.moveNum]
        local isInside = KUtil.isInside(soldierItem, currentItem, result.Soldier.moveRang, node.type)
        
        if isInside then 
            node.findCount = 0
            local point = coordinate.getPoint(map, node.path[node.moveNum])      
            node.layer:getChildByTag(101):runAction(cc.MoveTo:create(node.speed,
                cc.p(point.x, point.y+20)))
            node.layer:getChildByTag(102):runAction(cc.MoveTo:create(node.speed,
                cc.p(point.x, point.y+20)))
            node.layer:getChildByTag(103):runAction(cc.MoveTo:create(node.speed,
                cc.p(point.x, point.y+30)))
            node.layer:getChildByTag(100):runAction(cc.Sequence:create(
                cc.MoveTo:create(node.speed, point),cc.CallFunc:create(Noderun, userData)))
        else
            node.moveNum = 0;
            node.isPatrol = true
            node.findCount = node.findCount + 1
        end                           
    else   
        node.moveNum = 0;
        node.isPatrol = true
    end
end  

--更新小兵血量
function soldierLayer.updateBlood(tag)
    for key, soldier in ipairs(soldierTab) do
		if soldier.tag == tag then 
            local remaind = soldier.layer:getChildByTag(102)
            local txt = soldier.layer:getChildByTag(103) 
            
            remaind:setPercentage(math.floor(soldier.remaindBlood/soldier.blood*100))
            txt:setString(soldier.remaindBlood.. "/" .. soldier.blood)
		end
	end
end

--更新小兵血量
function soldierLayer.updateAllBlood()
    for key, soldier in ipairs(soldierTab) do

        local remaind = soldier.layer:getChildByTag(102)
        local txt = soldier.layer:getChildByTag(103)

        remaind:setPercentage(math.floor(soldier.remaindBlood/soldier.blood*100))
        txt:setString(soldier.remaindBlood.. "/" .. soldier.blood)
    end
end

function soldierLayer.deleteSoldier(tag)
    for key, soldier in ipairs(soldierTab) do
        if soldier.tag == tag then 
            local remaind = soldier.layer:getChildByTag(102)
            local txt = soldier.layer:getChildByTag(103) 

            remaind:setPercentage(math.floor(soldier.remaindBlood/soldier.blood*100))
            txt:setString(soldier.remaindBlood.. "/" .. soldier.blood)
        end
    end
end

----小兵移动--查岗
function soldierLayer.move(map)	        
       for key, var in ipairs(soldierTab) do        
           if(var.isPatrol)then
              var.moveNum = 0
              var.isPatrol  =  false   --防止小兵在运动是再次触发移动 
              local point = cc.p(var.layer:getChildByTag(100):getPositionX(),
                   var.layer:getChildByTag(100):getPositionY())  
                ---获取起点的item           
              local startItem = coordinate.getItem(map,point)
             
              --print("start: " .. startItem.x .. "  " ..startItem.y)
           
              --获取巡逻终点的item
              local ram = math.random(1,table.getn(result.SoldierPoint)) 
                       
              local endItem = result.SoldierPoint[ram]
              --多次为移动，移动回巢穴方向 
              if var.findCount >= 3 then endItem = soldierItem end

               --A_start寻路
              local result = A_start.findPath(startItem, endItem, map)
               ---路径查找到
              if(result ~= 0)then
                 var.path = {} --path{}先清零
                 table.insert(var.path,1, endItem) -- 插入终点
                 --位置数组
                 while(result.x)do
                    local item = {x =result.x, y=result.y}  
                    --print(item.x,item.y)                 
                    --table.insert(var.path ,  1 , coordinate.getPoint(map,item))
                    table.insert(var.path ,  1 , item)
                 
                    result=result.father
                 end 
                
                --防止回退到item中心
                 --var.path[1].x,var.path[1].y = var.layer:getChildByTag(100):getPosition()                                  
                 --节点移动
                 Noderun("", {var = var , map = map}) --“"只是为了满足函数调用   
               --路径 没找到
              else
                 var.isPatrol = true  --重新巡逻 
              end
            
      	   end
       end       
  	
end

return soldierLayer