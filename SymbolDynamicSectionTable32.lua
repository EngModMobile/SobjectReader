local SymbolDynamicSectionTable = require("SymbolDynamicSectionTable")
local SymbolDynamicSectionTable32 = SymbolDynamicSectionTable:new()

function SymbolDynamicSectionTable32:new(object, fileReader, dynsym)
    object = object or SymbolDynamicSectionTable:new(object, fileReader, dynsym)
    setmetatable(object, self)
    self.__index = self
    return object
end

function SymbolDynamicSectionTable32:_readSymbolInformationByOffset(offset)
    local symbolInformation = {
        value = self._fileReader:readInteger32ByOffset(offset + 0x4),
        size = self._fileReader:readInteger32ByOffset(offset + 0x8),
        info = self._fileReader:readByteByOffset(offset + 0xc)
    }
    return symbolInformation
end

return SymbolDynamicSectionTable32