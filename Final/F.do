clear all
cd "/Users/liz/Documents/Projects/ECON 308/Final/"
use "/Users/liz/Documents/Projects/ECON 308/Final/2.dta"


gen robcap = (robberies / (population/1000) )

gen bacap = (assaults + batteries) / (population/1000)

sum population 

gen popstand = (population - 857.2294)/479.5102

encode community, gen(enc_c)

eststo: reg robcap popstand i.enc_c bus_stops i.intersection i.majorstreet pct_black ///
pct_hisp pct_hh_w_public_assist pct_residential pct_industrial pct_commercial, vce(robust)

eststo: reg bacap popstand i.enc_c bus_stops i.intersection i.majorstreet pct_black ///
pct_hisp pct_hh_w_public_assist pct_residential pct_industrial pct_commercial, vce(robust)

eststo: ivregress 2sls robcap bus_stops i.enc_c i.intersection i.majorstreet pct_black ///
pct_hisp pct_hh_w_public_assist (popstand pct_residential pct_industrial pct_commercial = pct_low_dens_zoned pct_medium_dens_zoned pct_high_dens_zoned pct_highest_den_zoned pct_commercial_zoned pct_industrial_zoned pct_residential_zoned), vce(robust)

eststo: ivregress 2sls bacap bus_stops i.enc_c i.intersection i.majorstreet pct_black ///
pct_hisp pct_hh_w_public_assist (popstand pct_residential pct_industrial pct_commercial = pct_low_dens_zoned pct_medium_dens_zoned pct_high_dens_zoned pct_highest_den_zoned pct_commercial_zoned pct_industrial_zoned pct_residential_zoned), vce(robust)


eststo: ivregress 2sls robcap bus_stops i.enc_c i.intersection i.majorstreet pct_black ///
pct_hisp pct_hh_w_public_assist (popstand pct_residential pct_industrial pct_commercial = pct_low_dens_zoned pct_medium_dens_zoned pct_high_dens_zoned pct_highest_den_zoned pct_commercial_zoned pct_industrial_zoned pct_residential_zoned pct_low_dens_zoned c.pct_low_dens_zoned#c.pct_residential_zoned c.pct_medium_dens_zoned#c.pct_residential_zoned c.pct_high_dens_zoned#c.pct_residential_zoned c.pct_highest_den_zoned#c.pct_residential_zoned), vce(robust)

eststo: ivregress 2sls bacap bus_stops i.enc_c i.intersection i.majorstreet pct_black ///
pct_hisp pct_hh_w_public_assist (popstand pct_residential pct_industrial pct_commercial = pct_low_dens_zoned pct_medium_dens_zoned pct_high_dens_zoned pct_highest_den_zoned pct_commercial_zoned pct_industrial_zoned pct_residential_zoned pct_low_dens_zoned c.pct_low_dens_zoned#c.pct_residential_zoned c.pct_medium_dens_zoned#c.pct_residential_zoned c.pct_high_dens_zoned#c.pct_residential_zoned c.pct_highest_den_zoned#c.pct_residential_zoned), vce(robust)

esttab using tab1.tex, keep(_cons popstand pct_residential pct_industrial pct_commercial) se ar2 replace booktabs ///                   
title(Regression Table (Land Use Only)\label{tab1}) nomtitles
