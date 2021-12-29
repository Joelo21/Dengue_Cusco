use "datos\base_dengue.dta", clear

* Mantener sólo a los que tienen menos o igual que cinco días de diferencia y que tenga reportado fiebre de más o igual a 38 grados
keep if  (fecha_inicio_prueba <=5 & fecha_inicio_prueba != .) & (fiebre >=38 & fiebre != .)


* Mantener las variables relevantes
* keep dni inicio_s fecha_inicio_dengue muestra1 fmuestra1 fecha_inicio_prueba fiebre

* Reportar duplicados
duplicates report dni 
*fecha_inicio_dengue fmuestra1 

* Eliminar duplicados 
duplicates drop dni, force

* Mantener a los que tienen fecha de inicio > o = al 16 de marzo del 2020
keep if fmuestra1 >= d(16mar2020)

save "datos\datos_dengue_criterio_5_38", replace

export excel "datos\datos_dengue_criterio_5_38.xlsx", replace firstrow(variables)