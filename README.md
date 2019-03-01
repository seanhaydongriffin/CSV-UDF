# CSV-UDF

A UDF for AutoIT that provides functions for editing CSV files.

It uses the features of SQLite already existing within AutoIT to open, edit and save data in the CSV format.

Because SQLite is used the performance of the UDF is fast and the functions are accurate.

## Requirements

    Windows 64-bit (not tested under Windows 32-bit)
    AutoIt3 3.3 or higher
    sqlite3.exe (included)
    sqlite3.dll (included)
    the source CSV file(s) must be less than 4096 columns

## List of Functions

  * _CSV_Initialise()
  * _CSV_Open($csv_file)
  * _CSV_Exec($csv_handle, $csv_query)
  * _CSV_GetRecordArray($csv_handle, $row_number_or_query = "", $include_header = False)
  * _CSV_DisplayArrayResult($csv_result)
  * _CSV_GetRecordCount($csv_handle)
  * _CSV_SaveAs($csv_handle, $csv_file, $csv_query = "SELECT * FROM csv;")
  * _CSV_Cleanup() 

## Example

**Example.au3** is an example script that you can run.  You must make sure **sqlite3.exe**, **sqlite3.dll** and **Item.csv** are present in the same folder as the example. 

## A note about sqlite3.exe and sqlite3.dll

These two files have been compiled by myself to support CSV files up to 4,096 columns.  The default sqlite files only support a maximum of 2,000 columns.

The compilation process was not easy.  So for everyone's benefit here are the steps I followed to produce a sqlite3.exe and sqlite3.dll for AutoIT that works.

Ensure Visual Studio for C++ is installed.  Get the source amalgamation for SQLite -> https://sqlite.org/download.html.

Using "cl" from Visual Studio run this command to create sqlite3.dll:

**cl sqlite3.c -DSQLITE_API=__declspec(dllexport) -link -dll -out:sqlite3.dll**

And run this command to create sqlite3.exe:

**cl shell.c sqlite3.c -Fesqlite3.exe**

I tried gcc but it wasn't successful.
