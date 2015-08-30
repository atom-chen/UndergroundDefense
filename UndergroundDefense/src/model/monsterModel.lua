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
    if(monsterType == "monster3")then
        monster.cd = result.monster.monster3.cd
    end
end

function monsterModel:downCD(monsterType)
    local monster = self.monsterTab[monsterType]   
    monster.cd = monster.cd - 1
end

--判断该小兵死亡是否取消monster的影响
function monsterModel:isDisappear(type)
    if(type == 1)then
        local monsterModel = require("src/model/monsterModel")
        monsterModel:killMoster("monster1")
        
        --增加魔将金币
        local moneyControl = require("src/util/money")
        moneyControl.addMoney("monster1")
        
        if(monsterModel.monsterTab.monster1.currentMosterNum == 0 )then
            for key, soldier in ipairs(soldierTab) do
                if(soldier.type == 0) then -- 消除魔将debuff，恢复小兵原攻击力
                    soldier.hurt = soldier.hurt - result.monster.monster1.soldierHurt
                    --soldier.remaindBlood = soldier.remaindBlood - result.monster.monster1.soldierBlood
                    --soldier.blood = soldier.blood - result.monster.monster1.soldierBlood
                end
            end         
            --soldierView.updateBlood()
        end
        
        return true
    end

    if( type == 2)then
        local monsterModel = require("src/model/monsterModel")
        monsterModel:killMoster("monster2")
        
        --增加魔将金币
        local moneyControl = require("src/util/money")
        moneyControl.addMoney("monster2")
        
        if(monsterModel.monsterTab.monster2.currentMosterNum == 0 )then
            for key, soldier in ipairs(warriorTab) do
                soldier.hurt = soldier.hurt + result.monster.monster2.enemysoldierHurt
                --soldier.remaindBlood = soldier.remaindBlood + result.monster.monster2.enemysoldierBlood
            end
        end
        
        return true
    end

    if( type == 3)then
        local monsterModel = require("src/model/monsterModel")
        monsterModel:killMoster("monster3")
        
        --增加魔将金币
        local moneyControl = require("src/util/money")
        moneyControl.addMoney("monster3")
        
        if(monsterModel.monsterTab.monster3.currentMosterNum == 0 )then
            Warrior_P[8] = Warrior_P[8] + result.monster.monster3.warriorHurt
            Warrior_P[2] = Warrior_P[2] + result.monster.monster3.warriorBlood
            Warrior_P[7] = Warrior_P[7] - result.monster.monster3.warriorSpeed      
        end
        
        return true
    end
    
    return false
end

function monsterModel:printData()
    for key, var in pairs(self.monsterTab) do 
        print(key.."    currentMosterNum :" ..var.currentMosterNum.."   maxNum:  "..var.maxNum .. "CD : ".. var.cd)
    end
end

return monsterModel
