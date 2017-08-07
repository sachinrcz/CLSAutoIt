#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>

#include <Date.au3>


Func enterPassword($logfile,$screenfolder);
	_FileWriteLog($logfile,"Waiting for Password PopUp")
	;sendUpdate($logfile,"last_update="& "Waiting Password PopUp")
	While 1
	    If isCLSOpen($logfile,$screenfolder) Then
		   _FileWriteLog($logfile,"Login Complete")
		   capture($screenfolder)
		   ExitLoop
		EndIf
		WinWait("Business Rules! Connect", "", 10)
		Local $hWnd = WinGetHandle("Business Rules! Connect")

		If @error Then
			sleep(10000)
			ContinueLoop
		EndIf
		_FileWriteLog($logfile,"PopUp found. Entering Password")
		WinActivate($hWnd)

		Local $password = IniRead(@ScriptDir & "\password.ini", "Password", "key", "123456")
		Send($password)
		Send("{Enter}")
		 sleep(30000)
		 If isCLSOpen($logfile,$screenfolder) Then
		   _FileWriteLog($logfile,"Login Complete")
		   capture($screenfolder)
		   ExitLoop
		Else
		   _FileWriteLog($logfile,"Login Failed")
		   capture($screenfolder)
		   MsgBox($MB_SYSTEMMODAL, "","Log In Failed")
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

 Func startIndex($logfile,$screenfolder) ;
	_FileWriteLog($logfile,"Starting Index Run Module")
	Local $iPID = Run("F:\CLSInc\WBWIN\BRClient64.exe")
    enterPassword($logfile, $screenfolder)

	   WinWait("CM-8.7", "", 30)
	   Local $hWnd = WinGetHandle("CM-8.7")
		   If @error Then
			   MsgBox($MB_SYSTEMMODAL, "","Unknown Error in Index Run")
			   Exit
		   EndIf
	   WinActivate($hWnd)
	   _FileWriteLog($logfile,"On Main Screen")
	   capture($screenfolder)
	   key("41S1R")
	   key("{Enter}")
	   WinActivate($hWnd)
		Local $sText =WinGetText("CM-8.7")
		$i = StringInStr($sText, "EXIT_CM")
		If $i > 0 Then
			_FileWriteLog($logfile,"On User List Screen")
			$screenfile = capture($screenfolder)
			$screenfolder = StringSplit($screenfolder, "\")[5]
			$txt = readImage($screenfolder, $screenfile)
			_FileWriteLog($logfile,$txt)
			$users = getUserNumber($logfile, $txt)
			$deboo = StringInStr($txt, "jdeboo")
			if $users > 2  Then
				  MsgBox($MB_SYSTEMMODAL, "","Excess users in system. Not starting Index")
				   _FileWriteLog($logfile,"Excess users in system. Not starting Index")
				    WinActivate($hWnd)
					 key("{Esc}")
					 key("{Esc}")
			ElseIf ($users == 2 And $deboo > 0) Or ($users ==1) Then
			   MsgBox($MB_SYSTEMMODAL, "","Ok to start Index")
			   _FileWriteLog($logfile,"Ok to start Index")
			   WinActivate($hWnd)
			   key("{Esc}")
			   key("191")
			   return True
			EndIf

		 Else
			MsgBox($MB_SYSTEMMODAL, "","Not on user list window")
		 EndIf
	   Exit
	  return False
EndFunc

Func getUserNumber($logfile,$txt);
   $split = StringSplit($txt, "\n", $STR_ENTIRESPLIT)
   For $i = 1 To $split[0]
			   If StringInStr($split[$i], "Users in") > 0 Then
				  _FileWriteLog($logfile,$split[$i])
				  $split =StringSplit($split[$i]," ",$STR_ENTIRESPLIT)
				  return $split[1]
			   EndIf
   Next


EndFunc


 Func checkTriggerImportCLS($logfile, $screenfolder);
   _FileWriteLog($logfile,"Checking If Trigger Still Importing")
	Local $i = 1
	While $i > 0
		 ;WinWait("CM-8.7", "", 30)
		 Sleep(2000)
		 Local $hWnd = WinGetHandle("Batch Word Processing")
		If @error Then
			;MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			_FileWriteLog($logfile, "CLS Window not found. Means Trigger import is complete")
			ExitLoop
		 EndIf

		WinActivate($hWnd)
		Local $sText =WinGetText("Batch Word Processing")
		Local $split = StringSplit($sText, "Source Information",$STR_ENTIRESPLIT)
		$temp = StringMid($split[2], 1)
		$split = StringSplit($temp, "---",$STR_ENTIRESPLIT)
		 $temp = StringMid($split[1], 1)
		_FileWriteLog($logfile,$temp)

		$sText =WinGetText("CM-8.7")
		$i = StringInStr($sText, "SELECT")
		If $i > 0 Then
			_FileWriteLog($logfile,"Claim Not Found Screen Exist")
			sendUpdate($logfile,"last_update="& "Claim Not Found")
			capture($screenfolder)
			WinActivate($hWnd)
			key("{Enter}")

		 EndIf
		 _FileWriteLog($logfile,"Checking Again")
	WEnd
	_FileWriteLog($logfile,"Overnight Trigger Import Check Complete")
	capture($screenfolder)

EndFunc

Func pressKey($logfile, $key) ;
   _FileWriteLog($logfile,"Using CMD")
   Local $hWnd = WinGetHandle("C:\WINDOWS\system32\cmd.exe")
   WinActivate($hWnd)
   key($key)
    _FileWriteLog($logfile,"Key " & $key & " Pressed")
EndFunc

Func useCMD($logfile) ;
   _FileWriteLog($logfile,"Using CMD")
   Local $hWnd = WinGetHandle("C:\WINDOWS\system32\cmd.exe")
   WinActivate($hWnd)
   key("{Enter}")
    _FileWriteLog($logfile,"Enter Presses")
EndFunc


 Func watchIndex($logfile,$screenfolder) ;
	_FileWriteLog($logfile,"Starting Index Watch Module")
	While 1
	   WinWait("CM-8.7", "", 30)
	   Local $hWnd = WinGetHandle("CM-8.7")
		   If @error Then
			   Run(@ScriptDir & "\BatchFiles\DELETE_EXIT_CM.bat")
			   Run(@ScriptDir & "\BatchFiles\BATCH_EXPORT.bat")
			   Run(@ScriptDir & "\BatchFiles\Password.exe")
			   ExitLoop
		   EndIf
	   WinActivate($hWnd)
	   Local $sText =WinGetText("CM-8.7")
	    _FileWriteLog($logfile,"Index Active")
		sendUpdate($logfile,"last_update=Index Active")
		;_FileWriteLog($logfile,$sText)
	   capture($screenfolder)
	   sleep(60000)
	WEnd
	_FileWriteLog($logfile,"Index Complete")
	sendUpdate($logfile,"last_update=Index Complete")
	capture($screenfolder)
EndFunc



Func waitmergecomplete($logfile,$screenfolder) ;
	_FileWriteLog($logfile,"Wait Word Merge")
	WinWait("CM-8.7", "", 30)
	Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			;MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			_FileWriteLog($logfile, "CLS Window not found. End of Script")
			Exit
		EndIf
	Local $i = 1
	While $i > 0

		Sleep(30000)
		WinActivate($hWnd)
		Local $sText =WinGetText("CM-8.7")
		$i = StringInStr($sText, "EnterWP")
		If $i > 0 Then
			_FileWriteLog($logfile,"Word Merge Active")
			sendUpdate($logfile,"last_update=Word Merge Active")
			capture($screenfolder)
		EndIf
	WEnd
	_FileWriteLog($logfile,"Word Merge Complete")
	capture($screenfolder)


EndFunc

Func startmerge($logfile,$screenfolder);

	_FileWriteLog($logfile,"Starting Word Merge")
	WinWait("CM-8.7", "", 30)
	Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			;_FileWriteLog($logfile, "CLS Window not found. End of Script")
			Exit
		EndIf

	WinActivate($hWnd)
	sleep(10000)
	_FileWriteLog($logfile,"Main Menu Screen")
	capture($screenfolder)
	key("M")
	_FileWriteLog($logfile,"Word Merge Started")
	capture($screenfolder)

EndFunc
Func resetclaim($logfile,$screenfolder);

	_FileWriteLog($logfile,"Starting Reset Claim Module")
	WinWait("CM-8.7", "", 30)
	Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			;_FileWriteLog($logfile, "CLS Window not found. End of Script")
			Exit
		EndIf

	WinActivate($hWnd)
	sleep(10000)
	_FileWriteLog($logfile,"Main Menu Screen")
	capture($screenfolder)
	key("1369")
	key("{Enter}")

	_FileWriteLog($logfile,"Reset Done")
	capture($screenfolder)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($screenfolder)
EndFunc

Func xnwclaim($logfile,$screenfolder);

	_FileWriteLog($logfile,"Starting XNWCLAIM Module")
	WinWait("CM-8.7", "", 30)
	Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			;_FileWriteLog($logfile, "CLS Window not found. End of Script")
			Exit
		EndIf

	WinActivate($hWnd)
	sleep(10000)
	_FileWriteLog($logfile,"Main Menu Screen")
	capture($screenfolder)
	key("13651")
	_FileWriteLog($logfile,"Batch Word Processing Screen")
	capture($screenfolder)
	key("XNWCLAIM")
	_FileWriteLog($logfile,"XNWCLAIM")
	capture($screenfolder)
	key("{Enter}")

	_FileWriteLog($logfile,"XNWCLAIM Done")
	capture($screenfolder)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($screenfolder)
EndFunc




Func assignment($logfile,$screenfolder);
	_FileWriteLog($logfile,"Starting Assignment Module")
	WinWait("CM-8.7", "", 30)
	Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			;_FileWriteLog($logfile, "CLS Window not found. End of Script")
			Exit
		EndIf

	WinActivate($hWnd)
	sleep(10000)
	_FileWriteLog($logfile,"Main Menu Screen")
	capture($screenfolder)
	key("1366")
	_FileWriteLog($logfile,"Assisnment Screen")
	capture($screenfolder)
	key("{Enter}")
	_FileWriteLog($logfile,"Set Y for calcsheriff")
	capture($screenfolder)
	key("{TAB}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("Y")
	_FileWriteLog($logfile,"Y SET")
	capture($screenfolder)
	key("{Enter}")
	_FileWriteLog($logfile,"Assignment Done")
	capture($screenfolder)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($screenfolder)
EndFunc

Func assignmentCourt($logfile,$screenfolder);
	_FileWriteLog($logfile,"Starting CourtOpt Assignment Module")
	WinWait("CM-8.7", "", 30)
	Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			;_FileWriteLog($logfile, "CLS Window not found. End of Script")
			Exit
		EndIf

	WinActivate($hWnd)
	sleep(10000)
	_FileWriteLog($logfile,"Main Menu Screen")
	capture($screenfolder)
	key("1366")
	_FileWriteLog($logfile,"Assisnment Screen")
	capture($screenfolder)
	key("{Enter}")
	_FileWriteLog($logfile,"Set Y for calcsheriff")
	capture($screenfolder)
	key("{TAB}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("{DOWN}")
	key("Y")
	key("{DOWN}")
	key("Y")
	MsgBox($MB_SYSTEMMODAL, "","Click OK to contiue")
	WinActivate($hWnd)
	_FileWriteLog($logfile,"Y SET")
	capture($screenfolder)
	key("{Enter}")
	_FileWriteLog($logfile,"Assignment Done")
	capture($screenfolder)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($screenfolder)
EndFunc

Func newClaimExist($logfile,$screenfolder);
   _FileWriteLog($logfile,"Checking for new claims")
   Local $hWnd = WinGetHandle("CM-8.7")
			If @error Then
				_FileWriteLog($logfile, "CLS Window not found. End of Script")
				 MsgBox($MB_SYSTEMMODAL, "","This should not have happened")
				Exit
			EndIf

		   WinActivate($hWnd)
		   Local $sText =WinGetText("CM-8.7")
		   $i = StringInStr($sText, "SELECT")
		   If $i > 0 Then

			   _FileWriteLog($logfile,"Found SELECT Means New Claim Exist")
			   ;MsgBox($MB_SYSTEMMODAL, "","Found SELECT Means New Claim Exist")
			   capture($screenfolder)
			   return True
			Else
			   _FileWriteLog($logfile,"It appears that No New Claim Exist")
			   capture($screenfolder)
			EndIf


   Return False
EndFunc


Func printNewClaim($logfile,$screenfolder) ;
	_FileWriteLog($logfile,"Starting Print New Claim module")
	WinWait("CM-8.7", "", 30)
	Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			;_FileWriteLog($logfile, "CLS Window not found. End of Script")
			Exit
		EndIf

	WinActivate($hWnd)
	sleep(10000)
	key("13623")
	_FileWriteLog($logfile,"At New Claim Screen")
	capture($screenfolder)
	key("{Enter}")
If newClaimExist($logfile,$screenfolder) Then
	_FileWriteLog($logfile,"New Claims Sorted By")
	capture($screenfolder)
	key("{Enter}")
	_FileWriteLog($logfile,"Continious Report")
	capture($screenfolder)
	key("{DOWN}")
	key("{Enter}")
	_FileWriteLog($logfile,"Printer Selection")
	capture($screenfolder)
	key("7")
	key("{Enter}")
	_FileWriteLog($logfile,"Printing Report")
	capture($screenfolder)
	sleep(10000)
	WinActivate($hWnd)
	_FileWriteLog($logfile,"New Claim Screen")
	capture($screenfolder)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($screenfolder)
	_FileWriteLog($logfile,"Print New Claim complete")
	If Not closeXLS() Then
	  MsgBox($MB_SYSTEMMODAL, "","Excel Did not close or No New Claime")
	  Return -1
   EndIf
   Return 1
Else
   WinActivate($hWnd)
   _FileWriteLog($logfile,"Backing Up")
	capture($screenfolder)
   key("{ESC}")
   key("{ESC}")
   key("{ESC}")
      _FileWriteLog($logfile,"Backing Up")
	capture($screenfolder)
   key("{ESC}")
   Return 0
EndIf
 EndFunc

Func closeXLS();
    Local $hWnd = WinGetHandle("Microsoft Excel")
		    If @error Then
			    MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
				Exit
		   EndIf
	WinActivate($hWnd)
	WinClose($hWnd)
	return True
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

Func capture($screenfolder) ;

	Local $screenfile = "ScreenShot" & getstamp() & ".jpg"
	 _ScreenCapture_Capture( $screenfolder & "\" & $screenfile )
	 return $screenfile

EndFunc

Func readImage($folder , $screenfile);

_FileWriteLog($logfile,"Attempting to read image")
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$oHTTP.Open("GET", "http://192.168.147.44:8000/dashboard-api/ocr/" & $folder & "/" & $screenfile, False)

$oHTTP.Send()
$oReceived = $oHTTP.ResponseText
$oStatusCode = $oHTTP.Status
_FileWriteLog($logfile,"Response Code:  "& $oStatusCode )
_FileWriteLog($logfile,"Response:  "& $oReceived )

return $oReceived

EndFunc


Func getActive($logfile);
_FileWriteLog($logfile,"Getting Active Dashboard ID")
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$oHTTP.Open("GET", "http://192.168.147.44:8000/dashboard-api/active/", False)

$oHTTP.Send()
$oReceived = $oHTTP.ResponseText
$oStatusCode = $oHTTP.Status
_FileWriteLog($logfile,"Response Code:  "& $oStatusCode )
_FileWriteLog($logfile,"ID:  "& $oReceived )
Return $oReceived


EndFunc



Func sendUpdate($logfile,$msg);
_FileWriteLog($logfile,"Sending Update: "& $msg)

$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$id = getActive($logfile)
$uri = "http://192.168.147.44:8000/dashboard-api/" & $id & "/"
$oHTTP.Open("PUT", $uri, False)
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")

; Performing the Request
$oHTTP.Send($msg)
$oReceived = $oHTTP.ResponseText
$oStatusCode = $oHTTP.Status
_FileWriteLog($logfile,"Response Code:  "& $oStatusCode )
_FileWriteLog($logfile,"Response:  "& $oReceived )
EndFunc
