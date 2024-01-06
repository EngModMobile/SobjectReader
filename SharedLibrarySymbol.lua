local ELFSectionHeaderTable32 = require("ELFSectionHeaderTable32")
local ELFSectionHeaderTable64 = require("ELFSectionHeaderTable64")
local SymbolDynamicSectionTable32 = require("SymbolDynamicSectionTable32")
local SymbolDynamicSectionTable64 = require("SymbolDynamicSectionTable64")
local ELFHeader32 = require("ELFHeader32")
local ELFHeader64 = require("ELFHeader64")
local FileReader = require("FileReader")
local BigEndianHandler = require("BigEndianHandler")
local LittleEndianHandler = require("LittleEndianHandler")
local Symbol = require("Symbol")
local SharedLibrarySymbol = {}

function SharedLibrarySymbol.create(path)
    local fileReader = FileReader:new(nil, path, "rb")
    local bytesMagic = fileReader:readDataByOffset(0, 4)
    local data = fileReader:readByteByOffset(5)
    fileReader:setBytesHandler(data == 1 and LittleEndianHandler:new() or BigEndianHandler:new())
    if bytesMagic == "\x7fELF" then
        local header, sectionHeader, informationDynamicLinkingSections;
        local class = fileReader:readByteByOffset(4)
        local symbolDynamicSectionTable = nil
        local symbolInformation = nil
        local symbol = nil
        local dynstr = nil
        if class == 1 then
            header = ELFHeader32:new(nil, fileReader)
            sectionHeader = ELFSectionHeaderTable32:new(nil, fileReader, header)
            informationDynamicLinkingSections = sectionHeader:readInformationDynamicLinkingSections()
            symbolDynamicSectionTable = SymbolDynamicSectionTable32:new(nil, fileReader, informationDynamicLinkingSections.dynsym)
            symbolInformation = symbolDynamicSectionTable:readInformationFromSymbols()
            dynstr = fileReader:readDataByOffset(informationDynamicLinkingSections.dynstr.offset, informationDynamicLinkingSections.dynstr.size)
            symbol = Symbol:new(nil, dynstr, symbolInformation)
        elseif class == 2 then
            header = ELFHeader64:new(nil, fileReader)
            sectionHeader = ELFSectionHeaderTable64:new(nil, fileReader, header)
            informationDynamicLinkingSections = sectionHeader:readInformationDynamicLinkingSections()
            symbolDynamicSectionTable = SymbolDynamicSectionTable64:new(nil, fileReader, informationDynamicLinkingSections.dynsym)
            symbolInformation = symbolDynamicSectionTable:readInformationFromSymbols()
            dynstr = fileReader:readDataByOffset(informationDynamicLinkingSections.dynstr.offset, informationDynamicLinkingSections.dynstr.size)
            symbol = Symbol:new(nil, dynstr, symbolInformation)
        end
        local symbolTable = symbol:getSymbolTable()
        fileReader:close()
        return symbolTable
    end
end

return SharedLibrarySymbol