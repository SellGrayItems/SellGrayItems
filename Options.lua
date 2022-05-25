if (SELLGRAYS == nil) then 
    SELLGRAYS = {};

    local frame = CreateFrame("Frame");
    frame:RegisterEvent("ADDON_LOADED");
    frame:SetScript("OnEvent", 
        function(self, event, addonName)
            if (event == "ADDON_LOADED" and addonName == "SellGrayItems") then
                handleSavedVars();
            end
        end
    )
end

local optionspanel = CreateFrame("Frame", "SellGrayItemsOptionsPanel", UIParent);
optionspanel.name = "Sell Gray Items";

optionspanel.headline = CreateFrame("SimpleHTML", "SellGrayItemsOptionsPanelHeadline", optionspanel);
optionspanel.headline:SetText("Sell Gray Items");
optionspanel.headline:SetTextColor(1, 0.82, 0);
optionspanel.headline:SetSize(50, 50);
optionspanel.headline:SetFont('Fonts\\FRIZQT__.TTF', 16);
optionspanel.headline:SetPoint("TOPLEFT", 20, -20);

-- Auto Sell
optionspanel.autoSellCheckbox = CreateFrame("CheckButton", "SellGrayItemsOptionsPanelCheckBox1", optionspanel, "ChatConfigCheckButtonTemplate");
optionspanel.autoSellCheckbox:SetPoint("TOPLEFT", 20, -44);
optionspanel.autoSellCheckbox:SetScript("OnClick", function()
    SELLGRAYITEMSOPTIONS.autoSellCheckboxState = optionspanel.autoSellCheckbox:GetChecked();
end);

optionspanel.autoSellCheckbox.text = CreateFrame("SimpleHTML", "SellGrayItemsOptionsPanelCheckBox1Text", optionspanel);
optionspanel.autoSellCheckbox.text:SetText("Auto-sell on merchant visit");
optionspanel.autoSellCheckbox.text:SetSize(50, 50);
optionspanel.autoSellCheckbox.text:SetFont('Fonts\\FRIZQT__.TTF', 12);
optionspanel.autoSellCheckbox.text:SetPoint("TOPLEFT", 50, -50);

-- Auto Repair
optionspanel.autoRepairCheckbox = CreateFrame("CheckButton", "SellGrayItemsOptionsPanelCheckBox2", optionspanel, "ChatConfigCheckButtonTemplate");
optionspanel.autoRepairCheckbox:SetPoint("TOPLEFT", 20, -70);
optionspanel.autoRepairCheckbox:SetScript("OnClick", function()
    SELLGRAYITEMSOPTIONS.autoRepairCheckboxState = optionspanel.autoRepairCheckbox:GetChecked();
end);

optionspanel.autoRepairCheckbox.text = CreateFrame("SimpleHTML", "SellGrayItemsOptionsPanelCheckBox2Text", optionspanel);
optionspanel.autoRepairCheckbox.text:SetText("Auto-repair on merchant visit");
optionspanel.autoRepairCheckbox.text:SetSize(50, 50);
optionspanel.autoRepairCheckbox.text:SetFont('Fonts\\FRIZQT__.TTF', 12);
optionspanel.autoRepairCheckbox.text:SetPoint("TOPLEFT", 50, -75);

-- Repair using guild bank funds
optionspanel.guildBankRepairCheckbox = CreateFrame("CheckButton", "SellGrayItemsOptionsPanelCheckBox2", optionspanel, "ChatConfigCheckButtonTemplate");
optionspanel.guildBankRepairCheckbox:SetPoint("TOPLEFT", 50, -96);
optionspanel.guildBankRepairCheckbox:SetScript("OnClick", function()
    SELLGRAYITEMSOPTIONS.guildBankRepairCheckboxState = optionspanel.guildBankRepairCheckbox:GetChecked();
end);

optionspanel.guildBankRepairCheckbox.text = CreateFrame("SimpleHTML", "SellGrayItemsOptionsPanelCheckBox2Text", optionspanel);
optionspanel.guildBankRepairCheckbox.text:SetText("Repair using guild bank funds (if available)");
optionspanel.guildBankRepairCheckbox.text:SetSize(50, 50);
optionspanel.guildBankRepairCheckbox.text:SetFont('Fonts\\FRIZQT__.TTF', 12);
optionspanel.guildBankRepairCheckbox.text:SetPoint("TOPLEFT", 80, -100);

-- Show Bag Grays Value
optionspanel.showBagGraysValueCheckbox = CreateFrame("CheckButton", "SellGrayItemsOptionsPanelCheckBox3", optionspanel, "ChatConfigCheckButtonTemplate");
optionspanel.showBagGraysValueCheckbox:SetPoint("TOPLEFT", 20, -122);
optionspanel.showBagGraysValueCheckbox:SetScript("OnClick", function()
    SELLGRAYITEMSOPTIONS.showBagGraysValueCheckboxState = optionspanel.showBagGraysValueCheckbox:GetChecked();
    SELLGRAYS:showBagGraysValue();
end);

optionspanel.showBagGraysValueCheckbox.text = CreateFrame("SimpleHTML", "SellGrayItemsOptionsPanelCheckBox3Text", optionspanel);
optionspanel.showBagGraysValueCheckbox.text:SetText("Show total value of gray items in bags");
optionspanel.showBagGraysValueCheckbox.text:SetSize(50, 50);
optionspanel.showBagGraysValueCheckbox.text:SetFont('Fonts\\FRIZQT__.TTF', 12);
optionspanel.showBagGraysValueCheckbox.text:SetPoint("TOPLEFT", 50, -125);

InterfaceOptions_AddCategory(optionspanel);

function handleSavedVars()
    if (SELLGRAYITEMSOPTIONS == nil) then
        SELLGRAYITEMSOPTIONS = {};
        SELLGRAYITEMSOPTIONS.autoSellCheckboxState = false;
        SELLGRAYITEMSOPTIONS.autoRepairCheckboxState = false;
        SELLGRAYITEMSOPTIONS.guildBankRepairCheckboxState = false;
        SELLGRAYITEMSOPTIONS.showBagGraysValueCheckboxState = false;
    else
        if (SELLGRAYITEMSOPTIONS.autoSellCheckboxState == nil) then
            optionspanel.autoSellCheckbox:SetChecked(false);
        end
        if (SELLGRAYITEMSOPTIONS.autoRepairCheckboxState == nil) then
            optionspanel.autoSellCheckbox:SetChecked(false);
        end
        if (SELLGRAYITEMSOPTIONS.guildBankRepairCheckboxState == nil) then
            optionspanel.autoSellCheckbox:SetChecked(false);
        end
        if (SELLGRAYITEMSOPTIONS.showBagGraysValueCheckboxState == nil) then
            optionspanel.autoSellCheckbox:SetChecked(false);
        end
    end

    optionspanel.autoSellCheckbox:SetChecked(SELLGRAYITEMSOPTIONS.autoSellCheckboxState);
    optionspanel.autoRepairCheckbox:SetChecked(SELLGRAYITEMSOPTIONS.autoRepairCheckboxState);
    optionspanel.guildBankRepairCheckbox:SetChecked(SELLGRAYITEMSOPTIONS.guildBankRepairCheckboxState);
    optionspanel.showBagGraysValueCheckbox:SetChecked(SELLGRAYITEMSOPTIONS.showBagGraysValueCheckboxState);
end
