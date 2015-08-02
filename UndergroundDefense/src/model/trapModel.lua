--  ********************************************************************
--  Copyright(c) KingSoft
--  FileName    : trapModel.lua
--  Creator     : HuangZhiLong
--  Date        : 2015年8月2日 下午11:20:52
--  Contact     : huangzhilong1@kingsoft.com
--  Comment     :
--  *********************************************************************


local traprModel = class(
    "traprModel"
)

function traprModel.create(sprite,tag,type)
    local myTrap    = {}

    myTrap.sprite        = sprite         

    myTrap.tag           = tag            

    myTrap.type          = type
    
    return myTrap
end

return traprModel
