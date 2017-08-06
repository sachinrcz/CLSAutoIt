#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>

#include <Date.au3>
#include <Excel.au3>
#include <Helper.au3>
#include <WinAPIFiles.au3>


Local $logfile = "S:\Sachin\C2\OvernightLogs\26 July\AI_Watcher_2017_07_25.log"
Local $screenfolder = "S:\Sachin\C2\OvernightScreenshots\26 July"

;enterPassword($logfile,$screenfolder)
;sendUpdate($logfile,"last_update=Watcher activated")
sendUpdate($logfile,"last_update="& "Word Merge Complete")

