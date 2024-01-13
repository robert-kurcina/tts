function onLoad()
  self.addContextMenuItem(" 8 3 3 Red", function(argument) updateDimensions(8,3,3,'Red') end, false)
  self.addContextMenuItem(" 8 3 0.5 Orange", function(argument) updateDimensions(8,3,0.5, 'Orange') end, false)
  self.addContextMenuItem(" via Tooltip", function(argument) updateDimensions() end, false)
end

function split(str, regex)
  local t = {}
  for x in string.gmatch(str, regex) do
      table.insert(t, x or 1)
  end

  return t
end

function getDependentObject()
  local joints = self.getJoints()
  local foundObj = nil

  for k, v in pairs(joints[1]) do
      if k == 'joint_object_guid' then
        local obj = getObjectFromGUID(v)
        local tags = obj.getTags()
          for j, m in pairs(tags) do
            if m == 'objDependent' then
              foundObj = obj
            end
          end
      end
  end

  return foundObj
end

function updateDimensions(givenL, givenW, givenH, givenColor)
  local joinedObj = getDependentObject()
  local description = self.getDescription()
  local lwhc = split(description, '([^ +]+)')
  local alpha = 0.75

  local length = lwhc[1] or 1
  local width = lwhc[2] or 1
  local height = lwhc[3] or 1
  local color = lwhc[4] or 'Red'

  if givenL then length = givenL end
  if givenW then width = givenW end
  if givenH then height = givenH end
  if givenColor then color = givenColor end

  joinedObj.setScale({width, height, width})
  joinedObj.setColorTint(color)
  local jc = joinedObj.getColorTint()
  joinedObj.setColorTint({ jc.r, jc.g, jc.b, alpha})

  self.setScale({width, height, length - width/2})
  self.setColorTint(color)
  local sc = joinedObj.getColorTint()
  self.setColorTint({ sc.r, sc.g, sc.b, alpha})
end
