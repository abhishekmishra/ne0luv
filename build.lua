--- build.lua - This program generates individual modules from the litpd files
-- for each module and then merges them into a single file. Each module in the
-- merged file is loaded into a table and returned by the merged file as part
-- of one module.
--
-- date: 25/03/2024
-- author: Abhishek Mishra

local Class = require('middleclass')

-- global Module list
local MODULES = {}

-- global Document list
local DOCUMENTS = {}

-- src folder
local SRC_FOLDER = 'src/'

-- output folder
local OUTPUT_FOLDER = 'dist/'

-- Define the output file
local NE0LUV_FILE = OUTPUT_FOLDER .. 'ne0luv.lua'


--- Module is a class that represents a module in the ne0luv library.
local Module = Class('Module')

--- Module:initialize
-- Create a new module definition and register it with the global MODULES table.
-- @param config A table containing the name of the module, the litpd file, the code file and the html file.
function Module:initialize(config)
    self.name = config.name
    self.codeFile = config.codeFile

    -- register the module as next in the list
    table.insert(MODULES, self)
end

function Module:clean()
    -- clean the dist folder by removing the code
    local cmd = 'rm -f ' .. OUTPUT_FOLDER .. self.codeFile
    print('Executing: ' .. cmd)
    local handle = io.popen(cmd)
    if handle == nil then
        print('Error executing command')
        return
    end
    handle:close()
end

--- Module:generate
-- Generate the module file from the litpd file.
function Module:generate()
    -- move the code file to the output folder
    local cmd = 'mv ' .. self.codeFile .. ' ' .. OUTPUT_FOLDER
    print('Executing: ' .. cmd)
    local handle = io.popen(cmd)
    if handle == nil then
        print('Error executing command')
        return
    end
    handle:close()

    self.codeFile = OUTPUT_FOLDER .. self.codeFile

    print('Generated ' .. self:toString())
end

--- Module:toString
function Module:toString()
    return 'Module: ' .. self.name .. ' (' .. self.codeFile .. ')'
end

-- create the modules
-- Module {'Vector', 'vector.md', 'vector.lua', 'vector.html'}
-- Module {'Rect', 'rect.md', 'rect.lua', 'rect.html'}
-- Module {'Panel', 'panel.md', 'panel.lua', 'panel.html'}
-- Module {'Text', 'text.md', 'text.lua', 'text.html'}
-- Module {'Button', 'button.md', 'button.lua', 'button.html'}
-- Module {'Slider', 'slider.md', 'slider.lua', 'slider.html'}
-- Module {'Layout', 'layout.md', 'layout.lua', 'layout.html'}

--- A document class which represents the main literate program in the ne0luv
-- library.

local Document = Class('Document')

--- Document:initialize
-- Create a new document definition and register it with the global DOCUMENTS table.
-- @param config A table containing the name of the document, the litpd file,
-- and the associated modules.
function Document:initialize(config)
    self.config = config
    self.name = self.config.name
    self.litpdFile = SRC_FOLDER .. self.config.litpd
    self.htmlFile = OUTPUT_FOLDER .. self.name .. '.html'
    self.modules = {}
    for _, c in ipairs(self.config.modules) do
        table.insert(self.modules, Module(c))
    end

    -- register the document as next in the list
    table.insert(DOCUMENTS, self)
end

--- Document:__tostring
function Document:__tostring()
    return 'Document: ' .. self.name .. ' (' .. self.litpdFile .. ' -> ' .. self.htmlFile .. ')'
end

--- Document:clean
-- Clean the document by removing the generated html file.
function Document:clean()
    -- clean the dist folder by removing the html file
    local cmd = 'rm -f ' .. self.htmlFile
    print('Executing: ' .. cmd)
    local handle = io.popen(cmd)
    if handle == nil then
        print('Error executing command')
        return
    end
    handle:close()

    -- clean the modules
    for _, module in pairs(self.modules) do
        module:clean()
    end

    print('Cleaned ' .. self:__tostring())
end

