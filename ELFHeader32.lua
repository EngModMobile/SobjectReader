local ELFHeader = require("ELFHeader")
local ELFHeader32 = ELFHeader:new()

function ELFHeader32:new(object, fileReader)
    object = object or ELFHeader:new(object, fileReader)
    setmetatable(object, self)
    self.__index = self
    return object
end

function ELFHeader32:readSectionHeaderTableInformation()
    local sectionHeaderTableInformation = {
        off = self._fileReader:readInteger32ByOffset(0x20),
        entsize = self._fileReader:readInteger16ByOffset(0x2e),
        num = self._fileReader:readInteger16ByOffset(0x30),
    }
    return sectionHeaderTableInformation
end

return ELFHeader32