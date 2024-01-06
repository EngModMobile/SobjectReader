local SharedLibrarySymbol = require("SharedLibrarySymbol")

print("Enter the shared library path:")
local path = io.read()

local symbolTable = SharedLibrarySymbol.create(path)

for i = 1, #symbolTable do
    for j, v in pairs(symbolTable[i]) do
        print(j, v)
    end
end