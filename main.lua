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

local sectionHeader32 = ELFSectionHeaderTable32:new(nil, readerFile, header32)
local sections = sectionHeader32:readInformationDynamicLinkingSections()
print(readerFile:readBufferFromOffset(sections.dynstr.offset, sections.dynstr.size))