#include <MsgBoxConstants.au3>
#include <File.au3>
#include <ScreenCapture.au3>

#include <Date.au3>



Func readImage($folder , $screenfile);

_FileWriteLog($logfile,"Attempting to read image")
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$url = "http://automationvm01.eltmanlaw.com/dashboard-api/ocr/" & $folder & "/" & $screenfile
_FileWriteLog($logfile,"Request URL:  "& $url )
$oHTTP.Open("GET", $url, False)

$oHTTP.Send()
$oReceived = $oHTTP.ResponseText
$oStatusCode = $oHTTP.Status
_FileWriteLog($logfile,"Response Code:  "& $oStatusCode )
_FileWriteLog($logfile,"Response:  "& $oReceived )

return $oReceived

EndFunc




Func getActive($logfile);
_FileWriteLog($logfile,"Getting Active Dashboard ID")
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$oHTTP.Open("GET", "http://automationvm01.eltmanlaw.com/dashboard-api/active/", False)

$oHTTP.Send()
$oReceived = $oHTTP.ResponseText
$oStatusCode = $oHTTP.Status
_FileWriteLog($logfile,"Response Code:  "& $oStatusCode )
_FileWriteLog($logfile,"ID:  "& $oReceived )
Return $oReceived


EndFunc

Func put_update($uri,$logfile,$msg);
_FileWriteLog($logfile,"Sending Update: "& $msg)

$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
$oHTTP.Open("PUT", $uri, False)
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")

; Performing the Request
$oHTTP.Send($msg)
$oReceived = $oHTTP.ResponseText
$oStatusCode = $oHTTP.Status
_FileWriteLog($logfile,"Response Code:  "& $oStatusCode )
_FileWriteLog($logfile,"Response:  "& $oReceived )
EndFunc


Func sendUpdate($logfile,$msg);
   $localuri = "http://automationvm01.eltmanlaw.com/dashboard-api/"
   $uri = "http://eec.mymailing.website/dashboard-api/"
   put_update($localuri,$logfile,$msg)
   put_update($uri,$logfile,$msg)
EndFunc
