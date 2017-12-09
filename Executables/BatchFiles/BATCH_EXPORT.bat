rem SCHTASKS /run /TN "IndexMail"
curl -X PUT --data "last_update=Batch Export Started" http://eec.mymailing.website/dashboard-api/
curl -X PUT --data "last_update=Batch Export Started" http://192.168.147.44:8000/dashboard-api/

F:
"F:\CLSInc\BATCH\RefreshADTables.cmd"


