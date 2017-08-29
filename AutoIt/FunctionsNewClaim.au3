#include <Helper.au3>



;~  ============================= New Claim Functions ============================


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
	capture($logfile,$screenfolder)
	key("1369")
	key("{Enter}")

	_FileWriteLog($logfile,"Reset Done")
	capture($logfile,$screenfolder)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($logfile,$screenfolder)
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
	capture($logfile,$screenfolder)
	key("13651")
	_FileWriteLog($logfile,"Batch Word Processing Screen")
	capture($logfile,$screenfolder)
	key("XNWCLAIM")
	_FileWriteLog($logfile,"XNWCLAIM")
	capture($logfile,$screenfolder)
	key("{Enter}")

	_FileWriteLog($logfile,"XNWCLAIM Done")
	capture($logfile,$screenfolder)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($logfile,$screenfolder)
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
	capture($logfile,$screenfolder)
	key("1366")
	_FileWriteLog($logfile,"Assisnment Screen")
	capture($logfile,$screenfolder)
	key("{Enter}")
	_FileWriteLog($logfile,"Set Y for calcsheriff")
	capture($logfile,$screenfolder)
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
	capture($logfile,$screenfolder)
	key("{Enter}")

	_FileWriteLog($logfile,"Assignment Started")
	capture($logfile,$screenfolder)
	waitAssignmentComplete($logfile,$screenfolder)
	WinActivate($hWnd)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($logfile,$screenfolder)
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
	capture($logfile,$screenfolder)
	key("1366")
	_FileWriteLog($logfile,"Assisnment Screen")
	capture($logfile,$screenfolder)
	key("{Enter}")
	_FileWriteLog($logfile,"Set Y for calcsheriff")
	capture($logfile,$screenfolder)
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
;~ 	MsgBox($MB_SYSTEMMODAL, "","Click OK to contiue")
	WinActivate($hWnd)
	_FileWriteLog($logfile,"Y SET")
	capture($logfile,$screenfolder)
	key("{Enter}")

	_FileWriteLog($logfile,"Assignment Started")
	capture($logfile,$screenfolder)
	waitAssignmentComplete($logfile,$screenfolder)
	WinActivate($hWnd)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($logfile,$screenfolder)
 EndFunc

 Func updateNewClaim($logfile,$screenfolder, $claim);
   _FileWriteLog($logfile,"Starting New Claim Update Module")
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
	capture($logfile,$screenfolder)
   key("136{Enter}")
   _FileWriteLog($logfile,"New Claim Screen")
   sleep(2000)
   $screenfile = capture($logfile,$screenfolder)
   $folder = StringSplit($screenfolder, "\")[5]
   $txt = readImage($folder, $screenfile)

   $newclaim = 0
   $split = StringSplit($txt, "\n", $STR_ENTIRESPLIT)
   For $i = 1 To $split[0]
			   If StringInStr($split[$i], "new claim") > 0 Then
				  _FileWriteLog($logfile,$split[$i])
				  $split =StringSplit($split[$i]," ",$STR_ENTIRESPLIT)
				  $newclaim =  $split[3]
				  ExitLoop
			   EndIf
   Next
   $msg = $claim & $newclaim
   sendUpdate($logfile,$msg)


   WinActivate($hWnd)
   key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($logfile,$screenfolder)

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
			   capture($logfile,$screenfolder)
			   return True
			Else
			   _FileWriteLog($logfile,"It appears that No New Claim Exist")
			   capture($logfile,$screenfolder)
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
	capture($logfile,$screenfolder)
	key("{Enter}")
If newClaimExist($logfile,$screenfolder) Then
	_FileWriteLog($logfile,"New Claims Sorted By")
	capture($logfile,$screenfolder)
	key("{Enter}")
	_FileWriteLog($logfile,"Continious Report")
	capture($logfile,$screenfolder)
	key("{DOWN}")
	key("{Enter}")
	_FileWriteLog($logfile,"Printer Selection")
	capture($logfile,$screenfolder)
	key("7")
	key("{Enter}")
	_FileWriteLog($logfile,"Printing Report")
	capture($logfile,$screenfolder)
	sleep(10000)
	WinActivate($hWnd)
	_FileWriteLog($logfile,"New Claim Screen")
	capture($logfile,$screenfolder)
	key("{ESC}")
	_FileWriteLog($logfile,"Main Screen")
	capture($logfile,$screenfolder)
	_FileWriteLog($logfile,"Print New Claim complete")
	If Not closeXLS() Then
	  MsgBox($MB_SYSTEMMODAL, "","Excel Did not close or No New Claime")
	  Return -1
   EndIf
   Return 1
Else
   WinActivate($hWnd)
   _FileWriteLog($logfile,"Backing Up")
	capture($logfile,$screenfolder)
   key("{ESC}")
    WinActivate($hWnd)
   key("{ESC}")
    WinActivate($hWnd)
   key("{ESC}")
      _FileWriteLog($logfile,"Backing Up")
	capture($logfile,$screenfolder)
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


Function waitAssignmentComplete($logfile,$screenfolder) ;
   _FileWriteLog($logfile,"Wait Assignment Complete")
	WinWait("CM-8.7", "", 30)
	Local $hWnd = WinGetHandle("CM-8.7")
		If @error Then
			;MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			_FileWriteLog($logfile, "CLS Window not found. End of Script")
			Exit
		EndIf
	Local $i = 1
	While $i > 0

		Sleep(1000)
		WinActivate($hWnd)
		Local $sText =WinGetText("CM-8.7")
		$i = StringInStr($sText, "ASSIGN")
		If $i > 0 Then
			_FileWriteLog($logfile,"Assignment Active")
			sendUpdate($logfile,"last_update=Assignment Active")
			capture($logfile,$screenfolder)
		EndIf
	WEnd
	_FileWriteLog($logfile,"Assignment Complete")
	capture($logfile,$screenfolder)




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
			capture($logfile,$screenfolder)
		EndIf
	WEnd
	_FileWriteLog($logfile,"Word Merge Complete")
	capture($logfile,$screenfolder)


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
	capture($logfile,$screenfolder)
	key("M")
	_FileWriteLog($logfile,"Word Merge Started")
	capture($logfile,$screenfolder)

EndFunc
