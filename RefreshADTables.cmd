@ECHO OFF

curl -X PUT --data "last_update=Batch Export Started" http://eec.mymailing.website/dashboard-api/

REM === STEP 1 === This step is a part of dunning automation process which appends the processed dunning file into dunning history table
SQLCMD -S PXSQL01\MSSQLSERVER2012 -E -d "CMPROD" -i \\nyfs801\Home\Share\CM\Conversion\CLS_Update\Dunning_Matrix_Record_Prod.sql

REM === STEP 2 === This step creates advanced CM tables
SQLCMD -S PXSQL01\MSSQLSERVER2012 -E -d "CMPROD" -i \\nyfs801\Home\Share\CM\Conversion\CLS_Update\Create_ADTables_PROD.sql

REM === STEP 3 === This step generates two dunning files needed for updating CM and sending to Matrix
CSCRIPT \\nyfs801\Home\Share\CM\Dunning\Generate_Matrix_File.vbs

REM === STEP 4 === This step is to auto import a dunning EDI file to update CM
REM ** PAUSE
SET mydate=%date:~10,4%%date:~4,2%%date:~7,2%
ECHO %mydate%
COPY /y S:\CLS_Placements\PostJmt_Placement_toCLS\NightlyUpdates\CLS_OvernightDunning_AutoSys_DT_%mydate%.txt F:\CLSInc\CUSTOM\CLS_OvernightDunning_AutoSys_DT.txt
F:
CD F:\CLSINC
SET AUTOMATE=DunningUpdate.ini
F:\CLSINC\WBWIN\BRCLIENT64.EXE
REM ** PAUSE
REM === STEP 5 === This step is to move the processed dunning EDI file to processed folder
MOVE S:\CLS_Placements\PostJmt_Placement_toCLS\NightlyUpdates\CLS_OvernightDunning_AutoSys_DT_%mydate%.txt S:\CLS_Placements\PostJmt_Placement_toCLS\NightlyUpdates\Processed-Files\CLS_OvernightDunning_AutoSys_DT_%mydate%.txt

ECHO COMPLETE
SCHTASKS /run /TN "NewClaim"
SCHTASKS /run /TN "SendErrorReports"
pause
curl -X PUT --data "last_update=Batch Export Complete" http://eec.mymailing.website/dashboard-api/

curl http://192.168.147.44:8000/CLS/dashboard-api/complete/
curl http://eec.mymailing.website/dashboard-api/complete/
"S:\CLS_Placements\PostJmt_Placement_toCLS\NightlyUpdates\Archive ProcessedFiles.cmd" 
pause