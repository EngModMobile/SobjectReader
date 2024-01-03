local BytesHandler = require("BytesHandler")

local LittleEndianHandler = BytesHandler:new()

function LittleEndianHandler:new(object)
    object = object or BytesHandler:new(object)
    setmetatable(object, self)
    self.__index = self
    return object
end

function LittleEndianHandler:toInteger(bytes)
    local result = 0
    for i = 1, #bytes do
        result = result + bytes[i] * 256 ^ (i - 1)
    end
    return result
end

return LittleEndianHandler









