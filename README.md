# Elite Logitech G HUB R6S Anti-Recoil Engine

A streamlined, high-performance Lua anti-recoil and operator-switching script built specifically for Logitech G HUB and Rainbow Six Siege.

---

## Features

* **Flat Recoil Engine:** Clean, reliable recoil script optimized for default advanced settings, 5-5 sensitivity, and 84 FOV.
* **Legit Mode Randomization:** Built-in pixel randomization to bypass anti-cheat.
* **Caps Lock Safety Toggle:** The script remains completely dormant unless your **Caps Lock** key is physically toggled **ON**.
* **Single-Button Operator Cycling:** Easily cycle through the full operator roster on the fly using **Mouse Button 4 (MB4)**.

---

## Configuration & Tuning Notes

```lua
-- OPTIMIZED FOR 5-5 SENS, DEFAULT ADVANCED SETTINGS, 84 FOV
-- 
-- NOTE FOR NEW OPERATORS: 
-- Because recoil varies based on barrel attachments and vertical grip 
-- choices, you may need to configure the 'vert' and 'horizontal' values 
-- for the operators (Skopos, Deimos, Tubarao, etc.).
-- 
-- HOW TO CONFIGURE:
-- 1. Take the operator into a Custom Match or Shooting Range.
-- 2. Shoot a full mag at a wall without moving your mouse.
-- 3. If your crosshair drifts too high, increase the 'vert' value slightly.
--    If it pulls too low, decrease the 'vert' value.
-- 4. If your crosshair drifts left/right, adjust the 'horizontal' value 
--    (positive numbers pull right, negative numbers pull left).

## Controls Reference

| Input / State | Action / Function |
| :--- | :--- |
| **Caps Lock ON** | $\rightarrow$ **System Armed:** Enables script execution & real-time compensation. |
| **Caps Lock OFF** | $\rightarrow$ **System Standby:** Completely disables all script functions. |
| **Mouse Button 4 (MB4)** | $\rightarrow$ **Operator Cycling:** Cycles forward through the roster (logs active operator). |
| **Left-Click + ADS** | $\rightarrow$ **Execution Engine:** Triggers flat anti-recoil with Legit Mode randomization. |
