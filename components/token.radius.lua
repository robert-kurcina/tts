
circleConfig = {
  {
      name              = "Circle",
      color             = {0.8, 0.0, 0.0},  --RGB color of the circle
      radius            = 5,              --radius of the circle around the object
      steps             = 36,             --number of segments that make up the circle
      thickness         = 0.5,            --thickness of the circle line
      offsetHeight      = 0.0,              --vertical height of the circle relative to the object
  },
}

arcs_on = 0 --set flag for drawing arcs to OFF

function onLoad()
  for i,elm in ipairs(circleConfig) do
    self.addContextMenuItem(elm.name, function(argument) ArcDraw(i) end, false)
  end

  local myscale = self.getScale()
  arc_scale = myscale.x --get x scale
end

--DRAW ARC FUNCTION
function ArcDraw(idno)
  if arcs_on == idno then
    self.setVectorLines()
    arcs_on = 0
  else
    drawCircle(circleConfig[idno])
    arcs_on = idno
  end
end

function getCircleVectorPoints(radius, steps, y, factor)
    local tempTable = {}
    local delta = 360/steps
    local sin = math.sin
    local cos = math.cos
    local radians = math.rad

    for i = 0, steps do
      local x = cos(radians(delta * i)) * radius * factor
      local z = sin(radians(delta * i)) * radius/factor
        table.insert(tempTable, { x, y, z })
    end
    return tempTable
end

function drawCircle(circleData)

  local pointsCircle0 = getCircleVectorPoints(circleData.radius - 0.2, circleData.steps, circleData.offsetHeight, 1);
  local pointsCircle1 = getCircleVectorPoints(circleData.radius, circleData.steps, circleData.offsetHeight + 0.1, 1);
  local pointsCircle2 = getCircleVectorPoints(circleData.radius/2, circleData.steps, circleData.offsetHeight, 2);
  self.setVectorLines({
    {
      points = pointsCircle0,
      color = { 0.5, 0, 0},
      thickness = circleData.thickness*2,
      rotation = {0, 0, 0},
    },
    {
      points = pointsCircle1,
      color = circleData.color,
      thickness = circleData.thickness,
      rotation = {0, 0, 0},
    },
    {
      points = pointsCircle2,
      color = circleData.color,
      thickness = circleData.thickness/2,
      rotation = {90, 0, 0},
    },
    {
      points = pointsCircle2,
      color = circleData.color,
      thickness = circleData.thickness/2,
      rotation = {90, 90, 0},
    },
  })
end
