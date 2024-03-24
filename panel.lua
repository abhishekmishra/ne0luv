--- panel.lua - A panel class
--
-- date: 17/02/2024
-- author: Abhishek Mishra

-- Require the middleclass library
local class = require('middleclass')
local vector = require('vector')

-- Default values for the panel
local PANEL_DEFAULT_WIDTH = 100
local PANEL_DEFAULT_HEIGHT = 100

-- Define the Panel class
Panel = class('Panel')

--- Constructor for the Panel class
--@param dim the dimensions of the panel
function Panel:initialize(dim)
    self.dim = dim or vector(PANEL_DEFAULT_WIDTH, PANEL_DEFAULT_HEIGHT)
    self.translateX = 0
    self.translateY = 0
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
    -- love.graphics.translate(self.x, self.y)
    self:_draw()
    love.graphics.pop()
end

function Panel:screenToWorld(sx, sy)
    -- print(sx, sy, self.translateX, self.translateY)
    return sx - self.translateX, sy - self.translateY
end

function Panel:_draw()
    -- Code to draw the panel
end

function Panel:keypressed(key)
    -- Code to handle key press
end

function Panel:mousepressed(x, y, button, istouch, presses)
    local wx, wy = self:screenToWorld(x, y)
    if wx >= 0 and wx <= self.dim.w and wy >= 0 and wy <= self.dim.h then
        self:_mousepressed(wx, wy, button, istouch, presses)
    end
end

function Panel:_mousepressed(x, y, button, istouch, presses)
end

function Panel:mousereleased(x, y, button, istouch, presses)
    local wx, wy = self:screenToWorld(x, y)
    if wx >= 0 and wx <= self.dim.w and wy >= 0 and wy <= self.dim.h then
        self:_mousereleased(wx, wy, button, istouch, presses)
    end
end

function Panel:_mousereleased(x, y, button, istouch, presses)
end

function Panel:mousemoved(x, y, dx, dy, istouch)
    local wx, wy = self:screenToWorld(x, y)
    if wx >= 0 and wx <= self.dim.w and wy >= 0 and wy <= self.dim.h then
        self:_mousemoved(wx, wy, dx, dy, istouch)
    else
        self:_mouseout()
    end
end

function Panel:_mousemoved(x, y, dx, dy, istouch)
end

function Panel:_mouseout()
end

function Panel:getWidth()
    return self.dim.w
end

function Panel:getHeight()
    return self.dim.h
end

return Panel
