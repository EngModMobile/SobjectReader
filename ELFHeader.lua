local ELFHeader = {}
ELFHeader._fileReader = nil

function ELFHeader:new(object, fileReader)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    self._fileReader = fileReader
    return object
end

function ELFHeader:readSectionHeaderTableInformation()
end

return ELFHeader
