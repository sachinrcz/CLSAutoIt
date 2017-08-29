#include <FunctionsNewClaim.au3>

Local $logfile = $CmdLine[1]
Local $screenfolder = $CmdLine[2]
;Local $logfile = "S:\Sachin\C2\OvernightLogs\26 July\AI_Watcher_2017_07_25.log"
;Local $screenfolder = "S:\Sachin\C2\OvernightScreenshots\26 July"
sendUpdate($logfile,"last_update="& "CourtOpt New Claim")
Local $iPID = Run("F:\CLSInc\WBWIN\BRClient64.exe")
enterPassword($logfile, $screenfolder)

sendUpdate($logfile,"last_update="& "CourtOpt Print Claim")
Local $claimRes = printNewClaim($logfile, $screenfolder)
If  $claimRes == 1 Then
   _FileWriteLog($logfile,"Print Claim Successful")
   ;MsgBox($MB_SYSTEMMODAL, "","Print Claim Successful")

Else
   If $claimRes == 0 Then
	  _FileWriteLog($logfile,"Print Claim Failed Stopping Further Execution")
	  sendUpdate($logfile,"last_update="& "CourtOpt Print Failed")
	  useCMD($logfile)
	  ;MsgBox($MB_SYSTEMMODAL, "","Print Claim Failed Stopping Further Execution")
	  Exit

   Else
	  sendUpdate($logfile,"last_update="& "Close Excel to Proceed")
	  MsgBox($MB_SYSTEMMODAL, "","Close Excel to Proceed")
   EndIf

EndIf

updateNewClaim($logfile,$screenfolder,"court_new_claim=")
sendUpdate($logfile,"last_update="& "CourtOpt Assignment")
assignmentCourt($logfile,$screenfolder)
sendUpdate($logfile,"last_update="& "CourtOpt XNWCLAIM")
xnwclaim($logfile,$screenfolder)
sendUpdate($logfile,"last_update="& "CourtOpt Reset")
resetclaim($logfile,$screenfolder)
sendUpdate($logfile,"last_update="& "CourtOpt Merge")
startmerge($logfile,$screenfolder)
waitmergecomplete($logfile,$screenfolder)
Local $hWnd = WinGetHandle("CM-8.7")
WinActivate($hWnd)
key("{ESC}")
If $claimRes ==  -1 Then
  MsgBox($MB_SYSTEMMODAL, "","Close Excel to Proceed")
  Exit
EndIf

useCMD($logfile)
sendUpdate($logfile,"last_update="& "CourtOpt New Claim Completed")








