#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>
#include <Helper.au3>
#include <Date.au3>

Local $logfile = $CmdLine[1]
Local $screenfolder = $CmdLine[2]


If startIndex($logfile,$screenfolder) Then
   pressKey($logfile,"y{Enter}")
   watchIndex($logfile,$screenfolder)
   useCMD($logfile)
Else
   useCMD($logfile)
   _FileWriteLog($logfile,"Index Skipped")
   sendUpdate($logfile,"remarks="& "No Index Run")
   Run(@ScriptDir & "\BatchFiles\DELETE_EXIT_CM.bat")
   Run(@ScriptDir & "\BatchFiles\BATCH_EXPORT.bat")
   Run(@ScriptDir & "\BatchFiles\Password.exe")
EndIf