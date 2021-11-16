clear 

use "/Users/liz/Documents/Projects/ECON 308/Assignment 2/Q3/chicago.dta"

summarize

*drop if intersection != 1
summarize

gen thousand = .
replace thousand = rob/population 

generate standard_pop = (population -   857.2294)/479.5102
generate standard_walkscore = (walkscore - 74.52856)/10.99043
set seed 1000
lasso linear rob bus_stops lh_bar standard_pop intersection pct_com standard_walkscore, folds(20)
cvplot, graphregion(color(white))

reg rob bus_stops lh_bar standard_pop intersection pct_com standard_walkscore


gen com = 0
replace com = 1 if pct_com > .4

gen pop = 0
replace pop = 1 if standard_pop > 0

reg rob i.com i.pop

foreach x of varlist bus_stops lh_bar population intersection pct_com walkscore {
ereplace `x' = std(`x')
}
lasso linear rob bus_stops lh_bar population intersection pct_com walkscore, folds(30)

lassocoef, display(coef, standardized)
lassogof

reg rob bus_stops lh_bar population intersection pct_com walkscore
reg rob pct_com standard_pop

reg rob com i.pop

reg rob pct_com standard_pop c.standard_pop#c.pct_com

esttab using "tableboom.tex", se ar2 varwidth(20) label nobaselevels interaction(" $\times$ ")style(tex) replace 

egen std(pct_com)
generate standard_ = (population -   857.2294)/479.5102
