--- layout_panel.lua - A class for a panel that lays out child components
--                     in a row or column
-- date: 17/02/2024
-- author: Abhishek Mishra

local class = require('middleclass')

-- Require the Panel class
local Panel = require('panel')

-- Define the Layout class that extends the Panel class
Layout = class('Layout', Panel)

-- Constructor for the Layout class
function Layout:initialize(rect, config)
    Panel.initialize(self, rect)
    self.config = config or {}
    -- Default layout is row
    self.layout = self.config.layout or 'row'
    -- Default fill color is black
    self.bgColor = self.config.bgColor or { 0, 0, 0, 1 }
    -- Initialize an empty table for child components
    self.children = {}
end

-- Method to add a child component
function Layout:addChild(c)
    table.insert(self.children, c)

    -- Set the parent of the child to this layout
    c:setParent(self)

    -- set the position of the child based on layout, and the size of the children

    -- if layout is row
    if self.layout == 'row' then
        local startPos = 0
        for _, child in ipairs(self.children) do
            child:setX(startPos)
            startPos = startPos + child:getWidth()
        end
    else -- layout is column
        local startPos = 0
        for _, child in ipairs(self.children) do
            child:setY(startPos)
            startPos = startPos + child:getHeight()
        end
    end

end

function Layout:setX(x)
    -- set the x position of the layout
    local prevX = self:getX()
    self.rect:setX(x)
    local diff = x - prevX
    -- update the x position of all the children
    -- if layout is row
    if self.layout == 'row' then
        -- adjust the x position of all the children
        for _, child in ipairs(self.children) do
            child:setX(child:getX() + diff)
        end
    end
    if self.layout == 'column' then
        -- adjust the x position of all the children
        for _, child in ipairs(self.children) do
            child:setX(self:getX())
        end
    end
end

function Layout:setY(y)
    -- set the y position of the layout
    local prevY = self:getY()
    self.rect:setY(y)
    local diff = y - prevY
    -- update the y position of all the children
    -- if layout is row
    if self.layout == 'row' then
        -- adjust the y position of all the children
        for _, child in ipairs(self.children) do
            child:setY(self:getY())
        end
    end
    if self.layout == 'column' then
        -- adjust the y position of all the children
        for _, child in ipairs(self.children) do
            child:setY(child:getY() + diff)
        end
    end
end

-- Get children
function Layout:getChildren()
    return self.children
end

-- Method to set the background color for the panel
function Layout:setBGColor(color)
    self.bgColor = color
end

-- show method
function Layout:show()
    -- Iterate over child components and show them
    local startPos = 0
    for _, child in ipairs(self.children) do
        child:show()
    end
end

-- hide method
function Layout:hide()
    -- Iterate over child components and hide them
    for _, child in ipairs(self.children) do
        child:hide()
    end
end

-- Override the _draw method
function Layout:_draw()
    -- Draw the background
    love.graphics.setColor(self.bgColor)
    love.graphics.rectangle('fill', self:getX(), self:getY(), self:getWidth(), self:getHeight())
    -- Iterate over child components and draw them
    for _, child in ipairs(self.children) do
        child:draw()
    end
end

-- Override the update method
function Layout:update(dt)
    -- Iterate over child components and update them
    for _, child in ipairs(self.children) do
        child:update(dt)
    end
end

-- Override the keypressed method
function Layout:keypressed(key)
    -- Iterate over child components and pass the keypress event
    for _, child in ipairs(self.children) do
        child:keypressed(key)
    end
end

-- Override the mousepressed method
function Layout:_mousepressed(x, y, button, istouch, presses)
    -- print("Layout:_mousepressed [" .. x .. ", " .. y .. "]")
    -- Iterate over child components and pass the mousepress event
    for _, child in ipairs(self.children) do
        child:mousepressed(x, y, button, istouch, presses)
    end
end

-- Override the mousereleased method
function Layout:_mousereleased(x, y, button, istouch, presses)
    -- Iterate over child components and pass the mouserelease event
    for _, child in ipairs(self.children) do
        child:mousereleased(x, y, button, istouch, presses)
    end
end

-- Override the mousemoved method
function Layout:_mousemoved(x, y, dx, dy, istouch)
    -- print("Layout:_mousemoved [" .. x .. ", " .. y .. "]")
    -- Iterate over child components and pass the mousemove event
    for _, child in ipairs(self.children) do
        child:mousemoved(x, y, dx, dy, istouch)
    end
end

return Layout
