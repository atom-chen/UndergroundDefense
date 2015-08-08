--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : monsterModel.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年8月8日 下午10:29:25
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************


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

function monsterModel:flushCD(monsterType)
    local monster = self.monsterTab[monsterType]
    if(monsterType == "monster1")then
        monster.cd = result.monster.monster1.cd
    end
    if(monsterType == "monster2")then
        monster.cd = result.monster.monster2.cd
    end
    if(monsterType == "monster2")then
        monster.cd = result.monster.monster2.cd
    end
end

function monsterModel:downCD(monsterType)
    local monster = self.monsterTab[monsterType]
    if(monsterType == "monster1")then
        monster.cd = monster.cd - 1
    end
    if(monsterType == "monster2")then
        monster.cd = monster.cd - 1
    end
    if(monsterType == "monster2")then
        monster.cd = monster.cd - 1
    end
end

function monsterModel:printData()
    for key, var in pairs(self.monsterTab) do 
        print(key.."    currentMosterNum :" ..var.currentMosterNum.."   maxNum:  "..var.maxNum .. "CD : ".. var.cd)
    end
end

return monsterModel
