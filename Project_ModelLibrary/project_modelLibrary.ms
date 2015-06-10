/*
Project Model Library
WIP
------------------------------
Autodesk 3D's max 2009 or higher
*/
--change you folder path here
global pdl_folderPath = ""

try(destroyDialog projectModelLibrary)catch()
rollout projectModelLibrary "Model Library" width:208 height:296
(
	dropDownList pdl_folderList "" pos:[8,8] width:192 height:21
	listBox pdl_fileList "" pos:[8,32] width:192 height:15
	button btn_ImportFile "Import File" pos:[8,240] width:192 height:24
	button btn_OpenFile "Open File" pos:[8,264] width:192 height:24
)
createDialog projectModelLibrary
