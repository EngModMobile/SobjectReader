local Symbol = {}
Symbol.mFileReader = nil
Symbol.mDynstr = nil
Symbol.mSymbolInformation = nil

function Symbol:new(object, dynstr, symbolInformation)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    self.mFileReader = fileReader
    self.mDynstr = dynstr
    self.mSymbolInformation = symbolInformation
    return object
end

function Symbol:mGetTypeSymbol(info)
    local ST_TYPE = info & 0xf
    if ST_TYPE == 0 then return "NOTYPE"
    elseif ST_TYPE == 1 then return "OBJECT"
    elseif ST_TYPE == 2 then return "FUNC"
    elseif ST_TYPE == 3 then return "SECTION"
    elseif ST_TYPE == 4 then return "FILE"
    end
end

function Symbol:getSymbolTable()
    local symbolTable = {}
    local strStart, strEnd = 0, 0
    for i = 1, #self.mSymbolInformation do
        symbolTable[i] = {}
        strStart, strEnd = self.mDynstr:find("[^\0]+", self.mSymbolInformation[i].name)
        symbolTable[i].name = self.mDynstr:sub(strStart, strEnd)
        symbolTable[i].offset = string.format("%x", self.mSymbolInformation[i].value)
        symbolTable[i].size = self.mSymbolInformation[i].size
        symbolTable[i].type = self:mGetTypeSymbol(self.mSymbolInformation[i].info)
    end
    return symbolTable
end

return Symbol
