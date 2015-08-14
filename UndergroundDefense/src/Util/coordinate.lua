
----cocos坐标和tmx的item转换

local  coordinate = class("coordinate")

-----把cocos2d坐标转化为map地图对应的item
function coordinate.getItem(map,point)
    local point={ x= math.floor(point.x/32),y = math.floor((map:getContentSize().height-point.y)/32)}  
    
    return point
end

function coordinate.getPoint(map,item)
    local point={x= item.x*32 + 16 , y= (60-item.y-1)*32 + 16 }
    
    return cc.p(point.x,point.y)
end

return coordinate