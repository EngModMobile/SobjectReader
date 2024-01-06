local ELFSectionHeaderTable = require("ELFSectionHeaderTable")
local ELFSectionHeaderTable64 = ELFSectionHeaderTable:new()

function ELFSectionHeaderTable64:new(object, fileReader, header)
    object = object or ELFSectionHeaderTable:new(object, fileReader, header)
    setmetatable(object, self)
    self.__index = self
    return object
end

function ELFSectionHeaderTable64:_readSectionHeaderFlagsByOffset(offset)
     return self._fileReader:readInteger64ByOffset(offset + 0x8)
end

function ELFSectionHeaderTable64:_readSectionHeaderInformationByOffset(offset)
    local sectionHeaderInformation = {
        offset = self._fileReader:readInteger64ByOffset(offset + 0x18),
        size = self._fileReader:readInteger64ByOffset(offset + 0x20),
        entsize = self._fileReader:readInteger64ByOffset(offset + 0x38)
    }
    return sectionHeaderInformation
end


return ELFSectionHeaderTable64