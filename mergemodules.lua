--- mergemodules.lua - A script to merge multiple lua files into a single file
--
-- date: 25/03/2024
-- author: Abhishek Mishra

-- Define the modules to merge
local moduleSequence = {
    'Screen',
    'Vector',
    'Rect',
    'Panel',
    'Text',
    'Button',
    'Slider',
    'Layout'
}
local moduleFiles = {
    Screen = 'screen.lua',
    Panel = 'panel.lua',
    Vector = 'vector.lua',
    Text = 'text.lua',
    Button = 'button.lua',
    Slider = 'slider.lua',
    Layout = 'layout.lua',
    Rect = 'rect.lua'
}

-- Define the output file
local outputFile = 'dist/ne0luv.lua'

-- Open the output file
local output = io.open(outputFile, 'w')

if not output then
    print('Error: Could not open output file at ' .. outputFile)
    return
end

-- Write the header
output:write('--[[\n')
output:write('  ne0luv - Some love2d utilities\n')
output:write('\n')
output:write('  date: 25/03/2024\n')
output:write('  author: Abhishek Mishra\n')
output:write(']]\n')

-- Write the module loader
output:write('local modules = {}\n')
output:write('\n')

-- Write the modules
for _, moduleName in ipairs(moduleSequence) do
    local moduleFile = moduleFiles[moduleName]
    local file = io.open(moduleFile, 'r')

    if not file then
        print('Error: Could not open module file at ' .. moduleFile)
        return
    end

    output:write('\n')
    output:write('-- ' .. moduleName .. '\n')
    output:write('\n')

    local content = file:read('*a')
    -- replace "return moduleName" with "modules[moduleName] = moduleName"
    content = content:gsub('return ' .. moduleName, 'modules["' .. moduleName .. '"] = ' .. moduleName)
    -- replace any line which requires a module in the moduleSequence with an empty line.
    for _, module in ipairs(moduleSequence) do
        content = content:gsub('require%(\'' .. module .. '\'%)', '')
    end
    output:write(content)

    file:close()
end

-- Load the modules into the modules table
for _, module in ipairs(moduleFiles) do
    output:write('modules["' .. module .. '"] = ' .. module .. '()\n')
end

-- Return the modules table
output:write('return modules\n')

-- Close the output file
output:close()

print('Merged modules into ' .. outputFile)