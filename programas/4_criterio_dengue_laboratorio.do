
import excel "datos\raw\BASE DE DATOS DENGUE 2020.xlsx", sheet("2020") firstrow clear

drop if N == .

save "datos\base_laboratorio_2020", replace

import excel "datos\raw\BASE DE DATOS DENGUE 2021.xlsx", sheet("2021") firstrow clear

drop if N == .

save "datos\base_laboratorio_2021", replace

append using "datos\base_laboratorio_2020", force 


gen nombre_paciente = APELLIDOSYNOMBRES

sort nombre_paciente 

*br nombres
gen datos_criterio_laboratorio = 1

format CODIGO %13.0g

save "datos\datos_laboratorio_nombre", replace
/*
x 
duplicates report nombres
duplicates tag nombres, gen(dupli)
quietly by nombres: gen dup = cond(_N==1,0,_n)

br if dup != 0

format CODIGO %15.0g


split nombres, parse(" ") 

rename nombres1 apellido1
rename nombres2 apellido2
rename nombres3 nombre1

gen nombre_paciente = apellido1 + apellido2 + nombre1

sort nombre_paciente

br nombre_paciente


duplicates report apellido1 apellido2 nombre1 EDAD
x 
*/

use "datos\datos_dengue_criterio_5_38", clear

sort apepat apemat nombres


gen nombre_paciente = apepat + " " + apemat + " " + nombres

gen datos_criterio_dengue = 1

keep dni nombre_paciente datos_criterio_dengue

*save "datos\datos_dengue_nombre", replace

merge 1:m nombre_paciente using "datos\datos_laboratorio_nombre"

*keep if _merge == 3 | _merge == 1

sort nombre_paciente

*br nombre_paciente datos_criterio_dengue datos_criterio_laboratorio CODIGO 

save "datos\criterio_dengue_laboratorio", replace
export excel "datos\criterio_dengue_laboratorio.xlsx", replace firstrow(variables)



/*
gen apellido1 = apepat + " "
gen apellido2 = apemat + " "

split nombres, parse(" ")
split apepat, parse(" ")
split apemat, parse(" ")

gen nombre_paciente = apepat1 + apemat + nombres1

sort nombre_paciente

br nombre_paciente
x 
*rename apemat apellido2


br apepat nombres1 nombres2

duplicates report apepat apemat nombres1 

*/