---screen.lua: base class of all screens
--
-- date: 16/02/2024
-- author: Abhishek Mishra

local class = require('lib/middleclass')

local Screen = class('Screen')

function Screen:initialize(orchestrator)
    self.orchestrator = orchestrator
    self.displayText = "Screen"
end

function Screen:getWidth()
    return love.graphics.getWidth()
end

function Screen:getHeight()
    return love.graphics.getHeight()
end

function Screen:show()
    -- code to show the screen
end

function Screen:hide()
    -- code to hide the screen
end

function Screen:update(dt)
    -- code to update the screen
end

function Screen:draw()
    -- code to draw the screen
end

function Screen:mousepressed(x, y, button, istouch, presses)
    -- Code to handle mouse press
end

function Screen:mousereleased(x, y, button, istouch, presses)
end

function Screen:mousemoved(x, y, dx, dy, istouch)
end

return Screen