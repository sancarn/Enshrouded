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