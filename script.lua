-- ============================================================
-- Optimized for 5-5 sens, default advanced settings, 84 FOV
-- ============================================================
local ADS_REQUIRED    = true
local RECOIL_SLEEP    = 10  -- dont change this unless you know how to optimize settings
local LEGIT_MODE      = true -- Randomizes spray patterns for anti-cheat evasion
local RANDOMNESS      = 0.50 -- Higher = safer but worse recoil control (sweet spot: 0.35-0.75)

local attackers = {
    { 
        name   = "Ash", 
        weapon = "R4-C", 
        vert   = 34.9,   
        h      = -2.10,  
    },
    { 
        name   = "Twitch", 
        weapon = "F2", 
        vert   = 40.0,   
        h      = -1.8,   
    },
    { 
        name   = "Mute", 
        weapon = "SMG-11", 
        vert   = 20.0,   
        h      =  3.00,    
    },
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

local function nextOperator()
    state.op_index = state.op_index + 1
    if state.op_index > #attackers then state.op_index = 1 end
    local op = getOp()
    OutputLogMessage(string.format("[R6S RCS] Switched Operator to: %s (%s)\n", op.name, op.weapon))
end

local function doRecoil()
    if state.rcs_running then return end
    local op = getOp()
    state.rcs_running = true
    
    local accX, accY = 0, 0
    
    repeat
        local firing = IsMouseButtonPressed(1)
        local ads    = IsMouseButtonPressed(2) or IsMouseButtonPressed(3)
        
        if firing and (ads or not ADS_REQUIRED) and IsKeyLockOn("Capslock") then
            local current_vert = op.vert
            local current_h    = op.h
            
            if LEGIT_MODE then
                local randX = (math.random() * 2 - 1) * RANDOMNESS
                local randY = (math.random() * 2 - 1) * RANDOMNESS
                current_h    = current_h + randX
                current_vert = current_vert + randY
            end
            
            accX = accX + current_h
            accY = accY + current_vert
            
            local mX = math.floor(accX + 0.5)
            local mY = math.floor(accY + 0.5)
            
            accX = accX - mX
            accY = accY - mY

            if mX ~= 0 or mY ~= 0 then 
                MoveMouseRelative(mX, mY) 
            end
            
            Sleep(RECOIL_SLEEP)
        else
            accX, accY = 0, 0
            Sleep(15)
        end
    until not IsMouseButtonPressed(1) or not IsKeyLockOn("Capslock")
    state.rcs_running = false
end

EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
    if not IsKeyLockOn("Capslock") then
        return
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == 4 then
        nextOperator()
        return
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == 1 then
        doRecoil()
    end
end
