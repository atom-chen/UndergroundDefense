
----cocos坐标和tmx的item转换

local  coordinate = class("coordinate")

-----把cocos2d坐标转化为map地图对应的item
function coordinate.getItem(map,point)
    local point={ x= math.floor(point.x/BlockWidth),y = math.floor((map:getContentSize().height-point.y)/BlockWidth)}  
    
    return point
end

function coordinate.getPoint(map,item)
    local lenght = BlockWidth / 2

    local point={x= item.x * BlockWidth + lenght , y= (MapY_Item- item.y -1) * BlockWidth + lenght }
    
    return cc.p(point.x,point.y)
end

return coordinate