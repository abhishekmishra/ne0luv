--- layout_panel.lua - A class for a panel that lays out child components
--                     in a row or column
-- date: 17/02/2024
-- author: Abhishek Mishra

local class = require('lib/middleclass')
local vector = require('lib/vector')

-- Require the Panel class
local Panel = require('Panel')

-- Define the Layout class that extends the Panel class
Layout = class('Layout', Panel)

-- Constructor for the Layout class
function Layout:initialize(pos, dim, layout, bgColor)
    self.pos = pos or vector(0, 0)
    Panel.initialize(self, dim)
    self.layout = layout or 'row'            -- Default layout is 'row'
    self.bgColor = bgColor or { 0, 0, 0, 1 } -- Default fill color is black
    self.children = {}                       -- Initialize an empty table for child components
end

-- Method to add a child component
function Layout:addChild(child)
    table.insert(self.children, child)
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
        if self.layout == 'row' then
            child.translateX = child.translateX + startPos
            startPos = startPos + child.width
        else -- layout is 'column'
            child.translateY = child.translateY + startPos
            startPos = startPos + child.height
        end

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
    love.graphics.rectangle('fill', 0, 0, self.dim.w, self.dim.h)
    -- Iterate over child components and draw them
    local startPos = 0
    for i, child in ipairs(self.children) do
        love.graphics.push()
        if self.layout == 'row' then
            love.graphics.translate(startPos, 0)
            startPos = startPos + child.dim.w
        else -- layout is 'column'
            love.graphics.translate(0, startPos)
            startPos = startPos + child.dim.h
        end
        child:draw()
        love.graphics.pop()
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
