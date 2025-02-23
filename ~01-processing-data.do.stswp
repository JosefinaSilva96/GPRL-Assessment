*Processing Data 	


*-------------------------------------------------------------------------------	
* Innitial Commands 
*------------------------------------------------------------------------------- 		



   clear
   set more off
   set mem 800m

   * Directory


	cd "C:\Users\wb631166\OneDrive - WBG\Desktop\GPRL Assestment\data" // change directory 

	

*-------------------------------------------------------------------------------	
* Part I
*------------------------------------------------------------------------------- 		
   *Q1:At what level is each dataset uniquely identified (i.e., what does each row represent, and which variables are unique identifiers)? 
    
	*Dataset demoraphics
	
	*Load data set 
	
	use "demographics.dta", replace // 34,427 obs and 19 variables 
	
	*check duplicates 
	
	duplicates report wave hhid hhmid // no duplicates 
	
	* rows with unique indentifier
	
	isid wave hhid hhmid
    
	*what ecah row represent: Each row in the dataset represents an individual (hhmid) within a household (hhid) in a specific survey wave (wave). The dataset is structured at the individual level, where each person is observed across different waves, and multiple individuals can belong to the same household.
	
	*Dataset assets
	
	*Load data set 
	
	use "assets.dta", replace // 164,693 obs and 9 variables 
	
	*check duplicates 
	
	duplicates report wave hhid InstanceNumber Asset_Type  // no duplicates 
	
	* rows with unique indentifier
	
	isid wave hhid InstanceNumber Asset_Type
	
	*what each row represent:Each row represents a unique asset (InstanceNumber) within a household (hhid) for a specific survey wave (wave), categorized by asset type (Asset_Type). The dataset is uniquely identified by the combination of wave, hhid, InstanceNumber, and Asset_Type. 
	
	*Dataset depression
	
	*Load data set 
	
	use "depression.dta", replace // 13,842 obs and 13 variables 
	
	*check duplicates 
	
	duplicates report wave hhid hhmid  // no duplicates 
	
	* rows with unique indentifier
	
	isid wave hhid hhmid
	
	*what each row represent: Each row represents a unique individual (hhmid) within a household (hhid) for a given survey wave (wave). The dataset is uniquely identified by wave, hhid, and hhmid.
	
	
	
	
	 *Q2:Import the demographics dataset and calculate a proxy variable for household size based on the number of members surveyed in each household in Wave 1. Assume the household size for Wave 2 remains the same.
	 
	 *Load data set 
	
	use "demographics.dta", replace // 34,427 obs and 19 variables 
	 
    gen hh_size = .
	
    bysort hhid (wave): replace hh_size = _N if wave == 1
	
	*Q3: To calculate the monetary value of all assets, you should use the `currentvalue' variable, which reports the monetary value of a single unit of the asset. However, you will notice that this variable is often missing. Please use the median of "currentvalue" for each type of asset (by type we mean, for example, "chickens", "Cutlass", "Room Furniture", "Radio", "Cell (mobile) Phone handset", etc.) to impute the missing values.
	
	
	
  
*-------------------------------------------------------------------------------	
* Creation of variables
*-------------------------------------------------------------------------------	
  
  
  
  
  
  *Generate unit variable 
  
 
  
  *Date variable 

  gen date_part = substr(SubmissionDate, 1, strpos(SubmissionDate, " ") - 1)

 gen day = substr(date_part, 1, strpos(date_part, "/") - 1)

 gen month = substr(date_part, strpos(date_part, "/") + 1, strpos(substr(date_part, strpos(date_part, "/") + 1, .), "/") - 1)

 gen year = substr(date_part, -4, .)  
 

*-------------------------------------------------------------------------------	
* Select varaibles
*-------------------------------------------------------------------------------  


   
   
 *-------------------------------------------------------------------------------	
* Order Data set
*-------------------------------------------------------------------------------	
   
   order day month year id_entrevista municipality age gender income
  

*-------------------------------------------------------------------------------	
* Save data set
*-------------------------------------------------------------------------------	
   
   save "", replace
   
   
   