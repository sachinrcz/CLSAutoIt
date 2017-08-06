#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>

#include <Date.au3>
#include <Excel.au3>
#include <Helper.au3>
#include <WinAPIFiles.au3>
Local $logfile = "S:\Sachin\C2\OvernightLogs\26 July\AI_Watcher_2017_07_25.log"
Local $screenfolder = "S:\Sachin\C2\OvernightScreenshots\26 July"
 Local $hWnd = WinWait("CM-8.7", "", 10)

    ; Set the edit control in Notepad with some text. The handle returned by WinWait is used for the "title" parameter of ControlSetText.
   ; ControlSetText($hWnd, "", "Edit1", "This is some text")

    ; Retrieve the text of the edit control in Notepad. The handle returned by WinWait is used for the "title" parameter of ControlGetText.
    Local $sText = ControlGetText($hWnd, "", "[CLASS:wxWindowClass]")

    ; Display the text of the edit control.
    ;MsgBox($MB_SYSTEMMODAL, "", "The text in Edit1 is: " & $sText)
   WinActivate($hWnd)
   capture($screenfolder)
    ; Close the Notepad window using the handle returned by WinWait.
    ;WinClose($hWnd)



Exit

checkTriggerImportCLS($logfile, $screenfolder)
Exit


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
