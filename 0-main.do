/*******************************************************************************
						 Main do-file							   
*******************************************************************************/

	* Set version
	*version 18

	* Set project global(s)	
	// User: you 
	display "`c(username)'" 	//Check username and copy to set project globals by user
	
	
	if "`c(username)'" == "wb636611" {
        global onedrive "C:\Users\wb631166\OneDrive - WBG\Desktop\GPRL Assestment\data"
		global github 	"C:\WBG\GitHub\GPRL-Assessment"
    }
	
	
	* Set globals for sub-folders 
	global code 	"${github}\Code"
	global outputs 	"${github}\Outputs"
	
	sysdir set PLUS "C:\WBG\GitHub\GPRL-Assessment\Code\ado" // change path



	* Install packages 
	local user_commands	ietoolkit iefieldkit winsor sumstats estout keeporder grc1leg2  asdoc shp2dta spmap asdoc

	foreach command of local user_commands {
	   capture which `command'
	   if _rc == 111 {
		   ssc install `command'
	   }
	}

	* Run do files 
	* Switch to 0/1 to not-run/run do-files 
	if (0) do "${code}\01-processing-data.do"
	if (1) do "${code}\02-analyzing-data.do"
	


* End of do-file!	