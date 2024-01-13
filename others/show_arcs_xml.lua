

function onLoad()
  Global.setDecals({})
  local params = {
      name     = "Base",
      url      = "http://cloud-3.steamusercontent.com/ugc/1762569119535316551/02A91491E435B256EFB93EAC72B1069850BCCDBF/",
      position = {0 , 0,0},
      rotation = {0 , 0,0},
      scale    = {1 , 1, 1},
  }
  Global.addDecal(params)
  addHotkey("Get arc hotkey.", hotkey1)
  vSelfGUID = self.guid
  UI.setXml("<Panel><button width='130' height='30' position='-300,450' fontSize='18' fontStyle='Bold' color='Blue' textcolor='White' onClick='"..vSelfGUID.."/clear_arc'>Clear Arcs</button><button width='130' height='30' position='-150,450' fontSize='18' fontStyle='Bold' color='Blue' textcolor='White' onClick='"..vSelfGUID.."/set_allarcs'>Show Arcs</button></Panel>")
end

function global_arc(guidInput)
  pos_current = getObjectFromGUID(guidInput).getPosition()
  rot_current = getObjectFromGUID(guidInput).getRotation()

  distance = -1
  pos_target = getObjectFromGUID(guidInput).getTransformForward()
  pos = {
      x = pos_current.x + pos_target.x * distance,
      y = pos_current.y + 0.05,
      z = pos_current.z + pos_target.z * distance,
  }
  rot = {
      x = rot_current.x + 90,
      y = rot_current.y + 180,
      z = rot_current.z,
  }

  local params = {
      name     = "arc"..guidInput,
      url      = "http://cloud-3.steamusercontent.com/ugc/1762569119535316551/02A91491E435B256EFB93EAC72B1069850BCCDBF/",
      position = pos,
      rotation = rot,
      scale    = {11.2 , 11.2, 1  },
    }
  vFound = false
  vDecalTable = Global.getDecals()
  if vDecalTable ~= nil then
    for _, value in ipairs(vDecalTable) do
      if value.name == "arc"..guidInput then
        table.remove(vDecalTable, _)
        vFound = true
      end
    end
  end
  if vFound == false then
    Global.addDecal(params)
  else
    Global.setDecals(vDecalTable)
  end
end


function set_allarcs()
  clear_arc()
  distance = -1
  vAllObjects = getAllObjects()
    for _, value in ipairs(vAllObjects) do
      if value.hasTag("Unit") == true then
        pos_current = value.getPosition()
        rot_current = value.getRotation()
        pos_target = value.getTransformForward()
        pos = {
            x = pos_current.x + pos_target.x * distance,
            y = pos_current.y + 0.05,
            z = pos_current.z + pos_target.z * distance,
        }
        rot = {
            x = rot_current.x + 90,
            y = rot_current.y + 180,
            z = rot_current.z,
        }
        local params = {
            name     = "arc"..value.getGUID(),
            url      = "http://cloud-3.steamusercontent.com/ugc/1762569119535316551/02A91491E435B256EFB93EAC72B1069850BCCDBF/",
            position = pos,
            rotation = rot,
            scale    = {11.2 , 11.2, 1  },
      }
      Global.addDecal(params)
      end
    end
end





function clear_arc()
  -- Clears all decals with "arc" in the label
  vDecalTable = Global.getDecals()

    -- Zone.getObjects() returns {Object, ...}
  vNewDecalTable = {}
  vCount = 1
  if vDecalTable ~= nil then
    for _, value in ipairs(vDecalTable) do
      if string.match(value.name, "arc") then
      else
        table.insert(vNewDecalTable, vCount, vDecalTable[_])
        vCount = vCount + 1
      end
    end
    Global.setDecals(vNewDecalTable)
  end
end


function hotkey1(player_color, hovered_object, world_position, key_down_up)
  if( hovered_object ~= nil ) then
      if hovered_object.hasTag("Unit") == true then
           param=hovered_object.getGUID()
           success = self.call("global_arc",param)
      end
  end
end
--Startup procedure
