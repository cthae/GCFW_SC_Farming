#SingleInstance

F1::{
	;This is the main test function
	main()
}

$F2::{
	reload()
}

$F3::{
	exit()
}

$F4::{
	getMouseCoords()
}

$F5::{
	; MsgBox(IsInteger(detector("FiledW4Inside.png"))?"Nope!":"Found!")
	targetingChange(382, 339, 5)
}

main(i := 0, position := false){
	WMActions("W4")
	Sleep(1000)
	ClearW4()
	Click 11,11,0
	MouseMove(11, 11, 1500)
	Sleep(4000)
	MouseMove(11, 11, 1500)
	Click 11,11,0
	main(i++, false)
}

WMActions(field := "W4"){
	W4Coords := detector("FieldW4.png")
		; This function is for Activity on World Map
	if(!IsInteger(W4Coords)) {
		; MsgBox "All is good! X is " . W4Coords[1] . " and Y is " . W4Coords[2]
		MouseMove W4Coords[1]-150, W4Coords[2]+110, 300
		Sleep(520)
		Click W4Coords[1]-150, W4Coords[2]+110, 3
		Sleep(520)
		Click
		Sleep(520)
		Click
		waitUntilLoaded("FieldW4Traits.png",300)
		;MsgBox "Traits Loaded!"
		Click 519, 202, 2 ; Journey
		Sleep(200)
		Click 1456, 879, 2 ; Start Battle
		Sleep(3000)
		waitUntilLoaded("FiledW4Inside.png",300)
	}
	else
		MsgBox "Field " . field . " hasn't been found :("
}

ClearW4(){
	; This clears W4 on 1920*1080 fullscreen
	
	x := 382
	y := 339
	Click 670, 537, 0 ; Sell useless inventory gems
	PressKey("x", 1, 25)
	Click 1763, 484, 0
	PressKey("x", 1, 25)
	Click 1827, 491, 0
	PressKey("x", 1, 25)
	PressKey("Numpad4") ; Get gems in tower
	PressKey("t")
	Click x, y, 1
	Click "right", 1
	Sleep(250)
	click 1768, 484, 0 ; upgrading, duplicating the gem
	PressKey("u", 2)
	PressKey("d", 8)
	PressKey("u", 3)
	Click x, y, 1
	PressKey("a") ; building amps
	EightClicksAround(322, 281)
	Click "right", 1 ; populating amps
	EightClicksAround(322, 281)
	targetingChange(x, y, 5) ;changing the main gem's targeting
	Sleep 350
	Send "{Ctrl down}" ; Send all waves
	Click 18, 130
	Sleep 70
	Send "{Ctrl up}"
	Sleep 70
	PressKey("q", 2)
	Click 857, 548, 0 ; Move cursor to the center to decrease lags
	Sleep 10000
	Click x, y, 0 ; upgrade the killgem
	PressKey("u", 3)
	PressKey("5", 2)
	Click 857, 548, 0 ; Move cursor to the center to decrease lags
	waitUntilLoaded("BattleEnd.png",1000)
	Sleep(500)
	Click 1754, 980, 1
}

targetingChange(x, y, n := 5){
	MouseMove(x,y)
	Loop n{
		Sleep(100)
		Send("{RButton}")
	}
}

EightClicksAround(x,y){
	offset := 60
	Click x,y,1 
	Sleep(150)
	Click x+offset,y,1
	Sleep(150)
	Click x+offset*2,y,1
	Sleep(150)
	Click x+offset*2,y+offset,1
	Sleep(150)
	Click x+offset*2,y+offset*2,1
	Sleep(150)
	Click x+offset,y+offset*2,1
	Sleep(150)
	Click x,y+offset*2,1
	Sleep(150)
	Click x,y+offset,1
}

getMouseCoords(){
	; This is for mouse position tracking
	MouseGetPos OutputVarX, OutputVarY
	ColorVar := 0
	OutputVarX := OutputVarX ;- 10
	OutputVarY := OutputVarY ;- 10
	PixelGetColor ColorVar, OutputVarX, OutputVarY
	A_Clipboard := Format("{1}, {2}", OutputVarX, OutputVarY)
	msgbox(Format("This is coords: {1}, {2}, The color is {3}",OutputVarX, OutputVarY,ColorVar))
	return
}

detector(path){
	; This function detects images on screen.
	ErrorLvl := ImageSearch(FoundX, FoundY, 0, 0, 1920, 1080, A_ScriptDir . "/images/GC/" . path)
	if(ErrorLvl = 1) {
		
		;MsgBox path." was found at " . FoundX . "x" . FoundY
		return [FoundX, FoundY]
	}
	else{
		;MsgBox(A_ScriptDir . "/images/GC/" . path . " was NOT found.")
		return 0
	}
}

PressKey(charkey, count := 1, ms := 30)
{
    Loop count
    {
        Send("{" . charkey . " down}")
        Sleep(ms)
        Send("{" . charkey . " up}")
        Sleep(ms)
    }
}
waitUntilLoaded(image, timeInterval){
	Loop {
		Sleep(timeInterval)
		if(detector(image) != 0)
			return
	}
}