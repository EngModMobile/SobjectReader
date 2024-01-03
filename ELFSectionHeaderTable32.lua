local ELFSectionHeaderTable32 = require("ELFSectionHeaderTable")

function ELFSectionHeaderTable32:_readSectionHeaderFlagsByOffset(offset)
     return self._fileHandler:readInteger32FromOffset(offset + 0x8)
end

function ELFSectionHeaderTable32:_readSectionHeaderInformationByOffset(offset)
    local sectionHeaderInformation = {
        offset = self._readerFile:readInteger32FromOffset(offset + 0x10),
        size = self._readerFile:readInteger32FromOffset(offset + 0x14),
        entsize = self._readerFile:readInteger32FromOffset(offset + 0x24)
    }
    return SectionHeaderInformation
end


return ELFSectionHeaderTable32