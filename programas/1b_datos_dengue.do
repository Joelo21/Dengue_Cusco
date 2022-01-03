*-------------------------------------------------------------------------------%

* Programa: Limpieza de Datos de Casos COVID-19 por PCR y AG en Cusco

* Primera vez creado:     15/06/2021
* Ultima actualizaciónb:  16/06/2021

*-------------------------------------------------------------------------------%

import excel "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_dengue.xlsx", clear firstrow 

* Duplicados
duplicates report dni

* Identificar los duplicados
sort dni
duplicates report dni
duplicates tag dni, gen(dupli_dengue)
quietly by dni: gen dup_dengue = cond(_N==1,0,_n)

* Fecha de inciio de síntoma
gen fecha_inicio_dengue = inicio_s
format fecha_inicio_dengue %td

*Renombrar variables string de fecha 
replace fresult01="" if fresult01 =="0000-00-00" 
split fresult01, parse(/) destring
rename (fresult01?) (month day year)
gen fresultado1 = daily(fresult01, "MDY")
format fresultado1 %td

/*
*no tomar en cuenta, 0 fechas
replace fresult02="" if fresult02 =="0000-00-00" 
split fresult02, parse(/) destring
rename (fresult02?) (month day year)
gen fresultado2 = daily(fresult02, "DMY")
format fresultado2 %td
*/

replace fresult03="" if fresult03 =="0000-00-00"
split fresult03, parse(/) destring
rename (fresult03?) (month3 day3 year3)
gen fresultado3 = daily(fresult03, "MDY")
format fresultado3 %td

/*
replace fresult04="" if fresult04 =="0000-00-00"
split fresult04, parse(/) destring
rename (fresult04?) (month4 day4 year4)
gen fresultado4 = daily(fresult04, "MDY")
format fresultado4 %td
*/

replace fresult05="" if fresult05 =="0000-00-00"
split fresult05, parse(/) destring
rename (fresult05?) (month5 day5 year5)
gen fresultado5 = daily(fresult05, "MDY")
format fresultado5 %td

replace fresult06="" if fresult06 =="0000-00-00"
split fresult06, parse(/) destring
rename (fresult06?) (month6 day6 year6)
gen fresultado6 = daily(fresult06, "MDY")
format fresultado6 %td

replace fresult07="" if fresult07 =="0000-00-00"
split fresult07, parse(/) destring
rename (fresult07?) (month7 day7 year7)
gen fresultado7 = daily(fresult07, "MDY")
format fresultado7 %td


/*
replace fresult08="" if fresult08 =="0000-00-00"
split fresult08, parse(/) destring
rename (fresult08?) (month8 day8 year8)
gen fresultado8 = daily(fresult08, "MDY")
format fresultado8 %td
*/

replace fresult09="" if fresult09 =="0000-00-00"
split fresult09, parse(/) destring
rename (fresult09?) (month9 day9 year9)
gen fresultado9 = daily(fresult09, "MDY")
format fresultado9 %td

********************************************************************************
* Fecha muestra 1
replace muestra1="" if muestra1 =="0000-00-00"
split muestra1, parse(/) destring
rename (muestra1?) (month10 day10 year10)
gen fmuestra1 = daily(muestra1, "MDY")
format fmuestra1 %td

* Diferencia de fecha de muestra 1 y fecha de inicio de síntoma
gen fecha_inicio_prueba = .
replace fecha_inicio_prueba = fmuestra1 - fecha_inicio_dengue
sum fecha_inicio_prueba


* Mantener los positivos
*generar
gen positivos = .
replace positivos = 1 if result01 == "P" | result03  =="P" | result04 == "P" | result05  =="P" | result06  =="P" | result07  =="P" | result09  =="P" | result10  =="P" | result11 == "P" 

gen negativos = .
replace negativos = 1 if result01 == "N" | result03  =="N" | result04 == "N" | result05  =="N" | result06  =="N" | result07  =="N" | result09  =="N" | result10  =="N" | result11 == "N" 


* Guardar 

save "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_dengue", replace


* mantener los positivos
keep if positivos == 1
* | negativos == 1



* Mantener las variables de interés 
keep dni prueba* fresultado* 

* Guardar la base de datos
save "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_dengue_positivos", replace
