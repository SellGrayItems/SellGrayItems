function SellGrayItems()
	TotalPrice = 0
	for myBags = 0,4 do
		for bagSlots = 1, GetContainerNumSlots(myBags) do
			CurrentItemLink = GetContainerItemLink(myBags, bagSlots)
				if CurrentItemLink then
					_, _, itemRarity, _, _, _, _, _, _, _, itemSellPrice = GetItemInfo(CurrentItemLink)
					_, itemCount = GetContainerItemInfo(myBags, bagSlots)
					if itemRarity == 0 and itemSellPrice ~= 0 then
						TotalPrice = TotalPrice + (itemSellPrice * itemCount)
						print("Sold: ".. CurrentItemLink .. "x" .. itemCount .. " for " .. GetCoinTextureString(itemSellPrice * itemCount))
						UseContainerItem(myBags, bagSlots)
					end
				end
		end
	end
	if TotalPrice ~= 0 then
		print("Total Price for all items: " .. GetCoinTextureString(TotalPrice))
	else
		print("No items were sold.")
	end
end

local BtnSellGray = CreateFrame( "Button" , "SellGrayBtn" , MerchantFrame, "UIPanelButtonTemplate" )
BtnSellGray:SetText("Sell Grays")
BtnSellGray:SetWidth(90)
BtnSellGray:SetHeight(21)
BtnSellGray:SetPoint("TopRight", -180, -30 )
BtnSellGray:RegisterForClicks("AnyUp")
BtnSellGray:SetScript("Onclick", SellGrayItems)
