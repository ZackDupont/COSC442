-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local widget = require("widget")
local physics = require("physics")

physics.start()
physics.setGravity(0, 0)




local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

local background = display.newImageRect(backGroup, "background.jpg.jpg", 360, 570)
        background.x = display.contentCenterX
        background.y = display.contentCenterY

local boat = display.newImageRect(mainGroup, "boat-307125_640.png", 200, 100)
        boat.x = display.contentCenterX
        boat.y = display.contentCenterY - 100
        physics.addBody( boat, {radius = 30, isSensor = true })
        boat.myName = boat

local monkey = display.newImageRect(mainGroup, "monkey-183051_640.png", 150, 200)
        monkey.x = boat.x + 70
        monkey.y = boat.y -50
        monkey:toBack()

 local fLine = display.newRect(190, 80, 10, 50)
        fLine:setFillColor(brown)

local function lowerLineRelease (event)
        fLine.y = fLine.y + 30
        fLine.height = fLine.height + 60
        return true       
end 


local function raiseLineRelease (event)
        fLine.y = fLine.y - 30
        fLine.height = fLine.height - 60
        return true
end

local upButton = widget.newButton
{
        left = 0,
        top = 20,
        width = 100,
        height = 50,
        defaultFile = "upButton.png",
        overFile = "upButton.png",
        label = "Raise Line",
        onRelease = raiseLineRelease,
} 

local downButton = widget.newButton{
        left = 0,
        top = 50,
        width = 100,
        height = 50,
        defaultFile = "downButton.png",
        overFile = "downButton.png",
        label = "Lower Line",
        onRelease = lowerLineRelease, 
}





