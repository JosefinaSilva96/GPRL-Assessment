* Analyzing Data


*-------------------------------------------------------------------------------	
* Load data
*------------------------------------------------------------------------------- 
	
	use merged_data.dta, replace
	

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
	asdoc reg kessler_score total_value, robust replace save(my_regression.tex) 
	
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
  
	
****************************************************************************end!
	