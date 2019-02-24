#include-once
#include "CSV.au3"


_CSV_Initialise()
Local $csv_handle = _CSV_Open("SIT - Item.csv")
Local $csv_result = _CSV_GetTable2d($csv_handle, "select * from csv where `Assigned to` = 'DELI_SIT_S0003';")
;_CSV_Display2DResult($csv_result)
_CSV_SaveAs($csv_handle, "fred.csv")
_CSV_Cleanup()

