clear all 
cd "/Users/liz/Documents/Projects/ECON 308/Assignment 5"
use "maimonides.dta" 
gen enroll_cubic = enrollment^2

eststo: reg avgmath classize perc_disadvantaged enrollment enroll_cubic

gen over40 = 0 
replace over40 = 1 if classize > 40 

eststo: reg classize over40 perc_disadvantaged enrollment enroll_cubic

eststo: ivregress 2sls avgmath perc_disadvantaged enrollment enroll_cubic (classize = over40)


 esttab using class1.tex, se ar2 wide replace booktabs ///                     
 title(Class Size Regression Table\label{tab3}) nomtitles 
