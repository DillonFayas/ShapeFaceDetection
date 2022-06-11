--Input Positions -- Vectors unavailable in this fork
local InputPositionX = 0
local InputPositionY = 0
local InputPositionZ = 0
-- This will just be located at the origin to make the numbers simpler

--Input Size -- Again, NO VECTORS
local InputSizeX = 12
local InputSizeY = 4
local InputSizeZ = 6
-- Rectangular // if a rectangle works, a square will too.. maybe
-- DUDE I FORGOT ABOUT CIRCLES OMG NOOOOOOOOO // ok later

--Input Hit Positions -- i could use tables but i have a mental disorder so i wont
local HitPosX = 5.5 --This should be .5 units away from the right side and 1 unit from the back
local HitPosY = 1
local HitPosZ = 1

--This won't account for all orientations of the object in the 3D space
--But it's a step in the right direction I guess

--[[
    Face Definitions:
    X Axis = Right/Left     |     Positive X = Right
    Y Axis = Top/Bottom     |     Positive Y = Top
    Z Axis = Front/Back     |     Positive Z = Back

    Object orientation will be assumed null
    HOWEVER
    I think this should account for it
    I didn't do the math so we'll see                                            ugh kill me
]]

function Cancer()
    --Let's define the marks! These vectors will indicate four corners from which I can calculate faces from
    --Well I actually don't think I will use these for this scenario, but I'll need them when I do the next thing
    local Mark1X, Mark1Y, Mark1Z = (InputPositionX - InputSizeX / 2), (InputPositionY - InputSizeY / 2), (InputPositionZ - InputSizeZ / 2) -- Front Bottom Left
    local Mark2X, Mark2Y, Mark2Z = (InputPositionX + InputSizeX / 2), (InputPositionY + InputSizeY / 2), (InputPositionZ - InputSizeZ / 2) -- Front Top Right
    local Mark3X, Mark3Y, Mark3Z = (InputPositionX - InputSizeX / 2), (InputPositionY + InputSizeY / 2), (InputPositionZ + InputSizeZ / 2) -- Back Top Left
    local Mark4X, Mark4Y, Mark4Z = (InputPositionX + InputSizeX / 2), (InputPositionY - InputSizeY / 2), (InputPositionZ + InputSizeZ / 2) -- Back Bottom Right
    -- ^ Nice declaring multiple variables on each line ^
    -- Also realize the relationships in the operators!

    --[[
        Faces can be defined as such:
            Front  ==  Mark1 -> Mark2    |    Back    ==  Mark3 -> Mark4
            Top    ==  Mark3 -> Mark2    |    Bottom  ==  Mark1 -> Mark4
            Right  ==  Mark2 -> Mark4    |    Left    ==  mark1 -> Mark3

        Now the real math begins
        Gotta find which face is closest to the hit position vector
        I should just be able to compare values... well it's hard to explain without a picture... whatever I'm just talking to myself anyways haha I'm lonely
    ]]

    local FrontFaceZ = math.sqrt((InputPositionZ + InputSizeZ / 2)^2)
    local BackFaceZ = math.sqrt((InputPositionZ - InputSizeZ / 2)^2)
    local TopFaceY = math.sqrt((InputPositionY + InputSizeY / 2)^2)
    local BottomFaceY = math.sqrt((InputPositionY - InputSizeY / 2)^2)
    local RightFaceX = math.sqrt((InputPositionX + InputSizeX / 2)^2)
    local LeftFaceX = math.sqrt((InputPositionX - InputSizeX / 2)^2)

    -- Just check which side it is closest to; I CANT EXPLAIN IN WORDS ITS A PICTURE
    local Offset, Face = FrontFaceZ - HitPosZ, 'Front' -- Give default value, this very well could be the solution
    if BackFaceZ - HitPosZ < Offset then
        Offset = BackFaceZ - HitPosZ
        Face = 'Back'
    end
    if TopFaceY - HitPosY < Offset then
        Offset = TopFaceY - HitPosY
        Face = 'Top'
    end
    if BottomFaceY - HitPosY < Offset then
        Offset = BottomFaceY - HitPosY
        Face = 'Bottom'
    end
    if RightFaceX - HitPosX < Offset then
        Offset = RightFaceX - HitPosX
        Face = 'Right'
    end
    if LeftFaceX - HitPosX < Offset then
        Offset = LeftFaceX - HitPosX
        Face = 'Left'
    end
    return Offset, Face
end

local Offset, Face = Cancer()
print('Nearest Face:')
print(Face)
print('Offset:')
print(Offset)

--In cases where the hit is an equal distance from multiple faces... only the last one that was checked will be returned