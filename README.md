# 🎯 Logitech G-Hub Customisable Recoil Macro (R6 Siege)

An advanced, lightweight Lua script optimized for **5-5 Sensitivity and 84 FOV** in Rainbow Six Siege. Features a delay-based progressive ramping engine to eliminate first-shot weapon kick and a humanised randomization toggle for anti-cheat evasion.

---

## ⚡ Features
* **Delay-Based Ramping:** Overcomes initial recoil jumps using a customizable millisecond window (`RAMP_DELAY_MS`).
* **Anti-Cheat Humanization:** Randomizes micro-movements via `LEGIT_MODE` to break up perfect linear patterns.
* **Two-Way Cycling:** Quickly navigate operators forward (**Mouse Button 4**) or backward (**Mouse Button 5**).
* **Caps Lock Safety Lock:** Instantly pauses the macro when Caps Lock is off to navigate menus cleanly.

---

## 🎥 Video Setup & Showcase
For a live pattern demonstration and a step-by-step installation guide, watch the full video:
👉 **[WATCH THE TUTORIAL HERE](https://www.youtube.com/watch?v=OXSRYlvN44A)**

---

## 📋 Included Operator Profiles
* **Ash** (R4-C)
* **Twitch** (F2)
* **Mute** (SMG-11)
* **Goyo** (Vector .45)
* **Doc** (MP5)

---

## ⚙️ Configuration Guide

### 1. Progressive Ramping
```lua
local ENABLE_RAMPING      = false -- true = fixes first bullet kick, false = basic control (easier to configure)
local RAMP_DELAY_MS       = 250   -- How long (in milliseconds) the extra compensation lasts
local FIRST_SHOT_RAMP     = 1.35  -- Multiplier for the ramping duration
```
* If your gun flies **UP** during the first split second, increase `FIRST_SHOT_RAMP` (e.g., to `1.45`).
* If it pulls into the **FLOOR**, decrease it (e.g., to `1.25`).

### 2. Anti-Cheat Evasion
```lua
local LEGIT_MODE          = true  -- toggle true/false, false = better recoil but can be detected
local RANDOMNESS          = 0.30  -- Sweet spot for anti-cheat evasion
```

---

## 💻 How to Use
1. Copy the entire source code from your script file.
2. Open **Logitech G-Hub** and select your active profile.
3. Click **Scripting** -> **Create New Lua Script** -> **Edit Script**.
4. Delete any default code, paste the script, and hit **Ctrl + S** to save.
5. Turn **Caps Lock ON** in-game to activate.

---
*Disclaimer: This script is shared purely for educational and analysis purposes.*
