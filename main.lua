local Layout = require('layout')
local Rect = require('rect')

local top

local topConfig = {
    layout = 'column',
    bgColor = { 1, 0, 0, 1 }
}

function love.load()
    top = Layout(
        Rect(0, 0, love.graphics.getWidth(), love.graphics.getHeight()),
        topConfig
    )
    for i = 1, 3 do
        top:addChild(
            Layout(
                Rect(0, 0, 100, 100),
                {
                    bgColor = { 0, 0, 0.2 * i, 1 }
                }
            )
        )
    end
    top:show()
end

function love.draw()
    top:draw()
end

function love.keypressed(key)
    top:keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end