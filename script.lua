-- ============================================================
-- OPTIMIZED FOR 5-5 SENS, DEFAULT ADVANCED SETTINGS, 84 FOV
-- 
-- NOTE FOR NEW OPERATORS: 
-- Because recoil varies based on barrel attachments and vertical grip 
-- choices, you may need to configure the 'vert' and 'horizontal' values 
-- for the newly added operators (Skopos, Deimos, Tubarao, etc.).
-- 
-- HOW TO CONFIGURE:
-- 1. Take the operator into a Custom Match or Shooting Range.
-- 2. Shoot a full mag at a wall *without* moving your mouse.
-- 3. If your crosshair drifts too high, increase the 'vert' value slightly.
--    If it pulls too low, decrease the 'vert' value.
-- 4. If your crosshair drifts left/right, adjust the 'horizontal' value 
--    (positive numbers pull right, negative numbers pull left).
-- ============================================================

-- FEATURE TOGGLES
local ADS_REQUIRED        = true  
local RECOIL_SLEEP        = 10    -- Fixed, reliable loop timing
local BURST_PROTECTION    = true  

-- LEGIT MODE SECTION
local LEGIT_MODE          = true  
local RANDOMNESS          = 0.30  -- Sweet spot for anti-cheat evasion

-- FULL OPERATOR ROSTER (Ram synced to Ash's R4-C values)
local attackers = {
    { name = "Ash",     weapon = "R4-C",      vert = 34.9, horizontal = -2.10 },
    { name = "Twitch",  weapon = "F2",        vert = 40.0, horizontal = -1.80 },
    { name = "Ying",    weapon = "T-95 LSW",  vert = 27.5, horizontal =  0.80 },
    { name = "Hibana",  weapon = "Type-89",   vert = 32.0, horizontal = -1.50 },
    { name = "Jager",   weapon = "416-C",     vert = 31.0, horizontal =  1.10 },
    { name = "Warden",  weapon = "MPX",       vert = 22.0, horizontal =  0.40 },
    { name = "Mira",    weapon = "Vector .45",vert = 19.5, horizontal =  1.20 },
    { name = "Goyo",    weapon = "Vector .45",vert = 19.5, horizontal =  1.20 },
    { name = "Doc",     weapon = "MP5",       vert = 21.0, horizontal = -0.50 },
    { name = "Bandit",  weapon = "MP7",       vert = 25.0, horizontal = -0.90 },
    { name = "Mute",    weapon = "SMG-11",    vert = 20.0, horizontal =  3.00 },
    { name = "Deimos",  weapon = "AK-74M",    vert = 26.0, horizontal =  1.00 },
    { name = "Skopos",  weapon = "PCX-33",    vert = 24.5, horizontal = -0.50 },
    { name = "Ram",     weapon = "R4-C",      vert = 34.9, horizontal = -2.10 }, 
    { name = "Tubarao", weapon = "MPX",       vert = 22.0, horizontal =  0.40 },
    { name = "Solis",   weapon = "P90",       vert = 23.0, horizontal =  0.20 }
}

local state = { op_index = 1 }

local function getOp()
    return attackers[state.op_index]
end

local function changeOperator(direction)
    state.op_index = state.op_index + direction
    if state.op_index > #attackers then state.op_index = 1 
    elseif state.op_index < 1 then state.op_index = #attackers end
    local op = getOp()
    OutputLogMessage("\n >>> ACTIVE OPERATOR: %s (%s) <<<\n", op.name, op.weapon)
end

EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
    -- Caps Lock Safety Toggle
    if not IsKeyLockOn("Capslock") then return end

    if event == "MOUSE_BUTTON_PRESSED" then
        if arg == 4 then
            changeOperator(1)   -- Cycle forward through operators
        elseif arg == 1 then
            -- FLAT RECOIL ENGINE
            local op = getOp()
            local accX, accY = 0, 0
            local bulletTimer = 0
            
            repeat
                local firing = IsMouseButtonPressed(1)
                local ads    = IsMouseButtonPressed(2) or IsMouseButtonPressed(3)
                
                if firing and (ads or not ADS_REQUIRED) then
                    bulletTimer = bulletTimer + 1
                    
                    if BURST_PROTECTION and bulletTimer < 2 then
                        Sleep(RECOIL_SLEEP)
                    else
                        local current_vert       = op.vert
                        local current_horizontal = op.horizontal
                        
                        -- Legit Mode Randomization (Anti-Cheat Evasion)
                        if LEGIT_MODE then
                            local randX = (math.random() * 2 - 1) * RANDOMNESS
                            local randY = (math.random() * 2 - 1) * RANDOMNESS
                            current_horizontal   = current_horizontal + randX
                            current_vert         = current_vert + randY
                        end
                        
                        accX = accX + current_horizontal
                        accY = accY + current_vert
                        
                        local mX = math.floor(accX + 0.5)
                        local mY = math.floor(accY + 0.5)
                        
                        accX = accX - mX
                        accY = accY - mY

                        if mX ~= 0 or mY ~= 0 then 
                            MoveMouseRelative(mX, mY) 
                        end
                        
                        Sleep(RECOIL_SLEEP)
                    end
                else
                    break
                end
            until not IsMouseButtonPressed(1)
        end
    end
end
