local ELFHeader = {}
ELFHeader._readerFile = nil

function ELFHeader:new(readerFile)
    local object = {}
    self._readerFile = readerFile
    setmetatable(object, self)
    self.__index = self
    return obj
end

function ELFHeader:readSectionHeaderTableInformation()
end

return ELFHeader
