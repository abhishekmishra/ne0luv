--- button.lua - A simple button class
--
-- date: 17/02/2024
-- author: Abhishek Mishra
local class = require('middleclass')
local Panel = require('panel')

--- Button class
local Button = class('Button', Panel)

--- a counter to keep track of the number of buttons created
Button.static.idCounter = 0

--- constructor
--@param displayText the text to display on the button
--@param onActivate the function to call when the button is activated
function Button:initialize(width, height, displayText, onActivate, colors)
    Panel.initialize(self, width, height)
    Button.idCounter = Button.idCounter + 1
    self.id = 'Button' .. Button.idCounter
    self.displayText = displayText
    self.onActivate = onActivate or function() end
    self.text = love.graphics.newText(love.graphics.getFont(), self.displayText)
    self.colors = colors or {
        bg = { 0.5, 0.5, 0.5, 1 },
        fg = { 1, 1, 1, 1 },
        bgSelect = { 0.7, 0.7, 0.7, 1 },
        fgSelect = { 0, 0, 0, 1 }
    }
end

function Button:toggleSelect()
    self.select = not self.select
end

function Button:isSelected()
    return self.select
end

function Button:setSelected(selected)
    if selected == nil then
        selected = true
    end
    self.select = selected
end

--- run the onActivate function
function Button:activate()
    self.onActivate()
end

--- draw the button
function Button:_draw()
    local bgColor, fgColor
    love.graphics.push()
    if self:isSelected() then
        bgColor = self.colors.bgSelect
        fgColor = self.colors.fgSelect
    else
        bgColor = self.colors.bg
        fgColor = self.colors.fg
    end
    love.graphics.setColor(bgColor)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(fgColor)
    love.graphics.draw(self.text, self.x + 10, self.y + 10)
    love.graphics.pop()
end

function Button:_mouseout()
    self:setSelected(false)
end

function Button:_mousemoved(x, y, dx, dy, istouch)
    if self:contains(x, y) then
        self:setSelected(true)
    else
        self:setSelected(false)
    end
end

function Button:_mousepressed(x, y, button, istouch, presses)
    if self:contains(x, y) then
        self:activate()
    end
end

-- contains - check if the button contains the point x, y
function Button:contains(x, y)
    return x >= 0 and x <= self.width and
        y >= 0 and y <= self.height
end

return Button
