#include <Helper.au3>


;~  ============================= Word Merge Functions ============================


 Func checkTriggerImportCLS($logfile, $screenfolder);
   _FileWriteLog($logfile,"Checking If Trigger Still Importing")
	Local $i = 1
	While $i > 0
		 ;WinWait("CM-8.7", "", 30)
		 Sleep(2000)
		 Local $hWnd = WinGetHandle("Batch Word Processing")
		If @error Then
			;MsgBox($MB_SYSTEMMODAL, "","CLS Window not found. End of Script")
			_FileWriteLog($logfile, "Pop Up not found. Means Trigger import is complete")
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


Func updateBatchWordMerge($logfile,$screenfolder);
   _FileWriteLog($logfile,"Starting Batch Word Merge Update Module")

;~    $screenfile = "ScreenShot_6_08_17 AM.jpg"
   $screenfile = capture($screenfolder)
   $folder = StringSplit($screenfolder, "\")[5]
   $txt = readImage($folder, $screenfile)

   $newclaim = 0
   $split = StringSplit($txt, "\n", $STR_ENTIRESPLIT)
   For $i = 1 To $split[0]
			   If StringInStr($split[$i], "Document") > 0 Then
				  _FileWriteLog($logfile,$split[$i])
				  $split =StringSplit($split[$i],"ssingh2",$STR_ENTIRESPLIT)
				  $stripped = StringStripWS($split[2],$STR_STRIPLEADING + $STR_STRIPTRAILING)
				  $split =StringSplit($stripped," ",$STR_ENTIRESPLIT)
;~ 				  MsgBox($MB_SYSTEMMODAL, "",$split[1])
				  $newclaim =  $split[1]
				  ExitLoop
			   EndIf
   Next
   If  $newclaim == 0 Then
	  sendUpdate($logfile,"last_update=Something Wrong with Merge")
	  _FileWriteLog($logfile, "Something Wrong with Merge")
	  MsgBox($MB_SYSTEMMODAL, "","Something is Wrong")
   Else
	  $msg = "word_merge=" & $newclaim
	  sendUpdate($logfile,$msg)

   EndIf



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

