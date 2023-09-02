local icon = {}
--icon['Shadow Word: Pain'] = 'Interface\\Icons\\Spell_Shadow_ShadowWordPain'
icon['Corruption'] = 'Interface\\Icons\\Spell_Shadow_AbominationExplosion'
icon['Curse of Agony'] = 'Interface\\Icons\\Spell_Shadow_CurseOfSargeras'
icon['Curse of Elements'] = 'Interface\\Icons\\Spell_Shadow_ChillTouch'
icon['Curse of Recklessness'] = 'Interface\\Icons\\Spell_Shadow_UnholyStrength'
icon['Curse of Weakness'] = 'Interface\\Icons\\Spell_Shadow_CurseOfMannoroth'
icon['Immolate'] = 'Interface\\Icons\\Spell_Fire_Immolation'

local f = CreateFrame('FRAME', nil, UIParent)
f:SetBackdrop({bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background'})
f:SetPoint('CENTER', UIParent)
f:SetWidth(100)
f:SetHeight(20)
f:SetMovable(true)
f:EnableMouse(true)

f.t = f:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
f.t:SetPoint('CENTER', f)
f.t:SetText('For Iridium')

f.tex = {}
for i = 1, 10 do
	f.tex[i] = f:CreateTexture(nil, 'ARTWORK')
	f.tex[i]:SetPoint('TOPLEFT', f, 'BOTTOMLEFT', (i - 1) * 25, -1)
	f.tex[i]:SetWidth(24)
	f.tex[i]:SetHeight(24)
    f.tex[i]:Hide()
end
for i = 11, 20 do
	f.tex[i] = f:CreateTexture(nil, 'ARTWORK')
	f.tex[i]:SetPoint('TOPLEFT', f, 'BOTTOMLEFT', (i - 11) * 25, -26)
	f.tex[i]:SetWidth(24)
	f.tex[i]:SetHeight(24)
    f.tex[i]:Hide()
end
for i = 21, 30 do
	f.tex[i] = f:CreateTexture(nil, 'ARTWORK')
	f.tex[i]:SetPoint('TOPLEFT', f, 'BOTTOMLEFT', (i - 21) * 25, -52)
	f.tex[i]:SetWidth(24)
	f.tex[i]:SetHeight(24)
    f.tex[i]:Hide()
end
for i = 31, 40 do
	f.tex[i] = f:CreateTexture(nil, 'ARTWORK')
	f.tex[i]:SetPoint('TOPLEFT', f, 'BOTTOMLEFT', (i - 31) * 25, -78)
	f.tex[i]:SetWidth(24)
	f.tex[i]:SetHeight(24)
    f.tex[i]:Hide()
end

f:RegisterForDrag('LeftButton')
f:SetScript('OnDragStart', function() this:StartMoving() end)
f:SetScript('OnDragStop',  function() this:StopMovingOrSizing() end)

f:RegisterEvent('CHAT_MSG_SPELL_AURA_GONE_OTHER')
f:RegisterEvent('CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE')
f:RegisterEvent('PLAYER_TARGET_CHANGED')
f:SetScript('OnEvent', function() this[event]() end)

f.CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE = function()
    local r = {string.find(arg1, '^(.+) is afflicted by (.+)%.$')}
    if r[1] then
        for i = 1, 40 do
            if not f.tex[i]:IsVisible() then
                --f.tex[i]:SetTexture(icon[r[4]] or 'Interface\\Icons\\Temp')
                f.tex[i]:SetTexture(icon[r[4]] or '')
                f.tex[i]:Show()
                return
            end
        end
    end
end

f.CHAT_MSG_SPELL_AURA_GONE_OTHER = function()
    local r = {string.find(arg1, '^(.+) fades from (.+)%.$')}
    if r[1] then
        for i = 1, 40 do
            if f.tex[i]:GetTexture() == icon[r[3]] then
                f.tex[i]:Hide()
                for j = i, 40 - 1 do
                    --f.tex[j]:SetTexture(f.tex[j+1]:GetTexture())
                    --f.tex[j+1]:Hide()
                    if f.tex[j+1]:IsVisible() then
                        f.tex[j]:SetTexture(f.tex[j+1]:GetTexture())
                        f.tex[j]:Show()
                        f.tex[j+1]:Hide()
                    else
                        return
                    end
                end
                return
            end
        end
    end
end

f.PLAYER_TARGET_CHANGED = function()
    for i = 1, 40 do
        f.tex[i]:Hide()
    end
end
