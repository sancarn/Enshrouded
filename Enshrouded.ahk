#InstallKeybdHook
#SingleInstance, force


#IfWinActive Enshrouded
#If WinActive("ahk_exe Enshrouded.exe") && !(IsMenuMode() || IsStorageMode())

$LButton::ClickTimer()
$e::KeyTimer("e")
$r::
  if IsLookingAtStorage() {
    EnshroudedSendKey("e")
    SendEvent +{r down}
    sleep,50
    SendEvent {r up}
    sleep,50
    EnshroudedSendKey("esc")
  }
return
~Escape::
 global cookingMode := false 
return

;;;; Cooking

;Inspired by https://gitlab.com/gobozen/enshrouded-key-macros
;          | Campfire  | Scavenger Bonfire
;PennyBun  | TBC       | 2000
;
;Meat      |           | 3500

+!enter::CookingInit(3500)


CookingInit(timeToCook){
  maxFoodStack := 20
  InputBox, input, Enshrouded AHK, House many to cook?,,200,100,,,,,%maxFoodStack%
  if ErrorLevel
    return

  stack := input+0
  sleep,150
  CookingStart(stack, timeToCook)
}

CookingStart(stack, timeToCook){
  global cookingMode:=true
  While (stack > 0 && cookingMode) {
    stack := stack - 1
    Send {LButton Down}
    sleep, %timeToCook%
    Send {LButton Up}
    sleep, 50
  }
}

;;;; Click and Key spam

ClickTimer(){
  While GetKeyState("LButton", "P") {
    Click
    Sleep,50
  }
}

KeyTimer(key){
  While GetKeyState(key, "P") {
    EnshroudedSendKey(key)
  }
}

EnshroudedSendKey(key){
    SendEvent {%key% down}
    sleep, 50
    SendEvent {%key% up}
    sleep, 50
}

;;;; Checks

IsMenuMode() {
    ImageSearch, , , 0, 0, A_ScreenWidth, A_ScreenHeight, *50 res\menu_indicator.png
    return !ErrorLevel
}
IsStorageMode() {
    ImageSearch, , , 0, 0, A_ScreenWidth, A_ScreenHeight, *50 res\storage_indicator.png
    return !ErrorLevel
}
IsLookingAtStorage(){
    ImageSearch, , , 0, 0, A_ScreenWidth, A_ScreenHeight, *150 res\e_open.png
    return !ErrorLevel
}