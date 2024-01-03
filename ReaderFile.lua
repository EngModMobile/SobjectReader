local ReaderFile = {
    mFile = nil,
    mBytesHandler = nil
}

function ReaderFile:new(object, filename, mode)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    self.mFile = io.open(filename, mode)
    return object
end

function ReaderFile:setBytesHandler(BytesHandler)
    self.mBytesHandler = BytesHandler
end

function ReaderFile:readBufferFromOffset(offset, length)
    local currentPosition = self.mFile:seek("cur")
    self.mFile:seek("set", offset)
    local buffer = self.mFile:read(length)
    self.mFile:seek("set", currentPosition)
    return buffer
end

function ReaderFile:readByteFromOffset(offset)
    local buffer = self:readBufferFromOffset(offset, 1)
    local byte = buffer:byte(1, 1)
    return byte
end

function ReaderFile:readInteger16FromOffset(offset)
    local buffer = self:readBufferFromOffset(offset, 2)
    local bytes = {buffer:byte(1, -1)}
    return self.mBytesHandler:toInteger(bytes)
end

function ReaderFile:readInteger32FromOffset(offset)
    local buffer = self:readBufferFromOffset(offset, 4)
    local bytes = {buffer:byte(1, -1)}
    return self.mBytesHandler:toInteger(bytes)
end

function ReaderFile:readInteger64FromOffset(offset)
    local buffer = self:readBufferFromOffset(offset, 8)
    local bytes = {buffer:byte(1, -1)}
    return self.mBytesHandler:toInteger(bytes)
end

function ReaderFile:close()
    self.mFile:close()
end

return ReaderFile