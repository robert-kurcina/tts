function onLoad()
  self.addContextMenuItem("45° Arc", function(argument) drawArc(45, 4, 1) end, false)
  self.addContextMenuItem("120° Arc in 2", function(argument) drawArc(120, 4, 2) end, false)
  self.addContextMenuItem("180° Arc in 4", function(argument) drawArc(180, 4, 4) end, false)
  self.addContextMenuItem("360° Arc in 6", function(argument) drawArc(360, 4, 6) end, false)
  self.addContextMenuItem("via Tooltip", function(argument) drawArc() end, false)
  self.addContextMenuItem("<< Clear >>", function(argument) self.setVectorLines() end, false)

  local myscale = self.getScale()
end

function drawArc(givenArc, givenRadius, givenSectors)
    local description = self.getDescription()
    local ars = split(description, '([^ ]+)')
    local arc = math.abs(givenArc or ars[1] or 45)
    local radius = math.abs(givenRadius or ars[2] or 4)
    local sectors = math.abs(givenSectors or ars[3] or 1)

    self.setDescription(arc .. ' ' .. radius .. ' ' .. sectors)
    self.setVectorLines(
        getArcPoints(arc, radius, sectors)
    )
end

function split(str, regex)
  local t = {}
  for x in string.gmatch(str, regex) do
      table.insert(t, x or 1)
  end

  return t
end

function getArcPoints(arc, radius, sectors)
  local radians = arc * math.pi / 180
  local offsetRadians = -(math.pi - radians)/2
  local numPoints = 36
  local offsetY = 0.05
  local actualArcLength = radians/sectors
  local radians_step = actualArcLength/numPoints
  local scale = self.getScale()
  local totalPoints = {}

  for s = 1, sectors, 1 do
    local start_radians = actualArcLength * (s - 1) - offsetRadians
    local points = {}

    points[1] = {0, offsetY, 0}

    for i = 1, numPoints + 1, 1 do
      local angle = start_radians + (i - 1) * radians_step
      local x = radius * Grid.sizeX * math.cos(angle)/scale.x
      local z = radius * Grid.sizeY * math.sin(angle)/scale.z
      local y = offsetY

      points[i + 1] = {x, y, z}
    end

    local sector = {
      points = points,
      thickness = 0.1,
      color = self.getColorTint(),
      loop = true
    }

    totalPoints[s] = sector
  end

  return totalPoints
end
