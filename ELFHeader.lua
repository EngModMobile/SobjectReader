local ELFHeader = {
    _readerFile = 2
}

function ELFHeader:new(object, readerFile)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    self._readerFile = readerFile
    return object
end

function ELFHeader:readSectionHeaderTableInformation()
end



--print(header)
return ELFHeader
