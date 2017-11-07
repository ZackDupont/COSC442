-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

-- include Corona's "physics" library
local physics = require "physics"

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX
local background = display.newImageRect( "images/waterbg.jpg", 600 , 400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

function scene:create( event )

	-- Called when the scene's view does not exist.
	--
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
    physics.pause()



	-- all display objects must be inserted into group


	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.



	-- all display objects must be inserted into group
	sceneGroup:insert(background)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		--
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view

	local phase = event.phase

	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end

end


function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	--
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view

	package.loaded[physics] = nil
	physics = nil
end

-- Game Layout
local backgroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()


--Game Objects
-----------------------------------------------------
-----------------------------------------------------
--game text
local sample = display.newText(uiGroup, "H E L L _", 60, 40, native.systemFontBuild, 48)
sample:setFillColor("black")

local score = display.newText(uiGroup, "That's right! The Correct word is H E L L O", 235 , 210, native.systemFontBuild, 28)
score:setFillColor(1, 0, 0)
score.isVisible = false

local hint = display.newText(uiGroup, "a word like hi", 235, 210, native.systemFontBuild, 32)
hint:setFillColor(0, 1, 1)
hint.isVisible = false

local tut1 = native.newTextBox(70, 200, 200, 250)
tut1.font = native.newFont("Helvetica-Bold", 18 )
tut1.text = "Welcome. Your goal is to catch the fish with the right letter. Hold down the hint button if your not sure. \n\nUse the raise and lower buttons to put the fishing line near the right letter."

local tut2 = display.newText(uiGroup, "H E L L A is not a word!", 235 , 210, native.systemFontBuild, 28)
score:setFillColor(1, 0, 0)
tut2.isVisible = false


local help = display.newText(uiGroup, "Wrong Fish! Use a hint if you need!", 140, 300, native.systemFontBuild, 20)
help:setFillColor(1, 1, 0)
help.isVisible = false


-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--


local boat = display.newImageRect( mainGroup, "images/boat.png", 200, 100)
boat.x = display.contentCenterX
boat.y = 100

local monkey = display.newImageRect( mainGroup, "images/monkey.png", 140, 100)
monkey.x = display.contentCenterX + 50
monkey.y = 50

local frod = display.newImageRect( mainGroup, "images/frod.png", 50, 50)
frod.x = display.contentCenterX + 75
frod.y = 40
--------------------------------------------------------------
--------------------------------------------------------------
local fishA = display.newImageRect("images/YFish.png", 60, 60)
fishA.x = 1000
fishA.y = 400

local fishB = display.newImageRect("images/fish.png", 60, 60)
fishB.x = 1000
fishB.y = 300
isVisible = true

local line = display.newRect(mainGroup, display.contentCenterX + 98, 40, 2, 20)
    line:setFillColor(black)

local sloth = display.newImageRect("images/sloth.png", 200, 200)
sloth.x = display.contentCenterX - 180
sloth.y = display.contentCenterY + 50
sloth.isVisible = false
---------------------------------------------------------
---------------------------------------------------------


--buttons for raising/lowering fishing line.
-------------------------------------------------------
-------------------------------------------------------
local function raiseLine( event )
    line.y = line.y - 30
    line.height = line.height - 60
    tut2.isVisible = false
    return true
end

local function lowerLine (event)
    line.y = line.y + 30
    line.height = line.height + 60
    tut1.isVisible = false
    tut2.isVisible = false
    return true
end

local function giveHint(event)
   hint.isVisible = true
   sloth.isVisible = true
   tut1.isVisible = false
end

local function hideHint(event)
    hint.isVisible = false
    sloth.isVisible = false


end


--functions for buttons
--------------------------------------------------------
--------------------------------------------------------
local upButton = widget.newButton
{
        left = 400,
        top = 20,
        width = 100,
        height = 50,
        defaultFile = "images/upbutton.png",
        overFile = "images/upbutton.png",
        label = "Raise Line",
        onRelease = raiseLine,
}

local downButton = widget.newButton
{
        left = 400,
        top = 80,
        width = 100,
        height = 50,
        defaultFile = "images/downbutton.png",
        overFile = "images/downbutton.png",
        label = "Lower Line",
        onRelease = lowerLine,
}

local hintButton = widget.newButton
{
    left = 400,
    top = 140,
    width = 100,
    height = 50,
    defaultFile = "images/hint.png",
    overFile = "images/hint.png",
    label = "Show Hint",
    onPress = giveHint,
    onRelease = hideHint,

}




--function to move fish
----------------------------------------------------------
--------------------------------------------------------
local function moveFishA()
  transition.to(fishA, {x = -100, y = 200, time=9000,onComplete=function() fishA.x = 1000 fishA.y = 200
    transition.to(fishA, {x = -100, y = 200, time=9000, onComplete=moveFishA()})
  end})
end

for i=1, 10, 1
    do
        moveFishA()
    end

local function moveFishB()
     transition.to(fishB, {x = -200, y = 140, time=12000,onComplete=function() fishB.x = 1000 fishB.y = 140
    transition.to(fishB, {x = -200, y = 140, time=12000, onComplete=moveFishB()})
  end})
end

for i = 1, 10 ,1
    do
        moveFishB()
    end




--physics detection
------------------------------------------------------------
------------------------------------------------------------


--function for physics interaction
-------------------------------------------------------
-------------------------------------------------------
function distance (fish)
	d = math.sqrt(math.pow(line.x - fish.x, 2) + math.pow(line.y - fish.y, 2))
	return d
end

local function listener( event )
	if distance(fishB) < 80 then
       tut2 = display.newText("H E L L A is not a word", 235 , 210, native.systemFontBuild, 28)
       score:setFillColor(1, 0, 0)
       transition.fadeOut(tut2, {time = 2000})

    elseif distance(fishA) < 80 then
        score.isVisible = true
        sample.isVisible = false
        fishA.isVisible = false
        fishB.isVisible = false
        tut2.isVisible = false

	end
end

timer.performWithDelay(100, listener, 0)



---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------
Runtime:addEventListener("touch", hintButton)
return scene
