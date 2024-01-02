local ELFHeader = {}
ELFHeader.mFileHandler = nil

function ELFHeader:new(fileHandler)
    local obj = {}
    self.mFileHandler = fileHandler
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function ELFHeader:readSectionHeaderTableInformation()
end

return ELFHeader
