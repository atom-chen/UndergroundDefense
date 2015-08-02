----定义节点类
local  node= class("node")
--创建节点,x,y是map的item
function node.create(x,y,map)
   local myNode={}
   -- 节点在tmx的位置
   myNode.x = x;
   myNode.y = y;
   ---A start参数
   myNode.g = 0;  --当前节点到起始点的代价
   myNode.h = 0;  --当前点的终点的估价
   myNode.f = 0;  --f=g+h
   myNode.moveable = tiled.getMoveable(map,cc.p(x,y))  --该节点是否可行走
   
   myNode.father={} -- 记录父节点,用来回溯路径  
   return myNode
end

return node