#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>
#include <Helper.au3>
#include <Date.au3>

Local $logfile = $CmdLine[1]
Local $screenfolder = $CmdLine[2]
Local $iPID = Run("F:\CLSInc\WBWIN\BRClient64.exe")
enterPassword($logfile, $screenfolder)
Local $claimRes = printNewClaim($logfile, $screenfolder)
If  $claimRes == 1 Then
   _FileWriteLog($logfile,"Print Claim Successful")
   ;MsgBox($MB_SYSTEMMODAL, "","Print Claim Successful")

Else
   If $claimRes == 0 Then
	  _FileWriteLog($logfile,"Print Claim Failed Stopping Further Execution")
	  useCMD($logfile)
	  ;MsgBox($MB_SYSTEMMODAL, "","Print Claim Failed Stopping Further Execution")
	  Exit

   Else
	  MsgBox($MB_SYSTEMMODAL, "","Close Excel to Proceed")
   EndIf

EndIf



assignment($logfile,$screenfolder)
xnwclaim($logfile,$screenfolder)
resetclaim($logfile,$screenfolder)
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









