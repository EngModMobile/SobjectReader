local ELFSectionHeaderTable = require("ELFSectionHeaderTable")
local ELFSectionHeaderTable64 = ELFSectionHeaderTable:new()

function ELFSectionHeaderTable64:new(object, readerFile, header)
    object = object or ELFSectionHeaderTable:new(object, readerFile, header)
    setmetatable(object, self)
    self.__index = self
    return object
end

function ELFSectionHeaderTable64:_readSectionHeaderFlagsByOffset(offset)
     return self._readerFile:readInteger64FromOffset(offset + 0x8)
end

function ELFSectionHeaderTable64:_readSectionHeaderInformationByOffset(offset)
    local sectionHeaderInformation = {
        offset = self._readerFile:readInteger64FromOffset(offset + 0x14),
        size = self._readerFile:readInteger64FromOffset(offset + 0x20),
        entsize = self._readerFile:readInteger64FromOffset(offset + 0x38)
    }
    return SectionHeaderInformation
end


return ELFSectionHeaderTable64