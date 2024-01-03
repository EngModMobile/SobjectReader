local ELFSectionHeaderTable = require("ELFSectionHeaderTable")
local ELFSectionHeaderTable32 = ELFSectionHeaderTable:new()

function ELFSectionHeaderTable32:new(object, readerFile, header)
    --print(readerFile, header)
    object = object or ELFSectionHeaderTable:new(object, readerFile, header)
    setmetatable(object, self)
    self.__index = self
    return object
end

function ELFSectionHeaderTable32:_readSectionHeaderFlagsByOffset(offset)
    return self._readerFile:readInteger32FromOffset(offset + 0x8)
end

function ELFSectionHeaderTable32:_readSectionHeaderInformationByOffset(offset)
    local sectionHeaderInformation = {
        offset = self._readerFile:readInteger32FromOffset(offset + 0x10),
        size = self._readerFile:readInteger32FromOffset(offset + 0x14),
        entsize = self._readerFile:readInteger32FromOffset(offset + 0x24)
    }
    return sectionHeaderInformation
end


return ELFSectionHeaderTable32