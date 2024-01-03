local ELFHeader = require("ELFHeader")
local ELFHeader64 = ELFHeader:new()

function ELFHeader64:new(object, readerFile)
    object = object or ELFHeader:new(object, readerFile)
    setmetatable(object, self)
    self.__index = self
    return object
end

function ELFHeader64:readSectionHeaderTableInformation()
    local sectionHeaderTableInformation = {
        off = self._readerFile:readInteger64FromOffset(0x28),
        entsize = self._readerFile:readInteger16FromOffset(0x3a),
        num = self._readerFile:readInteger16FromOffset(0x3c),
    }
    return sectionHeaderTableInformation
end

return ELFHeader64