local ELFHandler = require("ELFHandler")

local ELFHandler32 = ELFHandler

function ELFHandler32:readSectionHeaderTableInfos()
    local sectionHeaderTableInfos = {
        off = self.file:readIntegerByOffset(0x20, 4),
        entsize = self.file:readIntegerByOffset(0x2e, 2),
        num = self.file:readIntegerByOffset(0x30, 2),
    }
    return sectionHeaderTableInfos
end


function ELFHandler32:findSectionHeaderValuesByOffset(offset)
    local sectionHeaderValues = {}
    sectionHeaderValues.type = self.buffer:readIntegerByOffset(offset + 0x4, 4)
    sectionHeaderValues.flags = self.buffer:readIntegerByOffset(offset + 0x8, 4)
    sectionHeaderValues.offset = self.buffer:readIntegerByOffset(offset + 0x10, 4)
    sectionHeaderValues.size = self.buffer:readIntegerByOffset(offset + 0x14, 4)
    sectionHeaderValues.entsize = self.buffer:readIntegerByOffset(offset + 0x24, 4)
    return sectionHeaderValues
end

return ELFHandler32