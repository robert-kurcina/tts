-- [[ DRAW Rays and Concentric circles around object to divide battlefield for use with MEST Tactics Aggression Goal ]]

--[[ The onLoad event is called after the game save finishes loading. --]]
function onLoad()
  self.addContextMenuItem("Lines  2x2", function(argument) drawLines(1, 2, 2) end, false)
  self.addContextMenuItem("Lines  2x3", function(argument) drawLines(1, 2, 3) end, false)
  self.addContextMenuItem("Lines  3x3", function(argument) drawLines(1, 3, 3) end, false)
  self.addContextMenuItem("Lines  3x4", function(argument) drawLines(1, 3, 4) end, false)
  self.addContextMenuItem("Lines  4x4", function(argument) drawLines(1, 4, 4) end, false)
  self.addContextMenuItem("Lines  5x4", function(argument) drawLines(2, 4, 5) end, false)
  self.addContextMenuItem("Lines  6x4", function(argument) drawLines(2, 4, 6) end, false)
  self.addContextMenuItem("Lines  7x4", function(argument) drawLines(3, 4, 7) end, false)
  self.addContextMenuItem("Lines  8x4", function(argument) drawLines(2, 4, 8) end, false)
  self.addContextMenuItem("Lines 12x4", function(argument) drawLines(4, 4, 12) end, false)
end

function drawLines(idno, sizeX, sizeY)
  local boxPoints = getBoxPoints(sizeX, sizeY)
  self.setVectorLines(boxPoints)
end

function getBoxPoints(sizeY, sizeX)
  local gridCellsPerUnitSize = 6
  local gridSizeX = sizeX * Grid.sizeX * gridCellsPerUnitSize
  local gridSizeY = sizeY * Grid.sizeY * gridCellsPerUnitSize
  local offsetZ = 0.2
  local x = gridSizeX or Grid.sizeX * 48
  local y = gridSizeY or x
  local colorTint = self.getColorTint() or { 1,0,0 }

  local result = {
      {
          points    = { {x,offsetZ,y}, {-x,offsetZ,-y} },
          color     = colorTint,
          thickness = 0.1,
      },
      {
          points    = { {x,offsetZ,-y}, {-x,offsetZ,y} },
          color     = colorTint,
          thickness = 0.1,
      },
      {
          points    = { {x,offsetZ,0}, {-x,offsetZ,0} },
          color     = colorTint,
          thickness = 0.1,
      },
      {
          points    = { {0,offsetZ,y}, {0,offsetZ,-y} },
          color     = colorTint,
          thickness = 0.1,
      },
      {
          points    = { {x,offsetZ,y}, {x,offsetZ,-y}, {-x,offsetZ,-y}, {-x,offsetZ,y}, {x,offsetZ,y} },
          color     = colorTint,
          thickness = 0.5,
      },
  }

  return result
end
