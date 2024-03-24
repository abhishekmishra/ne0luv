local Class = require('middleclass')
local Vector = require('vector')

local Rect = Class('Rect')

function Rect:initialize(x, y, w, h)
    self.pos = Vector(x, y)
    self.dim = Vector(w, h)
end

function Rect:contains(x, y)
    return (x >= self.pos.x and x <= self.pos.x + self.dim.w
        and y >= self.pos.y and y <= self.pos.y + self.dim.h)
end

function Rect:getWidth()
    return self.dim.w
end

function Rect:getHeight()
    return self.dim.h
end

function Rect:getX()
    return self.pos.x
end

function Rect:getY()
    return self.pos.y
end

function Rect:setX(x)
    self.pos.x = x
end

function Rect:setY(y)
    self.pos.y = y
end

function Rect:setWidth(w)
    self.dim.w = w
end

function Rect:setHeight(h)
    self.dim.h = h
end

return Rect
