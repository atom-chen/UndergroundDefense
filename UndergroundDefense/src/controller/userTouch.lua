
local A_start=require("src/util/A_start")

local warriorView = require("src/view/role/warrior")

local userTouch = class("userTouch")


----点击改变图块类型
--
function userTouch.bitBlock(layerBg, point,mapPointX,mapPointY, map)
    ---求出是地图哪一个点cc.p()

    local bit_point={}    
    bit_point.x= point.x - mapPointX;
    bit_point.y= point.y - mapPointY
    local item = tiled.getItem(map,bit_point)
    
    local gid = layerBg:getTileGIDAt(cc.p(item[1],item[2])) --获取点击方块的gid
    
    print("gid: ".. gid,"pointX: ".. point.x)
    if(gid ~= 34 )then
        if(gid == 15)then --变为可走路线
            layerBg:setTileGID(34,cc.p(item[1],item[2])) --设置为可行走图块
           
            --没解锁一块砖，加钱
            Money = Money + result.money.block_money
            
            --每次点击更新勇士的寻路路径    
            ---获取勇士对象
            if(isExistWarrior )then

                local warriorLayer = map:getChildByTag(5000)

                local warrior = warriorLayer:getChildByTag(1000)

                local blood =warriorLayer:getChildByTag(1001)
                local blooding =warriorLayer:getChildByTag(1002)
                local blood_txt =warriorLayer:getChildByTag(1003)

                -- print("stop actions")
                blood:stopAllActions()
                blooding:stopAllActions()
                blood_txt:stopAllActions()
                warrior:stopActionByTag(1010);

                Warrior_P[4] = false

                warriorView.move(map)
            end
        else
            layerBg:setTileGID(15,cc.p(item[1],item[2])) 
        end 
    end
    
    --layerBg:removeTileAt(cc.p(item[1],item[2])) --删除原来的图块

end

return userTouch