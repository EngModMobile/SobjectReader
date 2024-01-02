local BytesHandler = require("BytesHandler")

local LittleEndianHandler = BytesHandler

function LittleEndianHandler:toInteger(bytes)
    local result = 0
    for i = 1, #bytes do
        result = result + bytes[i] * 256 ^ (i - 1)
    end
    return result
end

return LittleEndianHandler









