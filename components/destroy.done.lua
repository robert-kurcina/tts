function onLoad(saved_button)
  local buttonSize = 5000
  local scaleModifier = 0
  local buttonFontColor = {0,0,0,0}
  local buttonColor = {1,1,1,0}
  local buttonScale = {0.1,0.1,0.1}

    self.createButton({
      label           = "",
      click_function  = "buttonClick",
      function_owner  = self,
      position        = {0,0.5,0},
      height          = buttonSize,
      width           = buttonSize,
      font_size       = buttonSize/1.5,
      scale           = buttonScale,
      color           = buttonColor,
      font_color      = buttonFontColor,
      tooltip         = "Delete objects tagged 'Done'"
    })
end

function buttonClick()
  local objects = getAllObjects()
  local myGUID = self.getGUID()

  for i, obj in ipairs(objects) do
    if obj.type == 'Tile' and obj.guid != myGUID then
      local tags = obj.getTags()

      for i, tag in ipairs(tags) do
        if tag:lower() == 'done' then obj.destruct() end
      end
    end
  end
end
