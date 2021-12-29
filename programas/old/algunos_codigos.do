x 


* Generar la diferencia
gen fecha_dif = fecha_inicio_noti - fecha_inicio_ag if fecha_inicio_ag != . & fecha_inicio_noti != .


br fecha_inicio_*

x 
import delimited "$datos\base_arbovirosis.csv", clear
x 


br fecha_inicio_*

gen fecha_dif = fecha_inicio_noti - fecha_inicio_ag if fecha_inicio_ag != . & fecha_inicio_noti != .

gen fecha_sintoma_1 = fecha_inicio_noti 
replace fecha_sintoma_1 = fecha_inicio_ag_sis if (fecha_inicio_noti >= 22281 & fecha_inicio_noti == .) & fecha_dif >0
format fecha_sintoma_1 %td 
*br fecha_inicio_* fecha_sintoma_1

gen fecha_sintoma_2 = fecha_inicio_noti 
replace fecha_sintoma_2 = fecha_inicio_ag_sis if (fecha_inicio_noti == fecha_sintoma_1)
replace fecha_sintoma_2 = fecha_inicio_noti if fecha_sintoma_2 == . & fecha_inicio_noti !=.
replace fecha_sintoma_2 = fecha_inicio_ag_sis if fecha_sintoma_2 == .
format fecha_sintoma_2 % td 
*br fecha_inicio_* fecha_sintoma_1 fecha_sintoma_2

drop if fecha_sintoma_1 == .
drop _merge 
* duplicates drop dni, force

save "${data}\output\data-sin-data_dupli_pcr_ag.dta", replace

import excel "${data}\raw\BASE ARBOVIROSIS.xlsx", sheet("BASE") firstrow clear

save "${data}\output\base_arbovirosis.dta", replace

gen positivo_dengue = .
replace positivo_dengue = 1 if prueba01 == 1  | prueba02 == 1 | prueba03 == 1 | prueba04 == 1
*keep if positivo_dengue == 1

duplicates report dni

gen fecha_inicio_dengue = inicio_s
format fecha_inicio_dengue %td

keep dni fecha_inicio_dengue positivo_dengue

merge m:m dni using "${data}\output\data-sin-data_dupli_pcr_ag.dta"

br fecha_sintoma_1 fecha_sintoma_2 fecha_inicio_dengue

sort dni fecha_inicio_noti
duplicates drop dni, force 

br fecha_sintoma_1 fecha_inicio_dengue if fecha_sintoma_1 !=. & fecha_inicio_dengue !=.

gen diferencia = fecha_sintoma_1 - fecha_inicio_dengue

br fecha_sintoma_1 fecha_inicio_dengue if(fecha_sintoma_1 !=. & fecha_inicio_dengue !=.) & (diferencia>=-7& diferencia<=7)


keep if(fecha_sintoma_1 !=. & fecha_inicio_dengue !=.) & (diferencia>=-7& diferencia<=7)
save "${data}\output\data_fc.dta", replace

* 12 marzo del 2021
use "${data}\output\data_fc.dta", clear

drop _merge 
merge 1:m dni using "${data}\output\base_arbovirosis.dta" 

drop if _merge == 2

duplicates drop dni, force 



x 

sort dni
duplicates report dni
duplicates tag dni, gen(repe_den)
quietly by dni: gen repeti_den = cond(_N==1,0,_n)

tostring fecha_not, replace 
destring fecha_not, replace
format fecha_not %td

gen fecha_inicio_dengue = inicio_s

gen positivo_dengue = .
replace positivo_dengue = 1 if prueba01 == 1  | prueba02 == 1 | prueba03 == 1 | prueba04 == 1
replace positivo_dengue = 0 if positivo_dengue == .

duplicates drop dni, force

keep dni positivo_dengue fecha_not

merge 1:m dni using "${data}\output\data-sin-duplicados.dta"

keep if _merge == 3

gen positivo_covid = .
replace positivo_covid = 1 if positivo_pcr1 == 1 | positivo_pcr2 == 1 | positivo_pcr3 == 1 | positivo_ag_noti == 1 | positivo_ag_sis == 1

*replace positivo = 1 if positivo_pcr1 == 1 | positivo_pcr2 == 1 | positivo_pcr3 == 1 | positivo_pr1_noti ==1 | positivo_pr2_noti ==1| positivo_ag_noti == 1 | positivo_ag_sis ==1 | positivo_pr_sis == 1
replace positivo = 0 if positivo == .

tab positivo prueba 
*******************

tab prueba 

br dni fecha_not repeti_den if repe_den != 0

br dni fecha

sort dni

merge 1:m dni using "${data}\data-sin-duplicados.dta"
