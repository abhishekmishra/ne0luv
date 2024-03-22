--- panel.lua - A panel class
--
-- date: 17/02/2024
-- author: Abhishek Mishra

-- Require the middleclass library
local class = require('lib/middleclass')

-- Define the Panel class
Panel = class('Panel')

-- Constructor for the Panel class
function Panel:initialize(x, y, width, height)
    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 100
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
    love.graphics.translate(self.x, self.y)
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
    if wx >= 0 and wx <= self.width and wy >= 0 and wy <= self.height then
        self:_mousepressed(wx, wy, button, istouch, presses)
    end
end

function Panel:_mousepressed(x, y, button, istouch, presses)
end

function Panel:mousereleased(x, y, button, istouch, presses)
    local wx, wy = self:screenToWorld(x, y)
    if wx >= 0 and wx <= self.width and wy >= 0 and wy <= self.height then
        self:_mousereleased(wx, wy, button, istouch, presses)
    end
end

function Panel:_mousereleased(x, y, button, istouch, presses)
end

function Panel:mousemoved(x, y, dx, dy, istouch)
    local wx, wy = self:screenToWorld(x, y)
    if wx >= 0 and wx <= self.width and wy >= 0 and wy <= self.height then
        self:_mousemoved(wx, wy, dx, dy, istouch)
    else
        self:_mouseout()
    end
end

function Panel:_mousemoved(x, y, dx, dy, istouch)
end

function Panel:_mouseout()
end

function Panel:getX()
    return self.x
end

function Panel:getY()
    return self.y
end

function Panel:getWidth()
    return self.width
end

function Panel:getHeight()
    return self.height
end

return Panel
