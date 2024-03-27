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
        { name = 'ne0luv', codeFile = 'ne0luv.lua' },
    }
}

-- generate the documents
for _, doc in pairs(DOCUMENTS) do
    print(doc)
    doc:clean()
    doc:generate()
end

print('Done!')
