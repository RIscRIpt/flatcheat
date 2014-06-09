Dim FASM_Path
FASM_Path = "C:\FASM\"

Dim fileobj : Set fileobj = CreateObject("Scripting.FileSystemObject")

If fileobj.FolderExists(FASM_Path) Then
	MsgBox "Folder " & FASM_Path & " exists. If you wish to redownload flatassembler," & Chr(13) & Chr(10) & _
		"Delete this directory!", vbError, "FASM was found on your computer"
	WScript.Quit()
End If

Dim httpobj : Set httpobj = CreateObject("MSXML2.XMLHTTP")
httpobj.Open "GET", "http://flatassembler.net/download.php", False
httpobj.Send

Set re = New RegExp
re.IgnoreCase = False
re.Global = True
re.Pattern = "fasmw([0-9]+)\.zip"
Set matches = re.Execute(httpobj.responseText)

Dim filename
filename = matches.Item(matches.Count - 1).Value

Set tmpfolder = fileobj.GetSpecialFolder(2) '2 = Temporary folder

Dim savepath
savepath = tmpfolder & "\" & fileobj.GetTempName & ".zip"

Dim download_url
download_url = "http://flatassembler.net/" & filename

MsgBox "Downloading: " & download_url, vbInformation, "Processing.."
	
httpobj.Open "GET", download_url, False
httpobj.Send

Dim bStream: Set bStream = CreateObject("Adodb.Stream")
With bStream
	.Type = 1 '1 = binary
	.Open
	.Write httpobj.responseBody
	.SaveToFile savepath, 2 '2 = overwrite
End With

result = MsgBox("Successfully downloaded file " & download_url & Chr(13) & Chr(10) & _
				"Extracting files to " & FASM_Path, vbInformation, "Step 2/3")

'Extract the content of the zip file.
fileobj.CreateFolder(FASM_Path)

Set shellapp = CreateObject("Shell.Application")
Set zipfiles = shellapp.NameSpace(savepath)
Set destobj = shellapp.NameSpace(FASM_Path)

destobj.CopyHere zipfiles.Items
fileobj.DeleteFile savepath

MsgBox "Successfully unzipped " & filename, vbInformation, "Success"
