--- text_panel.lua - A panel class that displays text
--
-- date: 17/02/2024
-- author: Abhishek Mishra

-- Require the middleclass library
local Class = require('middleclass')

-- Require the Panel class
local Panel = require('Panel')

-- Define the TextPanel class that extends the Panel class
TextPanel = Class('TextPanel', Panel)

-- Constructor for the TextPanel class
function TextPanel:initialize(x, y, width, height, text, font)
    Panel.initialize(self, x, y, width, height)
    self.font = font or love.graphics.newFont(14) -- Default font size is 14
    self.displayText = text or "" -- Default text is an empty string
    self._text = love.graphics.newText(self.font, self.displayText) -- Create the love2d text object
end

-- Method to set the text
function TextPanel:setText(text)
    self.displayText = text
    self._text:set(text) -- Update the love2d text object
end

-- Override the draw method
function TextPanel:_draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(self.font)
    love.graphics.draw(self._text, self.x, self.y)
end

return TextPanel