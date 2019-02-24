#include-once
#include <SQLite.au3>
#include <SQLite.dll.au3>
#Region Header
#cs
	Title:   		CSV UDF Library for AutoIt3
	Filename:  		CSV.au3
	Description: 	A collection of functions for CSV manipulation
	Author:   		seangriffin
	Version:  		V0.1
	Last Update: 	24/02/19
	Requirements: 	AutoIt3 3.2 or higher,
					sqlite.exe.
	Changelog:		---------24/02/19---------- v0.1
					Initial release.

#ce
#EndRegion Header
#Region Global Variables and Constants
#EndRegion Global Variables and Constants
#Region Core functions
; #FUNCTION# ;===============================================================================
;
; Name...........:	cURL_initialise()
; Description ...:	Initialises cURL.
; Syntax.........:	cURL_initialise()
; Parameters ....:
; Return values .:
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	Must be executed prior to any other cURL functions.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
func _CSV_Initialise()

	; Load and initialize sqlite
	_SQLite_Startup("sqlite3.dll", False, 1)
EndFunc

; #FUNCTION# ;===============================================================================
;
; Name...........:	_CSV_Open()
; Description ...:	Opens a CSV file and returns a handle to it.
; Syntax.........:	_CSV_Open($csv_file)
; Parameters ....:	$csv_file			- the CSV file.
; Return values .: 	On Success			- Returns a handle to the CSV file.
;                 	On Failure			- Returns nothing.
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	A prerequisite is that _CSV_Initialise() has been executed.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
Func _CSV_Open($csv_file)

	Local $sOut
	Local $csv_handle = StringReplace($csv_file, ".csv", ".db")
	FileDelete($csv_handle)
	_SQLite_SQLiteExe($csv_handle, ".mode csv" & @CRLF & ".import '" & $csv_file & "' csv", $sOut, -1, True)
	Return $csv_handle
EndFunc


; #FUNCTION# ;===============================================================================
;
; Name...........:	_CSV_GetTable2d()
; Description ...:	Passes out a 2Dimensional array containing column names and data of executed query.
; Syntax.........:	_CSV_GetTable2d($csv_handle, $csv_query)
; Parameters ....:	$csv_handle			- the handle of the CSV file you are querying.
;					$csv_query			- the query.
; Return values .: 	On Success			- the 2Dimensional array of results.
;                 	On Failure			- Returns nothing.
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	A prerequisite is that _CSV_Open() has been executed.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
Func _CSV_GetTable2d($csv_handle, $csv_query)

	Local $aResult, $iRows, $iColumns, $iRval
	$conn = _SQLite_Open ($csv_handle) ; open :memory: Database
	_SQLite_GetTable2d(-1, $csv_query, $aResult, $iRows, $iColumns)
	_SQLite_Close($conn)
	Return $aResult
EndFunc


; #FUNCTION# ;===============================================================================
;
; Name...........:	_CSV_Display2DResult()
; Description ...:	Prints to Console a formated display of a 2Dimensional array.
; Syntax.........:	_CSV_Display2DResult($csv_result)
; Parameters ....:	$csv_result			- the results of a query (see _CSV_GetTable2d() above).
; Return values .: 	On Success			- Returns nothing.
;                 	On Failure			- Returns nothing.
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	A prerequisite is that _CSV_GetTable2d() has been executed.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
Func _CSV_Display2DResult($csv_result)

	_SQLite_Display2DResult($csv_result)
EndFunc

; #FUNCTION# ;===============================================================================
;
; Name...........:	_CSV_SaveAs()
; Description ...:	Saves a CSV file ($csv_handle) to another CSV file.
; Syntax.........:	_CSV_SaveAs($csv_handle, $csv_file)
; Parameters ....:	$csv_handle			- the handle of the CSV file to save.
;					$csv_file			- the name of the CSV file to save to.
; Return values .: 	On Success			- True
;                 	On Failure			- False
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	A prerequisite is that _CSV_Open() has been executed.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
Func _CSV_SaveAs($csv_handle, $csv_file)

	Local $sOut
	FileDelete($csv_file)
	_SQLite_SQLiteExe($csv_handle, ".headers on" & @CRLF & ".mode ascii" & @CRLF & ".output '" & $csv_file & "'" & @CRLF & "SELECT * FROM csv;", $sOut, -1, True)
	Local $csv_str = FileRead($csv_file)

	; Each of the embedded double-quote characters must be represented by a pair of double-quote characters.
	$csv_str = StringReplace($csv_str, '"', '""')

	; Fields with embedded commas or double-quote characters must be quoted.
	$csv_str = StringRegExpReplace($csv_str, "(?U)([\x1E\x1F])([^\x1E\x1F]*[,""][^\x1E\x1F]*)([\x1E\x1F])", '${1}"${2}"${3}')

	; In CSV implementations that do trim leading or trailing spaces, fields with such spaces as meaningful data must be quoted.
	$csv_str = StringRegExpReplace($csv_str, "(?U)([\x1E\x1F])([^\x1E\x1F]* )([\x1E\x1F])", '${1}"${2}"${3}')
	$csv_str = StringRegExpReplace($csv_str, "(?U)([\x1E\x1F])( [^\x1E\x1F]*)([\x1E\x1F])", '${1}"${2}"${3}')
	$csv_str = StringRegExpReplace($csv_str, "(?U)([\x1E\x1F])( [^\x1E\x1F]* )([\x1E\x1F])", '${1}"${2}"${3}')

	; Convert ascii field and record separators to csv
	$csv_str = StringReplace($csv_str, "", @CRLF)
	$csv_str = StringReplace($csv_str, "", ",")

	FileDelete($csv_file)
	FileWrite($csv_file, $csv_str)

EndFunc


; #FUNCTION# ;===============================================================================
;
; Name...........:	_CSV_Cleanup()
; Description ...:	Cleans up the CSV UDF.
; Syntax.........:	_CSV_Cleanup()
; Parameters ....:
; Return values .:
; Author ........:	seangriffin
; Modified.......:
; Remarks .......:	A prerequisite is that _CSV_Initialise() has been executed.
; Related .......:
; Link ..........:
; Example .......:	Yes
;
; ;==========================================================================================
func _CSV_Cleanup()

	_SQLite_Shutdown()
EndFunc

