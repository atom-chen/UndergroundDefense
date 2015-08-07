
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

---更新左级菜单
function updateMenu.leftMenu(menu)

    local monster1   =  menu:getChildByTag(1)
    local monster2   =  menu:getChildByTag(2)
    local monster3   =  menu:getChildByTag(3)
    
    --点亮怪兽1
    if(Money >= result.monster.monster1.cost)then
        monster1:setColor(cc.c3b(255,255,255))
    else
        monster1:setColor(cc.c3b(120,120,120))
    end
    
    --点亮怪兽2
    if(Money >= result.monster.monster2.cost)then
        monster2:setColor(cc.c3b(255,255,255))
    else
        monster2:setColor(cc.c3b(120,120,120))
    end
    
    
    --点亮怪兽3
    if(Money >= result.monster.monster3.cost)then
        monster3:setColor(cc.c3b(255,255,255))
    else
        monster3:setColor(cc.c3b(120,120,120))
    end
    
    
   
end

return updateMenu