boundObj = nil

isDetach = false
isAttach = false
frame_count = 0

storedSides = 0
storedRadius = 0
storedColorTintSelf = nil
storedColorTintBound = nil

isKOd = false
isEliminated = false

function onLoad()
  self.addContextMenuItem("<< Detach >>", function(argument) detachModel() end, false)
end

function onCollisionEnter(collision_info)
    local obj = collision_info.collision_object
    local type = collision_info.collision_object.type
    local tags = obj.getTags()

    outputTags(tags, obj, type)
end

function onUpdate()
  if isDetach == false and isAttach == false then return end

  frame_count = frame_count + 1

  if frame_count >= 30 then
      self.setVectorLines()
      frame_count = 0
      isDetach = false
      isAttach = false
  end
end

function outputTags(tags, obj, type)
 for i, tag in pairs(tags) do
   handleTags(tag, obj)
 end
end

function handleTags(tag, obj)
  if tag:upper() ~= "MODEL" then return end
  if boundObj != nil then return end

  attachModel(obj)
end

function getJointedGUID()
  local boundGUID = nil
  local jointsInfo = self.getJoints()

  if jointsInfo == nil then return end
  if jointsInfo[1] == nil then return end

  for k, v in pairs(jointsInfo[1]) do
      if k == 'joint_object_guid' then boundGUID = v end
  end

  return boundGUID
end

function attachModel(object)
  if object == nil then return end
  if isDetach == true then return end

  local objectGUID = object.getGUID()
  local objectJointedGUID = nil
  local hasFunc = object.getVar('nogo')

  if hasFunc != nil then return end

  object.jointTo(self, {
    ["type"]        = "Fixed",
    ["collision"]   = false,
    ["break_force"]  = nil,
    ["break_torgue"] = nil,
  })

  boundObj = object
  frame_count = 0
  isAttach = true
  drawCircles(1, {0, 1, 0}, 0.25)

  setTargetScript(object, self)
  boundObj.call("createContext", {})
end

function detachModel(targetObj)
  local boundGUID = getJointedGUID()
  local boundGUIDObj = getObjectFromGUID(boundGUID)

  unmarkKOd()

  if boundObj != nil then
    boundObj.jointTo(nil, {
      ["type"]        = "Fixed",
      ["collision"]   = true,
      ["break_force"]  = 1000.0,
      ["break_torgue"] = 1000.0,
    })

    boundObj.setLuaScript([[]])
    boundObj.reload()
  end

  if boundGUIDObj != nil then
    boundGUIDObj.jointTo(nil, {
      ["type"]        = "Fixed",
      ["collision"]   = true,
      ["break_force"]  = 1000.0,
      ["break_torgue"] = 1000.0,
    })

    boundGUIDObj.setLuaScript([[]])
    boundGUIDObj.reload()
  end

  self.jointTo(nil, {
    ["type"]        = "Fixed",
    ["collision"]   = true,
    ["break_force"]  = 1000.0,
    ["break_torgue"] = 1000.0,
  })

  frame_count = 0
  isDetach = true
  drawCircles(1, {1, 0, 0}, 0.25)
  boundObj = nil

  -- self.destruct()
end

function drawCircles(givenRadius, givenColor, givenThickness)
  local originalSize = 50

  local myScale = self.getScale()
  local gridFactor = (Grid.sizeX + Grid.sizeY)/2
  local scaleFactor = (myScale[1] + myScale[3])/2

  local diameter = originalSize/25.4
  local desiredRadius = givenRadius*gridFactor/scaleFactor + diameter/2
  local thickness = (givenThickness or 0.2)/scaleFactor

  local color = givenColor or self.getColorTint()
  local steps = getStoredSides()
  local circlePoints = getCirclePoints(desiredRadius, color, thickness, steps)
  self.setVectorLines(circlePoints)

  storedRadius = desiredRadius
end

function getStoredSides()
  if storedSides == 0 then return 36 end
  return math.max(4, storedSides)
end

function getStoredRadius()
  if storedRadius == 0 then return 16 end
  return math.max(1, storedRadius)
end

function getCirclePoints(givenRadius, givenColor, givenThickness, givenSteps)
  local sin = math.sin
  local cos = math.cos
  local radians = math.rad

  local steps = givenSteps or 36
  local gridFactor = (Grid.sizeX + Grid.sizeY)/2
  local delta = 360/steps
  local radius = givenRadius * gridFactor
  local adjust = getRotationAdjustment(steps)
  local colorTint = givenColor or self.getColorTint()

  local tempTable = {}
  local resultTable = {}

  local z = 0.2
  for i = 0, steps do
    local x = cos(radians(delta * i) - adjust) * radius
    local y = sin(radians(delta * i) - adjust) * radius

    table.insert(tempTable, { x, z, y })
  end

  table.insert(resultTable, {
    points = tempTable,
    color = givenColor or self.getColorTint(),
    thickness = givenThickness or 0.25,
    rotation = {0, 0, 0},
  })

  return resultTable
end

function getRotationAdjustment(givenSides)
  if givenSides == 2 then return 0
  else return math.pi/givenSides end
end

function getSectorPoints(givenRadius, givenColor, givenThickness, givenSteps)
  local sin = math.sin
  local cos = math.cos
  local radians = math.rad

  local steps = givenSteps or 36
  local gridFactor = (Grid.sizeX + Grid.sizeY)/2
  local delta = 360/steps
  local radius = givenRadius * gridFactor
  local adjust = getRotationAdjustment(steps)
  local colorTint = givenColor or self.getColorTint()

  local tempTable = {}
  local resultTable = {}

  local z = 0.2
  for i = 0, steps do
    local x1 = cos(radians(delta * i) - adjust) * radius
    local y1 = sin(radians(delta * i) - adjust) * radius

    local x2 = cos(radians(delta * i) - adjust - math.pi) * radius
    local y2 = sin(radians(delta * i) - adjust - math.pi) * radius

    table.insert(tempTable, {
      points = {{ x1, z, y1 }, { x2, z, y2 }},
      color = givenColor or self.getColorTint(),
      thickness = givenThickness or 0.25,
      rotation = {0, 0, 0},
    })
  end

  return tempTable
