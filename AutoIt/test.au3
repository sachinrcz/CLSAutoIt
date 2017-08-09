#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>

#include <Date.au3>
#include <Excel.au3>
#include <Helper.au3>
#include <WinAPIFiles.au3>

Local $logfile = "S:\Sachin\C2\OvernightLogs\9 August\AI_Watcher_2017_08_08.log"
Local $screenfolder = "S:\Sachin\C2\OvernightScreenshots\9 August"
watchIndex($logfile,$screenfolder)
useCMD($logfile)
;~ pressKey($logfile,"{Enter}")
;useCMD($logfile)
;startIndex($logfile,$screenfolder)

