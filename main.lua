---@diagnostic disable: duplicate-set-field
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
        local lp = Layout(
            Rect(0, 0, top:getWidth(), top:getHeight()/3.0),
            {
                bgColor = { 0, 0, 0.2 * i, 1 }
            }
        )
        for j = 1, 3 do
            local sp = Layout(
                Rect(0, 0, lp:getWidth()/3, lp:getHeight()),
                {
                    bgColor = { 0.2 * i, 0.2 * j, 0, 1 }
                }
            )
            lp:addChild(sp)
        end
        top:addChild(lp)
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
