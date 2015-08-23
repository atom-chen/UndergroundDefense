
----获取tmx的Tiled的属性

local tiled = class("tiled")


--获取指定point的tiled块能否行走，point是左上角为cc.p(0,0)，point为tmx的坐标
function tiled.getMoveable(map , point)
    --获取地图的layer
    local layerBg = map:getLayer("layerMap")

    local gid=layerBg:getTileGIDAt(point)
       
    if(gid == 34)then   ---- gid为34的图块才能走
        return true
    end
    return false
end


-----把cocos2d坐标转化为map地图对应的item
function tiled.getItem(map,point)
    
    local point={math.floor(point.x/32),math.floor((map:getContentSize().height-point.y)/32)}  
    return point
end

return tiled