clear all 
cd "/Users/liz/Documents/Projects/ECON 308/Assignment 5"

use "cheng_hoekstra_data.dta"

*gen homicide_log = log(homicide)

foreach x of varlist homicide police prisoner lagprisoner income exp_subsidy exp_pubwelfare larceny motor {
	gen `x'_log = log(`x')
}

eststo: reg homicide_log c.cdl i.sid i.year, vce(cluster sid)


eststo: reg homicide_log c.cdl i.sid i.year i.northeast#i.year i.midwest#i.year ///
 i.south#i.year i.west#i.year , vce(cluster sid)


eststo: reg homicide_log c.cdl i.sid i.year i.northeast#i.year i.midwest#i.year i.south#i.year ///
 i.west#i.year  c.income_log c.police_log c.prisoner_log c.lagprisoner_log ///
c.exp_pubwelfare_log c.exp_subsidy_log c.poverty c.unemployrt  c.whitem_15_24 c.whitem_25_44 ///
 c.blackm_25_44 c.blackm_15_24, vce(cluster sid)
 
 
eststo: reg homicide_log  c.cdl pre2_cdl i.sid i.year i.northeast#i.year i.midwest#i.year  ///
i.south#i.year i.west#i.year   c.income_log c.police_log c.prisoner_log c.lagprisoner_log ///
c.exp_pubwelfare_log c.exp_subsidy_log c.poverty c.unemployrt  c.whitem_15_24 c.whitem_25_44 ///
 c.blackm_25_44 c.blackm_15_24, vce(cluster sid)
   
eststo: reg homicide_log c.cdl i.sid i.year i.northeast#i.year i.midwest#i.year i.south#i.year  ///
i.west#i.year  c.income_log c.police_log c.prisoner_log c.lagprisoner_log ///
c.exp_pubwelfare_log c.exp_subsidy_log c.poverty c.unemployrt  c.whitem_15_24 c.whitem_25_44 ///
 c.blackm_25_44 c.blackm_15_24 c.larceny_log c.motor_log, vce(cluster sid)
  
 
  eststo: reg homicide_log  c.cdl i.sid i.year i.northeast#i.year i.midwest#i.year ///
 i.south#i.year i.west#i.year   c.income_log c.police_log c.prisoner_log c.lagprisoner_log ///
c.exp_pubwelfare_log c.exp_subsidy_log c.poverty c.unemployrt  c.whitem_15_24 c.whitem_25_44 ///
 c.blackm_25_44 c.blackm_15_24 i.sid#c.year, vce(cluster sid) 
 
 
 esttab using crime.tex, keep(cdl pre2_cdl) se ar2 replace booktabs ///                     
 title(Regression Table (Excluding most covariates)\label{tab1}) nomtitles
 
 eststo clear 
 
sort sid
by sid: egen pop_weight=mean(population)

eststo: reg homicide_log c.cdl i.sid i.year [aweight=pop_weight], vce(cluster sid)


eststo: reg homicide_log c.cdl i.sid i.year i.northeast#i.year i.midwest#i.year ///
 i.south#i.year i.west#i.year [aweight=pop_weight], vce(cluster sid)


eststo: reg homicide_log c.cdl i.sid i.year i.northeast#i.year i.midwest#i.year i.south#i.year ///
 i.west#i.year  c.income_log c.police_log c.prisoner_log c.lagprisoner_log ///
c.exp_pubwelfare_log c.exp_subsidy_log c.poverty c.unemployrt  c.whitem_15_24 c.whitem_25_44 ///
 c.blackm_25_44 c.blackm_15_24 [aweight=pop_weight], vce(cluster sid)
 
 
eststo: reg homicide_log  c.cdl pre2_cdl i.sid i.year i.northeast#i.year i.midwest#i.year  ///
i.south#i.year i.west#i.year   c.income_log c.police_log c.prisoner_log c.lagprisoner_log ///
c.exp_pubwelfare_log c.exp_subsidy_log c.poverty c.unemployrt  c.whitem_15_24 c.whitem_25_44 ///
 c.blackm_25_44 c.blackm_15_24 [aweight=pop_weight], vce(cluster sid)
   
eststo: reg homicide_log c.cdl i.sid i.year i.northeast#i.year i.midwest#i.year i.south#i.year  ///
i.west#i.year  c.income_log c.police_log c.prisoner_log c.lagprisoner_log ///
c.exp_pubwelfare_log c.exp_subsidy_log c.poverty c.unemployrt  c.whitem_15_24 c.whitem_25_44 ///
 c.blackm_25_44 c.blackm_15_24 c.larceny_log c.motor_log [aweight=pop_weight], vce(cluster sid)
  
 
  eststo: reg homicide_log  c.cdl i.sid i.year i.northeast#i.year i.midwest#i.year ///
 i.south#i.year i.west#i.year   c.income_log c.police_log c.prisoner_log c.lagprisoner_log ///
c.exp_pubwelfare_log c.exp_subsidy_log c.poverty c.unemployrt  c.whitem_15_24 c.whitem_25_44 ///
 c.blackm_25_44 c.blackm_15_24 i.sid#c.year [aweight=pop_weight], vce(cluster sid) 
 
 esttab using crime1.tex, keep(cdl pre2_cdl) se ar2 replace booktabs ///                     
 title(Weighted Regression Table (Excluding most covariates)\label{tab2}) nomtitles
 
