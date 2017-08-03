#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>

#include <Date.au3>


Local $logfile = $CmdLine[1]
Local $screenfolder = $CmdLine[2]

While 1
	Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			Run(@ScriptDir & "\BatchFiles\DELETE_EXIT_CM.bat", "", @SW_SHOWMAXIMIZED)
			Run(@ScriptDir & "\BatchFiles\BATCH_EXPORT.bat", "", @SW_SHOWMAXIMIZED)
			Run(@ScriptDir & "\BatchFiles\Password.exe")
			MsgBox($MB_SYSTEMMODAL, "", "Process Complete")
			Exit
		EndIf

	_FileWriteLog(@ScriptDir & $logfile, $hWnd)
	Local $sText = WinGetText("CM-8.7")
	_FileWriteLog(@ScriptDir & $logfile, $sText)
	Local $screenfile = "\ScreenShot" & getstamp() & ".jpg"
	 _ScreenCapture_Capture($screenfolder & $screenfile )

	sleep(60000)
	 _FileWriteLog(@ScriptDir & $logfile, "Sleep Over")

 WEnd
MsgBox($MB_SYSTEMMODAL, "", "EDI Import Complete")
Exit


Func getDate() ;
    Local $aMyDate, $aMyTime, $string
	Local $tCur = _Date_Time_GetSystemTime()
	Local $stamp = _Date_Time_SystemTimeToDateTimeStr($tCur)
	_DateTimeSplit($stamp, $aMyDate, $aMyTime)

	For $x = 1 To $aMyDate[0]
		$string = $string & "_" & $aMyDate[$x]
	Next
	local $folder =@ScriptDir &  "\Screen\IndexWatcher\" & $string
	If DirGetSize($folder) <> -1 Then
        Return $folder
    EndIf
	DirCreate($folder)
	Return $folder
EndFunc

Func getstamp() ;
    Local $aMyDate, $aMyTime, $string
	Local $tCur = _Date_Time_GetSystemTime()
	Local $stamp = _Date_Time_SystemTimeToDateTimeStr($tCur)
	_DateTimeSplit($stamp, $aMyDate, $aMyTime)

	For $x = 1 To $aMyDate[0]
		$string = $string & "_" & $aMyDate[$x]
	Next

	For $x = 1 To $aMyTime[0]
		$string = $string & "_" & $aMyTime[$x]
	Next
	Return $string
EndFunc

