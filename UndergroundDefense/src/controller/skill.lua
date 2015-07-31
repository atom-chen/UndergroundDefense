
local skill = class("skill")

---施放技能
function skill.type()
    -- 根据血量判断施放杀害技能还是回血
    local blood_p = Warrior_P [2] / Warrior.blood * 100
    if(blood_p > 50)then --伤害技能
        return 1
    else
        return 2
    end
end

function skill.play(map,target)
--    local blood_p = Warrior_P [2] / Warrior.blood * 100 
--    if(blood_p > 50)then
--        --显示技能名
--        local skill_tip =  bloodTip.skill(Warrior_P[1]:getChildByTag(1000),"暴击  -"..Warrior.skill_type1 ,map,123)
--        map:addChild(skill_tip,0,123)
--
--        Boss_blood = Boss_blood - Warrior.skill_type1 ;
--        progress:setPercentage(math.floor(Boss_blood/Boss.blood*100))
--        txt:setString(Boss_blood.. "/" .. Boss.blood)
--    else
--        --显示技能名
--        local skill_tip =  bloodTip.skill(Warrior_P[1]:getChildByTag(1000),"治疗术 +".. Warrior.skill_type2,map,123)
--        map:addChild(skill_tip,0,123)
--        Warrior_P [2] = Warrior_P [2] + Warrior.skill_type2
--
--        local warriorLayer = map:getChildByTag(5000)
--        local blooding_ok =warriorLayer:getChildByTag(1002)
--        local blood_txtok =warriorLayer:getChildByTag(1003)
--        blooding_ok:setPercentage(math.floor(Warrior_P[2]/Warrior.blood*100))
--        blood_txtok:setString(Warrior_P[2].. "/" .. Warrior.blood)
--    end

end

return skill