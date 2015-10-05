
local gameTip = require("src/view/gameTip")

local moneyControl = {}

--金币奖励,bug会触发多次
function moneyControl.addMoney(typeName, node, map)
    local awardMoney = result.money[typeName]
    local currentMoney = Money
    
    Money = Money + awardMoney
    
    local layerMap = map:getParent()
    if currentMoney < result.monster["monster1"].cost and Money >= result.monster["monster1"].cost then
        require("src/view/menu/scaleMap").showMessage("金币数已够召唤魔将1", layerMap)
        return
    end
    
    if currentMoney < result.monster["monster2"].cost and Money >= result.monster["monster2"].cost then
        require("src/view/menu/scaleMap").showMessage("金币数已够召唤魔将2", layerMap)
        return
    end
   
    if currentMoney < result.monster["monster3"].cost and Money >= result.monster["monster3"].cost then
        require("src/view/menu/scaleMap").showMessage("金币数已够召唤魔将3", layerMap)
    end
       
--    local nodeKey  = 999
--    local moneyTip =  gameTip.awardMoney(node, "+ ".. awardMoney , map, nodeKey)
--    map:addChild(moneyTip, 0, nodeKey) 
    
end

--金币减少
function moneyControl.costMoney(typeName)
    local costMoney = result.monster[typeName].cost
    Money = Money - costMoney
end

function moneyControl.getCurrentMoney()
	return Money
end

return moneyControl