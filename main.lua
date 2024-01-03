local ELFSectionHeaderTable32 = require("ELFSectionHeaderTable32")
local ELFSectionHeaderTable64 = require("ELFSectionHeaderTable64")
local ELFHeader32 = require("ELFHeader32")
local ELFHeader64 = require("ELFHeader64")
local ReaderFile = require("ReaderFile")
local BigEndianHandler = require("BigEndianHandler")
local LittleEndianHandler = require("LittleEndianHandler")

local binPath = "/storage/emulated/0/libqplay.so"
local readerFile = ReaderFile:new(nil, binPath, "r")
readerFile:setBytesHandler(LittleEndianHandler:new())
local header32 = ELFHeader32:new(nil, readerFile)
print(header32:readSectionHeaderTableInformation())