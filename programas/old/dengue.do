* Definir el directorio de trabajo actual
global path "D:\Johar\7. Work\covid"
	global base "$path/base"
	global data "$path/data"
	global do "$path/do"
	global regional "$path/regional"
	global provincial "$path/provincial"
	global distrital "$path/distrital"
	
use "${data}\data-duplicados.dta", clear

duplicates drop dni, force

save "${data}\data-sin-duplicados.dta", replace

import excel "D:\Johar\7. Work\covid\arbovirosis\BASE ARBOVIROSIS.xlsx", sheet("BASE") firstrow clear

duplicates report dni

sort dni
duplicates report dni
duplicates tag dni, gen(repe_den)
quietly by dni: gen repeti_den = cond(_N==1,0,_n)

tostring fecha_not, replace 
destring fecha_not, replace
format fecha_not %td

br dni fecha_not repeti_den if repe_den != 0


br dni fecha

sort dni

merge 1:m dni using "${data}\data-sin-duplicados.dta"