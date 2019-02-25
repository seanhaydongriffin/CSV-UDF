#include-once
#include "CSV.au3"

ConsoleWrite(@CRLF & "Initialise the CSV handler ... ")
_CSV_Initialise()
ConsoleWrite("Done." & @CRLF)

ConsoleWrite(@CRLF & "Open the CSV file 'Item.csv' ... ")
Local $item_csv_handle = _CSV_Open("Item.csv")
ConsoleWrite("Done." & @CRLF)

ConsoleWrite(@CRLF & "Delete all CSV records with an 'Assigned to' value of 'DELI_SIT_S0003' ... ")
_CSV_Exec($item_csv_handle, "delete from csv where `Assigned to` = 'DELI_SIT_S0003';")
ConsoleWrite("Done." & @CRLF)

ConsoleWrite(@CRLF & "Get all CSV records with the header and display the result ..." & @CRLF & @CRLF)
Local $csv_result = _CSV_GetRecordArray($item_csv_handle, "", True)
_CSV_DisplayArrayResult($csv_result)

ConsoleWrite(@CRLF & "Get the first CSV record without the header and display the result ..." & @CRLF & @CRLF)
Local $csv_result = _CSV_GetRecordArray($item_csv_handle, 1, False)
_CSV_DisplayArrayResult($csv_result)

ConsoleWrite(@CRLF & "Get all CSV records with an 'Assigned to' value of 'DELI_SIT_S0004' and display the result ..." & @CRLF & @CRLF)
Local $csv_result = _CSV_GetRecordArray($item_csv_handle, "select * from csv where `Assigned to` = 'DELI_SIT_S0004';", False)
_CSV_DisplayArrayResult($csv_result)

ConsoleWrite(@CRLF & "Get a count of the number of records in the CSV file ... ")
Local $number_of_records = _CSV_GetRecordCount($item_csv_handle)
ConsoleWrite("There are " & $number_of_records & " records in the CSV." & @CRLF)

ConsoleWrite(@CRLF & "Save the entire CSV file as 'Item complete.csv' ... ")
_CSV_SaveAs($item_csv_handle, "Item complete.csv")
ConsoleWrite("Done." & @CRLF)

ConsoleWrite(@CRLF & "Sort and Save the entire CSV file as 'Item sorted.csv' ... ")
_CSV_SaveAs($item_csv_handle, "Item sorted.csv", "select * from csv order by `Assigned to`, `Comment 1`;")
ConsoleWrite("Done." & @CRLF)

ConsoleWrite(@CRLF & "Query records with an 'Assigned to' value of 'DELI_SIT_S0004' and Save as 'Item DELI_SIT_S0004.csv' ... ")
_CSV_SaveAs($item_csv_handle, "Item DELI_SIT_S0004.csv", "select * from csv where `Assigned to` = 'DELI_SIT_S0004';")
ConsoleWrite("Done." & @CRLF)

ConsoleWrite(@CRLF & "Cleanup the CSV handler ... ")
_CSV_Cleanup()
ConsoleWrite("Done." & @CRLF)
