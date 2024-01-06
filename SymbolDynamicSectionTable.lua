local SymbolDynamicSectionTable = {}
SymbolDynamicSectionTable._fileReader= nil
SymbolDynamicSectionTable._dynsym = nil


function SymbolDynamicSectionTable:new(object, fileReader, dynsym)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    self._fileReader = fileReader
    self._dynsym = dynsym
    return object
end

function SymbolDynamicSectionTable:_readSymbolInformationByOffset(offset)
end

function SymbolDynamicSectionTable:readInformationFromSymbols()
    local symbolInformation = {}
    local sizeSymbolTable = self._dynsym.size / self._dynsym.entsize
    do
        local offset = self._dynsym.offset
        for i = 1, sizeSymbolTable do
            symbolInformation[i] = self:_readSymbolInformationByOffset(offset)
            symbolInformation[i].name = self._fileReader:readInteger32ByOffset(offset)
            offset = offset + self._dynsym.entsize
        end
    end
    return symbolInformation
end

return SymbolDynamicSectionTable