#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>
#include <Helper.au3>
#include <Date.au3>

;Local $logfile = "S:\Sachin\C2\OvernightLogs\4 August\AI_Watcher_2017_08_03.log"
;Local $screenfolder = "S:\Sachin\C2\OvernightScreenshots\4 August"
Local $logfile = $CmdLine[1]
Local $screenfolder = $CmdLine[2]
sendUpdate($logfile,"last_update="& "Trigger Import")
Run(@ScriptDir & "\BatchFiles\Password.exe")
;~ enterPassword($logfile, $screenfolder)
;MsgBox($MB_SYSTEMMODAL, "","Click ok to start merge")
sleep(30000)
checkTriggerImportCLS($logfile, $screenfolder)
sleep(30000)
sendUpdate($logfile,"last_update="& "Batch Word Merge")
Local $brClient = Run("F:\CLSInc\WBWIN\BRClient64.exe")
enterPassword($logfile, $screenfolder)
startmerge($logfile,$screenfolder)
waitmergecomplete($logfile,$screenfolder)
useCMD($logfile)
sendUpdate($logfile,"last_update="& "Merge Complete")










