-- ============================================================
-- Optimized for 5-5 sens, default advanced settings, 84 FOV
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

-- SETTINGS
local ADS_REQUIRED        = true  -- Only pull down when fully zoomed in (true/false)
local RECOIL_SLEEP        = 10    -- dont change this unless you know how to optimize settings
local BURST_PROTECTION    = true  -- Prevents downward throw if tap-firing or short-bursting (true/false)
local STANCE_SCALING      = true  -- Scales recoil down slightly when crouched (true/false)
local ATTACHMENT_MOD      = false -- Adjusts horizontal pull for alternate barrel attachments (true/false)

-- LEGIT MODE SECTION
local LEGIT_MODE          = true  -- Randomizes spray patterns for anti-cheat evasion
local RANDOMNESS          = 0.30  -- Higher = safer but worse recoil control (sweet spot: 0.35-0.75)

local attackers = {
    { 
        name       = "Ash", 
        weapon     = "R4-C", 
        rpm        = 860,
        vert       = 34.9,   
        horizontal = -2.10,
    },
    { 
        name       = "Twitch", 
        weapon     = "F2", 
        rpm        = 980,
        vert       = 40.0,   
        horizontal = -1.80,
    },
    { 
        name       = "Ying", 
        weapon     = "T-95 LSW", 
        rpm        = 650,
        vert       = 27.5,   
        horizontal =  0.80,
    },
    { 
        name       = "Hibana", 
        weapon     = "Type-89", 
        rpm        = 850,
        vert       = 32.0,   
        horizontal = -1.50,
    },
    { 
        name       = "Jager", 
        weapon     = "416-C", 
        rpm        = 740,
        vert       = 31.0,   
        horizontal =  1.10,
    },
    { 
        name       = "Warden", 
        weapon     = "MPX", 
        rpm        = 800,
        vert       = 22.0,   
        horizontal =  0.40,
    },
    { 
        name       = "Mira", 
        weapon     = "Vector .45 ACP", 
        rpm        = 1200,
        vert       = 19.5,   
        horizontal =  1.20,
    },
    { 
        name       = "Goyo", 
        weapon     = "Vector .45 ACP", 
        rpm        = 1200,
        vert       = 19.5,   
        horizontal =  1.20,
    },
    { 
        name       = "Doc", 
        weapon     = "MP5", 
        rpm        = 800,
        vert       = 21.0,   
        horizontal = -0.50,
    },
    { 
        name       = "Bandit", 
        weapon     = "MP7", 
        rpm        = 900,
        vert       = 25.0,   
        horizontal = -0.90,
    },
    { 
        name       = "Mute", 
        weapon     = "SMG-11", 
        rpm        = 1270,
        vert       = 20.0,   
        horizontal =  3.00,
    },
    { 
        name       = "Deimos", 
        weapon     = "AK-74M", 
        rpm        = 650,
        vert       = 26.0,   
        horizontal =  1.00,
    },
    { 
        name       = "Skopos", 
        weapon     = "PCX-33", 
        rpm        = 780,
        vert       = 24.5,   
        horizontal = -0.50,
    },
    { 
        name       = "Ram", 
        weapon     = "R4-C / LMG", 
        rpm        = 780,
        vert       = 28.0,   
        horizontal = -1.20,
    },
    { 
        name       = "Tubarao", 
        weapon     = "MPX", 
        rpm        = 800,
        vert       = 22.0,   
        horizontal =  0.40,
    },
    { 
        name       = "Solis", 
        weapon     = "P90", 
        rpm        = 970,
        vert       = 23.0,   
        horizontal =  0.20,
    }
}

local state = {
    op_index    = 1,
    rcs_running = false,
}

local function getOp()
    local i = state.op_index
    if i < 1 or i > #attackers then i = 1 end
    return attackers[i]
end

local function changeOperator(direction)
    state.op_index = state.op_index + direction
    if state.op_index > #attackers then 
        state.op_index = 1 
    elseif state.op_index < 1 then 
        state.op_index = #attackers 
    end
    
    local op = getOp()
    OutputLogMessage("\n========================================\n")
    OutputLogMessage(" >>> ACTIVE OPERATOR [%d/%d]: %s (%s) [RPM: %d] <<<\n", state.op_index, #attackers, op.name, op.weapon, op.rpm)
    OutputLogMessage("========================================\n")
end

local function doRecoil()
    if state.rcs_running then return end
    local op = getOp()
    state.rcs_running = true
    
    local accX, accY = 0, 0
    local bulletTimer = 0
    
    repeat
        local firing = IsMouseButtonPressed(1)
        local ads    = IsMouseButtonPressed(2) or IsMouseButtonPressed(3)
        
        if firing and (ads or not ADS_REQUIRED) and IsKeyLockOn("Capslock") then
            bulletTimer = bulletTimer + 1
            
            if BURST_PROTECTION and bulletTimer < 2 then
                Sleep(RECOIL_SLEEP)
            else
                local current_vert       = op.vert
                local current_horizontal = op.horizontal
                
                if STANCE_SCALING and IsModifierPressed("lctrl") then
                    current_vert       = current_vert * 0.85
                    current_horizontal = current_horizontal * 0.85
                end
                
                if ATTACHMENT_MOD then
                    current_horizontal = current_horizontal * 0.90
                end
                
                if LEGIT_MODE then
                    local randX          = (math.random() * 2 - 1) * RANDOMNESS
                    local randY          = (math.random() * 2 - 1) * RANDOMNESS
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
            accX, accY = 0, 0
            bulletTimer = 0
            Sleep(10)
        end
    until not IsMouseButtonPressed(1) or not IsKeyLockOn("Capslock")
    state.rcs_running = false
end

EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
    if not IsKeyLockOn("Capslock") then
        return
    end

    if event == "MOUSE_BUTTON_PRESSED" then
        if arg == 4 then
            changeOperator(1)  
        elseif arg == 5 then
            changeOperator(-1) 
        elseif arg == 1 then
            doRecoil()
        end
    end
end
