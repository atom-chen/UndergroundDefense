

KUtil = {}

--显示提示的函数
function KUtil.showMessage(message, map)
    
    local layer = cc.Layer:create()

    ------引导文字
    local x = cc.Director:getInstance():getVisibleSize().width/2
    local y = cc.Director:getInstance():getVisibleSize().height/2

    local gameTip = cc.Label:createWithTTF(message, "fonts/menu_format.ttf", 25)
    gameTip:setPosition(x,y)
    --gameTip:setScale(0.1)
    layer:addChild(gameTip)

    local squenceAction = cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(
        function()
            map:removeChild(layer)
        end
    ))
    
    map:addChild(layer, 999, 999)
    gameTip:runAction(squenceAction)
end


function KUtil.getItem(map, point)
    local item={ x= math.floor(point.x/BlockWidth),y = math.floor((map:getContentSize().height-point.y)/BlockWidth)}  

    return item
end

function KUtil.getPoint(map,item)
    local lenght = BlockWidth / 2

    local point={x= item.x * BlockWidth + lenght , y= (MapY_Item- item.y -1) * BlockWidth + lenght }

    return cc.p(point.x,point.y)
end

--判断巡查是否超半径
function KUtil.isInside(startItem, endItem, moveRang)
	local distX = math.abs(startItem.x - endItem.x)
	local distY = math.abs(startItem.y - endItem.y)
	
	if distX <= moveRang and distY <= moveRang then return true end
	
	return false
end

return KUtil
