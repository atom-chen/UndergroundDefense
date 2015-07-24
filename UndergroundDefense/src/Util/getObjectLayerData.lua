
----获取tmx对象层属性

local object = class("object")

function object.getPoint(map ,layerName , propertyName)
    --获取对象层layer的name属性
    local objectLayer=map:getObjectGroup(layerName)
    
    if(objectLayer)then
       local point=objectLayer:getObject(propertyName)
       return point   
    end
end

return object