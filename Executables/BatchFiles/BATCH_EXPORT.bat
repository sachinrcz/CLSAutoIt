rem SCHTASKS /run /TN "IndexMail"
curl -X PUT --data "last_update=Batch Export Started" http://eec.mymailing.website/dashboard-api/
curl -X PUT --data "last_update=Batch Export Started" http://192.168.147.44:8000/dashboard-api/

F:
"F:\CLSInc\BATCH\RefreshADTables.cmd"

SCHTASKS /run /TN "NewClaim"
SCHTASKS /run /TN "SendErrorReports"

curl -X PUT --data "last_update=Batch Export Complete" http://eec.mymailing.website/dashboard-api/
curl -X PUT --data "last_update=Batch Export Complete" http://192.168.147.44:8000/dashboard-api/

curl http://192.168.147.44:8000/CLS/dashboard-api/complete/
curl http://eec.mymailing.website/dashboard-api/complete/


echo =====================================================
echo Move Overnight files to processed folder
echo =====================================================
echo .
echo .
echo .
echo Ctrl-Break to Cancel
echo . 
move "S:\CLS_Placements\PostJmt_Placement_toCLS\NightlyUpdates\CLS_*" "S:\CLS_Placements\PostJmt_Placement_toCLS\NightlyUpdates\Processed-Files" 
echo .
echo .
echo Move complete

pause
