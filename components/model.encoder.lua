function onCollisionEnter(collision_info)
    local obj = collision_info.collision_object
    local type = collision_info.collision_object.type
    local tags = obj.getTags()

    print("collision" .. type)

    outputTags(tags, obj)
end

function outputTags(tags, obj)
 for i, tag in pairs(tags) do
   print(tag)
   handleTags(tag, obj)
 end
end

function handleTags(tag, obj)
  if tag != "MODEL" then return end

  setTargetScript(obj)
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
