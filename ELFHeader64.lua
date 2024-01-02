local ELFHeader = require("ELFHeader")

local ELFHeader64 = ELFHeader

function ELFHeader64:readSectionHeaderTableInformation()
    local sectionHeaderTableInformation = {
        off = self._readerFile:readInteger64FromOffset(0x28),
        entsize = self._readerFile:readInteger16FromOffset(0x3a),
        num = self._readerFile:readInteger16FromOffset(0x3c),
    }
    return sectionHeaderTableInformation
end

return ELFHeader64