<% 
'Global variables for ASP data access
dbTable = "PARCELS"
dbIDField = "APN"					' mpID Field. . . usually parcel# 
dbNumField = "Strtnum"						' mpHouse Number Field 
dbStreetField = "StrtNam"					' mpStreet Name Field 
dbOwnerField = "Ownname1"						' mpOwner Name Field 
dbDisplayField = "Address"		' mpDisplay Field. . . usually complete address 
dbIDOrderByString = "APN" ' mpReturn values from ID query are  sorted by these fields 
dbAddressOrderByString = "Address"	' mpReturn values from Address query are sorted by these fields 
dbOwnerOrderByString = "Ownname1"		' mpReturn values from Owner query are sorted by these fields 
layerLinkField = "APN"	'  Field in db used to match up with layer 

	'  Fields returned in Candidate list 
dbCandidateFieldList = "APN,Address,OwnName1"
	'  Descriptions displayed in Candidate list... each matches a field in dbCandidateFields 
dbCandidateFieldDescriptList = "Parcel ID,Address,Owner"
' Arrays holding field names created from the above lists, used to display results
	'  Array holding Field names defined in dbCandidateFieldList
dbCandidateFields = Split(dbCandidateFieldList,",")
	'  Array holding Field names defined in dbCandidateFieldDescriptList
dbCandidateFieldDescript = Split(dbCandidateFieldDescriptList,",")
	'  Array holding Field names defined in dbResultFieldList
dbResultFields = Split(dbResultFieldList,",")
	'  Array holding Field names defined in dbHyperLinkFieldList
dbHyperLinkFields = Split(dbHyperLinkFieldList,",")

 %>