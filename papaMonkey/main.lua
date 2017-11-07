-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--Start stat tracking
_G.path = system.pathForFile( "statTracker.txt", system.DocumentsDirectory)
_G.file, errorString = io.open(path, "w")

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require("composer")

-- Seed the random number generator
math.randomseed( os.time() )

-- load menu screen
composer.gotoScene( "menu" )