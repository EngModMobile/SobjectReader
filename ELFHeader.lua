local ELFHeader = {}
ELFHeader.mReaderFile = nil

function ELFHeader:new(readerFile)
    local obj = {}
    self.mReaderFile = readerFile
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function ELFHeader:readSectionHeaderTableInformation()
end

return ELFHeader
