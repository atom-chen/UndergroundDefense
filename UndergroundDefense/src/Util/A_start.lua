----A start寻路算法

local  A_start= class("A_start")

local node = require("src/model/node")

local cost_stargiht =1 ; --直线移动花费

local cost_diag=1.414; --对角线移动花费

local MapY = 59 --地图y坐标最大值

local MapX = 89 --地图x坐标最大值
  
local _open = {}; --代考察表

local _close = {}; --以考察表

--计算某点的估值函数，可以多种实现
local function  calculateH(point,endPoint)
	----计算两个点的距离
	local x = math.floor(endPoint.x - point.x)  --获取该点x到终点x的距离
    local y = math.floor(endPoint.y - point.y)  --获取该点y到终点y的距离
	local dis =math.abs(x)+math.abs(y)
	--local dis = math.sqrt(math.pow(x,2)+math.pow(y,2))	
	return dis
end

---判断某点是否在close表内
local function isClose(point)
	for key, var in ipairs(_close) do
		if(var.x == point.x and var.y == point.y )then
		   return true
		end
	end
	
	return false
end

---判断某点是否在open表内
local function isOpen(point)
    for key, var in ipairs(_open) do
        if(var.x == point.x and var.y == point.y )then
           return true
        end
    end
    
    return false
end

---寻路住逻辑，startPoint起始点，endPoint为终点，map为地图
function A_start.findPath(startPoint, endPoint, map)
   
  _open = {}; --初始化

  _close = {}; --初始化
    
  --起始点
  local point = node.create(startPoint.x,startPoint.y,map)
  point.g = 0  
  point.h = calculateH(point,endPoint)
  point.f = point.g + point.h
   
  --当前节点不等于终点
  while(not(point.x == endPoint.x and point.y == endPoint.y))do  
        ----获取其上下左右四点
        local around={}
        if(point.y > 0)then --上
            table.insert(around,node.create(point.x,point.y-1,map))
        end
        if(point.y < MapY)then --下
            table.insert(around,node.create(point.x,point.y+1,map))
        end
        if(point.x > 0)then --左
            table.insert(around,node.create(point.x-1,point.y,map))
        end
        if(point.x < MapX)then --右
            table.insert(around,node.create(point.x+1,point.y,map))
        end
             
        --检查周围点
        for key, var in pairs(around) do
            
            --如果不可行走或已在close表，忽略此点
        	if(isClose(var) or (not var.moveable))then
        	     --print("忽略该点" .. var.x .. "  " .. var.y)       	
        	else
        	     --计算此点的代价
                 local g = cost_stargiht+ point.g    -- G值等同于上一步的G值 + 从上一步到这里的成本          
                 local h = calculateH(var,endPoint)
                 local f = g + h
                  --该点不在open列表内
                 if(not isOpen(var))then
                    var.g = g;
                    var.h = h;
                    var.f = f
                    var.father = point --指向父节点
                    table.insert(_open,var) -- 添加到open表
                  
                    --如果在open表，进行f比较
                 else
                      for key1, var1 in ipairs(_open) do
                  	       if(var1.x == var.x and var1.y == var.y)then 
                               --if(var1.f>f)then---两个版本，// 检查G值还是F值
                              if(var1.g>g)then
                  	               var1.f = f
                  	               var1.g = g
                  	               var1.h = h
                  	               var1.parent = point 
                  	           end
                  	           break
                  	       end
                      end
                  end
        	 end
         end
        
        ----当前节点找完一遍添加到——close表
        table.insert(_close,point)
        --open为空，则查找失败
        if(table.getn(_open)== 0)then
           return 0 ---查找失败返回0
        end

        ---从open表去除最小的f点,并从open表移除
        local max=99999
        local myKey
        for key2, var2 in ipairs(_open) do
        	if(var2.f<max)then
        	    max = var2.f
        	    myKey = key2
        	end
        end
        --从_open表移除并取出最小f的点最为起始点
        point = table.remove(_open,myKey)   
            
   end
   return point.father; -- 返回路径
end
return A_start