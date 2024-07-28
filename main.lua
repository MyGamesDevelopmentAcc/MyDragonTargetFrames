local addonName, AddonNS = ...

local frame = CreateFrame("Frame", addonName.."Frame", TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar)
local background = frame:CreateTexture()
frame:SetAllPoints(TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar.HealthBarTexture)
background:SetAllPoints(frame)
background:SetColorTexture(1, 1, 1, 1)
frame:SetFrameLevel(TargetFrame:GetFrameLevel()-1)

local function UnitColor(unit)
	local localizedClass, englishClass = UnitClass(unit);
	local classColor = RAID_CLASS_COLORS[englishClass];
	return classColor;
end
local function OnEvent(self, event, ...)
    local unit ="target";
    local bossPortraitFrameTexture = TargetFrame.TargetFrameContainer.BossPortraitFrameTexture
    if UnitExists(unit) and UnitIsPlayer(unit) and UnitIsConnected(unit) and not UnitIsDeadOrGhost(unit)  then
		local classColor = UnitColor(unit)
		
        local r, g, b = classColor.r, classColor.g, classColor.b;
        TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar.HealthBarTexture:SetDesaturated(true)
        TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar:SetStatusBarColor(r, g, b, 1)
        TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar.HealthBarTexture:SetBlendMode("ADD")
        background:SetColorTexture(r, g, b, 1)
        
        
        local bossPortraitFrameTexture = TargetFrame.TargetFrameContainer.BossPortraitFrameTexture
        
        bossPortraitFrameTexture:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold", TextureKitConstants.UseAtlasSize);
        bossPortraitFrameTexture:SetPoint("TOPRIGHT", -11, -8);
        bossPortraitFrameTexture:Show();
        bossPortraitFrameTexture:SetDesaturated(true)
        bossPortraitFrameTexture:SetVertexColor(r, g, b, 1)
    else
        TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar.HealthBarTexture:SetDesaturated(false)
        TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar.HealthBarTexture:SetBlendMode("BLEND")
        TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar:SetStatusBarColor(1,1,1,1)
        bossPortraitFrameTexture:SetDesaturated(false)
        bossPortraitFrameTexture:SetVertexColor(1,1,1,1)
    end
end
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", OnEvent)