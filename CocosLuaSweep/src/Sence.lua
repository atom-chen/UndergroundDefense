

--图片资源矩阵
local width,height=32,32

local Scree_width,Scree_height

local remainder --剩余方块数

--cc.rect(x, y, width, height)-
local pic_tab={
    bg=cc.rect(0, 0, width, height),
    flag=cc.rect(2*width, 0,width, height),
    blank=cc.rect(4*width, 0, width, height),
    num_1=cc.rect(5*width, 0, width, height),
    num_2=cc.rect(0, height, width, height),
    num_3=cc.rect(width, height, width, height),
    num_4=cc.rect(2*width, height, width, height),
    num_5=cc.rect(3*width, height, width, height),
    num_6=cc.rect(4*width, height, width, height),
    num_7=cc.rect(5*width, height, width, height),
    num_8=cc.rect(0, 2*height, width, height),
    mine=cc.rect(width, 2*height, width, height)
}

local mine_tab={}--地雷位置

local map={}--地图，-1代表地雷


---取整函数--向下取整
local function getIntPart(x)
    return math.floor(x)--向下取整
end

---求item位置
local function getItem(x,y)
    return getIntPart((y-88)/height)*10 + getIntPart(x/width)
end

---检查table是否存在某个value
local function isExist(tab,value)
    if(table.getn(tab)==0)then
        return false
    else
        for key, var in ipairs(tab) do
            if(var==value)then
                return true
            end
        end
        return false
    end
end


---随机地雷位置
local function Create_mine()
    mine_tab={};-- 每次先清除

    local ram;
    math.randomseed(os.time())---
    for i=0,10 do
        while(true)do
            ram=math.random(0,99)  --0<=n<=99

            if(not isExist(mine_tab,ram))then

                table.insert(mine_tab,ram)
                break
            end
        end
    end
end


---计算item的周围的地雷数
local function inMap(item)
    local total=0;
    --顺时针计算，上开始
    if(item<90)then
        if(isExist(mine_tab,item+10))then
            total=total+1;
        end
    end
    --右上
    if(item<90)then
        if(math.mod(item,10)~=9)then
            if(isExist(mine_tab,item+11))then
                total=total+1;
            end
        end
    end
    --右
    if(math.mod(item,10)~=9)then
        if(isExist(mine_tab,item+1))then
            total=total+1;
        end
    end
    --右下
    if(item>9 )then
        if(math.mod(item,10)~=9)then
            if(isExist(mine_tab,item-9))then
                total=total+1;
            end
        end
    end
    --下
    if(item>9)then
        if(isExist(mine_tab,item-10))then
            total=total+1;
        end
    end
    --左下
    if(item>9)then
        if( math.mod(item,10)~=0)then
            if(isExist(mine_tab,item-11))then
                total=total+1;
            end
        end
    end
    --左
    if(math.mod(item,10)~=0)then
        if(isExist(mine_tab,item-1))then
            total=total+1;
        end
    end
    --左上r
    if(item<90)then
        if(math.mod(item,10)~=0)then
            if(isExist(mine_tab,item+9))then
                total=total+1;
            end
        end
    end

    return total;
end


----地图map,-1代表地雷
local function Calculate_mine()
    map={};
    for i=0,99 do
        if(isExist(mine_tab,i))then
            table.insert(map,-1)
        else
            table.insert(map,inMap(i))--计算周围地雷数
        end
    end

    for key, var in ipairs(map) do
        print(key,var)
   end

end

local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)

function GameScene.create()
    local scene = GameScene.new()
    scene:addChild(scene:creatMap())
    scene:addChild(scene:creatBg())
    return scene
end

function GameScene:ctor()

    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    --获取屏幕宽高
    Scree_height=self.visibleSize.height
    Scree_width=self.visibleSize.width

    ---生成雷的位置
    Create_mine();

    Calculate_mine();
    
    remainder=100 --初始化剩余方块数100
    
end


