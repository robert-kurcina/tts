isKOd = false
storedColorTint = { 0, 0, 0 }

function onLoad()
  self.addContextMenuItem(" KO'd", function(argument) checkKOd() end, false)
end

function checkKOd()
  if isKOd == true then unmarkKOd() return end
  markKOd()
end

function markKOd()
  storedColorTint = self.getColorTint()

  local height = self.getBoundsNormalized().size.y or 1
  local scale = self.getScale().y or 1
  local offset_y = 0.5 * height/scale

  local params = {
    click_function = "onLoad",
    function_owner = self,
    color = { 1, 0, 0 },
    font_color = { 1, 0, 0 },
    label = "\u{2620}",
    tooltip = "KO'd",
    position = {x = 0, y = offset_y, z = 0},
    width = 0,
    height = 0,
    font_size = 1000
  }

  self.createButton(params)
  self.setColorTint({ 0, 0, 0, 0.55 })
  self.highlightOn({ 0.5, 0.5, 0.5 })

  self.locked = true

  isKOd = true
end

function unmarkKOd()
  self.removeButton(0)
  self.setColorTint(storedColorTint)
  self.highlightOff({ 0, 0, 0 })

  self.locked = false

  isKOd = false
end
