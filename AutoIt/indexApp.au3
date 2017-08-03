#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>
#include <Helper.au3>
#include <Date.au3>

Local $logfile = $CmdLine[1]
Local $screenfolder = $CmdLine[2]

watchIndex($logfile,$screenfolder)
useCMD($logfile)