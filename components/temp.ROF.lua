
circleConfig = {
  {
      name              = "Circle 1",
      color             = {0, 0.8, 0.4},  --RGB color of the circle
      radius            = 1,              --radius of the circle around the object
      steps             = 36,             --number of segments that make up the circle
      thickness         = 0.1,            --thickness of the circle line
      offsetHeight      = 3,              --vertical height of the circle relative to the object
  },
}

arcs_on = 0 --set flag for drawing arcs to OFF

function onLoad()
  for i,elm in ipairs(circleConfig) do
    self.addContextMenuItem(elm.name, function(argument) ArcDraw(i) end, false)
  end
end

--DRAW ARC FUNCTION
function ArcDraw(idno)
  if arcs_on == idno then
    self.setVectorLines()
    arcs_on = 0
  else
    drawCircle(circleConfig[idno])
  end
end

function getCircleVectorPoints(radius, steps, y)
    local tempTable = {}
    local delta = 360/steps
    local sin = math.sin
    local cos = math.cos
    local radians = math.rad

    for i = 0, steps do
      local x = cos(radians(delta * i)) * radius
      local z = sin(radians(delta * i)) * radius
        table.insert(tempTable, { x, y, z })
    end
    return tempTable
end

function drawCircle(circleData)
  local pointsCircle1 = getCircleVectorPoints(circleData.radius, circleData.steps, circleData.offsetHeight);
  boundObj.setVectorLines({
    {
      points = pointsCircle1,
      color = playerColor or circleData.color,
      thickness = circleData.thickness,
      rotation = {0.5, 0, 0},
    },
  })
end
