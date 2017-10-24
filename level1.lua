-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

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


	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.

	local background = display.newImageRect( "waterbg.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX
	background.y = 0 + display.screenOriginY

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
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

-- FISHES

local fish = display.newImageRect("fish.png", 60, 60)
fish.x = 1000
fish.y = 200

local fish1 = display.newImageRect("BPFish.png", 60, 60)
fish1.x = -500
fish1.y = 275

local fish2 = display.newImageRect("GFish.png", 60, 60)
fish2.x = 1000
fish2.y = 300

local fish3 = display.newImageRect("RFish.png", 60, 60)
fish3.x = -500
fish3.y = 150

local fish4 = display.newImageRect("YFish.png", 60, 60)
fish4.x = 1000
fish4.y = 175

-- MOVING FISHES

local function moveFishA()
  transition.to(fishA, {x = -100, y = 200, time=9000,onComplete=function() fishA.x = 1000 fishA.y = 200
    transition.to(fishA, {x = -100, y = 200, time=9000, onComplete=moveFish()})
  end})
end

local function moveFish1()
  transition.to(fish1, {x = 700, y = 275, time=10000,onComplete=function() fish1.x = -500 fish1.y = 275
    transition.to(fish1, {x = 700, y = 275, time=10000, onComplete=moveFish1()})
  end})
end

local function moveFish2()
  transition.to(fish2, {x = -100, y = 300, time=12000,onComplete=function() fish2.x = 1000 fish2.y = 300
    transition.to(fish2, {x = -100, y = 300, time=12000, onComplete=moveFish2()})
  end})
end

local function moveFish3()
  transition.to(fish3, {x = 700, y = 150, time=15000,onComplete=function() fish3.x = -500 fish1.y = 150
    transition.to(fish3, {x = 700, y = 150, time=15000, onComplete=moveFish3()})
  end})
end

local function moveFish4()
  transition.to(fish4, {x = -100, y = 175, time=14000,onComplete=function() fish4.x = 1000 fish1.y = 175
    transition.to(fish4, {x = -100, y = 175, time=14000, onComplete=moveFish4()})
  end})
end

-- CALL MOVEFISH

for i=1,10,1
do
  moveFish()
  moveFish1()
  moveFish2()
  moveFish3()
  moveFish4()
end











---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
