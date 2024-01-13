--Runs on save to record save data
function onSave()
    saved_data = JSON.encode(highlightData)
    --saved_data = "" --Uncomment this line+save if you need to erase savedata
    return saved_data
end

--Runs on load
function onload(saved_data)
    --Loads info from memory
    if saved_data ~= "" then
        highlightData = JSON.decode(saved_data)
    else
        highlightData = {}
    end

    --Apply highlights from save data
    for guid, tint in pairs(highlightData) do
        local obj = getObjectFromGUID(guid)
        if obj ~= nil then
            obj.highlightOn(tint)
        else
            highlightData[guid] = nil
        end
    end

    Timer.create({
        identifier="MrHighlight_Unit_"..self.getGUID(),
        function_name="maintainHighlight", function_owner=self,
        delay=1, repetitions=0
    })
end

--Monitor tool's collisitions to add/remove highlight
function onCollisionEnter(collision_info)
    local obj = collision_info.collision_object
    if obj.getPosition().y > self.getPosition().y then
        if getHighlightToggle() then
            local selfTint = self.getColorTint()
            --Addd highlight and save to memory
            obj.highlightOn(selfTint)
            highlightData[obj.getGUID()] = {selfTint.r, selfTint.g, selfTint.b}
        else
            --Remove highlight and remove from memory
            obj.highlightOff()
            highlightData[obj.getGUID()] = nil
        end
    end
end

--Uses rotation to determine if tool is set to add or remove highlight
function getHighlightToggle()
    if self.getRotationValue() == "MrHighlight: [00ff00]Add[-]" then
        return true
    elseif self.getRotationValue() == "MrHighlight: [ff0000]Remove[-]" then
        return false
    else
        error("Rotation value name not found in getHighlightToggle.")
    end
end

--Reapplies a highlight if a unit went into a bag
function maintainHighlight()
    for guid, tint in pairs(highlightData) do
        local obj = getObjectFromGUID(guid)
        if obj ~= nil then
            obj.highlightOn(tint)
        end
    end
end

--Kills repeating timer if object is destroyed
function onDestroy()
    Timer.destroy("MrHighlight_Unit_"..self.getGUID())
end
