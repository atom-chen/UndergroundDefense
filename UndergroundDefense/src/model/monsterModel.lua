

local monsterModel = {}

monsterModel.monsterTab = {
    monster1 =  {currentMosterNum  = 0,  MaxNum  =  0 },  
    monster2 =  {currentMosterNum  = 0,  MaxNum  =  0 },  
    monster3 =  {currentMosterNum  = 0,  MaxNum  =  0 },  
}

function monsterModel:init()
    for key, var in pairs(self.monsterTab) do  --key =monster1
		var.currentMosterNum = 0
        var.MaxNum = result.monster.key.maxNum
	end
end

function monsterModel:addMoster(monsterType)
    local monster = self.monsterTab.monsterType
	if(monster.currentMosterNum >= monster.MaxNum)then return end
    monster.currentMosterNum = monster.currentMosterNum + 1
end

function monsterModel:killMoster(monsterType)
    local monster = self.monsterTab.monsterType
    if(monster.currentMosterNum <= 0)then return end
    monster.currentMosterNum = monster.currentMosterNum - 1
end

function monsterModel:printData()
    for key, var in pairs(self.monsterTab) do  --key =monster1
        print(key.."    currentMosterNum :" ..var.currentMosterNum.."   MaxNum:  "..var.MaxNum)
    end
end

return monsterModel

-- local monster = require("src/monsterModel")
--    monster:printData()
--    
--    monster:addMoster("monster1")
--    monster:addMoster("monster1")
--    monster:addMoster("monster1")
--    monster:addMoster("monster2")
--
--    monster:printData()