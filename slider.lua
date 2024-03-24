--- slider.lua - A slider control based on the panel class
--
-- date: 17/04/2024
-- author: Abhishek Mishra

-- Require the middleclass library
local class = require('middleclass')

-- Require the Panel class
local Panel = require('Panel')

-- Define the Slider class that extends the Panel class
Slider = class('Slider', Panel)

-- Constructor for the Slider class
function Slider:initialize(width, height, minValue, maxValue, currentValue)
    Panel.initialize(self, width, height)
    self.minValue = minValue or 0                     -- Default minValue is 0
    self.maxValue = maxValue or 100                   -- Default maxValue is 100
    self.currentValue = currentValue or self.minValue -- Default currentValue is minValue
    self.handleWidth = 10                             -- Width of the handle
    self.handleHeight = height                        -- Height of the handle
    self.handleX = self:calculateHandlePosition()     -- X position of the handle
    self.changeHandler = {}
end

-- Method to calculate the handle position based on the current value
function Slider:calculateHandlePosition()
    local range = self.maxValue - self.minValue
    local fraction = (self.currentValue - self.minValue) / range
    return fraction * (self.width - self.handleWidth)
end

-- Method to update the current value based on the handle position
function Slider:updateCurrentValue()
    local range = self.maxValue - self.minValue
    local fraction = (self.handleX) / (self.width - self.handleWidth)
    self.currentValue = self.minValue + fraction * range
    self.currentValue = math.floor(self.currentValue + 0.5)
    self:fireChangeHandlers()
end

function Slider:addChangeHandler(handler)
    table.insert(self.changeHandler, handler)
end

function Slider:fireChangeHandlers()
    for _, handler in ipairs(self.changeHandler) do
        handler(self.currentValue)
    end
end

-- remove handler
function Slider:removeChangeHandler(handler)
    for i, h in ipairs(self.changeHandler) do
        if h == handler then
            table.remove(self.changeHandler, i)
            break
        end
    end
end

-- Override the draw method
function Slider:_draw()
    love.graphics.push()

    -- Draw the line
    love.graphics.line(0, self.height / 2, self.width, self.height / 2)

    if self.dragging then
        love.graphics.setColor(0.5, 0.5, 0.5, 1)
    else
        love.graphics.setColor(0.8, 0.8, 0.8, 1)
    end

    -- Draw the handle
    love.graphics.rectangle('fill', self.handleX, 0, self.handleWidth, self.handleHeight)

    love.graphics.pop()
end

-- Override the mousepressed method
function Slider:_mousepressed(x, y, button)
    -- print("Slider:mousepressed [" .. x .. ", " .. y .. "]")
    if button == 1 and x >= self.handleX
        and x <= self.handleX + self.handleWidth
        and y >= 0 and y <= self.handleHeight then
        self.dragging = true
    else
        self.handleX = x
        self.dragging = false
        self:updateCurrentValue()
    end
end

-- Override the mousemoved method
function Slider:_mousemoved(x, y, dx, dy)
    -- print("Slider:mousemoved")
    if self.dragging then
        self.handleX = self.handleX + dx
        self.handleX = math.max(0,
            math.min(self.width - self.handleWidth, self.handleX))
        self:updateCurrentValue()
    end
end

-- Override the mousereleased method
function Slider:_mousereleased(x, y, button)
    -- print("Slider:mousereleased")
    if button == 1 then
        self.dragging = false
    end
end

return Slider
