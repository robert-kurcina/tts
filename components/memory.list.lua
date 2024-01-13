-- From Memory List 2.0

function updateSave()
    local data_to_save = {["ml"]=memoryList}
    saved_data = JSON.encode(data_to_save)
    self.script_state = saved_data
end

function onload(saved_data)
    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        --Set up information off of loaded_data
        memoryList = loaded_data.ml
    else
        --Set up information for if there is no saved saved data
        memoryList = {}
    end

    if next(memoryList) == nil then
        createSetupButton()
    else
        createMemoryActionButtons()
    end
end
