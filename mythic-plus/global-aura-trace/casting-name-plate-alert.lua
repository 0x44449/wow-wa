-- Trigger init
function()

end

-- EVENT: COMBAT_LOG_EVENT_UNFILTERED
-- Trigger
function(event)
    local alertSpell = {
        257426: true
    }
    local _, subEvent, _, sourceGUID, sourceName, _, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()

    if subEvent == "SPELL_CAST_START" and UnitExists(sourceName) then
        local spellName, _, _, _, _, _ = UnitCastingInfo(sourceName)

        if alertSpell[spellID] then
            for i = 0, 40 do
                local plate = "nameplate"..i
                
            end
        end


        if true then
            
        end

        WeakAuras.ScanEvents("ZX_CASTING_NAME_PLATE_ALERT_START")
    end

    if subEvent == "SPELL_INTERRUPT" or subEvent == "SPELL_CAST_SUCCESS" or subEvent == "SPELL_CAST_FAILED" then

        WeakAuras.ScanEvents("ZX_CASTING_NAME_PLATE_ALERT_END")
    end

end

-- EVENT: ZX_CASTING_NAME_PLATE_ALERT_START, ZX_CASTING_NAME_PLATE_ALERT_END
-- Trigger
function(event, unit)
    if event == "ZX_CASTING_NAME_PLATE_ALERT_START" then
        for i = 0, 40 do
            local plate = "nameplate"..i
            if UnitIsUnit(unit, plate) then
                -- mark to nameplate
                break
            end

        end

    end

    if event == "ZX_CASTING_NAME_PLATE_ALERT_END" then
        for i = 0, 40 do
            local plate = "nameplate"..i
            if UnitIsUnit(unit, plate) then
                -- remove mark from nameplate
                break
            end

        end

    end

end
