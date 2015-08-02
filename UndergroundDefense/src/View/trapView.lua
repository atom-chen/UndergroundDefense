--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : trapView.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年8月2日 下午11:16:16
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************


local  trapView= class("trapView",function()
    return cc.Layer:create()
end)

local function randomPosition(map)
	local item_x = math.random(1,88)
	local item_y = math.random(1,58)
	
    print(item_x,item_y)
	local item ={ x = item_x ,y = item_y}	
    local point = require("src/util/coordinate").getPoint(map,item)
    
    return point
end

function trapView.create(map)

    local layer = trapView.new()
    
    for key, var in ipairs(trapTab) do
        local point = randomPosition(map)
        print(point.x,point.y)
        var.sprite:setPosition(point)
        layer:addChild(var.sprite,0,var.tag)
    end

    return layer
end

return trapView