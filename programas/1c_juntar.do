* Cargar la base de datos
use "datos\base_covid_positivos.dta", clear

* Unir la base de datos con la base dengue
merge m:m dni using "datos\base_dengue_positivos"

* Mantener sólo los que emparejan (positivos en alguna prueba molecular o ag del NOTI o ag del SISCOVID y que haya salido positivo en dengue)
keep if _merge==3


*br positivo_pcr1 positivo_ag_sis positivo_covid positivo_dengue
*duplicates drop dni, force
sort dni
duplicates report dni
duplicates tag dni, gen(repetidos)
quietly by dni: gen repes = cond(_N==1,0,_n)

* Borrar duplicados
duplicates drop dni, force

save "datos\base_covid_dengue.dta", replace