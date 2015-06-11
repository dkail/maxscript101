/*
Project Model Library
WIP
------------------------------
Autodesk 3D's max 2009 or higher
*/
try(destroyDialog setupNewDirectory)catch()
try(destroyDialog projectModelLibrary)catch()
directorySettingsFile = (getDir #scripts + "\startup\PML_DirectorySetting.ini")
if doesFileExist directorySettingsFile then
(
	theModelDir = getINISetting directorySettingsFile "Directory" "folderPath"
)
else
(
	setINISetting directorySettingsFile "" "" ""
	delINISetting directorySettingsFile ""
)
rollout setupNewDirectory "Setup Directory" width:176 height:40
(
	local dirLocation
	button btn_setDir "Select Directory" pos:[8,8] width:160 height:24
	on btn_setDir pressed do
	(
		dirLocation = getSavepath()
		if dirLocation != undefined then
		(
			setINISetting directorySettingsFile "Directory" "folderPath" dirLocation
			destroyDialog setupNewDirectory
		)
	)
)
rollout projectModelLibrary "Model Library" width:200 height:336
(
	local theModelFolder = theModelDir
	local getFolders	
	--local getFile = getFiles(getFolders+"*.max")
	dropdownList pml_folderList "" pos:[16,24] width:168 height:21
	listbox pml_fileList "" pos:[16,48] width:168 height:15
	button btn_ImportFile "Import File" pos:[16,272] width:168 height:24
	button btn_OpenFile "Open File" pos:[16,296] width:168 height:24
	GroupBox grp1 "Model Browser" pos:[8,8] width:184 height:248
	GroupBox grp2 "Edit Files" pos:[8,256] width:184 height:72
	on projectModelLibrary open do
	(
		 listFolders = #()
		 getFolders = getDirectories(theModelFolder+"/*")
		 for i in getFolders do
		 (
			theFolder = filterstring i "\\"
			appendIfUnique listFolders theFolder[theFolder.count] 
		)
		 pml_folderList.items = listFolders
	)
	on btn_ImportFile pressed do
		(
	
	)
)
if theModelDir == "" then
(
	createDialog setupNewDirectory
)
else
(
	createDialog projectModelLibrary
)
