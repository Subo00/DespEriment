extends Node


#Level
signal OnLevelFinished(is_success: bool)
signal OnCleanUp
signal OnLevelStart

#Gear
signal OnGearCollect
signal ChangeGearUI(text: String)

#Narrator
signal NarratorAudioStartEnded
signal NarratorAudioEndEnded(is_success: bool)
signal StartNarratonEnd(is_success: bool)

#Interactables
signal OnInteraction
signal OnInteracted

#utiliy
signal OnTimerTimeout
signal Pause(is_pause: bool)
