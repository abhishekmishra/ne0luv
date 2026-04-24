--- button.lua - A simple button class
--
-- date: 17/02/2024
-- author: Abhishek Mishra

--- Button class
local module_name = ...
local root = assert(module_name:match("^(.*)%.button$"))

local Class = require(root .. '.middleclass')
local Panel = require(root .. '.panel')

local Button = Class('Button', Panel)

--- a counter to keep track of the number of buttons created
Button.static.idCounter = 0

--- constructor
--@param rect dimensions of the panel
--@param config the configuration options for the button
function Button:initialize(rect, config)
    Panel.initialize(self, rect)
    self.config = config
    Button.idCounter = Button.idCounter + 1
    self.id = 'Button' .. Button.idCounter
    self.displayText = self.config.text
    self.onActivate = self.config.onActivate or function() end
    -- self.text = love.graphics.newText(love.graphics.getFont(), self.displayText)
    self.font = self.config.font
    self.align = self.config.align or "left"
    self.colors = {
        bg = self.config.bgColor,
        fg = self.config.fgColor,
        bgSelect = self.config.bgSelectColor or self.config.bgColor,
        fgSelect = self.config.fgSelectColor or self.config.fgColor
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

--- draw the button
function Button:_draw()
    local bgColor, fgColor
    if self:isSelected() then
        bgColor = self.colors.bgSelect
        fgColor = self.colors.fgSelect
    else
        bgColor = self.colors.bg
        fgColor = self.colors.fg
    end
    love.graphics.setColor(bgColor)
    love.graphics.rectangle('fill', self:getX(), self:getY(), self:getWidth(), self:getHeight())
    love.graphics.setColor(fgColor)
    love.graphics.setFont(self.font)
    love.graphics.printf(self.displayText, self:getX(), self:getY(), self:getWidth(), self.align)
end

function Button:_mouseout()
    self:setSelected(false)
end

function Button:_mousemoved(x, y, dx, dy, istouch)
    self:setSelected(true)
end

function Button:_mousepressed(x, y, button, istouch, presses)
    self.onActivate()
end

return Button
