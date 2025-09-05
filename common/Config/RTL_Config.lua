-- RTL_Config.lua
-- Centralizes AR-specific (RTL) tweaks for the Ace3 config UI

local AceConfigDialog = LibStub and LibStub("AceConfigDialog-3.0", true)

WOWTR = WOWTR or {}
WOWTR.Config = WOWTR.Config or {}
WOWTR.Config.RTL = WOWTR.Config.RTL or {}

local RTL = WOWTR.Config.RTL

local function isAR()
  return type(WoWTR_Localization) == "table" and WoWTR_Localization.lang == 'AR'
end

-- Reverse tab order in the options table (display order) – runs when building options
function RTL.ReverseTabOrder(options)
  if not isAR() or not options or not options.args then return end
  local orders = {}
  for key, group in pairs(options.args) do
    if type(group) == "table" and group.order then
      table.insert(orders, { k = key, o = group.order })
    end
  end
  table.sort(orders, function(a,b) return a.o > b.o end)
  local start = 1
  for _, entry in ipairs(orders) do
    local g = options.args[entry.k]
    if g then g.order = start; start = start + 1 end
  end
end

-- Apply RTL alignment to texts/labels inside the frame (checkbox labels, descriptions, edit boxes)
local function alignFontsInFrame(frame)
  if not frame then return end
  
  -- Skip entire widget if it's a button (we don't want to touch those)
  if frame.obj and frame.obj.type then
    local wtype = tostring(frame.obj.type)
    if wtype == "Button" or wtype == "LSM30_Font" or wtype == "LSM30_Sound" or wtype == "LSM30_Statusbar" then
      return
    end
  end
  
  local function looksLikeAceGUICheckBox(f)
    if not (f and f.GetRegions) then return nil, nil end
    local fs
    local candidate
    local regions = { f:GetRegions() }
    for _, r in ipairs(regions) do
      local rt = r.GetObjectType and r:GetObjectType() or nil
      if rt == "FontString" then fs = r end
      if rt == "Texture" then
        local w = (r.GetWidth and r:GetWidth()) or 0
        local h = (r.GetHeight and r:GetHeight()) or 0
        -- typical AceGUI checkbox textures are square and ~16-24 px
        if w > 8 and w <= 28 and h > 8 and h <= 28 then
          candidate = candidate or r
        end
      end
    end
    if fs and candidate then return fs, candidate end
    return nil, nil
  end
  if frame.GetRegions then
    local regions = { frame:GetRegions() }
    for _, r in pairs(regions) do
      if r and r.GetObjectType and r:GetObjectType() == "FontString" and r.SetJustifyH then
        local parent = r.GetParent and r:GetParent() or nil
        local skipFS = false
        if parent and parent.obj and parent.obj.type then
          local pt = tostring(parent.obj.type)
          if pt == "Button" or pt:find("LSM30") then skipFS = true end
          if pt == "CheckBox" or pt == "Dropdown" then skipFS = false end
        end
        if not skipFS then pcall(r.SetJustifyH, r, "RIGHT") end
      end
    end
  end
  local t = frame.GetObjectType and frame:GetObjectType() or nil
  if t == "EditBox" and frame.SetJustifyH then pcall(frame.SetJustifyH, frame, "RIGHT") end
  if frame.obj and frame.obj.type then
    local wtype = tostring(frame.obj.type)
    if wtype == "CheckBox" then
      -- AceGUI CheckBox widget
      local fs, box = looksLikeAceGUICheckBox(frame)
      if fs and box then
        pcall(fs.SetJustifyH, fs, "RIGHT")
        if box.ClearAllPoints then pcall(box.ClearAllPoints, box); pcall(box.SetPoint, box, "RIGHT", frame, "RIGHT", -6, 0) end
        if fs.ClearAllPoints then pcall(fs.ClearAllPoints, fs); pcall(fs.SetPoint, fs, "RIGHT", box, "LEFT", -10, 0) end
      end
    elseif wtype == "Dropdown" then
      -- AceGUI Dropdown: align the label header to RIGHT
      local w = frame.obj
      local label = w.label
      if label and label.SetJustifyH then
        pcall(label.SetJustifyH, label, "RIGHT")
        if label.ClearAllPoints and w.frame then
          pcall(label.ClearAllPoints, label)
          pcall(label.SetPoint, label, "TOPRIGHT", w.frame, "TOPRIGHT", -2, 0)
        end
      end
    end
  elseif t == "CheckButton" then
    -- Blizzard CheckButton
    local fs = (frame.GetFontString and frame:GetFontString()) or nil
    if fs and fs.SetJustifyH then
      pcall(fs.SetJustifyH, fs, "RIGHT")
      if fs.ClearAllPoints then pcall(fs.ClearAllPoints, fs); pcall(fs.SetPoint, fs, "RIGHT", frame, "RIGHT", -10, 0) end
    end
  end
  if frame.GetChildren then
    local kids = { frame:GetChildren() }
    for _, child in pairs(kids) do alignFontsInFrame(child) end
  end
end

function RTL.ApplyTabsRTLForFrame(frameRef, topPad)
  if not (type(WoWTR_Localization) == "table" and WoWTR_Localization.lang == 'AR') then return end
  local root = (frameRef and frameRef.content) or frameRef
  -- Prefer aligning only the TabGroup content panels to avoid touching tab buttons
  if frameRef and frameRef.obj and frameRef.obj.children then
    for _, child in pairs(frameRef.obj.children) do
      if child and child.type == "TabGroup" and child.content then
        alignFontsInFrame(child.content)
      end
    end
  else
    alignFontsInFrame(root)
  end
end

-- Best-effort hook to re-apply RTL alignment after tab changes
if AceConfigDialog and AceConfigDialog.Open then
  local function wrap(method)
    local orig = AceConfigDialog[method]
    if type(orig) ~= "function" then return end
    AceConfigDialog[method] = function(self, appName, ...)
      local ret = orig(self, appName, ...)
      if type(WoWTR_Localization) == "table" and WoWTR_Localization.lang == 'AR' and self.OpenFrames and self.OpenFrames[appName] and self.OpenFrames[appName].frame then
        RTL.ApplyTabsRTLForFrame(self.OpenFrames[appName].frame)
      end
      return ret
    end
  end
  wrap("Open"); wrap("SelectGroup"); wrap("FeedGroup")
end


