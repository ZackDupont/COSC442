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
-- Play button handler
local function onPlayRelease(event)
	composer.gotoScene( "level1", "fade", 500 )
	return true
end

-- Stats button handler
local function onStatRelease(event)
	print("stats!")
	return true
end

-- Credits button handler
local function onCreditRelease(event)
	native.showAlert("Papa Monkey's Extravagent Credits", "Amazing Home screen: Me \nAmazing other Screen: You \nDank beats: Sam")
	return true
end

-- Music Reset Handler
local function resetBgMusic(event)
    if event.completed == false and event.phase == "stopped" then
        audio.setVolume ( 1, {channel=1 })
        audio.rewind (bgMusic)
    end
end

-- Music Player Handler
local function playBgMusic()
        audio.play(bgMusic, {channel=1, loops=0,  
        onComplete=resetBgMusic} )
end   

-----------------------------------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view

	-- Background image
	local bg = display.newImage("images/bg.jpg", true)
	bg.rotation = 90
	bg.width = display.contentHeight
	bg.height = display.contentWidth
	bg.x = display.contentWidth / 2
	bg.y = display.contentHeight / 2

	-- Game Title
	local titleInfo = {
		text = "Papa Monkey's Fishing Extravaganza",
		x = 1250,
		y = 1280,
		font = native.DroidSans,
		fontSize = 140
	}
	local title = display.newText(titleInfo)
	title:setFillColor(0,0,0)
	title.rotation = 90

	-- Menu Buttons
	-- Start Button
	playBtn = widget.newButton{
		left = 650,
		top = 1150,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Play",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onPlayRelease
	} 
	playBtn.rotation = 90

	-- Stats Button
	statBtn = widget.newButton{
		left = 350,
		top = 1150,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Stats",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onStatRelease
	} 
	statBtn.rotation = 90

	-- Credits Button
	credBtn = widget.newButton{
		left = 50,
		top = 1150,
		width = 600,
		height = 250,
		defaultFile = "images/button1.png",
		overFile = "images/button2.png",
		label = "Credits",
		font = native.DroidSans,
		fontSize = 120,
		labelColor = {default = {0.7,0.01,1}, over = {0,0,0}},
		onRelease = onCreditRelease
	} 
	credBtn.rotation = 90

	-- all display objects must be inserted into group
	sceneGroup:insert(bg)
	sceneGroup:insert(title)
	sceneGroup:insert(playBtn)
	sceneGroup:insert(statBtn)
	sceneGroup:insert(credBtn)
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
		resetBgMusic()
	elseif phase == "did" then
		
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

	if playBtn then
		playBtn:removeSelf()
		playBtn = nil
	end
	if statBtn then
		playBtn:removeSelf()
		playBtn = nil
	end
	if credBtn then
		playBtn:removeSelf()
		playBtn = nil
	end
end
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene