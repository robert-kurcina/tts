--@auto-fold regex /^\s*function/
-- NOTICE! This code belongs to "Tumba". See non-minimized version fot more instructions and criterias for use.
objectType = "Tumba's Best Button"
objectVersion = 2
resetMemory = false
buttonMemory = {BoundObjectIds = {}}
boundObjects = { }
ignoreBindingCriteria = true
allowBinding = true
allowChangeDescription = true
exactVersion = false
showCollisionInfo = false
showBindMessage = true
ignoreSurface = true
buttonSize = 1100
scaleModifier = 0
waitForRestMax = 1000
isLoading = true
loadDelay = 50
wait = false
waitMax = 1000
ActionTimer = os.clock()
enableDoubleClick = true
doubleClickDelay = 0.2
isAltClick = false
isDoubleClick = false
clicks = 0
clickingPlayerName = nil
clickingPlayerColor = nil
clickingTime = nil
collisionInfo = nil
collisionIndex = 0
local waitId = nil
local waitForResultId = nil
----------------------------------------
-- Custom Global Variables Here...

----------------------------------------
-- Code Here...

function Actions()
    if isDoubleClick then
        resetButtonMemory()
        broadcastToAll(RGBToBracketedHex(stringColorToRGB("White")).."Button memory reset. Please save game to make the reset permanent.")
        return end
    if isAltClick then return end

    if #boundObjects > 0 then
        local object = boundObjects[1].Object
        local clonePosition = self.getPosition()
        local objectBoundaries = object.getBoundsNormalized()
        clonePosition.x = clonePosition.x + (objectBoundaries.size.x/2) + 1
        clonePosition.y = clonePosition.y + (objectBoundaries.size.y/2) + 1
        object.clone({position = clonePosition})
    else
        broadcastToAll(RGBToBracketedHex(stringColorToRGB("White")).."No object bound. Please bind an object first by droping this button on the object. ")
    end
    stopwait() end
----------------------------------------

function postActions()
end
----------------------------------------

function postBinding(boundObjectIndex,boundObject)
end
----------------------------------------

function postOnLoad(boundObjectIndex,boundObject)
end
----------------------------------------

function someCustonFunction()
end


---------------------------------------------------------------------------------------------------------
-- Do not change below this line!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Here there be dragons!!!!!!!!!!!!
----------------------------------------------------------------------------------------------------------

function onLoad(saved_button)
    if resetMemory then saved_button = "" end
    if saved_button ~= nil and saved_button ~= "" then buttonMemory = JSON.decode(saved_button)end
    pReBindObjects()
    scaleModifier = self.getScale()
    size = buttonSize * scaleModifier['x']
    self.createButton({ label="", click_function="buttonClick", function_owner=self, position={0,0.5,0}, height=size, width=size, color={0,0,0,0}})
    postOnLoad()
    Wait.time(function () isLoading=false end, loadDelay / 100) end

function onSave()
    if resetMemory then saved_button = "" else saved_button = JSON.encode(buttonMemory) end return saved_button end

function doBindAction()
    if collisionInfo.collision_object.tag == "Surface" and ignoreSurface == true then return end
    playTriggerEffect(1)
    if collisionInfo == nil then return end
    boundObjects[collisionIndex] = {}
    boundObjects[collisionIndex].Object = collisionInfo.collision_object
    buttonMemory.BoundObjectIds[collisionIndex] = collisionInfo.collision_object.getGUID()
    local ci = collisionIndex
    local bo = boundObjects[collisionIndex].Object

    if allowChangeDescription then
        local description = "Bound to:\n"
        local name = ""
        for index, boundObject in ipairs(boundObjects) do
            if boundObject.Object ~= nil then
                name =  boundObject.Object.getName() or ""
                if name == "" then name = boundObject.Object.getGUID() end
                description = description .. name .. " "
            end
        end
        self.setDescription(description)
    end

    if showBindMessage then
        if boundObjects[collisionIndex].BindMessage  ~= nil then broadcastToAll(boundObjects[collisionIndex].BindMessage, {1,1,1,1})
        else
            local name =  bo.getGUID()
            local tag = ""
            if bo.getName() ~= nil and  bo.getName() ~= "" then  name = bo.getName() end
            if bo.tag ~= nil then tag = bo.tag end
            broadcastToAll(RGBToBracketedHex(stringColorToRGB("White")).."Button is now bound to: " ..
            RGBToBracketedHex(stringColorToRGB("Yellow")).. tostring(tag) ..": " .. tostring(name or "Table") .. RGBToBracketedHex(stringColorToRGB("White")).."."  , {1,1,1,1})
        end
    end
    collisionInfo = nil
    collisionIndex = 0
    postBinding(ci, bo) end

function buttonClick(objButton, playerColor, alt_click)
    clickingPlayerName  = Player[playerColor].steam_name
    clickingPlayerColor = playerColor
    clickingTime = os.date("%H:%M:%S")
    isDoubleClick= false
    isAltClick = alt_click
    clicks = clicks + 1

    if enableDoubleClick then
        if waitId == nil then
        waitId = Wait.condition(
            function() waitId = nil; doPreAction() end,
            function() if clicks > 1 then return true else return false end end,
            doubleClickDelay,
            function() waitId = nil; doPreAction() end) end
    else doPreAction() end end

