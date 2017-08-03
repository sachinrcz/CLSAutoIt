#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>
#include <Helper.au3>
#include <Date.au3>

;Local $logfile = "S:\Sachin\C2\OvernightLogs\27 July\AI_Watcher_2017_07_26.log"
;Local $screenfolder = "S:\Sachin\C2\OvernightScreenshots\27 July"
Local $logfile = $CmdLine[1]
Local $screenfolder = $CmdLine[2]

enterPassword($logfile, $screenfolder)
;MsgBox($MB_SYSTEMMODAL, "","Click ok to start merge")
sleep(60000)
Local $brClient = Run("F:\CLSInc\WBWIN\BRClient64.exe")
enterPassword($logfile, $screenfolder)
startmerge($logfile,$screenfolder)
waitmergecomplete($logfile,$screenfolder)
Exit









