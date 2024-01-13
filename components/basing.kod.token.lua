function onCollisionEnter(collision_info)
    local obj = collision_info.collision_object
    local type = collision_info.collision_object.type
    local tags = obj.getTags()

    outputTags(tags, obj, type)
end

function outputTags(tags, obj, type)
 for i, tag in pairs(tags) do
   handleTags(tag, obj)
 end
end

function handleTags(tag, obj)
  if tag:upper() ~= "MODEL" then return end

  alterModel(obj)
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

function alterModel(object)
  if object == nil then return end
  if isDetach == true then return end

  local objectGUID = object.getGUID()
  local objectJointedGUID = nil
  local hasFunc = object.getVar('nogo')

  if hasFunc != nil then object.reload() end

  setTargetScript(object, self)
  object.call("createContext", {})
end

function setTargetScript(obj, parentObj)
  local injectScript =
  [[
    frame_count = 0
    nogo = false

    isDetach = false
    isAttach = false
    frame_count = 0

    storedSides = 6
    storedRadius = 4
    storedColorTintSelf = nil

    isKOd = false
    isEliminated = false

    function onLoad()
      createContext()
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
      self.addContextMenuItem("Cohesion 4 MU", function(argument) drawCircles(4) end, false)
      self.addContextMenuItem("Cohesion 3 MU", function(argument) drawCircles(3) end, false)
      self.addContextMenuItem("Cohesion 2 MU", function(argument) drawCircles(2) end, false)
      self.addContextMenuItem("Cohesion 1 MU", function(argument) drawCircles(1) end, false)

      self.addContextMenuItem("2-sectors", function(argument) drawSectors(2) end, false)
      self.addContextMenuItem("4-sectors", function(argument) drawSectors(4) end, false)
      self.addContextMenuItem("6-sectors", function(argument) drawSectors(6) end, false)

      self.addContextMenuItem(" KO'd", function(argument) makeKOd() end, false)
      self.addContextMenuItem(" Eliminate", function(argument) makeEliminated() end, false)

      self.addContextMenuItem("<< Clear >>", function() clearVectors() end, false)
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

      self.createButton(params)
      self.setColorTint(color_tint)
      self.highlightOn({ 0.5, 0.5, 0.5 })

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
      if self.getButtons() != nil then self.removeButton(0) end
      if storedColorTintSelf != nil then self.setColorTint(storedColorTintSelf) end

      self.highlightOff({ 0, 0, 0 })
      self.highlightOff({ 0, 0, 0 })
    end

  ]]

  obj.setLuaScript(injectScript)
end
