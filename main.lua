---@diagnostic disable: duplicate-set-field
local nl = require('dist/ne0luv')
local Layout = nl.Layout
local Rect = nl.Rect
local Text = nl.Text
local Slider = nl.Slider

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
    local numOuterPanels = 3
    for i = 1, numOuterPanels do
        local outerPanel = Layout(
            Rect(0, 0, top:getWidth(), top:getHeight() / numOuterPanels),
            {
                bgColor = { 0, 0, 0.2 * i, 1 }
            }
        )
        local numInnerPanels = 3
        for j = 1, numInnerPanels do
            local innerPanel = Layout(
                Rect(0, 0,
                    outerPanel:getWidth() / numInnerPanels, outerPanel:getHeight()),
                {
                    layout = 'column',
                    bgColor = { 0.2 * i, 0.2 * j, 0, 1 }
                }
            )
            local txt = Text(
                Rect(0, 0,
                    innerPanel:getWidth(), innerPanel:getHeight() / numInnerPanels),
                {
                    fgColor = { 1, 1, 1, 1 },
                    text = 'Slider #' .. i .. ', ' .. j,
                    font = love.graphics.newFont(24)
                }
            )
            local slider = Slider(
                Rect(0, 0,
                    innerPanel:getWidth(), innerPanel:getHeight() / numInnerPanels),
                {
                    minValue = 0,
                    maxValue = 100,
                    currentValue = 50,
                    bgColor = { 0.2 * i, 0.2 * j, 0, 1 }
                }
            )
            local sliderValue = Text(
                Rect(0, 0,
                    innerPanel:getWidth(), innerPanel:getHeight() / numInnerPanels),
                {
                    fgColor = { 1, 1, 1, 1 },
                    text = '' .. slider.currentValue,
                    font = love.graphics.newFont(24)
                }
            )

            slider:addChangeHandler(function(value)
                sliderValue:setText('' .. value)
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
