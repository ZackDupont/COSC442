--
-- Project: PapaMonkey
-- Description:
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2017 . All Rights Reserved.
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

-----------------------------------------------------------------------------------------

-- forward declarations and other locals
local playBtn
local statBtn
local credBtn
local title
local bgMusic

-----------------------------------------------------------------------------------------

-- Event Handlers
local function onHomeRelease(event)
	--Log press
	if not file then
    	print( "File error: " .. errorString )
	else
    	file:write("Returned home\n")
	end

	composer.gotoScene( "menu", "fade", 500 )
	return true
end

-- Tutorial handler
local function onTutorialRelease(event)
		--Log press
	if not file then
    	print( "File error: " .. errorString )
	else
    	file:write("Started the tutorial\n")
	end

	composer.gotoScene( "tutorial", "fade", 500 )
	return true
end


-- Level 1 handler
local function onLevel1Release(event)
	--Log press
	if not file then
    	print( "File error: " .. errorString )
	else
    	file:write("Started from level 1\n")
	end

	composer.gotoScene( "level1", "fade", 500 )
	return true
end

-- Level 2 handler
local function onLevel2Release(event)
	--Log press
	if not file then
    	print( "File error: " .. errorString )
	else
    	file:write("started from level 2\n")
	end

	composer.gotoScene( "level2", "fade", 500 )
	return true
end

-- Level 3 handler
local function onLevel3Release(event)
	--Log press
	if not file then
    	print( "File error: " .. errorString )
	else
    	file:write("Started from level 3\n")
	end

	composer.gotoScene( "level3", "fade", 500 )
	return true
end


-- Music Reset Handler
-- local function resetBgMusic(event)
--     if event.completed == false and event.phase == "stopped" then
--         audio.setVolume ( 1, {channel=1 })
--         audio.rewind (bgMusic)
--     end
-- end

-- Music Player Handler
local function playBgMusic()
        audio.play(bgMusic, {channel=1, loops=0,
        onComplete=resetBgMusic} )
end

-----------------------------------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view

	-- Background image
	local bgMain = display.newImage( sceneGroup, "images/bgMain.jpg", true)
	bgMain.rotation = 90
	bgMain.width = display.contentHeight
	bgMain.height = display.contentWidth
	bgMain.x = display.contentWidth / 2
	bgMain.y = display.contentHeight / 2

	-- Game Title
	local titleInfo = {
		text = "Level Select",
		x = 1250,
		y = 1280,
		font = native.DroidSans,
		fontSize = 140
	}
	local title = display.newText(titleInfo)
	title:setFillColor(0,0,0)
	title.rotation = 90

	-- Menu Buttons
	homeBtn = widget.newButton{
		left = -150,
		top = 1150,
		width = 750,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Main Menu",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onHomeRelease
	}
	homeBtn.rotation = 90

	tutorialBtn = widget.newButton{
		left = 650,
		top = 350,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Tutorial",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onTutorialRelease
	}
	tutorialBtn.rotation = 90

	level1Btn = widget.newButton{
		left = 650,
		top = 1150,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Level 1",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onLevel1Release
	}
	level1Btn.rotation = 90

	level2Btn = widget.newButton{
		left = 650,
		top = 1950,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Level 2",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onLevel2Release
	}
	level2Btn.rotation = 90

	level3Btn = widget.newButton{
		left = 250,
		top = 350,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Level 3",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onLevel3Release
	}
	level3Btn.rotation = 90

	-- all display objects must be inserted into group
	sceneGroup:insert(bgMain)
	sceneGroup:insert(title)
	sceneGroup:insert(homeBtn)
	sceneGroup:insert(tutorialBtn)
	sceneGroup:insert(level1Btn)
	sceneGroup:insert(level2Btn)
	sceneGroup:insert(level3Btn)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
	elseif phase == "did" then
		-- Start Background Music
		bgMusic = audio.loadStream("audio/menu.wav")
		playBgMusic()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if event.phase == "will" then
		-- resetBgMusic()
	elseif phase == "did" then

	end
end

function scene:destroy( event )
	local sceneGroup = self.view
end
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