function doPreAction()
    if isLoading then
        broadcastToAll("Button is still Loading...", {1,1,1,1})
    else
        -- Check for errors
        if waitId ~= nil then Wait.stop(waitId); waitId = nil end
        local noErrors = true
        for index, boundObject in ipairs(boundObjects) do
            --Mandatory bound object missing
            if boundObject.Mandatory and boundObject.Object == nil then
                local nilMessage = "Missing binding at boundObject index: " .. index
                broadcastToAll(RGBToBracketedHex(stringColorToRGB("Red")) .. boundObject.MissingError or nilMessage, {1,1,1,1})
                noErrors = false
            end
            -- Bound object is still loading
            if boundObject.Object ~= nil then
                if boundObject.Object.getVar("isLoading") or false then
                    broadcastToAll(RGBToBracketedHex(stringColorToRGB("Red")) .. "Bound Object " .. (boundObject.Object.getName() or "") .. " is still Loading...", {1,1,1,1})
                    noErrors = false
                end
            end
        end

        if noErrors then
            if clicks == 2 then isDoubleClick= true end
            clicks = 0
            ActionTimer = os.clock()
            playTriggerEffect(0)
            waitForResult()
            Actions()
        end
    end end

function playTriggerEffect(indexEffext)
    local triggerEffects = self.AssetBundle.getTriggerEffects()
    if (#triggerEffects>=indexEffext) then self.AssetBundle.playTriggerEffect(indexEffext) end end

function onCollisionEnter(collision_info)
    if showCollisionInfo then ShowCollisionInfo(collision_info) end
    if not allowBinding then return end
    if ignoreBindingCriteria then setBoundObject(boundObjects[1],collision_info, 1) return end
    if  collision_info.collision_object.getVar("objectType") ~= nil
    and collision_info.collision_object.getVar("objectVersion") ~= nil
    then
        --binding using objectType and objectVersion and Tag
        for index, boundObject in ipairs(boundObjects) do
            if  (boundObject.ObjectTypeCriteria == collision_info.collision_object.getVar("objectType") or boundObject.ObjectTypeCriteria == "")
            and (boundObject.TagCriteria == collision_info.collision_object.tag or boundObject.TagCriteria == "")
            and not boundObject.IsLocked
            then
                if (boundObject.MinVersionCriteria == collision_info.collision_object.getVar("objectVersion") and exactVersion)
                or (boundObject.MinVersionCriteria <= collision_info.collision_object.getVar("objectVersion") and not exactVersion)
                then
                    if setBoundObject(boundObject,collision_info, index) then break end
                end
            end
        end
    else
    --binding using just Tag
        for index, boundObject in ipairs(boundObjects) do
            if  boundObject.ObjectTypeCriteria == nil
            and boundObject.MinVersionCriteria == nil
            and boundObject.TagCriteria ~= nil
            and boundObject.TagCriteria == collision_info.collision_object.tag
            and not boundObject.IsLocked
            then
                if setBoundObject(boundObject,collision_info, index) then break end
            end
        end
    end end

function setBoundObject(boundObject, collision_info, index)
    if boundObject == nil then boundObject={} end
    if (boundObject.Object ~= nil) and (boundObject.Object.getGUID() == collision_info.collision_object.getGUID()) then return false end
    if (boundObject.Object == nil) or (boundObject.Object.getGUID() ~= collision_info.collision_object.getGUID())
    then collisionInfo = collision_info;  collisionIndex = index return true end
    return false end

function onDropped(player_color)
    waitForRest() end

function waitForRest()
    if not allowBinding then return end
    Wait.condition(function() doBindAction() end, function() return self.resting end, waitForRestMax/100, function() doBindAction() end) end

function waitForResult()
    waitForResultId = Wait.condition(function() postActions() end, function() return not wait end, waitMax/100, function() postActions() end) end

function stopwait()
    wait = false end

function RGBToBracketedHex(rgb)
    if rgb ~= nil then return "[" .. string.format("%02x%02x%02x", rgb.r*255,rgb.g*255,rgb.b*255) .. "]" else return "" end end

function ShowElapsedTime(myTag)
    print(string.format(myTag .. ": Elapsed time: %.2f\n", os.clock() - ActionTimer))end

function pReBindObjects()
    for index, id in ipairs(buttonMemory.BoundObjectIds) do
        if id ~= nil then
            if boundObjects == nil then boundObjects = {} end
            if boundObjects[index] == nil then boundObjects[index] = {} end
            if boundObjects[index].Object == nil then boundObjects[index].Object ={} end
            boundObjects[index].Object = getObjectFromGUID(id)
        end end end

function ShowCollisionInfo(collision_info)
    print("CollisionInfo:" ..
        " objectType = " .. tostring(collision_info.collision_object.getVar("objectType"))..
        ", objectVersion = " .. tostring(collision_info.collision_object.getVar("objectVersion"))..
        ", tag = " .. tostring(collision_info.collision_object.tag)
        ) end

function resetButtonMemory()
    boundObjects = { }
    buttonMemory = {BoundObjectIds = {}}
    end