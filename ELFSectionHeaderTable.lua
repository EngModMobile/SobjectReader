local ELFSectionHeaderTable = {}
ELFSectionHeaderTable._readerFile = nil
ELFSectionHeaderTable._sectionHeaderTableInformation = nil

function ELFSectionHeaderTable:new(readerFile, header)
    local object = {}
    self._readerFile = readerFile
    self._sectionHeaderTableInformation = header:readsectionHeaderTableInformation()
    setmetatable(object, self)
    self.__index = self
    return object
end

function ELFSectionHeaderTable:_readSectionHeaderFlagsByOffset(offset)
end

function ELFSectionHeaderTable:_readSectionHeaderInformationByOffset(offset)
end

function ELFSectionHeaderTable:mIsDynamicLinkingSymbolSection(sectionHeaderType)
    return sectionHeaderType == 0x0b
end

function ELFSectionHeaderTable:mIsDynamicLinkingStringSection(sectionHeaderType, sectionHeaderFlags)
    return sectionHeaderType == 0x3 and sectionHeaderFlags == 0x2
end

function ELFSectionHeaderTable:readInformationDynamicLinkingSections()
    local informationDynamicLinkingSections = {}
    
    do
        local sectionHeaderOffset = self._sectionHeaderTableInformation.off
        local sectionType, sectionFlags
        local loopBreaks = 0
        for i = 1, self._sectionHeaderTableInformation.num do
            sectionHeaderType = self._readerFile:readIntegerByOffset(sectionHeaderOffset + 0x4)
            sectionHeaderFlags = self._readSectionHeaderFlagsByOffset(sectionHeaderOffset + 0x8)
            if self.mIsDynamicLinkingSymbolSection(sectionHeaderType) then
                informationDynamicLinkingSections.dynsym = self._readSectionHeaderInformationByOffset(sectionHeaderOffset)
                loopBreaks = loopBreaks + 1
            elseif self.mIsDynamicLinkingStringSection(sectionHeaderType, sectionHeaderFlags)
                informationDynamicLinkingSections.dynstr = self._readSectionHeaderInformationByOffset(sectionHeaderOffset)
                loopBreaks = loopBreaks + 1
            end
            if(LoopBreaks == 2) then
                break
            end
            sectionHeaderOffset = sectionHeaderOffset + self._sectionHeaderTableInformation.entsize
        end
    end

    return informationDynamicLinkingSections
end

return ELFSectionHeaderTable