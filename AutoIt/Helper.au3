#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>
#include <DashboardAPI.au3>
#include <Date.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>


Func enterPassword($logfile,$screenfolder);
	_FileWriteLog($logfile,"Waiting for Password PopUp")

	While 1
	    If isCLSOpen($logfile,$screenfolder) Then
		   _FileWriteLog($logfile,"Login Complete")
		   capture($logfile,$screenfolder)
		   ExitLoop
		EndIf
		WinWait("Business Rules! Connect", "", 10)
		Local $hWnd = WinGetHandle("Business Rules! Connect")

		If @error Then
			sleep(10000)
			ContinueLoop
		EndIf
		_FileWriteLog($logfile,"PopUp found. Entering Password")


		Local $password = IniRead(@ScriptDir & "\password.ini", "Password", "key", "123456")
		WinActivate($hWnd)
		Send($password)
		Send("{Enter}")
		 sleep(5000)
		 WinWait("Business Rules! Connect", "", 10)
		Local $hWnd = WinGetHandle("Business Rules! Connect")

		If @error Then
			 _FileWriteLog($logfile,"Login Complete")
			capture($logfile,$screenfolder)
		    ExitLoop
		 Else
			_FileWriteLog($logfile,"Login Failed")
			sendUpdate($logfile,"last_update="& "Error in Password PopUp")
		    capture($logfile,$screenfolder)
		EndIf


	WEnd
 EndFunc

Func isCLSOpen($logfile,$screenfolder);
		 Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			;MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			_FileWriteLog($logfile, "CLS is not open")
			Return False
		 EndIf
		 Return True

EndFunc


Func pressKey($logfile, $key) ;
   _FileWriteLog($logfile,"Using CMD")
   Local $hWnd = WinGetHandle("C:\WINDOWS\system32\cmd.exe")
			If @error Then
			   $hWnd = WinGetHandle("C:\WINDOWS\SYSTEM32\cmd.exe")
		   EndIf
   WinActivate($hWnd)
   key($key)
    _FileWriteLog($logfile,"Key " & $key & " Pressed")
EndFunc

Func useCMD($logfile) ;
   _FileWriteLog($logfile,"Using CMD")
   Local $hWnd = WinGetHandle("C:\WINDOWS\system32\cmd.exe")
			If @error Then
			   $hWnd = WinGetHandle("C:\WINDOWS\SYSTEM32\cmd.exe")
		   EndIf
   WinActivate($hWnd)
   key("{Enter}")
    _FileWriteLog($logfile,"Enter Presses")
EndFunc


Func getstamp() ;
    Local  $string

	Local $nwTime = _NowTime()
	Local $time = StringSplit($nwTime, ":")


	For $x = 1 To $time[0]
		$string = $string & "_" & $time[$x]
	Next
	Return $string
EndFunc


Func key($press);
	sleep(1000)
	Send($press)
	sleep(1000)
 EndFunc

Func capture($logfile,$screenfolder);

	Local $screenfile = "ScreenShot" & getstamp() & ".jpg"
	_FileWriteLog($logfile,"Screen Capture: " & $screenfile)
	 _ScreenCapture_Capture( $screenfolder & "\" & $screenfile )
	 return $screenfile

EndFunc

Func moveToErrorFolder($logfile,$screenfolder,$folder, $screenfile);

   _FileWriteLog($logfile,"Moving to Error Folder")
   $screenshot = $screenfolder & "\" & $screenfile
   $errordir = "S:\Sachin\C2\Overnight Errors\" & $folder
   FileCopy($screenshot, $errordir, $FC_OVERWRITE + $FC_CREATEPATH)
   _FileWriteLog($logfile,$screenshot & " Copied to " & $errordir)
EndFunc

Func moveToErrorFolder($logfile,$screenfolder,$folder, $screenfile);

   _FileWriteLog($logfile,"Moving to Error Folder")
   $screenshot = $screenfolder & "\" & $screenfile
   $errordir = "S:\Sachin\C2\Overnight Errors\" & $folder
   FileCopy($screenshot, $errordir, $FC_OVERWRITE + $FC_CREATEPATH)
   _FileWriteLog($logfile,$screenshot & " Copied to " & $errordir)
EndFunc

