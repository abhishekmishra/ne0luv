local Layout = require('layout')
local Rect = require('rect')

local top

local topConfig = {
    bgColor = { 1, 0, 0, 1 }
}

function love.load()
    top = Layout(
        Rect(0, 0, love.graphics.getWidth(), love.graphics.getHeight()),
        topConfig
    )
    top:show()
end

function love.draw()
    top:draw()
end
