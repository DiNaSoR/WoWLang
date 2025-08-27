-- Quests/Integrations.lua
-- Thin wrappers delegating to plugin integrations (Immersion, Storyline, DialogueUI, ClassicQuestLog)

local addonName, ns = ...
ns = ns or {}
ns.Quests = ns.Quests or {}

-- Classic Quest Log
function isClassicQuestLog()
  if ClassicQuestLogPlugin and ClassicQuestLogPlugin.isClassicQuestLog then
    return ClassicQuestLogPlugin.isClassicQuestLog()
  end
  return false
end

-- Immersion
function isImmersion()
  if ImmersionPlugin and ImmersionPlugin.isImmersion then
    return ImmersionPlugin.isImmersion()
  end
  return false
end

function QTR_Immersion(...)
  if ImmersionPlugin and ImmersionPlugin.QTR_Immersion then
    return ImmersionPlugin.QTR_Immersion(...)
  end
end

function QTR_Immersion_Static(...)
  if ImmersionPlugin and ImmersionPlugin.QTR_Immersion_Static then
    return ImmersionPlugin.QTR_Immersion_Static(...)
  end
end

function QTR_Immersion_OFF(...)
  if ImmersionPlugin and ImmersionPlugin.QTR_Immersion_OFF then
    return ImmersionPlugin.QTR_Immersion_OFF(...)
  end
end

function QTR_Immersion_OFF_Static(...)
  if ImmersionPlugin and ImmersionPlugin.QTR_Immersion_OFF_Static then
    return ImmersionPlugin.QTR_Immersion_OFF_Static(...)
  end
end

-- Storyline
function isStoryline()
  if StorylinePlugin and StorylinePlugin.isStoryline then
    return StorylinePlugin.isStoryline()
  end
  return false
end

function QTR_Storyline_Delay(...)
  if StorylinePlugin and StorylinePlugin.QTR_Storyline_Delay then
    return StorylinePlugin.QTR_Storyline_Delay(...)
  end
end

function QTR_Storyline_Quest(...)
  if StorylinePlugin and StorylinePlugin.QTR_Storyline_Quest then
    return StorylinePlugin.QTR_Storyline_Quest(...)
  end
end

function QTR_Storyline_Hide(...)
  if StorylinePlugin and StorylinePlugin.QTR_Storyline_Hide then
    return StorylinePlugin.QTR_Storyline_Hide(...)
  end
end

function QTR_Storyline_Objectives(...)
  if StorylinePlugin and StorylinePlugin.QTR_Storyline_Objectives then
    return StorylinePlugin.QTR_Storyline_Objectives(...)
  end
end

function QTR_Storyline_Rewards(...)
  if StorylinePlugin and StorylinePlugin.QTR_Storyline_Rewards then
    return StorylinePlugin.QTR_Storyline_Rewards(...)
  end
end

function QTR_Storyline(...)
  if StorylinePlugin and StorylinePlugin.QTR_Storyline then
    return StorylinePlugin.QTR_Storyline(...)
  end
end

function QTR_Storyline_Gossip(...)
  if StorylinePlugin and StorylinePlugin.QTR_Storyline_Gossip then
    return StorylinePlugin.QTR_Storyline_Gossip(...)
  end
end

function QTR_Storyline_OFF(...)
  if StorylinePlugin and StorylinePlugin.QTR_Storyline_OFF then
    return StorylinePlugin.QTR_Storyline_OFF(...)
  end
end

-- DialogueUI
function IsDUIQuestFrame()
  if DUIPlugin and DUIPlugin.IsDUIQuestFrame then
    return DUIPlugin.IsDUIQuestFrame()
  end
  return false
end

function QTR_DUIbuttons()
  if DUIPlugin and DUIPlugin.QTR_DUIbuttons then
    return DUIPlugin.QTR_DUIbuttons()
  end
end

function DUI_ON_OFF()
  if DUIPlugin and DUIPlugin.DUI_ON_OFF then
    return DUIPlugin.DUI_ON_OFF()
  end
end

function QTR_DUIQuestFrame(event)
  if DUIPlugin and DUIPlugin.QTR_DUIQuestFrame then
    return DUIPlugin.QTR_DUIQuestFrame(event)
  end
end

function GossipDUI_ON_OFF()
  if DUIPlugin and DUIPlugin.GossipDUI_ON_OFF then
    return DUIPlugin.GossipDUI_ON_OFF()
  end
end

function QTR_DUIGossipFrame()
  if DUIPlugin and DUIPlugin.QTR_DUIGossipFrame then
    return DUIPlugin.QTR_DUIGossipFrame()
  end
end

-- Legacy stub used by Core after QUEST_ACCEPTED for Immersion flow
function QTR_delayed3()
  -- Intentionally left as no-op; legacy hook was removed in modularization.
end
