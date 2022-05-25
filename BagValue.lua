local function calculateGraysValue()
    local totalGreysValue = 0;
    for bagNumber = 0, 5, 1 do
        local slotsCount = GetContainerNumSlots(bagNumber);
        for slotNumber = 1, slotsCount+1, 1 do
            local itemId = GetContainerItemID(bagNumber, slotNumber);
            if (itemId ~= nil) then
                itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemId);
                texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bagNumber, slotNumber);
                if (quality == 0) then
                    totalGreysValue = totalGreysValue + (itemCount*itemSellPrice);
                end
            end
        end
    end

    if (totalGreysValue > 0) then
        return "Grays: ".. GetCoinTextureString(totalGreysValue);
    end
    return "Grays: " .. GetCoinTextureString(0);
end

local bagGraysValueBackground = CreateFrame("Frame", "SellGrayItems_BagGraysValueBackground", ContainerFrame1, BackdropTemplateMixin and "BackdropTemplate");
bagGraysValueBackground:SetSize(135, 32);
bagGraysValueBackground:SetPoint("TOP", 18, -29);
bagGraysValueBackground:SetFrameStrata("HIGH");
bagGraysValueBackground:SetBackdrop({
    bgFile   = "Interface\\MONEYFRAME\\UI-MONEYFRAME-BORDER"
});
bagGraysValueBackground:Hide();

bagGraysValueBackground.graysValue = CreateFrame("SimpleHTML", "SellGrayItems_BagGraysValue", SellGrayItems_BagGraysValueBackground);
bagGraysValueBackground.graysValue:SetSize(125, 30);
bagGraysValueBackground.graysValue:SetText(calculateGraysValue());
bagGraysValueBackground.graysValue:SetFont('Fonts\\FRIZQT__.TTF', 10);
bagGraysValueBackground.graysValue:SetPoint("LEFT", 5, -3);

local bagEventFrame = CreateFrame("Frame");
bagEventFrame:RegisterEvent("BAG_UPDATE");
bagEventFrame:SetScript("OnEvent", function()
        if (SELLGRAYITEMSOPTIONS.showBagGraysValueCheckboxState) then
            bagGraysValueBackground.graysValue:SetText(calculateGraysValue());
            bagGraysValueBackground:Show();
        end
    end
)

-- public
function SELLGRAYS:showBagGraysValue()
    if (SELLGRAYITEMSOPTIONS.showBagGraysValueCheckboxState) then
        bagGraysValueBackground:Show();
    else
        bagGraysValueBackground:Hide();
    end
end
