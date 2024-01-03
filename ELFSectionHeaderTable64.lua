local ELFSectionHeaderTable64 = require("ELFSectionHeaderTable")

function ELFSectionHeaderTable64:_readSectionHeaderFlagsByOffset(offset)
     return self._fileHandler:readInteger64FromOffset(offset + 0x8)
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