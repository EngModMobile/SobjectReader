local BytesHandler = {}

function BytesHandler:new(object)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    return object
end

function BytesHandler:toInteger(bytes)
end

return BytesHandler
