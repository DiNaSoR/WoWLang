local addonName, ns = ...

ns.Bubbles = ns.Bubbles or {}
local Bubbles = ns.Bubbles

function Bubbles.DetectAndReplacePlayerNameForBubble(txt, target, part)
  if (txt == nil) then return "" end
  local text = string.gsub(txt, '\r', "")
  if (part == nil) or (part == '$B') then
    text = string.gsub(text, '\n', "$B")
  end
  return text
end


