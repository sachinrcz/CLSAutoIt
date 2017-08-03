#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>
#include <Helper.au3>
#include <Date.au3>

;Local $logfile = "S:\Sachin\C2\OvernightLogs\26 July\AI_Watcher_2017_07_25.log"
;Local $screenfolder = "S:\Sachin\C2\OvernightScreenshots\26 July"

Local $logfile = $CmdLine[1]
Local $screenfolder = $CmdLine[2]

enterPassword($logfile , $screenfolder)
watch()


Func watch();
	While 1
		WinWait("CM-8.7", "", 30)
		sleep(120000)
		Local $hWnd = WinGetHandle("CM-8.7")
			If @error Then
				_FileWriteLog($logfile, "CLS Window not found. End of Script")
				Exit
			EndIf
		_FileWriteLog($logfile, $hWnd)
		WinActivate($hWnd)
		Local $sText = WinGetText("CM-8.7")
		Local $split = StringSplit($sText, "R2C80",$STR_ENTIRESPLIT)
		$temp = StringMid($split[2], 2, 4)

			If @error Then
				_FileWriteLog($logfile, WinGetText("CM-8.7"))
			Else
				_FileWriteLog($logfile, $temp & " ")
			EndIf

		capture($screenfolder)

	 WEnd

EndFunc
