
local updateMenu = class("updateMenu")

local timeSpace = 0;

----更新upMenu
function updateMenu.upMenu(menu)
   
    local money_txt   =  menu:getChildByTag(1)
    local time_txt    =  menu:getChildByTag(2)
    local warrior_txt =  menu:getChildByTag(3)
    local soldier_txt =  menu:getChildByTag(4)
    
    if(isExistWarrior)then
      timeSpace = timeSpace + 0.2
    end
    ---没有在规定时间内杀死勇士，游戏失败
    if(WarriorLifeTime <= 0)then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedulerId)
        gameResult = false
        local scene = require("ResultScene")
        local gameScene = scene.create()
        cc.Director:getInstance():replaceScene(gameScene)  
    else
        money_txt:setString(Money)
        soldier_txt:setString(table.getn(soldierTab))

        warrior_txt:setString(whichWarrior)
        
        if(timeSpace >= 1)then
            WarriorLifeTime = WarriorLifeTime - 1
            time_txt:setString(WarriorLifeTime)
            timeSpace = 0
        end
    end
    
end

local updateCD1 = 0
local updateCD2 = 0
local updateCD3 = 0

---更新左级菜单
function updateMenu.leftMenu(menu)

    local monster1   =  menu:getChildByTag(1)
    local monster2   =  menu:getChildByTag(2)
    local monster3   =  menu:getChildByTag(3)
    
    local monsterModel = require("src/model/monsterModel")
    
    --点亮怪兽1
    local monster1Time = menu:getChildByTag(11)
    local monster1Max  = menu:getChildByTag(12)
    monster1:setColor(cc.c3b(120,120,120))
    monster1Time:setVisible(false)
    monster1Max:setVisible(false)
    --max state
    if(monsterModel.monsterTab.monster1.currentMosterNum == monsterModel.monsterTab.monster1.maxNum)then
        monster1Max:setVisible(true)
    else
        if(Money >= result.monster.monster1.cost and monsterModel.monsterTab.monster1.cd <=0)then
            monster1:setColor(cc.c3b(255,255,255))
        else
            if( monsterModel.monsterTab.monster1.cd ~= 0)then
                monster1Time:setVisible(true)
                updateCD1 = updateCD1 + 0.2
                if(updateCD1 >=1 and monsterModel.monsterTab.monster1.cd>0) then
                    local cdTime = monsterModel.monsterTab.monster1.cd
                    monsterModel:downCD("monster1")
                    monster1Time:setString(""..cdTime)
                    updateCD1 =0
                end 
            end
        end
    end
    --点亮怪兽2
    local monster2Time = menu:getChildByTag(21)
    local monster2Max  = menu:getChildByTag(22)
    monster2:setColor(cc.c3b(120,120,120))
    monster2Time:setVisible(false)
    monster2Max:setVisible(false)
    --max state
    if(monsterModel.monsterTab.monster2.currentMosterNum == monsterModel.monsterTab.monster2.maxNum)then
        monster2Max:setVisible(true)
    else
        if(Money >= result.monster.monster2.cost and monsterModel.monsterTab.monster2.cd <=0)then
            monster2:setColor(cc.c3b(255,255,255))
        else
            if( monsterModel.monsterTab.monster2.cd ~= 0)then
                monster2Time:setVisible(true)
                updateCD2 = updateCD2 + 0.2
                if(updateCD2 >=1 and monsterModel.monsterTab.monster2.cd>0) then
                    local cdTime = monsterModel.monsterTab.monster2.cd
                    monsterModel:downCD("monster2")
                    monster2Time:setString(""..cdTime)
                    updateCD2 =0
                end 
            end
        end
    end
    
    
    --点亮怪兽3
    local monster3Time = menu:getChildByTag(31)
    local monster3Max  = menu:getChildByTag(32)
    monster3:setColor(cc.c3b(120,120,120))
    monster3Time:setVisible(false)
    monster3Max:setVisible(false)
    --max state
    if(monsterModel.monsterTab.monster3.currentMosterNum == monsterModel.monsterTab.monster3.maxNum)then
        monster3Max:setVisible(true)
    else
        if(Money >= result.monster.monster3.cost and monsterModel.monsterTab.monster3.cd <=0)then
            monster3:setColor(cc.c3b(255,255,255))
        else
            if( monsterModel.monsterTab.monster3.cd ~= 0)then
                monster3Time:setVisible(true)
                updateCD3 = updateCD3 + 0.2
                if(updateCD3 >=1 and monsterModel.monsterTab.monster3.cd>0) then
                    local cdTime = monsterModel.monsterTab.monster3.cd
                    monsterModel:downCD("monster3")
                    monster3Time:setString(""..cdTime)
                    updateCD3 =0
                end 
            end
        end
    end

    
    
   
end

return updateMenu
