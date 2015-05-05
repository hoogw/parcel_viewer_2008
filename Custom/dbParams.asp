<% 
'Global variables for ASP data access

'dbSource = "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=geoprise;Initial Catalog=SAC;Data Source=geoprise;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;User Id=geoprise;Password=geo"
'dbSource = "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=gisuser;Initial Catalog=GIS;Data Source=PWASQL;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;User Id=gisuser;Password=gisuser"
dbSource = "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=gisuser;Initial Catalog=GIS;Data Source=PWASQLSTAGE;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;User Id=gisuser;Password=gisuser"
'dbSource = "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=gisuser;Initial Catalog=GIS;Data Source=L2K337830;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;User Id=gisuser;Password=gisuser"
dbTable = "PARCELS"
dbIDField = "cntyap_nbr"					' mpID Field. . . usually parcel# 
dbNumField = "street_no"						' mpHouse Number Field 
dbStreetField = "street_nam"					' mpStreet Name Field 
dbOwnerField = "name"						' mpOwner Name Field 
dbDisplayField = "situs_add1"		' mpDisplay Field. . . usually complete address 
dbIDOrderByString = "cntyap_nbr" ' mpReturn values from ID query are  sorted by these fields 
dbAddressOrderByString = "situs_add1"	' mpReturn values from Address query are sorted by these fields 
dbOwnerOrderByString = "name"		' mpReturn values from Owner query are sorted by these fields 
layerLinkField = "cntyap_nbr"	'  Field in db used to match up with layer 

	'  Fields returned in Candidate list 
dbCandidateFieldList = "cntyap_nbr,situs_add1,name"
	'  Descriptions displayed in Candidate list... each matches a field in dbCandidateFields 
dbCandidateFieldDescriptList = "Parcel ID,Address,Owner"
	'  Fields returned from chosen candidate or directly from identify 
dbResultFieldList = "cntyap_nbr,situs_add1,situs_add2,name,mail1,mail2,zone,landuse,lotsize,txrtarc,neibrhc,prc,lot,subdivsio"
dbResultFieldDescriptList = "Parcel ID,Situs Address,Situs City/St/Zip,Owner,Mail Address,Mail City/St/Zip,Zoning,Landuse Code,Lot Size (sq ft),Tax Rate Area,Neighborhood Code,Thomas Bros,Lot Number,Parcel/Subd. No"

' Arrays holding field names created from the above lists, used to display results
	'  Array holding Field names defined in dbCandidateFieldList
dbCandidateFields = Split(dbCandidateFieldList,",")
	'  Array holding Field names defined in dbCandidateFieldDescriptList
dbCandidateFieldDescript = Split(dbCandidateFieldDescriptList,",")
	'  Array holding Field names defined in dbResultFieldList
dbResultFields = Split(dbResultFieldList,",")
	'  Array holding Field names defined in dbResultFieldDescriptList
dbResultFieldDescript = Split(dbResultFieldDescriptList,",")
	'  Array holding Field names defined in dbHyperLinkFieldList
dbHyperLinkFields = Split(dbHyperLinkFieldList,",")

 %>