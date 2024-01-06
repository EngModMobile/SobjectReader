local FileReader = {}
FileReader.mFile = nil
FileReader.mBytesHandler = nil


function FileReader:new(object, filename, mode)
    object = object or {}
    setmetatable(object, self)
    self.mFile = io.open(filename, mode)
    self.__index = self
    return object
end

function FileReader:setBytesHandler(bytesHandler)
    self.mBytesHandler = bytesHandler
end

function FileReader:readDataByOffset(offset, length)
    local currentPosition = self.mFile:seek("cur")
    self.mFile:seek("set", offset)
    local buffer = self.mFile:read(length)
    self.mFile:seek("set", currentPosition)
    return buffer
end

function FileReader:readByteByOffset(offset)
    local buffer = self:readDataByOffset(offset, 1)
    local byte = buffer:byte(1, 1)
    return byte
end

function FileReader:readInteger16ByOffset(offset)
    local buffer = self:readDataByOffset(offset, 2)
    local bytes = {buffer:byte(1, -1)}
    return self.mBytesHandler:toInteger(bytes)
end

function FileReader:readInteger32ByOffset(offset)
    local buffer = self:readDataByOffset(offset, 4)
    local bytes = {buffer:byte(1, -1)}
    return self.mBytesHandler:toInteger(bytes)
end

function FileReader:readInteger64ByOffset(offset)
    local buffer = self:readDataByOffset(offset, 8)
    local bytes = {buffer:byte(1, -1)}
    return self.mBytesHandler:toInteger(bytes)
end

function FileReader:close()
    self.mFile:close()
end

return FileReader