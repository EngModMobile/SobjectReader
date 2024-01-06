local SymbolDynamicSectionTable = require("SymbolDynamicSectionTable")
local SymbolDynamicSectionTable64 = SymbolDynamicSectionTable:new()

function SymbolDynamicSectionTable64:new(object, fileReader, dynsym)
    object = object or SymbolDynamicSectionTable:new(object, fileReader, dynsym)
    setmetatable(object, self)
    self.__index = self
    return object
end

function SymbolDynamicSectionTable64:_readSymbolInformationByOffset(offset)
    local symbolInformation = {
        value = self._fileReader:readInteger64ByOffset(offset + 0x8),
        size = self._fileReader:readInteger64ByOffset(offset + 16),
        info = self._fileReader:readByteByOffset(offset + 0x4)
    }
    return symbolInformation
end

return SymbolDynamicSectionTable64
