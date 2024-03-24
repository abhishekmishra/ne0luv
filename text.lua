--- text.lua - A panel class that displays a single line of text
--
-- date: 17/02/2024
-- author: Abhishek Mishra

-- Require the middleclass library
local Class = require('middleclass')

-- Require the Panel class
local Panel = require('Panel')

-- Define the Text class that extends the Panel class
Text = Class('Text', Panel)

-- Constructor for the Text class
function Text:initialize(rect, config)
    Panel.initialize(self, rect)
    self.config = config or {}
    self.fgColor = self.config.fgColor or { 1, 1, 1, 1 } -- Default text color is white
    self.font = self.config.font or love.graphics.newFont(14) -- Default font size is 14
    self.displayText = self.config.text or "" -- Default text is an empty string
    self._text = love.graphics.newText(self.font, self.displayText) -- Create the love2d text object
end

-- Method to set the text
function Text:setText(text)
    self.displayText = text
    self._text:set(text) -- Update the love2d text object
end

-- Override the draw method
function Text:_draw()
    love.graphics.setColor(self.fgColor)
    love.graphics.setFont(self.font)
    love.graphics.draw(self._text, self:getX(), self:getY())
end

return Text