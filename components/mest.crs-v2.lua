
--MEST Character Record
--
--derived FROM Mr. Tumba
--USE as follows;
--  1. Alter the values on the card
--  2. Get a figurine as assign a 'MODEL' tag to it
--  3. Touch the card with the figurine; it will receive a tooltip with the stats from the card
--  4. Click the checkboxes at the top-left of the card to locate the figurine anywhere during game-play

--Set this to true while editing and false when you have finished
disableSave = false
--Remember to set this to false once you are done making changes
--Then, after you save & apply it, save your game too

--Color information for button text (r,g,b, values of 0-1)
buttonFontColor = {0,0,0}
textFontColor = {0.1,0.1,0.1,100}


--Color information for button background
buttonColor = {1,1,1}
textBoxColor = {0,0,0,0}

--Change scale of button (Avoid changing if possible)
buttonScale = {0.1,0.1,0.1}
textScale = {0.1,0.1,0.1}

memo = ""
spawnedButtonCount = 0
spawnedInputCount = 0
boundObj = nil
playerColor = nil
storedData = {}
showCircles = false
showArc = false

circleConfig = {
  color             = {0, 0.8, 0.4},  --RGB color of the circle
  radius            = 1,              --radius of the circle around the object
  steps             = 36,             --number of segments that make up the circle
  thickness         = 0.1,            --thickness of the circle line
  offsetHeight      = 3,              --vertical height of the circle relative to the object
}

arcConfig = {
  color             = {0, 0.8, 0.4},
  steps             = 25,
  thickness         = 0.1,
  heightFactor      = 10
}

