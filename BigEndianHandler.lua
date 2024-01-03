local BytesHandler = require("BytesHandler")

local BigEndianHandler = BytesHandler:new()

function BigEndianHandler:new(object)
    object = object or BytesHandler:new(object)
    setmetatable(object, self)
    self.__index = self
    return object
end

function BigEndianHandler:toInteger(bytes)
    local result = 0
    for i = 1, #bytes do
        result = result + bytes[i] * 256 ^ (#bytes - 1)
    end
    return result
end

return BigEndianHandler