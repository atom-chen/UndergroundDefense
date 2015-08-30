
local moneyControl = {}

--金币奖励
function moneyControl.addMoney(typeName)
    local awardMoney = result.money[typeName]
    Money = Money + awardMoney
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