local AddonColor = "|cFF00ff99"

function SELLGRAYS:repair()
    local repairCost, canRepair = GetRepairAllCost();
    if (canRepair) then
        local amount = GetGuildBankWithdrawMoney();
        if (amount ~= 0 and SELLGRAYITEMSOPTIONS.guildBankRepairCheckboxState) then
            RepairAllItems(1);
            local originalRepairCost = repairCost;
            local repairCost, canRepair = GetRepairAllCost();
            if (canRepair) then
                print("Repaired with guild bank funds: " .. GetCoinTextureString(originalRepairCost - repairCost));
                RepairAllItems();
                print("The guild bank funds ran out, so the remaining " .. GetCoinTextureString(repairCost) .. " came from your personal funds");
            else
                print("Repaired with guild bank funds: " .. GetCoinTextureString(repairCost));
            end
        else
            RepairAllItems();
            print("Repaired with personal funds: " .. GetCoinTextureString(repairCost));
        end
    end
end

function SELLGRAYS:sellGrays(autosold)
    local totalGreysValue = 0;
    local itemsSoldText = "";
    for bagNumber = 0, 5, 1 do
        local slotsCount = GetContainerNumSlots(bagNumber);
        for slotNumber = 1, slotsCount+1, 1 do
            local itemId = GetContainerItemID(bagNumber, slotNumber);
            if (itemId ~= nil) then
                itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemId);
                texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bagNumber, slotNumber);
                if (quality == 0) then
                    UseContainerItem(bagNumber, slotNumber);
                    totalGreysValue = totalGreysValue + (itemSellPrice * itemCount);
                    itemsSoldText = itemsSoldText .. itemLink .. "x" .. itemCount .. " for " .. GetCoinTextureString(itemSellPrice * itemCount) .. "\n"
                end
            end
        end
    end

    if (itemsSoldText ~= "") then
        itemsSoldText = AddonColor .. "Sell Gray Items:|r Items " ..  (autosold and "Automatically s" or "S") .. "old:\n" .. itemsSoldText;
        itemsSoldText = itemsSoldText .. "------------------------------------------------------------------\n";
        itemsSoldText = itemsSoldText .. "Sold all gray-quality items for a total of ".. GetCoinTextureString(totalGreysValue);
        print(itemsSoldText);

        return true;
    else
        return false;
    end
end

local sellGraysButton = CreateFrame("Button", nil, MerchantFrame, "UIPanelButtonTemplate");
sellGraysButton:SetPoint("TOP", MerchantFrame, "TOPLEFT", 112, -27);
sellGraysButton:SetWidth(100);
sellGraysButton:SetHeight(30);
sellGraysButton:SetText("Sell Grays");
sellGraysButton:SetScript("OnClick", function()
    if (SELLGRAYS:sellGrays(false) == false) then
        print("There was nothing to sell");
    end
end)

local eventFrame = CreateFrame("Frame");
eventFrame:RegisterEvent("MERCHANT_SHOW");
eventFrame:SetScript("OnEvent",
    function()
        if (SELLGRAYITEMSOPTIONS.autoSellCheckboxState) then
            SELLGRAYS:sellGrays(true);
        end
        if (SELLGRAYITEMSOPTIONS.autoRepairCheckboxState) then
            SELLGRAYS:repair();
        end
    end
);

-- Sets slash commands.
SLASH_SELLGRAYS1 = "/sellgrayitems"
SLASH_SELLGRAYS1 = "/sellgrays"
SLASH_SELLGRAYS1 = "/sgi"
SlashCmdList["SELLGRAYS"] = function(msg)
    msg = msg:lower()
    if msg == "help" or msg == "h" then
        print(AddonColor .. "Sell Gray Items:|r\n/sellgrayitems, /sellgrays, and /sgi all display the addon's settings page.")
        return
    elseif msg == "version" or msg == "v" or msg == "-v" then
        local version = GetAddOnMetadata("SellGrayItems", "Version");
        print(AddonColor .. "Sell Grays|r version " .. version)
        return
    else
        InterfaceOptionsFrame_Show();
        InterfaceOptionsFrame_OpenToCategory("Sell Gray Items");
    end
end
