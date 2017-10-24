
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- Background Image
	local bgStory = display.newImageRect("images/bgStory.png", 800, 1400 )
	bgStory.rotation = 90
	bgStory.width = display.contentHeight
	bgStory.height = display.contentWidth
	bgStory.x = display.contentWidth / 2
	bgStory.y = display.contentHeight / 2

	-- Speech Bubble
	local speechB = display.newImageRect("images/speechBubble.png", display.contentHeight, 330 )
	speechB.rotation = 90
	speechB.x = 50
	speechB.y = 1300

	-- Characters
	-- PapaMonkey
	local papaM= display.newImageRect("images/papaMonkey.png", 640, 480 )
	papaM.rotation = 90
	papaM.x = 450
	papaM.y = 1300

	-- MamaMaybelle
	local mamaM= display.newImageRect("images/mamaMaybelle.png", 440, 600 )
	mamaM.rotation = 90
	mamaM.x = 550
	mamaM.y = 2000
	mamaM.isVisible = false

	-- SonUkog
	local sonU= display.newImageRect("images/sonUkog.png", 340, 280 )
	sonU.rotation = 90
	sonU.x = 1100
	sonU.y = 870
	sonU.isVisible = false

	-- LavishLion
	local lavishL= display.newImageRect("images/lavishLion.png", 380, 540 )
	lavishL.rotation = 90
	lavishL.x = 470
	lavishL.y = 400
	lavishL.isVisible = false

	-- BabyBetsy
	local babyB= display.newImageRect("images/babyBetsy.png", 190, 250 )
	babyB.rotation = 90
	babyB.x = 400
	babyB.y = 1700
	babyB.isVisible = false

	-- -- AdoptedHippo
	-- local adoptedH= display.newImageRect("images/adoptedHippo.png", 854, 720 )
	-- adoptedH.rotation = 90
	-- adoptedH.x = 450
	-- adoptedH.y = -500
	-- adoptedH.xScale = -1

	-- -- StrandedSLoth
	-- local strandedS = display.newImageRect("images/strandedSLoth.png", 420, 440 )
	-- strandedS.rotation = 90
	-- strandedS.x = 450 
	-- strandedS.y = 3000
	
	-- Storyline
	local line1 = "Papa Monkey: My, what a beautiful day it is here in the land of Zo"
	local line2 = ".....: Papa Moneky! Where are you dear?"
	local line3 = "Papa Monkey: I am out by the pond enjoying the sunshine, my sweet wife Mama Maybelle"
	local line4 = "Mama Maybelle: Oh there you are, who would of thought that you weren't in our tiny home with me!"
	local line5 = "Mama Maybelle: Has our daily order of rations been dropped off yet? Baby Betsy is starting to get hungry and we are all out of food!"
	local line6 = "Papa Monkey: It appears that Lavish Lion is running late today dear, he should be here soon I reckon"
	local line7 = "Baby Betsy: Waaaaaaaah! Waaaaaaaaaaaaaaaah! Moma Papa im Hungwey!!!!!!"
	local line8 = "Mama Maybelle: I know dear, but don't worry we will have some more food soon"
	local line9 = ".....: Did i hear food?! Save me some!"
	local line10 = "Papa Monkey: Son Ukog, what did I tell you about riding your cloud that high?"
	local line11 = "Son Ukog: Awwwww but dad all the other kids are doing it."
	local line12 = "Papa Monkey: If you want your share of the food you'll come down here right now monsieur"
	local line13 = "Son Ukog: Alright Papa Monkey, don't get your bananas in a knot"
	local line14 = "Shouldn't Lavish Lion be here by now? This really is unlike him"
	local line15 = ".....: Crikey! I'm coming, hold your crocodiles."
	local line16 = "Lavish Lion: G'day mates! How ya going?"
	local line17 = "Papa Monkey: We are all starving! You are providing us with less food everyday, how do you expect us to live?"
	local line18 = "Lavish Lion: Listen here mates, I don't give two roos about your problems. Everyone gets the same amount, no excpetions."
	local line19 = "Papa Monkey: But with the newest addition to the family its simply not enough anymore."
	local line20 = "Lavish Lion: That there sounds like your problem, hey? Now im late for a barbie, have yourselves a ripper of a day."
	local line21 = "Mama Monkey: Oh dear oh dear. Papa Monkey what should we do?"
	local line22 = "Papa Monkey: In a crisis like this, theres really only one thing we CAN do....."
	local line23 = "Papa Monkey: ... and that my dear, is to go..."
	local line24 = "Papa Monkey: .... FISHING"

	-- Text Area
	local textArea = {
		text = line1,     
        x = 0,
        y = 1280,
        width = 2000,
        height = 300,
		font = native.DroidSans,   
		fontSize = 60,
		align = "center"  -- Alignment parameter
	}

	local text = display.newText(textArea)
	text:setFillColor(0,0,0)
	text.rotation = 90


	--Character Movement
	local function flipPapa(event) -- To be called at line 15
	 	if papaM.xScale>0 then papaM.xScale = -1 else papaM.xScale = 1 end
	 	return true
	end

	local function flipSon(event) -- To be called at line 15
	 	if sonU.xScale>0 then sonU.xScale = -1 else sonU.xScale = 1 end
	 	return true
	end

	local function mama(event) -- To be called at line 4 
		mamaM.isVisible = true
	end

	local function baby(event) -- To be called at line 7
		babyB.isVisible = true
	end

	local function son(event) -- To be called at line 10
		sonU.isVisible = true
	end

	local function sonDrop(event) -- To be called at line 13
		transition.to(sonU, {x = 380, y = 870, time = 800})
	end

	local function lion(event) -- To be called at like 16
		lavishL.isVisible = true
	end

	local function lionLeaves(event) -- To be called at line 21
		lavishL.isVisible = false
	end

	-- Terrible Line Switcher
	local function lineListener(event)
		if text.text == line1 then 
			text.text = line2 
		elseif text.text == line2 then
			text.text = line3
		elseif text.text == line3 then
			text.text = line4 
		elseif text.text == line4 then
			text.text = line5 
		elseif text.text == line5 then
			text.text = line6 
		elseif text.text == line6 then
			text.text = line7 
		elseif text.text == line7 then
			text.text = line8 
		elseif text.text == line8 then
			text.text = line9 
		elseif text.text == line9 then
			text.text = line10 
		elseif text.text == line10 then
			text.text = line11 
		elseif text.text == line11 then
			text.text = line12 
		elseif text.text == line12 then
			text.text = line13 
		elseif text.text == line13 then
			text.text = line14 
		elseif text.text == line14 then
			text.text = line15 
		elseif text.text == line15 then
			text.text = line16 
		elseif text.text == line16 then
			text.text = line17 
		elseif text.text == line17 then
			text.text = line18 
		elseif text.text == line18 then
			text.text = line19 
		elseif text.text == line19 then
			text.text = line20 
		elseif text.text == line20 then
			text.text = line21 
		elseif text.text == line21 then
			text.text = line22 
		elseif text.text == line22 then
			text.text = line23
		end

	end



	timer.performWithDelay(5000, lineListener, 25)
	timer.performWithDelay(20000, mama)
	timer.performWithDelay(35000, baby)
	timer.performWithDelay(50000, son)
	timer.performWithDelay(65000, sonDrop)
	timer.performWithDelay(75000, flipSon)
	timer.performWithDelay(75000, flipPapa)
	timer.performWithDelay(75000, lion)
	timer.performWithDelay(100000, lionLeaves)

	-- all display objects must be inserted into group
	sceneGroup:insert(bgStory)
	sceneGroup:insert(speechB)
	sceneGroup:insert(papaM)
	sceneGroup:insert(mamaM)
	sceneGroup:insert(sonU)
	sceneGroup:insert(babyB)
	sceneGroup:insert(lavishL)
	-- text?
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