end


function mergeTables(t1, t2)
  for k,v in ipairs(t2) do
    table.insert(t1, v)
  end

  return t1
end

function drawSectors(givenSides, givenColor, givenThickness)
  local myScale = self.getScale()
  local scaleFactor = (myScale[1] + myScale[3])/2

  local desiredRadius = getStoredRadius()
  local thickness = (givenThickness or 0.1)/scaleFactor
  local color = givenColor or self.getColorTint()

  local steps = getStoredSides()
  local sectorPoints = getSectorPoints(desiredRadius, color, thickness, givenSides)
  local circlePoints = getCirclePoints(desiredRadius, color, thickness, steps)
  local sectors = mergeTables(sectorPoints, circlePoints)
  self.setVectorLines(sectors)

  storedSides = givenSides
end

function clearVectors()
  self.setVectorLines()
  storedSides = 0
  storedRadius = 0
end

function markKOd(isKnockedOut)
  if storedColorTintSelf == nil then storedColorTintSelf = self.getColorTint() end
  if storedColorTintBound == nil then storedColorTintBound = boundObj.getColorTint() end

  local tooltipText = "KO'd"
  local labelText = "\u{2620}"
  local font_color = { 1, 0, 0 }
  local color_tint = { 0, 0, 0, 0.5 }

  if isKnockedOut == true then
    font_color = { 1, 1, 0 }
    color_tint = { 1, 0, 0, 0.5 }
    labelText = "\u{2623}"
  end

  local params = {
    click_function = "onLoad",
    function_owner = self,
    color = { 1, 0, 0 },
    font_color = font_color,
    label = labelText,
    tooltip = tooltipText,
    position = {x = 0, y = 0.2, z = 0.2},
    width = 0,
    height = 0,
    font_size = 1000
  }

  boundObj.createButton(params)
  boundObj.setColorTint(color_tint)
  boundObj.highlightOn({ 0.5, 0.5, 0.5 })

  self.highlightOn({ 0.5, 0.5, 0.5 })
  self.setColorTint({ 0, 0, 0, 0.55 })
end

function makeEliminated()
  if isKOd == true then isKOd = false unmarkKOd() end
  if isEliminated == true then isEliminated = false unmarkKOd() else isEliminated = true markKOd(false) end
end

function makeKOd()
  if isEliminated == true then isEliminated = false unmarkKOd() end
  if isKOd == true then isKOd = false unmarkKOd() else isKOd = true markKOd(true) end
end

function unmarkKOd()
  if boundObj.getButtons() != nil then boundObj.removeButton(0) end
  if storedColorTintBound != nil then boundObj.setColorTint(storedColorTintBound) end
  if storedColorTintSelf != nil then self.setColorTint(storedColorTintSelf) end

  boundObj.highlightOff({ 0, 0, 0 })
  self.highlightOff({ 0, 0, 0 })
end

function p_drawCircles(params)
  drawCircles(params.arg)
end

function p_drawSectors(params)
  drawSectors(params.arg)
end

function p_makeKOd(params)
  makeKOd(params.arg)
end

function p_makeEliminated(params)
  makeEliminated(params.arg)
end

function p_clearVectors(params)
  clearVectors()
end

function p_detachModel(params)
  detachModel(params.arg)
end

function setTargetScript(obj, parentObj)
  local injectScript =
  [[
    frame_count = 0
    nogo = false

    function onLoad()
      createContext()
    end

    function getJointedGUID()
      local boundGUID = nil
      local jointsInfo = self.getJoints()

      if jointsInfo == nil then return end
      if jointsInfo[1] == nil then return end

      for k, v in pairs(jointsInfo[1]) do
          if k == 'joint_object_guid' then boundGUID = v end
      end

      return boundGUID
    end

    function createContext()
      self.clearContextMenu()
      self.addContextMenuItem("Cohesion 4 MU", function(argument) invokeParent('drawCircles', 4) end, false)
      self.addContextMenuItem("Cohesion 3 MU", function(argument) invokeParent('drawCircles', 3) end, false)
      self.addContextMenuItem("Cohesion 2 MU", function(argument) invokeParent('drawCircles', 2) end, false)
      self.addContextMenuItem("Cohesion 1 MU", function(argument) invokeParent('drawCircles', 1) end, false)

      self.addContextMenuItem("2-sectors", function(argument) invokeParent('drawSectors', 2) end, false)
      self.addContextMenuItem("4-sectors", function(argument) invokeParent('drawSectors', 4) end, false)
      self.addContextMenuItem("6-sectors", function(argument) invokeParent('drawSectors', 6) end, false)

      self.addContextMenuItem(" KO'd", function(argument) invokeParent('makeKOd', true) end, false)
      self.addContextMenuItem(" Eliminate", function(argument) invokeParent('makeEliminated', false) end, false)

      self.addContextMenuItem("<< Clear >>", function() invokeParent('clearVectors', nil) end, false)
      self.addContextMenuItem("<< Detach >>", function(argument) invokeParent('detachModel', self) end, false)
    end

    function invokeParent(funcName, arg)
      local boundGUID = getJointedGUID()

      if boundGUID == nil then return end
      local parentObj = getObjectFromGUID(boundGUID)

      parentObj.call('p_' .. funcName, { arg = arg })
    end

  ]]

  obj.setLuaScript(injectScript)
end
