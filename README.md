# CSV-UDF

A UDF for AutoIT that provides functions for editing CSV files.

It uses the features of SQLite already existing within AutoIT to open, edit and save data in the CSV format.

Because SQLite is used the performance of the UDF is fast and the functions are accurate.

## REQUIREMENTS

    Windows 64-bit (not tested under Windows 32-bit)
    AutoIt3 3.3 or higher
    sqlite3.exe (included)
    sqlite3.dll (included)

## LIST OF FUNCTIONS

_CSV_Initialise()
_CSV_Open($csv_file)
_CSV_Exec($csv_handle, $csv_query)
_CSV_GetRecordArray($csv_handle, $row_number_or_query = "", $include_header = False)
_CSV_DisplayArrayResult($csv_result)
_CSV_GetRecordCount($csv_handle)
_CSV_SaveAs($csv_handle, $csv_file, $csv_query = "SELECT * FROM csv;")
_CSV_Cleanup() 

## EXAMPLE

Example.au3 is an example script that you can run.  You must make sure sqlite3.exe, sqlite3.dll and Item.csv are present in the same folder as the example. 
