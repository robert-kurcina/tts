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
  if tag == "MODEL" then setDesc(obj) end
  if tag == "CRS" then describeCRS(obj) end
end

function describeCRS(obj)
  if obj.memo then getInputText(obj) end
end

function getInputText(obj)
  print(obj.memo)
end

function setDesc(obj)
    local selfDesc = "[990000]WILMA[-]"
    local selfName = "FRED"
    local object = obj

    if (object == nil) then
        print('No object found with that GUI. Please set my description to a valid GUID')
    else
        object.setDescription(selfDesc)
        object.setName(selfName)

    end
end
