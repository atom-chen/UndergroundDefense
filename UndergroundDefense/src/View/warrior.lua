-----Warrior 的Layer
--
local A_start = require("src/util/A_start")
local coordinate = require("src/util/coordinate")

local WarriorLayer = class("WarriorLayer",function()
    return cc.Layer:create()
end)

function WarriorLayer.create(x,y,type)
--    local item ={ x=19,y=49 }
--    x = coordinate.getPoint(map,item).x
--    y = coordinate.getPoint(map,item).y
    
    local layer = WarriorLayer.new()
    --根据type生成智慧或勇猛型的勇士
    local warrior,action
    if(type==0) then
        warrior=cc.CSLoader:createNode("csb/pharaoh.csb")  --智慧型
        action = cc.CSLoader:createTimeline("csb/pharaoh.csb")--获取帧动画活动
    else
        warrior=cc.CSLoader:createNode("csb/captain_jack.csb")  --勇猛型
        action = cc.CSLoader:createTimeline("csb/captain_jack.csb")--获取帧动画活动
    end
    warrior:setScale(0.4)  
    warrior:setRotationSkewY(180)
    warrior:setPosition(x,y)
  
    action:gotoFrameAndPlay(0,60,true)--设置运行0-60fps,true为无线循环
    warrior:runAction(action)
    layer:addChild(warrior,0,1000)
    
    
    ------添加血条    
    local blood = cc.Sprite:create("monster_blood_frame.png")
    blood:setPosition(x,y+55)
    layer:addChild(blood,0,1001)
    
    local blooding = cc.Sprite:create("monster_blood.png")
    local progress1 = cc.ProgressTimer:create(blooding)
    progress1:setType(1)--设成横向
    progress1:setMidpoint(cc.p(0,0))
    progress1:setBarChangeRate(cc.p(1,0))--左往右
    progress1:setPercentage(100)--设置0%
    progress1:setPosition(x,y+55)   
    layer:addChild(progress1,0,1002)
    
    local bd_txt = Warrior.blood .. "/".. Warrior.blood
    ----添加血量文字
    local blood_txt = cc.Label:createWithTTF(bd_txt,"fonts/arial.ttf",10)
    
    blood_txt:setColor(cc.c3b(0,0,0))
    blood_txt:setPosition(x,y+65)

    layer:addChild(blood_txt,0,1003)
    
    ---剩余血量，类型,是否在运动,是否在攻击小兵
    Warrior_P={layer,Warrior.blood,type,false,false}
           
    return layer
end

---勇士移动
function WarriorLayer.move(map,targetItem)

    ---获取勇士对象
    local warriorLayer = map:getChildByTag(5000)
    
    local warrior = warriorLayer:getChildByTag(1000)
    
    local blood =warriorLayer:getChildByTag(1001)
    local blooding =warriorLayer:getChildByTag(1002)
    local blood_txt =warriorLayer:getChildByTag(1003)
    
    local point = cc.p(warrior:getPositionX(),warrior:getPositionY()) 
    ---获取起点的item           
    local startItem = coordinate.getItem(map,point)
        
    local endItem 
    if(targetItem)then
       endItem = targetItem
    else
        if(WarriorType == 0 and birthplace_blood >0)then
            endItem = {x = 5, y = 57}
        else
            endItem = {x = 10, y = 17}
        end 
    end  
    
    --A_start寻路
    local result = A_start.findPath(startItem,endItem,map)
    
    --路径查找到
    if(result ~= 0)then
        Warrior_P[4] = true --表示勇士运动
        
        local path = {} 
        local actionNum = 0 ;
        table.insert(path,1,coordinate.getPoint(map,endItem)) -- 插入终点
        --位置数组
        while(result.x)do
            local item = {x =result.x, y=result.y}  
            table.insert(path,1,coordinate.getPoint(map,item))
            result=result.father
        end
        
        --防止回退到item中心
        path[1].x,path[1].y = warrior:getPosition()
        
        print("要移动步数 。。 :  ".. table.getn(path))
        
        local function Noderun(node ,path )
        	if(actionNum < table.getn(path))then
                actionNum = actionNum + 1
                blood:runAction(cc.MoveTo:create(_warriorSpeed,cc.p(path[actionNum].x,path[actionNum].y+55)))
                blooding:runAction(cc.MoveTo:create(_warriorSpeed,cc.p(path[actionNum].x,path[actionNum].y+55)))
                blood_txt:runAction(cc.MoveTo:create(_warriorSpeed,cc.p(path[actionNum].x,path[actionNum].y+65)))
                local action =cc.Sequence:create(cc.MoveTo:create(_warriorSpeed,path[actionNum]),
                    cc.CallFunc:create(Noderun,path))
                action:setTag(1010)
                warrior:runAction(action)
                --第一个参数是回调的方法，第二个参数可以是开发者自定义的table
        	end
        end                          
        --节点移动
        Noderun("",path) --“ff"只是为了满足函数调用          
    end
    

end  
return WarriorLayer