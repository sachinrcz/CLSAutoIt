

#include <Helper.au3>


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
	   capture($logfile,$screenfolder)
	   key("41S1R")
	   key("{Enter}")
	   WinActivate($hWnd)
		Local $sText =WinGetText("CM-8.7")
		$i = StringInStr($sText, "EXIT_CM")
		If $i > 0 Then
			_FileWriteLog($logfile,"On User List Screen")
			$screenfile = capture($logfile,$screenfolder)
			$folder = StringSplit($screenfolder, "\")[5]
			$txt = readImage($folder, $screenfile)
			_FileWriteLog($logfile,$txt)
			$users = getUserNumber($logfile, $txt)
			$deboo = StringInStr($txt, "jdeboo")
			if $users > 2  Then
;~ 				 	MsgBox($MB_SYSTEMMODAL, "","Excess users in system. Not starting Index")
				   _FileWriteLog($logfile,"Excess users in system. Not starting Index")
					 moveToErrorFolder($logfile,$screenfolder,$folder, $screenfile)
				    WinActivate($hWnd)
					key("{Esc}")
					key("{Esc}")
					return False
			ElseIf ($users == 2 And $deboo > 0) Or ($users ==1) Then
;~ 			   MsgBox($MB_SYSTEMMODAL, "","Ok to start Index")
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

 Func watchIndex($logfile,$screenfolder) ;
	_FileWriteLog($logfile,"Starting Index Watch Module")
	sendUpdate($logfile,"index_run="& "Yes")
	While 1
	   WinWait("CM-8.7", "", 30)
	   Local $hWnd = WinGetHandle("CM-8.7")
		   If @error Then
			   Run(@ScriptDir & "\BatchFiles\DELETE_EXIT_CM.bat")
			   Run(@ScriptDir & "\BatchFiles\BATCH_EXPORT.bat")
;~ 			   Run(@ScriptDir & "\BatchFiles\Password.exe")
			   enterPassword($logfile, $screenfolder)
			   ExitLoop
		   EndIf
	   WinActivate($hWnd)
	   Local $sText =WinGetText("CM-8.7")
	    _FileWriteLog($logfile,"Index Active")
		sendUpdate($logfile,"last_update=Index Active")
		;_FileWriteLog($logfile,$sText)
	   capture($logfile,$screenfolder)
	   sleep(60000)
	WEnd
	_FileWriteLog($logfile,"Index Complete")
	sendUpdate($logfile,"last_update=Index Complete")
	capture($logfile,$screenfolder)
EndFunc


