toggleMeasure = -1;
selfpc = White;
distance_label = self.createButton({
    label="", click_function="none", position = pointLabel, rotation={-58,0,0}, height=0, width=0, font_size=500,
    font_color={1, 1, 1},
    alignment=2
})

cm_label = self.createButton({
    label="cm", click_function="none", position = {0, 7.7, 0.8}, rotation={-58,0,0}, height=0, width=0, font_size=200,
    font_color={1, 1, 1},
    alignment=2
})


function onObjectPickUp(playerCol, self)
    selfpc = playerCol;
end

function onUpdate()
    pointA = self.getPosition();

    if toggleMeasure == -1 then
        self.editButton({index=0,label=""});
        Global.setVectorLines({
        })
    end

    if selfpc != nil then
        function onObjectPickUp(selfpc, targetObj)
            if targetObj == self then
                toggleMeasure = 1;
            end

            if targetObj != nil and targetObj != self then
                toggleMeasure = -1;
                o_target = targetObj;
            end

        end


        if o_target != nil then
            pointB = o_target.getPosition();
        end

        if toggleMeasure == 1 then
            if pointB != nil then
                pointR = pointA - pointB;
                pointR[1] = math.abs(pointR[1]);
                pointR[3] = math.abs(pointR[3]);
                distResult = math.sqrt((pointR[1]^2) + (pointR[3]^2));
                distCm = distResult *2.54;

                distanceText = (math.floor(distCm *10)/10) .. "";

                --setting rotation value



                --editing the button position to match pole
                self.editButton({index=0,label=distanceText, position = {0,8.2,0.5}});

                --Drawing the line between pole and selected object
                Global.setVectorLines({
                    {
                        points    = { {pointA[1],pointA[2],pointA[3]}, {pointB[1],pointB[2],pointB[3]} },
                        color     = {1,1,1},
                        thickness = 0.1,
                        rotation  = {0,0,0},
                    },
                })
            end
        end
    end
end
