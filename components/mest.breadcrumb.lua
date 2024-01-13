isPickedUp = false
imageCDNURL = [[http://cloud-3.steamusercontent.com/ugc/1813237152123048485/9F11AFC102B74AEC9DA5AA033A0776753583FB53/]]

function getMoveTokenGridSize()
  return (Grid.sizeX + Grid.sizeY)/2
end

function onPickUp(playerColor)
  isPickedUp = true

  createMoveToken(playerColor, self)
end

function onDrop(playerColor)
  isPickedUp = false

  destroyMoveToken(playerColor)
end

function drawLine()
  local targetObj = self.getVar("myMoveToken")

  pointA = self.getPosition();
  pointB = targetObj.getPosition();

  if self.resting == false or targetObj.resting == false then
    pointR = pointA - pointB;
    pointD = pointB - pointA;

    pointR[1] = math.abs(pointR[1]);
    pointR[3] = math.abs(pointR[3]);

    lineRot = self.getRotation();
    lineColor = { 1, 0, 0 }

    self.setVectorLines({
      {
          points    = { {0, pointD[2], 0},
                        {pointD[1], pointD[2], pointD[3]} },
          color     = lineColor,
          thickness = 0.1,
          rotation  = {lineRot.x, -lineRot.y, lineRot.z},
      },
    })
  end
end

function onUpdate()
  local targetObj = self.getVar("myMoveToken")

  if targetObj != nil then
    drawLine()
  end
end

function destroyMoveToken(playerColor)
  local dropWatchFunc = function() return self.resting end
  local destroyMoveTokenFunc = function() destroyObject(self.getVar("myMoveToken")) self.setVectorLines() end

  Wait.condition(destroyMoveTokenFunc, dropWatchFunc)
end

function getMoveButtonParams()
  return {
    click_function = "onLoad",
    function_owner = self,
    label = "00.0",
    position = {x = 0, y = 0.1, z = 0},
    width = 0,
    height = 0,
    font_size = 600
  }
end

function getSpawnParams(tokenScale, tokenRotation, startPosition)
  return {
    type = "Custom_Tile",
    position = startPosition,
    rotation = {x = 0, y = tokenRotation, z = 0},
    scale = tokenScale
  }
end

function getMoveToken(mColor, mToken, spawnParams, moveTokenParams)
  local moveToken = spawnObject(spawnParams)
  local moveTokenGridSize = getMoveTokenGridSize()

  moveToken.setCustomObject(moveTokenParams)
  moveToken.setVar("myToken", mToken)
  moveToken.setVar("myPlayer", mColor)
  moveToken.setVar("myGridSize", moveTokenGridSize)
  mToken.setVar("myMoveToken", moveToken)

  return moveToken
end

function getMoveTokenParams()
  return {
    image = imageCDNURL,
    thickness = 0.1,
    type = 2
  }
end

function getTokenScale(mToken)
  return { x = mToken.getBoundsNormalized().size.x / 2, y = 1, z = mToken.getBoundsNormalized().size.z / 2 }
end

function createMoveToken(mColor, mToken)
  local tokenExistsAlready = mToken.GetVar("myMoveToken")

  if string.match(tostring(tokenExistsAlready), "Custom") then destroyObject(tokenExistsAlready) self.setVectorLines() end

  local tokenScale = getTokenScale(mToken)
  local tokenRotation = Player[mColor].getPointerRotation()
  local startPosition = mToken.getPosition()
  local spawnParams = getSpawnParams(tokenScale, tokenRotation, startPosition)

  local moveTokenParams = getMoveTokenParams()
  local moveToken = getMoveToken(mColor, mToken, spawnParams, moveTokenParams)
  local moveButtonParams = getMoveButtonParams()
  local moveButton = moveToken.createButton(moveButtonParams)

  moveToken.setLuaScript([[
    function onUpdate()
      local myPos = self.getPosition()
      local targetPos = myToken.getPosition()
      local isHeld = myToken.held_by_color

      targetPos.y = targetPos.y-(Player[myPlayer].lift_height*5)
      local mdiff = myPos - targetPos
      local mDistance

      if isHeld then
        mDistance = math.sqrt(mdiff.x^2 + mdiff.y^2 + mdiff.z^2)
        mDistance = math.floor(mDistance * (10/myGridSize)) / 10

        self.editButton({index = 0, label = tostring(mDistance)})
      end
    end]])
end
