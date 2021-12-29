

use "datos\criterio_dengue_laboratorio", clear

sort dni 

merge  m:m dni using "datos\base_covid_positivos_pcr_ag.dta", gen(repe)

sort nombre 

drop if repe == 2
*br if repe == 3

br dni nombre N criterio_*

save "datos\criterio_dengue_laboratorio_covid", replace

export excel "datos\criterio_dengue_laboratorio_covid.xlsx", replace firstrow(variables)