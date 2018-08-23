-- Trigger init
ZT_TrackAuras = {
    257426
}

ZN_TrackNameplate = {};

ZNF_ToggleGlowNameplate = function(unit, show) -- reference from wago.io, unit: unitID, show: showGlow/hideGlow
    local nameplate = C_NamePlate.GetNamePlateForUnit(unit);
    if not nameplate then
        return
    end
    
    if show then
        if nameplate.unitFrame and nameplate.unitFrame.HealthBar then
            -- elvui
            ActionButton_ShowOverlayGlow(nameplate.unitFrame.HealthBar)
        elseif nameplate.UnitFrame and nameplate.UnitFrame.HealthBar then
            -- elvui (old)
            ActionButton_ShowOverlayGlow(nameplate.UnitFrame.HealthBar)
        elseif nameplate.kui then
            -- kui
            ActionButton_ShowOverlayGlow(nameplate.kui.HealthBar)
        elseif nameplate.extended then
            -- tidyplates
            nameplate.extended.visual.healthbar:SetHeight(8)
            ActionButton_ShowOverlayGlow(nameplate.extended.visual.healthbar)
        elseif nameplate.TP_Extended then
            -- tidyplates: threat plates
            ActionButton_ShowOverlayGlow(nameplate.TP_Extended.visual.healthbar)
        elseif nameplate.ouf then
            -- bdNameplates
            ActionButton_ShowOverlayGlow(nameplate.ouf.Health)
        elseif nameplate.UnitFrame then 
            -- default
            ActionButton_ShowOverlayGlow(nameplate.UnitFrame.healthBar)
        end
    else
        if nameplate.unitFrame and nameplate.unitFrame.HealthBar then
            -- elvui
            ActionButton_HideOverlayGlow(nameplate.unitFrame.HealthBar)
        elseif nameplate.UnitFrame and nameplate.UnitFrame.HealthBar then
            -- elvui (old)
            ActionButton_HideOverlayGlow(nameplate.UnitFrame.HealthBar)
        elseif nameplate.kui then
            -- kui
            ActionButton_HideOverlayGlow(nameplate.kui.HealthBar)
        elseif nameplate.extended then
            -- tidyplates
            ActionButton_HideOverlayGlow(nameplate.extended.visual.healthbar)
        elseif nameplate.TP_Extended then
            -- tidyplates: threat plates
            ActionButton_HideOverlayGlow(nameplate.TP_Extended.visual.healthbar)
        elseif nameplate.ouf then
            -- bdNameplates
            ActionButton_HideOverlayGlow(nameplate.ouf.Health)
        elseif nameplate.UnitFrame then 
            -- default
            ActionButton_HideOverlayGlow(nameplate.UnitFrame.healthBar)
        end
    end
end



function(allstates, event)
    local _, subEvent, _, sourceGUID, sourceName, _, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()
    
    if subEvent == "SPELL_CAST_START" then
        for idx, auraID in pairs(ZT_TrackAuras) do
            if auraID == spellID then
                for i = 0, 40 do
                    local castingName, castingText, _, icon, _, _, castID, _, castingSpellID = UnitCastingInfo("nameplate"..i)
                    if castingSpellID == spellID then
                        ZNF_ToggleGlowNameplate("nameplate"..i, true);
                        ZN_TrackNameplate["nameplate"..i] = spellID

                        allstates[auraID] = {
                            show = true,
                            changed = true,
                            icon = icon
                        }
                    end
                end
            end
        end
    end
    
    if subEvent == "SPELL_INTERRUPT" or subEvent == "SPELL_CAST_SUCCESS" or subEvent == "SPELL_CAST_FAILED" then
        for plate, memSpellID in pairs(ZN_TrackNameplate) do
            if memSpellID ~= nil then
                local castingName, castingText, _, _, _, _, castID, _, castingSpellID = UnitCastingInfo(plate)
                if memSpellID ~= castingSpellID then
                    ZNF_ToggleGlowNameplate(plate, false);
                    ZN_TrackNameplate[plate] = nil
                end
            end
        end
    end
    
    return true
end