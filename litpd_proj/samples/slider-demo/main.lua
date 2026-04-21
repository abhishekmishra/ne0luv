--- main.lua: Demo the slider control.
--
-- date: 24/03/2024
-- author: Abhishek Mishra

package.path = package.path .. ';' .. '../../dist/?.lua' .. ';' .. '../../?.lua'

local nl = require('ne0luv')
local Slider = nl.Slider

local slider0

function love.load()
    local rect = nl.Rect(10, 10, 200, 30)
    slider0 = Slider(rect, {
        minValue = 0,
        maxValue = 100,
        currentValue = 50,
        bgColor = { 0.2, 0.2, 0, 1 }
    })
end

function love.draw()
    slider0:draw()
end

function love.mousepressed(x, y, button)
    slider0:mousepressed(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    slider0:mousemoved(x, y, dx, dy)
end

function love.mousereleased(x, y, button)
    slider0:mousereleased(x, y, button)
end
