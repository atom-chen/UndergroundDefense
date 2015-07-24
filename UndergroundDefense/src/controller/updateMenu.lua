
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
    if(_WarriorLifeTime <= 0)then
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
            _WarriorLifeTime = _WarriorLifeTime - 1
            time_txt:setString(_WarriorLifeTime)
            timeSpace = 0
        end
    end
    
end


return updateMenu