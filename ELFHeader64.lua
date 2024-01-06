local ELFHeader = require("ELFHeader")
local ELFHeader64 = ELFHeader:new()

function ELFHeader64:new(object, fileReader)
    object = object or ELFHeader:new(object, fileReader)
    setmetatable(object, self)
    self.__index = self
    return object
end

function ELFHeader64:readSectionHeaderTableInformation()
    local sectionHeaderTableInformation = {
        off = self._fileReader:readInteger64ByOffset(0x28),
        entsize = self._fileReader:readInteger16ByOffset(0x3a),
        num = self._fileReader:readInteger16ByOffset(0x3c),
    }
    return sectionHeaderTableInformation
end

return ELFHeader64