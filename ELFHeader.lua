local FileHandler = require("FileHandler")

local ELFHeader = {}


function ELFHeader:new(fileHandler)
    local obj = {}
    obj._fileHandler = fileHandler
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function ELFHeader:readSectionHeaderTableInformation()
end

return ELFHeader