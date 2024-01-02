local ELFHeader = require("ELFHeader")

local ELFHeader32 = ELFHeader

function ELFHeader32:readSectionHeaderTableInformation()
    local sectionHeaderTableInformation = {
        off = self._readerFile:readInteger32FromOffset(0x20),
        entsize = self._readerFile:readInteger16FromOffset(0x2e),
        num = self._readerFile:readInteger16FromOffset(0x30),
    }
    return sectionHeaderTableInformation
end

return ELFHeader32