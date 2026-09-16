# r6-no-recoil-undetected
# R6S Logitech G HUB Recoil Script

Optimized anti-recoil script for Rainbow Six Siege.

How Anti-Detection Works
Standard scripts draw the exact same path every time, which anti-cheat systems easily flag. Legit Mode injects random math adjustments on every tick. This breaks the pixel signature so no two sprays are identical, mimicking real human hand movement.

Installation
Open Logitech G HUB and go to your script profile.

Paste the code and save.

Turn Caps Lock ON, hold ADS (Right Click), and fire. Use MB4 to change operators.

## Settings & Requirements
- **Sensitivity:** 5-5 (Default advanced settings)
- **FOV:** 84
- **Master Switch:** Caps Lock (Must be ON)

## Features
- **Instant Recoil:** Pulls down immediately on bullet 1.
- **Operator Swap:** Press **MB4** to cycle through Ash (R4-C), Twitch (F2), and Mute (SMG-11).
- **Slow Walk Fix:** Works smoothly while holding Left Alt.
- **Legit Mode:** Randomizes spray paths to prevent detection.

## Configuration
```lua
local ADS_REQUIRED    = true
local RECOIL_SLEEP    = 10  -- dont change this unless you know how to optimize settings
local LEGIT_MODE      = true -- Randomizes spray patterns for anti-cheat evasion
local RANDOMNESS      = 0.25 -- Higher = safer from detection, but worse recoil control (sweet spot: 0.35-0.75; over 0.75 for legit looking recoil)
