/*
Project Model Library
WIP
------------------------------
Autodesk 3D's max 2009 or higher
*/
try(destroyDialog setupNewDirectory)catch()
try(destroyDialog projectModelLibrary)catch()
directorySettingsFile = (getDir #scripts + "\startup\PML_DirectorySetting.ini")
theModelDir = getINISetting directorySettingsFile "Directory" "folderPath"
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
rollout projectModelLibrary "Model Library" width:208 height:296
(
	local theModelFolder = theModelDir
	local getFolders
	--local getFile = getFiles(getFolders+"*.max")
	dropDownList pml_folderList "" pos:[8,8] width:192 height:21
	listBox pml_fileList "" pos:[8,32] width:192 height:15
	button btn_ImportFile "Import File" pos:[8,240] width:192 height:24
	button btn_OpenFile "Open File" pos:[8,264] width:192 height:24
	on projectModelLibrary open do
	(
		 getFolders = getDirectories(theModelFolder+"/*")
	)
	on btn_ImportFile pressed do
	(
		print getFolders
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
