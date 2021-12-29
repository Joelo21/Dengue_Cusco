use "datos\base_covid_dengue.dta", clear

********************************************************************************
* 1. Criterio para el COVID-19 por ambas bases de datos

*gen dif1=fecha_pcr1 - fresultado1

*br fecha_pcr1 fresultado1 if dif1 >=-7 & dif1 <=7

keep dni fecha_pcr1 fecha_pcr2 fecha_pcr3 fecha_ag_noti fecha_ag_sis fresultado1 fresultado3 fresultado5 fresultado6 fresultado7 fresultado9 fecha_sis_pr

* Colocar 1s cuando sea pertinente

save "datos\base_covid_dengue_criterio_uno.dta", replace



/*
* COVID-19 por primera PCR1 o AG (Noti y SISCOVID)
gen positivo_covid=.
replace positivo_covid = 1 if positivo_pcr1 == 1 | positivo_ag_sis == 1 | positivo_ag_noti == 1

* COVID-19 por primera PCR1 o AG (Noti y SISCOVID), falta limpieza
gen positivo_covid_2=.
replace positivo_covid_2 = 1 if positivo_pcr1 == 1 | positivo_pcr2 == 1 | positivo_pcr3 == 1 | positivo_ag_sis == 1 | positivo_ag_noti == 1 


* 2. Criterio para la base de arbovirosis
* Dengue como positivo por las 9 primeras pruebas
gen positivo_dengue = .
replace positivo_dengue = 1 if prueba01 == 1  | prueba02 == 1 | prueba03 == 1 | prueba04 == 1 | prueba05 == 1  | prueba06 == 1  | prueba07 == 1  | prueba08 == 1  | prueba09 == 1 

* Dengue como positivo por las 4 primeras pruebas
gen positivo_dengue_2 = .
replace positivo_dengue_2 = 1 if prueba01 == 1  | prueba02 == 1 | prueba03 == 1 | prueba04 == 1

* Dengue como positivo por las 3 primeras pruebas
gen positivo_dengue_3 = .
replace positivo_dengue_3 = 1 if prueba01 == 1  | prueba03 == 1 | prueba09 == 1 
********************************************************************************
* 3. Análisis
x 
*keep if positivo_dengue == 1

*

* Cuantos positivos con la primera (PCR1) hay que son positivos en dengue (cualquiera de las cuatro)
tab positivo_covid positivo_dengue_3

br fecha_pcr1 fecha_ag_noti fecha_ag_sis fecha_inicio_dengue

*********************

tab positivo_covid_2 positivo_dengue_3

tab positivo_pcr1 positivo_dengue

tab positivo_ag_sis positivo_dengue


br positivo_pcr1 positivo_pcr2 positivo_pcr3 if (positivo_pcr1 == .) & (positivo_pcr2 !=. | positivo_pcr3 !=.)
