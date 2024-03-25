---@diagnostic disable: duplicate-set-field
local Layout = require('layout')
local Rect = require('rect')
local Text = require('text')
local Slider = require('slider')

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
        local outerPanel = Layout(
            Rect(0, 0, top:getWidth(), top:getHeight() / 3.0),
            {
                bgColor = { 0, 0, 0.2 * i, 1 }
            }
        )
        for j = 1, 3 do
            local innerPanel = Layout(
                Rect(0, 0, outerPanel:getWidth() / 3, outerPanel:getHeight()),
                {
                    layout = 'column',
                    bgColor = { 0.2 * i, 0.2 * j, 0, 1 }
                }
            )
            local txt = Text(
                Rect(0, 0, innerPanel:getWidth(), innerPanel:getHeight() / 3),
                {
                    fgColor = { 1, 1, 1, 1 },
                    text = 'Text ' .. i .. ' ' .. j,
                    font = love.graphics.newFont(24)
                }
            )
            local slider = Slider(
                Rect(0, 0, innerPanel:getWidth(), innerPanel:getHeight() / 3),
                {
                    minValue = 0,
                    maxValue = 100,
                    currentValue = 50,
                    bgColor = { 0.2 * i, 0.2 * j, 0, 1 }
                }
            )
            local sliderValue = Text(
                Rect(0, 0, innerPanel:getWidth(), innerPanel:getHeight() / 3),
                {
                    fgColor = { 1, 1, 1, 1 },
                    text = 'Value: ' .. slider.currentValue,
                    font = love.graphics.newFont(24)
                }
            )

            slider:addChangeHandler(function(value)
                sliderValue:setText('Value: ' .. value)
            end)

            innerPanel:addChild(txt)
            innerPanel:addChild(slider)
            innerPanel:addChild(sliderValue)
            outerPanel:addChild(innerPanel)
        end
        top:addChild(outerPanel)
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

function love.update(dt)
    top:update(dt)
end

function love.mousepressed(x, y, button, istouch, presses)
    top:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
    top:mousereleased(x, y, button, istouch, presses)
end

function love.mousemoved(x, y, dx, dy, istouch)
    top:mousemoved(x, y, dx, dy, istouch)
end
