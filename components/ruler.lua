--Pointer Plus - Centimeters - Code by Giulianno Bessa "illugion"
--Made for Tabletop Simulator Api 2020

--::::::::::Initialization::::::::::
function onLoad()
    --Toggles between on and off (1 and -1)
    toggleMeasure = -1;

    --Target object starts as null
    targetObj = nil;

    --Sets the base player and line color to white
    -- playerColor = "White";
    lineColor   = {1,0,0.3};

    --Gets initial position
    pointA = self.getPosition();

    --Sets the label angle
    labelRot    = -60;

    --::::::::::Object Properties::::::::::

    --Sets sticky to false, to be able to get picked from under another object
    self.sticky = false

    --Makes the object bounce a bit when dropped
    self.bounciness = 0.1;

    --Sets the snap point
    self.setSnapPoints({
        {
            position = {0,0,0},
            rotation = {0,0,0},
            rotation_snap = false
        },
    });

end

--::::::::::Toggle on and off + Target selection::::::::::
function onObjectPickUp(color, pickedObj)
    -- if playerColor != nil and color == playerColor then
        --If the picked up object is the pointer, turns on the toggle
        if pickedObj == self then
            toggleMeasure = 1;
        end
        --If not, turns off the toggle and selects the picked object
        if pickedObj != nil and pickedObj != self then
            toggleMeasure = -1;
            targetObj = pickedObj;
        end
    -- end
end

--::::::::::Main Function::::::::::
function onUpdate()
    --Sets the player holding the pointer as active
    -- if self.held_by_color != nil and self.held_by_color != playerColor then
    --     playerColor = self.held_by_color;
    -- end

    --Gets the current position of the pointer
    if self.resting == false then
        pointA = self.getPosition();
    end

    --Keeps the object from toppling
    local rot = self.getRotation();
    if (rot.x != 0) or (rot.z != 0) then
        self.setRotation({0, rot.y, 0});
    end

    --Hides information when turned off (-1)
    if toggleMeasure == -1 then
      --Editing the labels to hide the information
      --Stop drawing the line
      self.setVectorLines({
      })
    end

    if toggleMeasure == 1 then
        --Gets the position of the target object
        if targetObj != nil then
            pointB = targetObj.getPosition();
        end

        if pointB != nil and (self.resting == false or targetObj.resting == false) then
            --Base calculation
            pointR = pointA - pointB;
            pointD = pointB - pointA;

            --Setting values to absolutes for different coordinate distances
            pointR[1] = math.abs(pointR[1]);
            pointR[3] = math.abs(pointR[3]);

            --Calculating the base result
            distResult   = math.sqrt((pointR[1]^2) + (pointR[3]^2));
            heightResult = pointR[2];

            --Getting the result in centimeters
            distCm    = distResult    *2.54;
            heightCm  = heightResult  *2.54;

            --Flooring the result to only get one extra digit
            distanceText  = (math.floor(distCm *10))/10;
            heightText    = ("Height " .. (math.floor(heightCm *10)/10)+0.1
                                .. " cm");


            --Assigning the rotation to a variable
            lineRot = self.getRotation();

            --::::::::::Drawing lines::::::::::
            --If the pointer is lower than the target
            if pointA[2] <= pointB[2] then
                self.setVectorLines({
                    --Drawing the distance line
                    {
                        points    = { {0,pointD[2],0},
                                      {pointD[1],pointD[2],pointD[3]} },
                        color     = lineColor,
                        thickness = 0.1,
                        rotation  = {lineRot.x, -lineRot.y, lineRot.z},
                    },
                    --Drawing the height lines (adds 0.01 for visibility)
                    --Draws two lines in order to make it visible on any angle
                    {
                        points    = { {0,0,0},
                                      {0+0.001,pointD[2],0} },
                        color     = lineColor,
                        thickness = 0.1,
                        rotation  = {lineRot.x, -lineRot.y, lineRot.z},
                    },
                    {
                        points    = { {0,0,0},
                                      {0+0.001,pointD[2],0} },
                        color     = lineColor,
                        thickness = 0.1,
                        rotation  = {lineRot.x, -lineRot.y + 90, lineRot.z},
                    },
                })
            end
            --If the pointer is higher than the target
            if pointA[2] > pointB[2] then
                --Has to calculate a new position offset from 90 degrees
                --in order to get the second line right
                selfRot = self.getRotation();
                eRot = 5.815;
                newX = pointD[1] * math.cos(-lineRot.y + 90 + selfRot[2] + eRot) - pointD[3] * math.sin(-lineRot.y + 90 + selfRot[2] + eRot);
                newY = pointD[1] * math.sin(-lineRot.y + 90 + selfRot[2] + eRot) + pointD[3] * math.cos(-lineRot.y + 90 + selfRot[2] + eRot);
                self.setVectorLines({
                    --Drawing the distance line
                    {
                        points    = { {0,pointR[2] + pointD[2]+0.02,0},
                                      {pointD[1],pointR[2]+pointD[2]+0.02,pointD[3]} },
                        color     = lineColor,
                        thickness = 0.1,
                        rotation  = {lineRot.x, -lineRot.y, lineRot.z},
                    },
                    --Drawing the height lines (adds 0.01 for visibility)
                    --Draws two lines in order to make it visible on any angle
                    {
                        points    = { {pointD[1],0 + 0.02,pointD[3]}, {pointD[1]+0.001,pointD[2]+0.02,pointD[3]} },
                        color     = lineColor,
                        thickness = 0.1,
                        rotation  = {lineRot.x, -lineRot.y, lineRot.z},
                    },
                    {
                        points    = { {newX,0 + 0.02,newY}, {newX+0.001,pointD[2] + 0.02,newY} },
                        color     = lineColor,
                        thickness = 0.1,
                        rotation  = {lineRot.x, -lineRot.y + 90, lineRot.z},
                    },
                })
            end
        end
    end
end
