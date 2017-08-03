#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>

#include <Date.au3>

enterPassword()

Func enterPassword();

	While 1
		WinWait("Business Rules! Connect", "", 10)
		Local $hWnd = WinGetHandle("Business Rules! Connect")

		If @error Then
			sleep(10000)
			ContinueLoop
		EndIf

		WinActivate($hWnd)
	    Local $password = IniRead(@ScriptDir & "\password.ini", "Password", "key", "123456")
		Send($password)
		Send("{Enter}")

		ExitLoop

	WEnd
EndFunc