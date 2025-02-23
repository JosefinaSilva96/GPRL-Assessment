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
	
	*Cleaning variables 
	
	replace age=. if age<0
	
	recode gender 5=2
	
	replace religion=. if religion==95
	
	*Save dataset 
	
	save "demographics_clean.dta", replace
    
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
	
	use "demographics_clean", replace // 34,427 obs and 19 variables 
	 
    gen hh_size = .
	
    bysort hhid (wave): replace hh_size = _N if wave == 1
	
	*Q3: To calculate the monetary value of all assets, you should use the `currentvalue' variable, which reports the monetary value of a single unit of the asset. However, you will notice that this variable is often missing. Please use the median of "currentvalue" for each type of asset (by type we mean, for example, "chickens", "Cutlass", "Room Furniture", "Radio", "Cell (mobile) Phone handset", etc.) to impute the missing values.
	
	*Load data set 
	
	use "assets.dta", replace // 164,693 obs and 9 variables 
	
	*Check missing values 
	
	sum currentvalue, detail
	
   count if missing(currentvalue) //  90,811 missing values 
   
   *Create a single variable that consolidates all asset names
   
   gen currentvalue_imputed = currentvalue
   
   egen median_value = median(currentvalue), by(animaltype toolcode durablegood_code)
   
   
   *Q4: Create a variable that contains the total monetary value for each observation, by multiplying quantity and the imputed current value.
   
   gen total_value = quantity * currentvalue_imputed
   
   sum total_value
   
   *Q5: Produce a dataset at the household-wave level (for each household, there should be at most two observations, one for each wave) which contains the following variables:
    
	gen total_value_animals = total_value if Asset_Type == 1
	
    gen total_value_tools = total_value if Asset_Type == 2
	
    gen total_value_durable = total_value if Asset_Type == 3
   
   collapse (sum) total_value_animals total_value_tools total_value_durable total_value,by(hhid wave)
   
   *Save dataset 
   
   save household_wave_assets.dta, replace
   
   *Q6:Using this reference, construct the kessler score (name it kessler score) and a categorical variable named kessler categories with 4 categories: no significant depression, mild depression, moderate depression, and severe depression.
   
   *Load data set 
   
   use "depression.dta", replace // 13,842 obs and 13 variables 
	
  *Generate Kessler-10 score
  
   gen kessler_score = .
   
   egen kessler_sum = rowtotal(tired nervous sonervous hopeless restless sorestless depressed everythingeffort nothingcheerup worthless), missing

  *Count missing values
  
  egen missing_count = rowmiss(tired nervous sonervous hopeless restless sorestless depressed everythingeffort nothingcheerup worthless)

  *If all values are present, use row sum
  
  replace kessler_score = kessler_sum if missing_count == 0

  *If at most 1 value is missing, impute using the mean of available responses

   egen kessler_mean = rowmean(tired nervous sonervous hopeless restless sorestless depressed everythingeffort nothingcheerup worthless)
   
   replace kessler_score = round(kessler_mean * 10) if missing_count == 1

  *If more than 1 value is missing, keep it as missing

   replace kessler_score = . if missing_count > 1
  
  *Create Categories 
  
  gen kessler_categories = .
  replace kessler_categories = 1 if kessler_score >= 10 & kessler_score <= 19
  replace kessler_categories = 2 if kessler_score >= 20 & kessler_score <= 24
  replace kessler_categories = 3 if kessler_score >= 25 & kessler_score <= 29
  replace kessler_categories = 4 if kessler_score >= 30 & kessler_score <= 50

label define kessler_lbl 1 "No significant depression" 2 "Mild depression" ///
                         3 "Moderate depression" 4 "Severe depression"
label values kessler_categories kessler_lbl

   *Save dataset 
   
   save "depressionII.dta", replace

   
   *Q7: At this point you have created three datasets: demographics, assets, and mental health. Please combine all three of these datasets to create a single dataset that you will use for data exploration and analysis. The unit of observation in this dataset should be an individual in a given survey round. (There should be at most two observations per individual, one for Wave 1 and another for Wave 2).
   
   *Check structure of the datasets 
   
   use demographics_clean.dta, clear
   describe hhid hhmid wave
   list hhid hhmid wave if _n <= 10, sepby(hhid)
  
   
   save demographics_clean.dta, replace
   
   use household_wave_assets.dta, clear
   describe hhid wave
   destring hhid, replace
  save household_wave_asset.dta, replace

  use "depressionII.dta", replace
  
  save depressionII.dta, replace
  
  
  *Merge 
  
   use demographics_clean.dta, clear

   
   merge 1:1 hhid hhmid wave using depressionII.dta //   Matched                            13,842
   
   
   
   *Check merge results
   
   drop if _merge == 1
   drop _merge
   save merged_data.dta, replace
   
   
   
   *Merge with depression data 
   
   use merged_data.dta, replace
   
    merge m:1 hhid wave using household_wave_assets.dta //   
   
   
   *Check merge results
   
   keep if _merge == 3
   drop _merge
   save merged_data.dta, replace
   
  
   
*-------------------------------------------------------------------------------	
* Part II: Exploratory Analysis
*-------------------------------------------------------------------------------	
  
  *Q1: Explore the relationship between depression and:
  
  *1. Household wealth, proxied by total asset value.

   keep if wave == 1
   
   summarize kessler_score
   
   *Histogram Kessler score
   
   histogram kessler_score, bin(20) normal title("Distribution of Kessler Score - Wave 1")

  
   *Scatterplot: Depression vs. Household Wealth
   
  scatter kessler_score total_value, ///
    title("Depression vs. Household Wealth") ///
    ytitle("Kessler Score (Depression)") ///
    xtitle("Total Asset Value") ///
    mcolor(blue)
	
	*Regression OLS
	
	asdoc reg kessler_score total_value, robust replace save(Kessler_Regression.doc)
	
	*Correlation table
	
	asdoc cor kessler_score total_value, replace save(Correlation_Table.doc)
	
	
	*2. A household or demographic characteristic that seems interesting to you.
	
	*Age 
	
	preserve
	
	drop if age<0
	
	collapse (mean) kessler_score, by(age)

twoway (line kessler_score age, lcolor(blue) lwidth(medthick)), ///
       title("Average Depression Score Over Time") ///
       xtitle("Age") ytitle("Mean Kessler Score") ///
       xlabel(, grid)
	   
	restore
	
	
    *Gender
	
	graph box kessler_score, over(gender, label(angle(45))) ///
    title("Depression Levels by Gender") ///
    ytitle("Kessler Score") 
	
	*Religion 
	
	preserve 
	
	drop if religion==95
	
	graph bar (mean) kessler_score, over(religion, sort(1) label(angle(45))) ///
    title("Average Depression Score by Religion") ///
    ytitle("Mean Kessler Score") 

	restore
	
	*Marital Status
	
	graph bar (mean) kessler_score, over(maritalstatus, sort(1) label(angle(45))) ///
    title("Average Depression Score by Marital Status") ///
    ytitle("Mean Kessler Score") 
	
	*Regressions 
	
	asdoc reg kessler_score total_value age gender, robust replace save(Kessler_FullModel.doc)
	
	asdoc reg kessler_score total_value age gender  maritalstatus, robust replace save(Kessler_FullModel_marital_status.doc)
	
	
*Q2: Were the GT sessions effective at reducing depression?

   use merged_data.dta, replace
   
   keep if wave == 2
   
   *Simple Regression: Effect of GT Sessions on Depression
   
   asdoc reg kessler_score treat_hh, robust replace ///
title(Effect of GT Sessions on Depression) ///
save(gt_effect.doc)
   
   *Adjusted Regression: Controlling for Demographics & Wealth
   
   asdoc reg kessler_score treat_hh age gender total_value, robust append ///
title(Adjusted Effect of GT Sessions on Depression) ///
save(gt_effect_controls.doc)


  *Mean Comparison (T-Test)
  
  asdoc ttest kessler_score, by(treat_hh) ///
title(T-Test: Depression in GT vs. Control) ///
save(gt_effect_Ttest.doc) append


   *Boxplot
   
   graph box kessler_score, over(treat_hh, label(angle(45))) ///
title("Effect of GT Sessions on Depression") ///
ytitle("Kessler Depression Score") 
graph export gt_effect.png, replace

  *Q3: Did the effect of GT sessions on depression differ by gender? Perform a linear regression of the Kessler Score on:
 
  
   *Create interact term 
   
   gen treat_x_woman = treat_hh * gender
   
   *Regression 
   
   asdoc reg kessler_score gender treat_hh treat_x_woman, robust replace ///
title(Effect of GT Sessions on Depression by Gender) ///
save(gt_gender_effect.doc)

  *Boxplot
  
   graph box kessler_score, over(treat_hh) over(gender) ///
title("Depression by Treatment & Gender") ///
ytitle("Kessler Depression Score") 
graph export gt_gender_effect.png, replace
 
 
  *Only women 
  
   preserve 
   
   keep if gender==2
   
    asdoc reg kessler_score gender treat_hh treat_x_woman, robust replace ///
title(Effect of GT Sessions on Depression by Gender) ///
save(gt_gender_effect_women.doc)

   *Boxplot
  
   graph box kessler_score, over(treat_hh) over(gender) ///
title("Depression by Treatment & Gender") ///
ytitle("Kessler Depression Score") 
graph export gt_gender_effect.png, replace

  restore


*-------------------------------------------------------------------------------	
* Save data set
*-------------------------------------------------------------------------------	
   
   save "final_dataset", replace
   
   
   