--This is the button placement information
defaultButtonData = {
    --Add checkboxes
    checkbox = {
        --[[
        pos   = the position (pasted from the helper tool)
        size  = height/width/font_size for checkbox
        state = default starting value for checkbox (true = checked, false = not)
        font_color = color of font
        color = color of background
        charTrue = the unicode character to show when checked, defaults to 10008 which is "X".
        ]]
      --toggleCircle to locate bound object
      {
        funcName  = "toggleCircle",
        pos       = {-1.3,0.2,-0.85},
        size      = 750,
        state     = false,
        charTrue  = 9632
      },
      {
        funcName  = "toggleArc",
        pos       = {-1.3,0.2,-0.65},
        size      = 750,
        state     = false,
        charTrue  = 9632
      },
      {
        funcName  = "togglePlayerColor",
        pos       = {-1.3,0.2,-0.45},
        size      = 750,
        state     = false,
        color     = circleConfig.color,
        charTrue  = 32
      }
        --End of checkboxes
    },
    --Add counters that have a + and - button
    counter = {
        --[[
        pos    = the position (pasted from the helper tool)
        size   = height/width/font_size for counter
        value  = default starting value for counter
        hideBG = if background of counter is hidden (true = hidden, false = not)
        font_color = color of font
        color = color of background
        ]]

        --End of counters
    },
    --Add editable text boxes
    textbox = {
        --[[
        pos       = the position (pasted from the helper tool)
        rows      = how many lines of text you want for this box
        width     = how wide the text box is
        font_size = size of text. This and "rows" effect overall height
        label     = what is shown when there is no text. "" = nothing
        value     = text entered into box. "" = nothing
        alignment = Number to indicate how you want text aligned
                    (1 = Automatic, 2 = Left, 3 = Center, 4 = Right, 5 = Justified)
        ]]
        --CCA
        {
            attr      = "CCA",
            pos       = {-1.05,0.2,-0.17},
            rows      = 1,
            width     = 1000,
            font_size = 800,
            label     = "",
            value     = "2",
            alignment = 3,
            validation = 2,
            scale  = {0.15,0.15, 0.15}
        },
        --RCA
        {
            attr      = "RCA",
            pos       = {-0.78,0.2,0.-0.17},
            rows      = 1,
            width     = 1000,
            font_size = 800,
            label     = "",
            value     = "2",
            alignment = 3,
            validation = 2,
            scale  = {0.15,0.15, 0.15}
        },
        --REF
        {
            attr      = "REF",
            pos       = {-0.52,0.2,-0.17},
            rows      = 1,
            width     = 1000,
            font_size = 800,
            label     = "",
            value     = "2",
            alignment = 3,
            validation = 2,
            scale  = {0.15,0.15, 0.15}
        },
        --INT
        {
            attr      = "INT",
            pos       = {-0.26,0.2,-0.17},
            rows      = 1,
            width     = 1000,
            font_size = 800,
            label     = "",
            value     = "2",
            alignment = 3,
            validation = 2,
            scale  = {0.15,0.15, 0.15}
        },
        --POW
        {
            attr      = "POW",
            pos       = {0.00,0.2,-0.17},
            rows      = 1,
            width     = 1000,
            font_size = 800,
            label     = "",
            value     = "2",
            alignment = 3,
            validation = 2,
            scale  = {0.15,0.15, 0.15}
        },
        --STR
        {
            attr      = "STR",
            pos       = {0.26,0.2,-0.17},
            rows      = 1,
            width     = 1000,
            font_size = 800,
            label     = "",
            value     = "2",
            alignment = 3,
            validation = 2,
            scale  = {0.15,0.15, 0.15}
        },
        --FOR
        {
            attr      = "FOR",
            pos       = {0.52,0.2,-0.17},
            rows      = 1,
            width     = 1000,
            font_size = 800,
            label     = "",
            value     = "2",
            alignment = 3,
            validation = 2,
            scale  = {0.15,0.15, 0.15}
        },
        --MOV
        {
            attr      = "MOV",
            pos       = {0.78,0.2,-0.17},
            rows      = 1,
            width     = 1000,
            font_size = 800,
            label     = "",
            value     = "2",
            alignment = 3,
            validation = 2,
            scale  = {0.15,0.15, 0.15}
        },
        --SIZ
        {
            attr      = "SIZ",
            pos       = {1.05,0.2,-0.17},
            rows      = 1,
            width     = 1000,
            font_size = 800,
            label     = "",
            value     = "3",
            alignment = 3,
            validation = 2,
            scale  = {0.15,0.15, 0.15}
        },
        --Name
        {
            attr      = "Name",
            pos       = {-0.2,0.2,-0.65},
            rows      = 1,
            width     = 9250,
            font_size = 800,
            label     = "Unknown",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
        -- Archetypes
        {
            attr      = "Archetypes",
            pos       = {-0.2,0.2,-0.40},
            rows      = 1,
            width     = 9250,
            font_size = 500,
            label     = "Average",
            value     = "Average",
            alignment = 2,
            height    = 800,
            scale  = {0.10,0.10, 0.10}
        },
        -- Frames
        {
            attr      = "Frames",
            pos       = {0.68,0.2,-0.40},
            rows      = 1,
            width     = 7500,
            font_size = 500,
            label     = "Human",
            value     = "Human",
            alignment = 2,
            height    = 800,
            scale  = {0.10,0.10, 0.10}
        },
        -- Traits
        {
            attr      = "Abilities",
            pos       = {0.2,0.2,0.05},
            rows      = 2,
            width     = 10500,
            font_size = 500,
            label     = "Abilities",
            value     = "",
            alignment = 2,
            height    = 1100,
            scale  = {0.10,0.10, 0.10}
        },
        {
            attr      = "Disabilities",
            pos       = {0.2,0.2,0.2},
            rows      = 1,
            width     = 10500,
            font_size = 500,
            label     = "Disabilities",
            value     = "",
            alignment = 2,
            height    = 600,
            scale  = {0.10,0.10, 0.10}
        },
        -- Weapons, Armor, Equipment
        {
            attr      = "Weapons",
            pos       = {0.1,0.2,0.40},
            rows      = 1,
            width     = 12000,
            font_size = 500,
            label     = "Weapons",
            value     = "",
            alignment = 2,
            height    = 800,
            scale  = {0.10,0.10, 0.10}
        },
        {
            attr      = "Armor",
            pos       = {0.1,0.2,0.50},
            rows      = 1,
            width     = 12000,
            font_size = 500,
            label     = "Armor",
            value     = "",
            alignment = 2,
            height    = 800,
            scale  = {0.10,0.10, 0.10}
        },
        {
            attr      = "Equipment",
            pos       = {0.1,0.2,0.60},
            rows      = 1,
            width     = 12000,
            font_size = 500,
            label     = "Equipment",
            value     = "",
            alignment = 2,
            height    = 800,
            scale  = {0.10,0.10, 0.10}
        },
        --BP
        {
            attr      = "BP",
            pos       = {0.86,0.2,-0.75},
            rows      = 1,
            width     = 1200,
            font_size = 500,
            label     = "0",
            value     = "",
            alignment = 3,
            validation = 2,
            scale  = {0.2,0.2, 0.2}
        },
        --CR
        {
            attr      = "CR",
            pos       = {0.68,0.2,0.75},
            rows      = 1,
            width     = 1000,
            font_size = 500,
            label     = "+0",
            value     = "",
            alignment = 3,
            scale  = {0.1,0.1, 0.1}
        },
        --dBP
        {
            attr      = "dBP",
            pos       = {0.9,0.2,0.75},
            rows      = 1,
            width     = 1100,
            font_size = 500,
            label     = "+0",
            value     = "0",
            alignment = 3,
            scale  = {0.1,0.1, 0.1}
        },
        --fBP
        {
            attr      = "fBP",
            pos       = {1.10,0.2,0.75},
            rows      = 1,
            width     = 1100,
            font_size = 500,
            label     = "0",
            value     = "0",
            alignment = 3,
            scale  = {0.1,0.1, 0.1}
        },
        --XP
        {
            attr      = "XP",
            pos       = {-0.7,0.2,0.85},
            rows      = 1,
            width     = 2500,
            font_size = 500,
            label     = "0",
            value     = "",
            alignment = 2,
            validation= 2,
            scale  = {0.15,0.15, 0.15}
        },

        --End of textboxes
    }
}

--Save function
function updateSave()
    saved_data = JSON.encode(ref_buttonData)
    if disableSave==true then saved_data="" end
    self.script_state = saved_data
end

--Startup procedure
function onload(saved_data)
    if disableSave==true then saved_data="" end
    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        ref_buttonData = loaded_data
    else
        ref_buttonData = defaultButtonData
    end

    spawnedButtonCount = 0
    spawnedInputCount = 0

    createCheckbox()
    createCounter()
    createTextbox()
end

function onUpdate()
  if boundObj == nil then return end

  renderVectors()
end

function onDestroy()
  clearVectors()
end

function onObjectDestroy(dying_object)
  if boundObj == nil then return end
  if boundObj == dying_object then clearVectors() end
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

function getArcVectorPoints(steps, heightFactor, targetVec, offsetHeight)
    local tempTable = {}
    local delta = 1.00/steps
    local baseHeight = offsetHeight + targetVec[2]

    for i = 0, steps do
      local x = targetVec[1] * delta * i
      local y = baseHeight * delta * i - (((i - (steps/2))/steps)^2 - 0.25) * heightFactor
      local z = targetVec[3] * delta * i
        table.insert(tempTable, { x, y, z })
    end
    return tempTable
end

function toggleCircle(player_color_clicker, value, instanceIndex)
  if boundObj == nil then showCircles = false return end
  showCircles = not showCircles

  renderVectors()
end

function toggleArc(player_color_clicker, value, instanceIndex)
  if boundObj == nil then showArc = false return end
  showArc = not showArc

  renderVectors()
end

function togglePlayerColor(player_color_clicker, value, instanceIndex)
  playerColor = player_color_clicker

  self.editButton({
    index = instanceIndex,
    color = playerColor
  })
end

function resetBoundObjVectors()
  if boundObj == nil then return end

  clearVectors()
  showArc = false
  showCircle = false
end

function resetBoundTargets()
  resetBoundObjVectors()
  boundObj = nil

  self.setName("")
  self.setDescription("")
end

function clearVectors()
  self.setVectorLines({})

  if boundObj == nil then return end

  boundObj.setVectorLines({})
end

function renderVectors()
  if boundObj == nil then return end

  clearVectors()

  if showCircles then
      drawCircle()
  end

  if showArc then
      drawArc()
  end
end

function drawCircle()
  if showCircles == false then return end
  if boundObj == nil then return end

  local pointsCircle1 = getCircleVectorPoints(circleConfig.radius, circleConfig.steps, circleConfig.offsetHeight);
  local pointsCircle2 = getCircleVectorPoints(circleConfig.radius, circleConfig.steps, 0.1);

  boundObj.setVectorLines({
    {
      points = { {0.0, 3, 0.0}, { 0.0, 10.0, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 0, 0},
    },
    {
      points = { {0.0, 3, 0.0}, { 0.0, 10.0, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 90, 0},
    },
    {
      points = { {0.0, 3, 0.0}, { 0.0, 10.0, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 45, 0},
    },
    {
      points = { {0.0, 3, 0.0}, { 0.0, 10.0, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 135, 0},
    },
    {
      points = { {0.0, 3, 0.0}, { 0.0, 10.0, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 135, 0},
    },

    {
      points = { {0.0, 10, 0.0}, { 0.0, 20.0, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 0, 0},
    },
    {
      points = { {0.0, 10, 0.0}, { 0.0, 20.0, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 90, 0},
    },
    {
      points = { {0.0, 10, 0.0}, { 0.0, 20.0, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 45, 0},
    },
    {
      points = { {0.0, 10, 0.0}, { 0.0, 20.0, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 135, 0},
    },
    {
      points = { {0.0, 10, 0.0}, { 0.0, 20.0, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 135, 0},
    },

    {
      points = { {0.0, 20, 0.0}, { 0.0, 30, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 0, 0},
    },
    {
      points = { {0.0, 20, 0.0}, { 0.0, 30, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 90, 0},
    },
    {
      points = { {0.0, 20, 0.0}, { 0.0, 30, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 45, 0},
    },
    {
      points = { {0.0, 20, 0.0}, { 0.0, 30, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 135, 0},
    },
    {
      points = { {0.0, 20, 0.0}, { 0.0, 30, 0.0} },
      color = { 0, 0, 1},
      thickness = 1,
      rotation = {0, 135, 0},
    },

    {
      points = { {0.0, 30, 0.0}, { 0.0, 40, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 0, 0},
    },
    {
      points = { {0.0, 30, 0.0}, { 0.0, 40, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 90, 0},
    },
    {
      points = { {0.0, 30, 0.0}, { 0.0, 40, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 45, 0},
    },
    {
      points = { {0.0, 30, 0.0}, { 0.0, 40, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 135, 0},
    },
    {
        points = { {0.0, 30, 0.0}, { 0.0, 40, 0.0} },
      color = playerColor or circleConfig.color,
      thickness = 1,
      rotation = {0, 135, 0},
    },


    {
      points = pointsCircle1,
      color = playerColor or circleConfig.color,
      thickness = circleConfig.thickness,
      rotation = {0.5, 0, 0},
    },
    {
      points = pointsCircle2,
      color = playerColor or circleConfig.color,
      thickness = circleConfig.thickness,
      rotation = {0.5, 0, 0},
    },
  })
end

function drawArc()
  if showArc == false then return end
  if boundObj == nil then return end

  local targetVec = self.positionToLocal(boundObj.getPosition())
  local offsetHeight = 0

  if showCircles == true then offsetHeight = circleConfig.offsetHeight end

  local pointsArc = getArcVectorPoints(arcConfig.steps, arcConfig.heightFactor, targetVec, offsetHeight)

  self.setVectorLines({
    {
      points = pointsArc,
      color = playerColor or arcConfig.color,
      thickness = arcConfig.thickness,
      rotation = {0, 0, 0},
    },
  })
end

function setTargetScript(obj)
  local injectScript =
  [[
    function onObjectSpawn(spawn_object)
      local spawnGUID = spawn_object.getGUID()
      local selfGUID = self.getGUID()

      if spawnGUID == selfGUID then clearVectorArt() end
    end

    function clearVectorArt()
      print ("clearing")
      self.setVectorLines({})
    end
  ]]

  obj.setLuaScript(injectScript)

end

function onCollisionEnter(collision_info)
    local obj = collision_info.collision_object
    local type = collision_info.collision_object.type
    local tags = obj.getTags()

    outputTags(tags, obj, type)
end

function onObjectSpawn(spawn_object)
  local spawnGUID = spawn_object.getGUID()
  local selfGUID = self.getGUID()

  if spawnGUID == selfGUID then resetBoundTargets() end
end

function outputTags(tags, obj, type)
 for i, tag in pairs(tags) do
   handleTags(tag, obj)
 end
end

function handleTags(tag, obj)
  if tag:upper() ~= "MODEL" then return end

  resetBoundObjVectors()

  boundObj = obj
  setNameAndDesc(obj)
  setTargetScript(obj)
end

function updateStoredData(i, val, attr)
  if attr == nil then return end
  storedData[attr] = val
  setNameAndDesc()
end

function setMemo(top, bottom)
  local DIVIDER = "~~~~~~"
  memo = top .. DIVIDER .. bottom
end

function setNameAndDesc(targetObj)
  local CR = storedData.CR or 0
  local dBP = storedData.dBP or 30
  local fBP = storedData.fBP or 30
  local BP = storedData.BP or 30
  local XP = storedData.XP or 0

  local archetypes = storedData.Archetypes or "Average"
  local frames = storedData.Frames or "Human"
  local name = storedData.Name or "UNKNOWN"
  local trait_abilities = storedData.Abilities or ""
  local trait_disabilities = storedData.Disabilities or ""
  local items_weapons = storedData.Weapons or ""
  local items_armor = storedData.Armor or ""
  local items_equipment = storedData.Equipment or ""

  local attr_CCA = storedData.CCA or 2
  local attr_RCA = storedData.RCA or 2
  local attr_REF = storedData.REF or 2
  local attr_INT = storedData.INT or 2
  local attr_POW = storedData.POW or 2
  local attr_STR = storedData.STR or 2
  local attr_FOR = storedData.FOR or 2
  local attr_MOV = storedData.MOV or 2
  local attr_SIZ = storedData.SIZ or 3

  local title = BP .. " BP > [ff0000]" .. name .. "[-]"
  local line_1 = "[00fdac]" .. archetypes .. "[-]\n"
  local line_2 = "[sub][ddddff]" .. frames .. "[-]\n"
  local line_3 = "--------------------------------------------------------\n"
  local line_4 = "[C35A26]CCA RCA REF[-] - [919C7A]INT POW STR[-] - [4F8593]FOR MOV SIZ[-]\n"
  local line_5 =
    "  " .. attr_CCA .. "     " .. attr_RCA .. "      " .. attr_REF ..
    "       " .. attr_INT .. "      " .. attr_POW .. "      " .. attr_STR ..
    "        " .. attr_FOR .. "      " .. attr_MOV .. "     " .. attr_SIZ .. "\n"
  local line_6 = "\n"
  local line_7 = "[dcff00]" .. trait_abilities .. "[-]\n"
  local line_8 = "[ffdc00]" .. trait_disabilities .. "[-]\n"
  local line_9 = "=====================================\n"
  local line_10 = "[ff3333]" .. items_weapons .. "[-]\n"
  local line_11= "[00ffdd]" .. items_armor .. "\n"
  local line_12= "[cccccc]" .. items_equipment .."\n"
  local line_13= "[-][/sub]"

  top = title
  bottom = line_1 .. line_2 .. line_3 .. line_4 .. line_5 .. line_6 .. line_7 ..
    line_8 .. line_9 .. line_10 .. line_11 .. line_12 .. line_13

  setMemo(top, bottom)

  if targetObj == nil then
    self.setName(top)
    self.setDescription(bottom)
  else
    targetObj.setName(top)
    targetObj.setDescription(bottom)
  end
end

--Click functions for buttons

function handleFuncName(funcName, player_color_clicker, value, instanceIndex)
  if funcName == nil then return end

  _G[funcName](player_color_clicker, value, instanceIndex)
end


--Checks or unchecks the given box
function click_checkbox(tableIndex, buttonIndex, funcName, player_color_clicker, checkedChar)
    if ref_buttonData.checkbox[tableIndex].state == true then
        ref_buttonData.checkbox[tableIndex].state = false
        self.editButton({index = buttonIndex, label = ""})
    else
        ref_buttonData.checkbox[tableIndex].state = true
        self.editButton({index = buttonIndex, label = checkedChar or string.char("10008")})
    end

    updateSave()
    handleFuncName(funcName, player_color_clicker, ref_buttonData.checkbox[tableIndex].state, buttonIndex)
end

--Applies value to given counter display
function click_counter(tableIndex, buttonIndex, amount, attr, funcName, player_color_clicker)
    ref_buttonData.counter[tableIndex].value = ref_buttonData.counter[tableIndex].value + amount
    self.editButton({index = buttonIndex, label = ref_buttonData.counter[tableIndex].value})

    updateSave()
    handleFuncName(funcName, player_color_clicker, amount, buttonIndex)
end

--Updates saved value for given text box
function click_textbox(tableIndex, inputIndex, value, selected, attr, funcName, player_color_clicker)
    if selected == false then
        ref_buttonData.textbox[tableIndex].value = value

        updateSave()
        updateStoredData(tableIndex, value, attr)
        handleFuncName(funcName, player_color_clicker, value, inputIndex)
    end
end

--Dud function for if you have a background on a counter
function click_none() end



--Button creation



--Makes checkboxes
function createCheckbox()
    for i, data in ipairs(ref_buttonData.checkbox) do
        --Sets up reference function
        local buttonIndex = spawnedButtonCount
        local funcName = "checkbox"..i
        local charTrue = data.charTrue or 10008
        local checkedChar = string.char(charTrue)
        local func = function(obj, player_clicker_color) click_checkbox(i, buttonIndex, data.funcName, player_clicker_color, checkedChar) end
        self.setVar(funcName, func)

        --Sets up label
        local label = ""
        if data.state == true then label = checkedChar end

        --Creates button and counts it
        self.createButton({
          label = label,
          click_function = funcName,
          function_owner = self,
          position = data.pos,
          height = data.size,
          width = data.size,
          font_size = data.size,
          scale = buttonScale,
          color = data.color or buttonColor,
          font_color = data.font_color or buttonFontColor
        })

        spawnedButtonCount = spawnedButtonCount + 1
    end
end

--Makes counters
function createCounter()
    for i, data in ipairs(ref_buttonData.counter) do
        local buttonIndex = spawnedButtonCount
        local label = data.value
        local size = data.size

        if data.hideBG == true then size = 0 end

        --Creates button and counts it
        self.createButton({
          label           = label,
          click_function  = "click_none",
          function_owner  = self,
          position        = data.pos,
          height          = size,
          width           = size,
          font_size       = data.size,
          scale           = buttonScale,
          color           = data.color or buttonColor,
          font_color      = data.font_color or buttonFontColor
        })

        spawnedButtonCount = spawnedButtonCount + 1

        --Sets up add 1
        local funcName = "counterAdd"..i
        local func = function(obj, player_clicker_color) click_counter(i, buttonIndex, 1, data.funcName, player_clicker_color) end
        self.setVar(funcName, func)

        --Sets up label
        local label = "+"

        --Sets up position
        local offsetDistance = (data.size/2 + data.size/4) * (buttonScale[1] * 0.002)
        local pos = {data.pos[1] + offsetDistance, data.pos[2], data.pos[3]}

        --Sets up size
        local size = data.size / 2

        --Creates button and counts it
        self.createButton({
          label           = label,
          click_function  = funcName,
          function_owner  = self,
          position        = pos,
          height          = size,
          width           = size,
          font_size       = size,
          scale           = buttonScale,
          color           = buttonColor,
          font_color      = buttonFontColor
        })

        spawnedButtonCount = spawnedButtonCount + 1

        --Sets up subtract 1
        local funcName = "counterSub"..i
        local func = function(obj, player_clicker_color) click_counter(i, buttonIndex, -1, data.funcName, player_clicker_color) end
        self.setVar(funcName, func)

        --Sets up label
        local label = "-"

        --Set up position
        local pos = {data.pos[1] - offsetDistance, data.pos[2], data.pos[3]}

        --Creates button and counts it
        self.createButton({
          label           = label,
          click_function  = funcName,
          function_owner  = self,
          position        = pos,
          height          = size,
          width           = size,
          font_size       = size,
          scale           = buttonScale,
          color           = buttonColor,
          font_color      = buttonFontColor
        })

        spawnedButtonCount = spawnedButtonCount + 1
    end
end

function createTextbox()
    for i, data in ipairs(ref_buttonData.textbox) do
        --Sets up reference function
        local inputIndex = spawnedInputCount
        local funcName = "textbox"..i
        local func = function(obj, player_clicker_color, input_value, selected) click_textbox(i, inputIndex, input_value, selected, data.attr, data.funcName, player_clicker_color) end

        self.setVar(funcName, func)
        self.createInput({
            input_function = funcName,
            function_owner = self,
            label          = data.label,
            alignment      = data.alignment,
            position       = data.pos,
            scale          = data.scale or textScale,
            width          = data.width,
            height         = data.height or ((data.font_size*1.02)*data.rows + 25),
            font_size      = data.font_size,
            color          = data.color or textBoxColor,
            font_color     = data.font_color or textFontColor,
            value          = data.value,
            validation     = data.validation or 1,
            tab            = data.tab or 2
        })

        spawnedInputCount = spawnedInputCount +1
    end
end
