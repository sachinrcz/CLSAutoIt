#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>

#include <Date.au3>
#include <Excel.au3>
#include <Helper.au3>
#include <WinAPIFiles.au3>

Example()
Exit
Func Example()
    ; Create a constant variable in Local scope of the filepath that will be read/written to.
    Local Const $sFilePath = _WinAPI_GetTempFileName(@ScriptDir & "\password.ini")

   MsgBox($MB_SYSTEMMODAL, "", @ScriptDir & "\password.ini")
    ; Read the INI file for the value of 'Title' in the section labelled 'General'.
    Local $sRead = IniRead(@ScriptDir & "\password.ini", "Password", "key", "Password")

    ; Display the value returned by IniRead.
    MsgBox($MB_SYSTEMMODAL, "",  $sRead)


EndFunc   ;==>Example


Local $logfile = "S:\Sachin\C2\OvernightLogs\26 July\AI_Watcher_2017_07_25.log"
Local $screenfolder = "S:\Sachin\C2\OvernightScreenshots\26 July"

Local $iPID = Run("F:\CLSInc\WBWIN\BRClient64.exe")
enterPassword($logfile, $screenfolder)
Local $claimRes = printNewClaim($logfile, $screenfolder)
If  $claimRes == 1 Then
   MsgBox($MB_SYSTEMMODAL, "","Print Claim Successful")

Else
   If $claimRes == 0 Then
	  MsgBox($MB_SYSTEMMODAL, "","Print Claim Failed Stopping Further Execution")
	  Exit
   Else
	  MsgBox($MB_SYSTEMMODAL, "","Close Excel to Proceed")
   EndIf

EndIf
