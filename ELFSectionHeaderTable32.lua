local ELFSectionHeaderTable = require("ELFSectionHeaderTable")
local ELFSectionHeaderTable32 = ELFSectionHeaderTable:new()

function ELFSectionHeaderTable32:new(object, fileReader, header)
    object = object or ELFSectionHeaderTable:new(object, fileReader, header)
    setmetatable(object, self)
    self.__index = self
    return object
end

function ELFSectionHeaderTable32:_readSectionHeaderFlagsByOffset(offset)
    return self._fileReader:readInteger32ByOffset(offset + 0x8)
end

function ELFSectionHeaderTable32:_readSectionHeaderInformationByOffset(offset)
    local sectionHeaderInformation = {
        offset = self._fileReader:readInteger32ByOffset(offset + 0x10),
        size = self._fileReader:readInteger32ByOffset(offset + 0x14),
        entsize = self._fileReader:readInteger32ByOffset(offset + 0x24)
    }
    return sectionHeaderInformation
end


return ELFSectionHeaderTable32