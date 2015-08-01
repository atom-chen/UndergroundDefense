--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : enemySoldier.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年8月1日 下午11:13:27
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************


local A_start = require("src/util/A_start")
local coordinate = require("src/util/coordinate")
local soldierModel = require("src/model/soldierModel")

local enemySoldierLayer = class("enemySoldierLayer",function()
    return cc.Layer:create()
end)

function enemySoldierLayer.create(x,y)

    local layer = enemySoldierLayer.new()

    local soldier = cc.Sprite:create("res/enemy.png")
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

    local bd_txt = result.enemySoldier.blood .. "/".. result.enemySoldier.blood
    
    ----添加血量文字
    local blood_txt = cc.Label:createWithTTF(bd_txt,"fonts/arial.ttf",10)
    blood_txt:setColor(cc.c3b(0,0,0))
    blood_txt:setPosition(x,y+30)
    layer:addChild(blood_txt,1,103)
    
    local soldier_model  = soldierModel.create(layer,true,0,{},false,result.enemySoldier.blood,soldierKey,false,false,result.enemySoldier.hurt,result.enemySoldier.blood)
    table.insert(warriorTab,soldier_model)

    return layer
end

local function Noderun(var,node)
    if(node.moveNum< table.getn(node.path))then
        node.moveNum = node.moveNum +1 ;       
        node.layer:getChildByTag(101):runAction(cc.MoveTo:create(Soldier.speed,
            cc.p(node.path[node.moveNum].x,node.path[node.moveNum].y+20)))
        node.layer:getChildByTag(102):runAction(cc.MoveTo:create(Soldier.speed,
            cc.p(node.path[node.moveNum].x,node.path[node.moveNum].y+20)))
        node.layer:getChildByTag(103):runAction(cc.MoveTo:create(Soldier.speed,
            cc.p(node.path[node.moveNum].x,node.path[node.moveNum].y+30)))
        node.layer:getChildByTag(100):runAction(cc.Sequence:create(
            cc.MoveTo:create(Soldier.speed,node.path[node.moveNum]),cc.CallFunc:create(Noderun,node)))                                --第一个参数是回调的方法，第二个参数可以是开发者自定义的table
    else   
        node.moveNum = 0;
        node.isPatrol = true
    end
end   

function enemySoldierLayer.move(map)  

    for key, var in ipairs(warriorTab) do
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

            --print("end : ".. endItem.x,endItem.y)
            --A_start寻路
            local result = A_start.findPath(startItem,endItem,map)
            ---路径查找到
            if(result ~= 0)then
                var.path = {} --path{}先清零
                table.insert(var.path,1,coordinate.getPoint(map,endItem)) -- 插入终点
                --位置数组
                while(result.x)do
                    local item = {x =result.x, y=result.y}  

                    --print(item.x,item.y)                 
                    table.insert(var.path ,  1 , coordinate.getPoint(map,item))

                    result=result.father
                end 

                --防止回退到item中心
                var.path[1].x,var.path[1].y = var.layer:getChildByTag(100):getPosition()  

                --节点移动
                Noderun("",var) --“"只是为了满足函数调用   

                --路径 没找到
            else
                var.isPatrol = true  --重新巡逻 
            end

        end
    end       

end

return enemySoldierLayer