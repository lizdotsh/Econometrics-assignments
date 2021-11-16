clear

use "/Users/liz/Documents/Projects/ECON 308/Assignment 2/Q2/linked_1880_1920_males.dta"

*summarize 
describe

drop if age_1 < 16

*eststo clear

* log log model
rename ln_occscore_hh Father
rename ln_occscore_child Child
rename ln_adj_occscore_hh Father_Adj
rename ln_adj_occscore_child Child_Adj
rename race_1 race
eststo: reg Child Father, vce(robust)

eststo: reg Child_Adj Father_Adj, vce(robust)



*esttab using inc.tex, se ar2 

*twoway lfitci ln_occscore_child ln_occscore_hh, plotregion(fcolor(gs15)) || scatter ln_occscore_child ln_occscore_hh, mcolor(eltblue)

*twoway lfitci ln_adj_occscore_child ln_adj_occscore_hh, plotregion(fcolor(gs15)) || scatter ln_adj_occscore_child ln_adj_occscore_hh, mcolor(eltblue)


*unique region_1

eststo: reg Child Father i.region_1 i.region_1#c.Father, vce(robust)
eststo: reg Child_Adj Father_Adj i.region_1 i.region_1#c.Father_Adj, vce(robust)
*esttab using inc2.tex, se ar2 interaction("*") wide

esttab using "table.tex", wide se ar2 varwidth(20) label nobaselevels interaction(" $\times$ ")style(tex) replace rename(Father_Adj Father)


eststo: reg Child Father i.race i.race#c.Father, vce(robust)
eststo: reg Child_Adj Father_Adj i.race i.race#c.Father_Adj, vce(robust)

esttab using "table1.tex", wide se ar2 varwidth(20) label nobaselevels interaction(" $\times$ ")style(tex) replace rename(Father_Adj Father)


gen nat = 0
replace nat = 1 if nativity_1 > 0
drop if nat == 0 
eststo: reg Child Father i.region_1 i.region_1#c.Father, vce(robust) 
eststo: reg Child_Adj Father_Adj i.region_1 i.region_1#c.Father_Adj, vce(robust) 
