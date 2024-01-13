
function onLoad()
  self.addContextMenuItem(" Radius via Tooltip", function(argument) drawCircle() end, false)
  self.addContextMenuItem(" Box via Tooltip", function(argument) drawBox() end, false)
  self.addContextMenuItem(" Half-box", function(argument) drawHalfBox(2) end, false)
  self.addContextMenuItem(" Quarter-box", function(argument) drawHalfBox(4) end, false)
  self.addContextMenuItem(" Eighth-box", function(argument) drawHalfBox(8) end, false)
  self.addContextMenuItem("<< Clear >>", function(argument) self.setVectorLines() end, false)
end

--DRAW ARC FUNCTION
function drawCircle()
  local radius = self.getDescription()
  local circlePoints = getCirclePoints(radius)
  self.setVectorLines(circlePoints)
end

function drawBox()
  local size = self.getDescription()
  local boxPoints = getBoxPoints(size)
  self.setVectorLines(boxPoints)
end

function drawHalfBox(divisor)
  local size = self.getDescription()
  local boxPoints = getHalfBoxPoints(size, divisor)
  self.setVectorLines(boxPoints)
end

function getHalfBoxPoints(givenSize, givenDivisor)
  local gridFactor = (Grid.sizeX + Grid.sizeY)/2
  local gridSizeX = givenSize * gridFactor
  local gridSizeY = givenSize * gridFactor
  local offsetZ = 0.2
  local x = gridSizeX or Grid.sizeX
  local y = gridSizeY or x
  local colorTint = self.getColorTint() or { 1,0,0 }

  local result = {
    {
        points    = { {x/givenDivisor,offsetZ,y}, {x/givenDivisor,offsetZ,-y}, {0,offsetZ,-y}, {0,offsetZ,y}, {x/givenDivisor,offsetZ,y} },
        color     = colorTint,
        thickness = 0.1,
    },
  }

  return result
end

function getBoxPoints(givenSize)
  local gridFactor = (Grid.sizeX + Grid.sizeY)/2
  local gridSizeX = givenSize * gridFactor
  local gridSizeY = givenSize * gridFactor
  local offsetZ = 0.2
  local x = gridSizeX or Grid.sizeX
  local y = gridSizeY or x
  local colorTint = self.getColorTint() or { 1,0,0 }

  local result = {
    {
        points    = { {x,offsetZ,y}, {x,offsetZ,-y}, {-x,offsetZ,-y}, {-x,offsetZ,y}, {x,offsetZ,y} },
        color     = colorTint,
        thickness = 0.1,
    },
  }

  return result
end

function getCirclePoints(givenRadius)
  local steps = 36
  local z = 0.2
  local gridFactor = (Grid.sizeX + Grid.sizeY)/2
  local tempTable = {}
  local resultTable = {}
  local colorTint = self.getColorTint() or { 1,0,0 }

  local delta = 360/steps
  local sin = math.sin
  local cos = math.cos
  local radians = math.rad
  local radius = givenRadius * gridFactor

  for i = 0, steps do
    local x = cos(radians(delta * i)) * radius
    local y = sin(radians(delta * i)) * radius
      table.insert(tempTable, { x, z, y })
  end

  table.insert(resultTable, {
    points = tempTable,
    color = self.getColorTint(),
    thickness = 0.1,
    rotation = {0, 90, 0},
  })

  return resultTable
end