function GameScene:creatMap()

    local layerMap = cc.Layer:create()
    -- create dog animate
    local picture = cc.Director:getInstance():getTextureCache():addImage("sweep.png")

    local my_num;

    for i = 0, 9 do
        for j = 0, 9 do
            local spriteLand
            my_num=i*10+j+1;

            if(map[my_num]==-1)then
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.mine)
            elseif (map[my_num]==0)then
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.blank)
            elseif (map[my_num]==1)then
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.num_1)
            elseif (map[my_num]==2)then
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.num_2)
            elseif (map[my_num]==3)then
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.num_3)
            elseif (map[my_num]==4)then
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.num_4)
            elseif (map[my_num]==5)then
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.num_5)
            elseif (map[my_num]==6)then
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.num_6)
            elseif (map[my_num]==7)then
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.num_7)
            else
                spriteLand = cc.Sprite:create("sweep.png",pic_tab.num_8)
            end
            spriteLand:setAnchorPoint(0,1)
            spriteLand:setPosition(j*width,120+i*height)
            layerMap:addChild(spriteLand)
        end

    end
   
    return layerMap
end


--判断是否是白块
local function isBlank(my_item)
    if(map[my_item]==0)then
        return true

    else
        return false
    end
end


---点击到空白快
local function bit_white(target,item)
    local blank_tab={};
    table.insert(blank_tab,item)
    local i=1;
    --print("--------------------bit----------".. item)
    while(blank_tab[i])do
        local ok=blank_tab[i]
        i=i+1
        if(map[ok+1]==0) then  -- 是白块1
            --上
            --print("----now item is".. ok)
            if(ok<90)then
                if(not isExist(blank_tab,ok+10))then
                   table.insert(blank_tab,ok+10) 
                  -- print("up: "..(ok+10))  ;              
                end
            end
            
            --右
            if(math.mod(ok,10)~=9)then              
                if(not isExist(blank_tab,ok+1))then
                    table.insert(blank_tab,ok+1)
                     --print("right: "..(ok+1))  ; 
                end
            end
            --下
            if(ok>9)then              
               if(not isExist(blank_tab,ok-10))then
                    table.insert(blank_tab,ok-10)
                     --print("down: ".. (ok-10))  ; 
               end
            end
            --左2
            if(math.mod(ok,10)~=0)then              
                if(not isExist(blank_tab,ok-1))then
                    table.insert(blank_tab,ok-1)
                    --print("left :"..(ok-1))  ; 
                end
            end
        end       
    end

    local child=nil

    for key, var in ipairs(blank_tab) do
        --print(key,var)
        child=target:getChildByTag(var);
        if(child)then
           target:removeChild(child,true)
           remainder=remainder-1;
        end
        child=nil
        --target:removeChildByTag(var,true)
    end
    
    --print("剩余块： ".. remainder)

end



---点击事件
local function onTouchBegan(touch, event)

    local location = touch:getLocation()
    local target=event:getCurrentTarget()

    --print(touchBeginPoint.x,touchBeginPoint.y)
    ---计算点击的方块的item
    local bit_item=getItem(location.x,location.y)

    if(map[bit_item+1]==-1)then--游戏结束5
        --target:getParent():addChild(target:getParent():defeat_Result())
        cc.UserDefault:getInstance():setBoolForKey("result", false)
        local scene = require("ResultScene")
        local resultScene = scene.create()
        cc.Director:getInstance():replaceScene(resultScene)
    end
    --点击到数字
    if(map[bit_item+1]>0)then
        target:removeChildByTag(bit_item,true)--根据tag移除
        remainder=remainder-1
        print("剩余块： ".. remainder)
    end
    --点到空白
    if(map[bit_item+1]==0)then
        bit_white(target,bit_item)
        --print("item "..bit_item  .."   is blank")
    end

    -----11个地雷，当剩下11时胜利
    if(remainder<=11)then
       cc.UserDefault:getInstance():setBoolForKey("result", true)
       local scene = require("ResultScene")
       local resultScene = scene.create()
       cc.Director:getInstance():replaceScene(resultScene)
    --target:removeFromParent(true);移除了整个layer
    end
    return false --不触发move和end1
end


function GameScene:creatBg()

    local layerBg = cc.Layer:create()
    local my_num;

    for i = 0, 9 do
        for j = 0, 9 do
            local spriteLand = cc.Sprite:create("sweep.png",pic_tab.bg)

            spriteLand:setAnchorPoint(0,1)
            spriteLand:setPosition(j*width,120+i*height)
            layerBg:addChild(spriteLand,1,i*10+j)--添加tag
        end

    end
    ----注册监听
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    local eventDispatcher = layerBg:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layerBg)
    return layerBg
end



return GameScene
