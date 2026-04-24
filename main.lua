local ne0luv = require('.')

local root
local statusText

function love.load()
    love.window.setTitle('ne0luv panel refactor playground')

    local title = ne0luv.Text(ne0luv.Rect(0, 0, 280, 24), {
        text = 'Panel local coordinates demo'
    })

    statusText = ne0luv.Text(ne0luv.Rect(0, 32, 280, 24), {
        text = 'Click the button or drag the slider'
    })

    local button = ne0luv.Button(ne0luv.Rect(0, 64, 180, 32), {
        text = 'Activate',
        onActivate = function()
            statusText:setText('Button activated')
        end
    })

    local slider = ne0luv.Slider(ne0luv.Rect(0, 112, 220, 24), {
        minValue = 0,
        maxValue = 100,
        currentValue = 25
    })

    slider:addChangeHandler(function(value)
        statusText:setText(string.format('Slider value: %.0f', value))
    end)

    root = ne0luv.Layout(ne0luv.Rect(100, 100, 280, 180), {
        layout = 'column',
        bgColor = { 0.1, 0.1, 0.1, 0.85 }
    })

    root:addChild(title)
    root:addChild(statusText)
    root:addChild(button)
    root:addChild(slider)
end

function love.update(dt)
    root:update(dt)
end

function love.draw()
    root:draw()
end

function love.mousepressed(x, y, button, istouch, presses)
    root:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
    root:mousereleased(x, y, button, istouch, presses)
end

function love.mousemoved(x, y, dx, dy, istouch)
    root:mousemoved(x, y, dx, dy, istouch)
end
