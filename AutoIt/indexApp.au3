
#include <FunctionsIndex.au3>


;~ Local $logfile = "S:\Sachin\C2\OvernightLogs\16 August\AI_Watcher_2017_08_16.log"
;~ Local $screenfolder = "S:\Sachin\C2\OvernightScreenshots\16 August"


Local $logfile = $CmdLine[1]
Local $screenfolder = $CmdLine[2]


If startIndex($logfile,$screenfolder) Then
   pressKey($logfile,"y{Enter}")
   sendUpdate($logfile,"index_run="& "Yes")
   watchIndex($logfile,$screenfolder)

Else
   _FileWriteLog($logfile,"Index Skipped")
   sendUpdate($logfile,"index_run="& "No Index run due to excess user in system")
EndIf
   useCMD($logfile)
   Run(@ScriptDir & "\BatchFiles\DELETE_EXIT_CM.bat")
   Run(@ScriptDir & "\BatchFiles\BATCH_EXPORT.bat")
   enterPassword($logfile, $screenfolder)
;~    Run(@ScriptDir & "\BatchFiles\Password.exe")



 _FileWriteLog($logfile,"Index Module End")