--- Document:generate
-- Generate the document file from the litpd file.
function Document:generate()
    -- run the litpd program to generate the html file
    local cmd = 'lua ./litpd/litpd.lua ' .. self.litpdFile .. ' --to=html --standalone --toc --output=' .. self.htmlFile
    print('Executing: ' .. cmd)
    local handle = io.popen(cmd)
    if handle == nil then
        print('Error executing command')
        return
    end
    handle:close()

    -- generate the modules
    for _, module in pairs(self.modules) do
        module:generate()
    end

    print('Generated ' .. self:__tostring())
end

Document {
    name = 'ne0luv',
    litpd = 'ne0luv.md',
    modules = {
        { name = 'Vector', codeFile = 'vector.lua' },
        -- { name = 'Rect', codeFile = 'rect.lua' },
        -- { name = 'Panel', codeFile = 'panel.lua' },
        -- { name = 'Text', codeFile = 'text.lua' },
        -- { name = 'Button', codeFile = 'button.lua' },
        -- { name = 'Slider', codeFile = 'slider.lua' },
        -- { name = 'Layout', codeFile = 'layout.lua' }
    }
}

for _, doc in pairs(DOCUMENTS) do
    print(doc)
    doc:clean()
    doc:generate()
end
-- Module {'Vector', 'vector.md', 'vector.lua', 'vector.html'}
-- Module {'Rect', 'rect.md', 'rect.lua', 'rect.html'}
-- Module {'Panel', 'panel.md', 'panel.lua', 'panel.html'}
-- Module {'Text', 'text.md', 'text.lua', 'text.html'}
-- Module {'Button', 'button.md', 'button.lua', 'button.html'}
-- Module {'Slider', 'slider.md', 'slider.lua', 'slider.html'}
-- Module {'Layout', 'layout.md', 'layout.lua', 'layout.html'}

-- -- generate the modules
-- for _, module in pairs(MODULES) do
--     module:generate()
-- end

-- -- Open the output file
-- local output = io.open(NE0LUV_FILE, 'w')

-- if not output then
--     print('Error: Could not open output file at ' .. NE0LUV_FILE)
--     return
-- end

-- -- Write the header
-- output:write('--[[\n')
-- output:write('  ne0luv - Some love2d utilities\n')
-- output:write('\n')
-- output:write('  date: 25/03/2024\n')
-- output:write('  author: Abhishek Mishra\n')
-- output:write(']]\n')

-- -- Write the module loader
-- output:write('local modules = {}\n')
-- output:write('\n')

-- -- Write the modules
-- for _, moduleDef in ipairs(MODULES) do
--     local moduleName = moduleDef.name
--     local moduleFile = moduleDef.codeFile

--     print('Merging ' .. moduleName .. ' from ' .. moduleFile)

--     local file = io.open(moduleFile, 'r')

--     if not file then
--         print('Error: Could not open module file at ' .. moduleFile)
--         return
--     end

--     output:write('\n')
--     output:write('-- ' .. moduleName .. '\n')
--     output:write('\n')

--     local content = file:read('*a')
--     -- replace "return moduleName" with ""
--     content = content:gsub('return ' .. moduleName .. '%s+', '')
--     -- replace any line which requires a module in the moduleSequence with an empty line.
--     for _, mdef in ipairs(MODULES) do
--         local m = mdef.name
--         content = content:gsub('local ' .. m .. ' = require%(\'' .. m:lower() .. '\'%)', '')
--     end
--     output:write(content)

--     file:close()
-- end

-- -- Load the modules into the modules table
-- for _, moduleDef in ipairs(MODULES) do
--     local module = moduleDef.name
--     output:write('modules["' .. module .. '"] = ' .. module .. '\n')
-- end

-- -- Return the modules table
-- output:write('return modules\n')

-- -- Close the output file
-- output:close()

-- print('Merged modules into ' .. NE0LUV_FILE)

-- -- copy middleclass.lua to dist folder
-- local cmd = 'cp middleclass.lua ' .. OUTPUT_FOLDER
-- print('Executing: ' .. cmd)
-- local handle = io.popen(cmd)
-- if handle == nil then
--     print('Error executing command')
--     return
-- end
-- handle:close()

-- print('Done!')
