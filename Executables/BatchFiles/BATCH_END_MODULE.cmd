SCHTASKS /run /TN "NewClaim"
SCHTASKS /run /TN "SendErrorReports"
SCHTASKS /run /TN "WeekendNotify"

curl -X PUT --data "last_update=Batch Export Complete" http://eec.mymailing.website/dashboard-api/
curl -X PUT --data "last_update=Batch Export Complete" http://192.168.147.44:8000/dashboard-api/

curl http://192.168.147.44:8000/CLS/dashboard-api/complete/
curl http://eec.mymailing.website/dashboard-api/complete/


"S:\CLS_Placements\PostJmt_Placement_toCLS\NightlyUpdates\Archive ProcessedFiles.cmd" 

pause