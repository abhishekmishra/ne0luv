local ne0luv = require('.')

local text
function love.load()
    text = ne0luv.Text(ne0luv.Rect(0, 0, 100, 100), {
        text = 'hello world'
    })
end

function love.update(dt)
    text:update(dt)
end

function love.draw()
    text:draw()
end
