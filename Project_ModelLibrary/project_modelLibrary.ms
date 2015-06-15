/*
Project Model Library
WIP
------------------------------
Autodesk 3D's max 2009 or higher

Folder Structure 

Main Folder
	-SubFolder
		-MaxFiles
*/
(
global theModelDir
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
			delINISetting directorySettingsFile ""
			setINISetting directorySettingsFile "Directory" "folderPath" dirLocation
			destroyDialog setupNewDirectory
			createDialog projectModelLibrary
		)
	)
)
rollout projectModelLibrary "Model Library" width:200 height:360
(
	local theModelFolder = theModelDir
	local getFolders	
	local getFile
	dropdownList pml_folderList "" pos:[16,24] width:168 height:21
	listbox pml_fileList "" pos:[16,48] width:168 height:15
	button btn_ImportFile "Merge File to Scene" pos:[16,272] width:168 height:24
	GroupBox grp1 "Model Browser" pos:[8,8] width:184 height:248
	GroupBox grp2 "Edit Files" pos:[8,256] width:184 height:48
	button btn_changeLibrary "Change Library Path" pos:[16,320] width:168 height:24
	GroupBox grp9 "Library Setup" pos:[8,304] width:184 height:48
	
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
	on pml_folderList selected sel do
	(
		if sel > 0 then
		(
			getFile = getFiles(getFolders[pml_folderList.selection]+"*.max")
			tempFile = (for i = 1 to getFile.count collect (getFileNameFile getFile[i] + getFileNameType getFile[i]))
			if pml_fileList.items.count > 0 then
			(
				for i = 1 to pml_fileList.items.count do
				(
					pml_fileList.items = deleteItem pml_fileList.items 1
				)
			)
			pml_fileList.items = tempFile
		)
	)
	on pml_fileList doubleClicked sel do
	(
		if getFile.count > 0 then
		(
				getStatus = getSaveRequired = true
				if getStatus == true then
				( 
					if querybox "The scene has been modified.\nDo you want to save your changes?" title:"3ds Max" beep:true then
					(
						saveMaxFile (maxFilePath + maxFileName) clearNeedSaveFlag:false
						loadMaxFile getFile[sel]
					)
					else
					(
						loadMaxFile getFile[sel]
					)
				)
		)	
	)
	on btn_ImportFile pressed do
	(	
	)
	on btn_changeLibrary pressed do
	(
		destroyDialog projectModelLibrary
		createDialog setupNewDirectory
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
)
