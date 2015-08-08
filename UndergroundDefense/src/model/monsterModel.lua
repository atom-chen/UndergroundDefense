
local monsterModel = {}

monsterModel.monsterTab = {
    monster1 =  {currentMosterNum  = 0,  maxNum  =  0,   cd = 0},  
    monster2 =  {currentMosterNum  = 0,  maxNum  =  0,   cd = 0},  
    monster3 =  {currentMosterNum  = 0,  maxNum  =  0,   cd = 0},  
}

function monsterModel:init()
    for key, var in pairs(self.monsterTab) do  --key =monster1
        print(key)
		var.currentMosterNum = 0		
        var.maxNum = result.monster[key].maxNum
        var.cd = result.monster[key].cd
	end
end

function monsterModel:addMoster(monsterType)
    local monster = self.monsterTab[monsterType] --使用[]接受变量，.表示字符串
	if(monster.currentMosterNum >= monster.maxNum)then return end
    monster.currentMosterNum = monster.currentMosterNum + 1
end

function monsterModel:killMoster(monsterType)
    local monster = self.monsterTab[monsterType]
    if(monster.currentMosterNum <= 0)then return end
    monster.currentMosterNum = monster.currentMosterNum - 1
end

function monsterModel:printData()
    for key, var in pairs(self.monsterTab) do 
        print(key.."    currentMosterNum :" ..var.currentMosterNum.."   maxNum:  "..var.maxNum)
    end
end

return monsterModel
