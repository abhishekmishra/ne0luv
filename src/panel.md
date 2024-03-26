```lua { code_file="panel.lua" }
--- panel.lua - A panel class
--
-- date: 17/02/2024
-- author: Abhishek Mishra

-- Require the middleclass library
local Class = require('middleclass')
local vector = require('vector')
local Rect = require('rect')

-- Default values for the panel
local PANEL_DEFAULT_WIDTH = 100
local PANEL_DEFAULT_HEIGHT = 100

-- Define the Panel class
local Panel = Class('Panel')

--- Constructor for the Panel class
--@param dim the dimensions of the panel
function Panel:initialize(rect)
    self.rect = rect or Rect(0, 0, PANEL_DEFAULT_WIDTH, PANEL_DEFAULT_HEIGHT)
    self.parent = nil
end

function Panel:setParent(parent)
    self.parent = parent
end

function Panel:getParent()
    return self.parent
end

-- Lifecycle methods
function Panel:show()
    -- Code to show the panel
end

function Panel:hide()
    -- Code to hide the panel
end

function Panel:update(dt)
    -- Code to update the panel
end

--- set the position of the panel and then draw using internal _draw method
-- Subclasses should override the _draw method
function Panel:draw()
    love.graphics.push()
    self:_draw()
    love.graphics.pop()
end

function Panel:_draw()
    -- Code to draw the panel
end

function Panel:keypressed(key)
    -- Code to handle key press
end

function Panel:mousepressed(x, y, button, istouch, presses)
    if self.rect:contains(x, y) then
        self:_mousepressed(x, y, button, istouch, presses)
    end
end

function Panel:_mousepressed(x, y, button, istouch, presses)
end

function Panel:mousereleased(x, y, button, istouch, presses)
    if self.rect:contains(x, y) then
        self:_mousereleased(x, y, button, istouch, presses)
    end
end

function Panel:_mousereleased(x, y, button, istouch, presses)
end

function Panel:mousemoved(x, y, dx, dy, istouch)
    if self.rect:contains(x, y) then
        self:_mousemoved(x, y, dx, dy, istouch)
    else
        self:_mouseout()
    end
end

function Panel:_mousemoved(x, y, dx, dy, istouch)
end

function Panel:_mouseout()
end

function Panel:getWidth()
    return self.rect:getWidth()
end

function Panel:getHeight()
    return self.rect:getHeight()
end

function Panel:getX()
    return self.rect:getX()
end

function Panel:getY()
    return self.rect:getY()
end

function Panel:setX(x)
    self.rect:setX(x)
end

function Panel:setY(y)
    self.rect:setY(y)
end

return Panel
```