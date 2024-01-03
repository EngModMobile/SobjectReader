local ELFHeader = require("ELFHeader")
local ELFHeader32 = ELFHeader:new()

function ELFHeader32:new(object, readerFile)
    object = object or ELFHeader:new(object, readerFile)
    setmetatable(object, self)
    self.__index = self
    return object
end

function ELFHeader32:readSectionHeaderTableInformation()
    local sectionHeaderTableInformation = {
        off = self._readerFile:readInteger32FromOffset(0x20),
        entsize = self._readerFile:readInteger16FromOffset(0x2e),
        num = self._readerFile:readInteger16FromOffset(0x30),
    }
    return sectionHeaderTableInformation
end

return ELFHeader32