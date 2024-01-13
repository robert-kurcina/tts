--Color information for button text (r,g,b, values of 0-1)
buttonFontColor = {0,0,0}
textFontColor = {0.1,0.1,0.1,100}


--Color information for button background
buttonColor = {1,1,1}
textBoxColor = {0,0,0,0}

--Change scale of button (Avoid changing if possible)
buttonScale = {1,1,1}
textScale = {1,1,1}
rotationNormal = {0,0,0}
rotationFlipped = {180,180,0}

textInputHash = {}
SystemMarkerHash = {}
SystemMarkerHash[1]="Humani"
SystemMarkerHash[2]="Ballani"
SystemMarkerHash[3]="T'kalakt"
SystemMarkerHash[4]="Wer-hgiem"
SystemMarkerHash[5]="Pok-ko"
SystemMarkerHash[6]="Voi-d'Nego"
SystemMarkerHash[7]="Ruilang"
SystemMarkerHash[8]="Onu-Anadalac"
SystemMarkerHash[9]="Thesur-Nam"
SystemMarkerHash[10]="Loamg-ertil"
SystemMarkerHash[11]="Muj-jiktya"
SystemMarkerHash[12]="Dru-dru"
SystemMarkerHash[13]="Indemni"
SystemMarkerHash[14]="S'slu-gat"
SystemMarkerHash[15]="Millenu"
SystemMarkerHash[16]="Avarem"
SystemMarkerHash[17]="Puir-saum"
SystemMarkerHash[18]="Gilmariish"
SystemMarkerHash[19]="Shobani"
SystemMarkerHash[20]="Or'rir'iri"
SystemMarkerHash[21]="Saut-thay"
SystemMarkerHash[22]="Rijna-Zhoua"
SystemMarkerHash[23]="Kumo"
SystemMarkerHash[24]="Yegruush"
SystemMarkerHash[25]="Lasui"
SystemMarkerHash[26]="Nevissinch"
SystemMarkerHash[27]="Dunkarciank"
SystemMarkerHash[28]="Narja"
SystemMarkerHash[29]="O'onai"
SystemMarkerHash[30]="J'Utan"
SystemMarkerHash[31]="Bohagdorsh"
SystemMarkerHash[32]="Bojhut"
SystemMarkerHash[33]="Chuk-ka"
SystemMarkerHash[34]="Nalise-agem"
SystemMarkerHash[35]="Mephisem"
SystemMarkerHash[36]="Azirin"
SystemMarkerHash[37]="Ungasumati"
SystemMarkerHash[38]="Dhar Sitoi"
SystemMarkerHash[39]="Ujonbo"
SystemMarkerHash[40]="ul-Mansul"
SystemMarkerHash[41]="Yua-gwui"
SystemMarkerHash[42]="Vesgah"
SystemMarkerHash[43]="In-ankto"
SystemMarkerHash[44]="T'sal'l"
SystemMarkerHash[45]="Dalu-ifrit"
SystemMarkerHash[46]="Dhar Ishii"
SystemMarkerHash[47]="Wer-lieda"
SystemMarkerHash[48]="Kik-kanik"
SystemMarkerHash[49]="Aganir"
SystemMarkerHash[50]="Druisto"
SystemMarkerHash[51]="Eretaru"
SystemMarkerHash[52]="Ghosht"
SystemMarkerHash[53]="H'ruem"
SystemMarkerHash[54]="Keelrt"
SystemMarkerHash[55]="Zegth"
SystemMarkerHash[56]="Muj-Nuirm"
SystemMarkerHash[57]="S'thsh-Thik"
SystemMarkerHash[58]="Ujes'eril"
SystemMarkerHash[59]="Vok-gwrorl"
SystemMarkerHash[60]="Xem"
SystemMarkerHash[61]="Nirdem"
SystemMarkerHash[62]="Zorel'riri"
SystemMarkerHash[63]="Thiemma"
SystemMarkerHash[64]="Triuoch"

--This is the button placement information
defaultButtonData = {
--Add editable text boxes
  textbox = {
      --[[
      attr      = the name of the attribute used for textInputHash{}
      pos       = the position (pasted from the helper tool)
      rows      = how many lines of text you want for this box
      width     = how wide the text box is
      font_size = size of text. This and "rows" effect overall height
      font_color= rgba { 0,0,0, 1 }
      color     = rgba { 1,1,1, 1}
      label     = what is shown when there is no text. "" = nothing
      value     = text entered into box. "" = nothing
      validation= 1=None, 2=Integer, 3=Float, 4=Alphanumeric, 5=Username, 6=name
      tooltip   = hover text
      alignment = Number to indicate how you want text aligned
                  (1=Automatic, 2=Left, 3=Center, 4=Right, 5=Justified)
      ]]
      --BACK
      {
          attr      = "SystemID_Front",
          pos       = {0, 0.225, 0.7},
          rows      = 1.15,
          width     = 300,
          font_size = 200,
          value     = ".",
          alignment = 3,
          color     = {0,0,0, 1},
          font_color= {1,1,1,1},
          scale     = {1, 1, 1},
      },
      {
          attr      = "SystemID_Back",
          pos       = {0, -0.025, 0.7},
          rows      = 1.15,
          width     = 300,
          font_size = 200,
          value     = ".",
          alignment = 3,
          color     = {1,1,1,1},
          font_color= {0,0,0,1},
          scale     = {1, 1, 1},
          rotation  = rotationFlipped
      },
    },
}

--Startup procedure
function onLoad(saved_data)
  local description = self.getName()
  ref_buttonData = defaultButtonData

  createTextbox()
  updateSystemID(description)
end

function convertValue(given, isNilOnly)
  local value = 0

  if given == nil and isNilOnly == true then return nil end
  if given == nil or given == "" then value = 0 end
  if type(given) == "string" then value = tonumber(given) end

  return value
end

function updateSystemID(givenId)
  local inputIndexFront = textInputHash["SystemID_Front"]
  local inputIndexBack = textInputHash["SystemID_Back"]

  self.editInput({index=inputIndexFront-1, label=givenId, value=givenId, tooltip=givenId})
  self.editInput({index=inputIndexBack-1, label=givenId, value=givenId, tooltip=givenId})

  self.setName(givenId)
  self.setDescription(SystemMarkerHash[convertValue(givenId)])
end

--Updates saved value for given text box
function click_textbox(i, value, selected, attr)
  if selected == false then
      ref_buttonData.textbox[i].value = value
      updateSystemID(value)
  end
end

function createTextbox()
    for i, data in ipairs(ref_buttonData.textbox) do
        --Sets up reference function
        local funcName = "textbox"..i
        local func = function(_,_,val,sel) click_textbox(i,val,sel, data.attr) end
        if data.attr then textInputHash[data.attr] = i end
        self.setVar(funcName, func)

        self.createInput({
            input_function = funcName,
            function_owner = self,
            label          = data.label,
            alignment      = data.alignment,
            position       = data.pos,
            rotation       = data.rotation or rotationNormal,
            scale          = data.scale or buttonScale,
            width          = data.width,
            height         = data.height or (data.font_size*data.rows),
            font_size      = data.font_size,
            color          = data.color or buttonColor,
            font_color     = data.font_color or buttonFontColor,
            value          = data.value,
            validation     = data.validation or 1,
            tab            = data.tab or 2,
            tooltip        = data.tooltip
        })
    end
end
