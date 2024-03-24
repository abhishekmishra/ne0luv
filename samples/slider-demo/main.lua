--- main.lua: Demo the slider control.
--
-- date: 24/03/2024
-- author: Abhishek Mishra

package.path = package.path .. ';' .. '../../?.lua'

local Slider = require('slider')

local slider0

function love.load()
    slider0 = Slider(10, 10, 200, 30, 0, 100, 50)
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
