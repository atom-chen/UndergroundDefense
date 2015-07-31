local character = class(
    "character"
)

function character:ctor()

    self.layer         = nil   --表示物体视图
    
    self.isPatrol      = nil   --一次目标点巡逻是否完成
    
    self.moveNum       = nil   --表示移动的次数
    
    self.path          = {}    --表示移动的路径
    
    self.isStop        = nil   --是否停止巡逻（攻击敌方）
    
    self.remaindBlood  = nil   --剩余血量
    
    self.tag           = nil   --view的tag
    
    self.isBeaten      = nil   --是否遭受攻击
    
    self.isBit         = nil   --是否在攻击状态
    
    self.hurt          = nil   --攻击伤害值
    
    self.blood         = nil   --总血量
end

function character.create(owner)
    local currentNode = character.new()

    currentNode._parent = owner
    currentNode:init()

    return currentNode
end

function character:init()
    local mainNode = cc.CSLoader:createNode("res/UI/layout_.csb")
    self._mainLayout = mainNode

    self:autoHandler()
end

return character
    