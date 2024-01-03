local ELFSectionHeaderTable = {
     _readerFile = nil,
     _sectionHeaderTableInformation = nil
}


function ELFSectionHeaderTable:new(object, readerFile, header)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    if header and readerFile then
        self._readerFile = readerFile
        self._sectionHeaderTableInformation = header:readSectionHeaderTableInformation() 
    end
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
            sectionHeaderType = self._readerFile:readInteger32FromOffset(sectionHeaderOffset + 0x4)
            sectionHeaderFlags = self:_readSectionHeaderFlagsByOffset(sectionHeaderOffset)
            if self:mIsDynamicLinkingSymbolSection(sectionHeaderType) then
                informationDynamicLinkingSections.dynsym = self:_readSectionHeaderInformationByOffset(sectionHeaderOffset)
                loopBreaks = loopBreaks + 1
            elseif self:mIsDynamicLinkingStringSection(sectionHeaderType, sectionHeaderFlags) then
                
                informationDynamicLinkingSections.dynstr = self:_readSectionHeaderInformationByOffset(sectionHeaderOffset)
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
