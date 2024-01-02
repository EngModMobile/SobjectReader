local BytesHandler = {}

function BytesHandler:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self
    return object
end

function BytesHandler:toInteger(bytes)
end

return BytesHandler
