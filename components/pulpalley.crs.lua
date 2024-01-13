--[[    Character Sheet Template    by: MrStump

Begin editing below:    ]]

--Set this to true while editing and false when you have finished
disableSave = false
--Remember to set this to false once you are done making changes
--Then, after you save & apply it, save your game too

--Color information for button text (r,g,b, values of 0-1)
buttonFontColor = {0,0,0}
--Color information for button background
buttonColor = {1,1,1}
--Change scale of button (Avoid changing if possible)
buttonScale = {0.1,0.1,0.1}

--This is the button placement information
defaultButtonData = {
    --Add checkboxes
    checkbox = {
        --[[
        pos   = the position (pasted from the helper tool)
        size  = height/width/font_size for checkbox
        state = default starting value for checkbox (true=checked, false=not)
        ]]

        --End of checkboxes
    },
    --Add counters that have a + and - button
    counter = {
        --[[
        pos    = the position (pasted from the helper tool)
        size   = height/width/font_size for counter
        value  = default starting value for counter
        hideBG = if background of counter is hidden (true=hidden, false=not)
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
                    (1=Automatic, 2=Left, 3=Center, 4=Right, 5=Justified)
        ]]
--League Name
        {
            pos       = {0.15,0.1,-1.955},
            rows      = 1,
            width     = 7000,
            font_size = 800,
            label     = "Unknown",
            value     = "",
            alignment = 2,
            scale  = {0.15,0.15, 0.15}
        },
--League: Perks
        {
            pos       = {0.0,0.1,1.85},
            rows      = 2,
            width     = 12000,
            font_size = 400,

            label     = "None",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },

--Leader: Name
        {
            pos       = {-0.985,0.1,-1.60},
            rows      = 1,
            width     = 2600,
            font_size = 400,
            height    = 500,
            label     = "??",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },

--Leader: Perks
        {
            pos       = {0.0,0.1,-1.30},
            rows      = 4,
            width     = 12000,
            font_size = 400,

            label     = "None",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Leader: Health
        {
            pos       = {-0.55,0.1,-1.60},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Leader: Brawl
        {
            pos       = {-0.270,0.1,-1.60},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Leader: Shoot
        {
            pos       = {0.0,0.1,-1.60},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Leader: Dodge
        {
            pos       = {0.290,0.1,-1.60},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Leader: Might
        {
            pos       = {0.575,0.1,-1.60},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Leader: Finesse
        {
            pos       = {0.865,0.1,-1.60},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Leader: Cunning
        {
            pos       = {1.15,0.1,-1.60},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },

--Sidekick: Name
        {
            pos       = {-0.985,0.1,-0.835},
            rows      = 1,
            width     = 2600,
            font_size = 400,
            height    = 500,
            label     = "??",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Sidekick: Perks
        {
            pos       = {0.0,0.1,-0.600},
            rows      = 2,
            width     = 12000,
            font_size = 400,

            label     = "None",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Sidekick: Health
        {
            pos       = {-0.55,0.1,-0.835},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Sidekick: Brawl
        {
            pos       = {-0.270,0.1,-0.835},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Sidekick: Shoot
        {
            pos       = {0.0,0.1,-0.835},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Sidekick: Dodge
        {
            pos       = {0.290,0.1,-0.835},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Sidekick: Might
        {
            pos       = {0.575,0.1,-0.835},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Sidekick: Finesse
        {
            pos       = {0.865,0.1,-0.835},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Sidekick: Cunning
        {
            pos       = {1.15,0.1,-0.835},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },

--Ally-1: Name
        {
            pos       = {-0.985,0.1,-0.22},
            rows      = 1,
            width     = 2600,
            font_size = 400,
            height    = 500,
            label     = "??",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-1: Perks
        {
            pos       = {0.0,0.1,-0.03},
            rows      = 1,
            width     = 12000,
            font_size = 400,
            height    = 500,

            label     = "None",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-1: Health
        {
            pos       = {-0.55,0.1,-0.22},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-1: Brawl
        {
            pos       = {-0.270,0.1,-0.22},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-1: Shoot
        {
            pos       = {0.0,0.1,-0.22},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-1: Dodge
        {
            pos       = {0.290,0.1,-0.22},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-1: Might
        {
            pos       = {0.575,0.1,-0.22},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-1: Finesse
        {
            pos       = {0.865,0.1,-0.22},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-1: Cunning
        {
            pos       = {1.15,0.1,-0.22},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },

--Ally-2: Name
        {
            pos       = {-0.985,0.1,0.300},
            rows      = 1,
            width     = 2600,
            font_size = 400,
            height    = 500,
            label     = "??",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-2: Perks
        {
            pos       = {0.0,0.1,0.49},
            rows      = 1,
            width     = 12000,
            font_size = 400,
            height    = 500,

            label     = "None",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-2: Health
        {
            pos       = {-0.55,0.1,0.300},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-2: Brawl
        {
            pos       = {-0.270,0.1,0.300},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-2: Shoot
        {
            pos       = {0.0,0.1,0.300},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-2: Dodge
        {
            pos       = {0.290,0.1,0.300},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-2: Might
        {
            pos       = {0.575,0.1,0.300},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-2: Finesse
        {
            pos       = {0.865,0.1,0.300},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-2: Cunning
        {
            pos       = {1.15,0.1,0.300},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },

--Ally-3: Name
        {
            pos       = {-0.985,0.1,0.84},
            rows      = 1,
            width     = 2600,
            font_size = 400,
            height    = 500,
            label     = "??",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-3: Perks
        {
            pos       = {0.0,0.1,1.02},
            rows      = 1,
            width     = 12000,
            font_size = 400,
            height    = 500,

            label     = "None",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-3: Health
        {
            pos       = {-0.55,0.1,0.84},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-3: Brawl
        {
            pos       = {-0.270,0.1,0.84},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-3: Shoot
        {
            pos       = {0.0,0.1,0.84},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-3: Dodge
        {
            pos       = {0.290,0.1,0.84},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-3: Might
        {
            pos       = {0.575,0.1,0.84},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-3: Finesse
        {
            pos       = {0.865,0.1,0.84},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Ally-3: Cunning
        {
            pos       = {1.15,0.1,0.84},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },


--Follower: Name
        {
            pos       = {-0.985,0.1,1.35},
            rows      = 1,
            width     = 2600,
            font_size = 400,
            height    = 500,
            label     = "??",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Follower: Perks
        {
            pos       = {0.0,0.1,1.53},
            rows      = 1,
            width     = 12000,
            font_size = 400,
            height    = 500,

            label     = "None",
            value     = "",
            alignment = 2,
            scale  = {0.10,0.10, 0.10}
        },
--Follower: Health
        {
            pos       = {-0.55,0.1,1.35},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Follower: Brawl
        {
            pos       = {-0.270,0.1,1.35},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Follower: Shoot
        {
            pos       = {0.0,0.1,1.35},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Follower: Dodge
        {
            pos       = {0.290,0.1,1.35},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Follower: Might
        {
            pos       = {0.575,0.1,1.35},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Follower: Finesse
        {
            pos       = {0.865,0.1,1.35},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
--Follower: Cunning
        {
            pos       = {1.15,0.1,1.35},
            rows      = 1,
            width     = 1200,
            font_size = 400,
            height    = 500,
            label     = "1d6",
            value     = "",
            alignment = 3,
            scale  = {0.10,0.10, 0.10}
        },
        --End of textboxes
    }
}



--Lua beyond this point, I recommend doing something more fun with your life



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
    createCheckbox()
    createCounter()
    createTextbox()
end



--Click functions for buttons



--Checks or unchecks the given box
function click_checkbox(tableIndex, buttonIndex)
    if ref_buttonData.checkbox[tableIndex].state == true then
        ref_buttonData.checkbox[tableIndex].state = false
        self.editButton({index=buttonIndex, label=""})
    else
        ref_buttonData.checkbox[tableIndex].state = true
        self.editButton({index=buttonIndex, label=string.char(10008)})
    end
    updateSave()
end

--Applies value to given counter display
function click_counter(tableIndex, buttonIndex, amount)
    ref_buttonData.counter[tableIndex].value = ref_buttonData.counter[tableIndex].value + amount
    self.editButton({index=buttonIndex, label=ref_buttonData.counter[tableIndex].value})
    updateSave()
end

--Updates saved value for given text box
function click_textbox(i, value, selected)
    if selected == false then
        ref_buttonData.textbox[i].value = value
        updateSave()
    end
end

--Dud function for if you have a background on a counter
function click_none() end



--Button creation



--Makes checkboxes
function createCheckbox()
    for i, data in ipairs(ref_buttonData.checkbox) do
        --Sets up reference function
        local buttonNumber = spawnedButtonCount
        local funcName = "checkbox"..i
        local func = function() click_checkbox(i, buttonNumber) end
        self.setVar(funcName, func)
        --Sets up label
        local label = ""
        if data.state==true then label=string.char(10008) end
        --Creates button and counts it
        self.createButton({
            label=label, click_function=funcName, function_owner=self,
            position=data.pos, height=data.size, width=data.size,
            font_size=data.size, scale=buttonScale,
            color=buttonColor, font_color=buttonFontColor
        })
        spawnedButtonCount = spawnedButtonCount + 1
    end
end

--Makes counters
function createCounter()
    for i, data in ipairs(ref_buttonData.counter) do
        --Sets up display
        local displayNumber = spawnedButtonCount
        --Sets up label
        local label = data.value
        --Sets height/width for display
        local size = data.size
        if data.hideBG == true then size = 0 end
        --Creates button and counts it
        self.createButton({
            label=label, click_function="click_none", function_owner=self,
            position=data.pos, height=size, width=size,
            font_size=data.size, scale=buttonScale,
            color=buttonColor, font_color=buttonFontColor
        })
        spawnedButtonCount = spawnedButtonCount + 1

        --Sets up add 1
        local funcName = "counterAdd"..i
        local func = function() click_counter(i, displayNumber, 1) end
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
            label=label, click_function=funcName, function_owner=self,
            position=pos, height=size, width=size,
            font_size=size, scale=buttonScale,
            color=buttonColor, font_color=buttonFontColor
        })
        spawnedButtonCount = spawnedButtonCount + 1

        --Sets up subtract 1
        local funcName = "counterSub"..i
        local func = function() click_counter(i, displayNumber, -1) end
        self.setVar(funcName, func)
        --Sets up label
        local label = "-"
        --Set up position
        local pos = {data.pos[1] - offsetDistance, data.pos[2], data.pos[3]}
        --Creates button and counts it
        self.createButton({
            label=label, click_function=funcName, function_owner=self,
            position=pos, height=size, width=size,
            font_size=size, scale=buttonScale,
            color=buttonColor, font_color=buttonFontColor
        })
        spawnedButtonCount = spawnedButtonCount + 1
    end
end

function createTextbox()
    for i, data in ipairs(ref_buttonData.textbox) do
        --Sets up reference function
        local funcName = "textbox"..i
        local func = function(_,_,val,sel) click_textbox(i,val,sel) end
        self.setVar(funcName, func)

        self.createInput({
            input_function = funcName,
            function_owner = self,
            label          = data.label,
            alignment      = data.alignment,
            position       = data.pos,
            scale          = data.scale or buttonScale,
            width          = data.width,
            height         = data.height or (data.font_size*data.rows),
            font_size      = data.font_size,
            color          = {0.87, 0.77, 0.57} or data.color or buttonColor,
            font_color     = data.font_color or buttonFontColor,
            value          = data.value,
            validation     = data.validation or 1,
            tab            = data.tab or 2
        })
    end
end
