*-------------------------------------------------------------------------------%

* Programa: Limpieza de Datos de Casos COVID-19 por PCR y AG en Cusco

* Primera vez creado:     15/06/2021
* Ultima actualizaciónb:  16/06/2021

*-------------------------------------------------------------------------------%

********************************************************************************
* 1. Pruebas Moleculares
********************************************************************************

* Importar la base de datos del NOTI

import excel "G:\Mi unidad\Datos_Dengue\datos\raw\base_noti.xlsx", sheet(BD_coronavirus) firstrow clear

keep dni telefono tipodoc departamento_residencia prueba prueba1 prueba2 resultado resultado1 resultado2 resultado_rap resultado_rap1 muestra muestra1 muestra2 fecha_res fecha_res1 fecha_res2 fecha_res_rap fecha_res_rap1 fecha_ini

* Seleccionar solo a los que pertencen al departamento Cusco
gen departamento = departamento_residencia
keep if departamento == "CUSCO"

gen positivo_pcr1=.
replace positivo_pcr1 = 1 if resultado == "POSITIVO" & (muestra == "ASPIRADO TRAQUEAL O NASAL FARINGEO" | muestra == "HISOPADO NASAL Y FARINGEO" | muestra == "LAVADO BRONCOALVEOLAR") & (prueba != "PRUEBA ANTIGÉNICA" & prueba != "PRUEBA SEROLÓGICA")
replace positivo_pcr1 = 0 if resultado == "NEGATIVO" & (muestra == "ASPIRADO TRAQUEAL O NASAL FARINGEO" | muestra == "HISOPADO NASAL Y FARINGEO" | muestra == "LAVADO BRONCOALVEOLAR") & (prueba != "PRUEBA ANTIGÉNICA" & prueba != "PRUEBA SEROLÓGICA")
tab positivo_pcr1

gen positivo_pcr2=.
replace positivo_pcr2 = 1 if resultado1 == "POSITIVO" & (muestra1 == "ASPIRADO TRAQUEAL O NASAL FARINGEO" | muestra1 == "HISOPADO NASAL Y FARINGEO" | muestra1 == "LAVADO BRONCOALVEOLAR") & (prueba1 != "PRUEBA ANTIGÉNICA" & prueba1 != "PRUEBA SEROLÓGICA")
replace positivo_pcr2 = 0 if resultado1 == "NEGATIVO" & (muestra1 == "ASPIRADO TRAQUEAL O NASAL FARINGEO" | muestra1 == "HISOPADO NASAL Y FARINGEO" | muestra1 == "LAVADO BRONCOALVEOLAR") & (prueba1 != "PRUEBA ANTIGÉNICA" & prueba1 != "PRUEBA SEROLÓGICA")
tab positivo_pcr2

gen positivo_pcr3=.
replace positivo_pcr3 = 1 if resultado2 == "POSITIVO" & (muestra2 == "ASPIRADO TRAQUEAL O NASAL FARINGEO" | muestra2 == "HISOPADO NASAL Y FARINGEO" | muestra2 == "LAVADO BRONCOALVEOLAR") & (prueba2 != "PRUEBA ANTIGÉNICA" & prueba2 != "PRUEBA SEROLÓGICA")
replace positivo_pcr3 = 0 if resultado2 == "NEGATIVO" & (muestra2 == "ASPIRADO TRAQUEAL O NASAL FARINGEO" | muestra2 == "HISOPADO NASAL Y FARINGEO" | muestra2 == "LAVADO BRONCOALVEOLAR") & (prueba2 != "PRUEBA ANTIGÉNICA" & prueba2 != "PRUEBA SEROLÓGICA")
tab positivo_pcr3

gen positivo_pr1_noti = .
replace positivo_pr1_noti = 1 if resultado_rap == "Ig G POSITIVO" | resultado_rap == "Ig M  e Ig G POSITIVO" | resultado_rap == "Ig M POSITIVO"
replace positivo_pr1_noti = 0 if resultado_rap == "NEGATIVO"
tab positivo_pr1_noti

gen positivo_pr2_noti = .
replace positivo_pr2_noti = 1 if resultado_rap1 == "Ig G POSITIVO" | resultado_rap1 == "Ig M  e Ig G POSITIVO" | resultado_rap1 == "Ig M POSITIVO"
replace positivo_pr2_noti = 0 if resultado_rap1 == "NEGATIVO"
tab positivo_pr2_noti

gen positivo_ag_noti=.
replace positivo_ag_noti = 1 if resultado == "POSITIVO" & (muestra == "ASPIRADO TRAQUEAL O NASAL FARINGEO" | muestra == "HISOPADO NASAL Y FARINGEO" | muestra == "LAVADO BRONCOALVEOLAR") & (prueba == "PRUEBA ANTIGÉNICA")
replace positivo_ag_noti = 0 if resultado == "NEGATIVO" & (muestra == "ASPIRADO TRAQUEAL O NASAL FARINGEO" | muestra == "HISOPADO NASAL Y FARINGEO"  | muestra == "LAVADO BRONCOALVEOLAR") & (prueba == "PRUEBA ANTIGÉNICA")
tab positivo_ag_noti

* Primera prueba molecular
gen fecha_molecular1 = fecha_res
split fecha_molecular1, parse(-) destring
rename (fecha_molecular1?) (dayl monthl yearl)
gen fecha_pcr1 = daily(fecha_molecular1, "DMY") if positivo_pcr1 == 1 | positivo_pcr1 == 0
format fecha_pcr1 %td

* Segunda prueba molecular
gen fecha_molecular2 = fecha_res1 
split fecha_molecular2, parse(-) destring
rename (fecha_molecular2?) (day2 month2 year2)
gen fecha_pcr2 = daily(fecha_molecular2, "DMY") if positivo_pcr2 == 1 | positivo_pcr2 == 0
format fecha_pcr2 %td

* Tercera prueba molecular
gen fecha_molecular3 = fecha_res2 
split fecha_molecular3, parse(-) destring
rename (fecha_molecular3?) (day3 month3 year3)
gen fecha_pcr3 = daily(fecha_molecular3, "DMY") if positivo_pcr3 == 1 | positivo_pcr3 == 0
format fecha_pcr3 %td

* Primera prueba rápida
gen fecha_rapida1 = fecha_res_rap 
split fecha_rapida1, parse(-) destring
rename (fecha_rapida1?) (day4 month4 year4)
gen fecha_pr1_noti = daily(fecha_rapida1, "DMY") if positivo_pr1 == 1 | positivo_pr2 == 0
format fecha_pr1_noti %td

* Segunda prueba rápida
gen fecha_rapida2 = fecha_res_rap1
split fecha_rapida2, parse(-) destring
rename (fecha_rapida2?) (day5 month5 year5)
gen fecha_pr2_noti = daily(fecha_rapida2, "DMY") if positivo_pr2 == 1 | positivo_pr2 == 0
format fecha_pr2_noti %td

* Fecha de inicio de síntomas
gen fecha_inici = fecha_ini
split fecha_inici, parse(-) destring
rename (fecha_inici?) (day7 month7 year7)
gen fecha_inicio_noti = daily(fecha_inici, "DMY") if positivo_pcr1 == 1 | positivo_pcr1 == 2 | positivo_pcr3 == 1
format fecha_inicio_noti %td


gen fecha_ag1 = fecha_res
split fecha_ag1, parse(-) destring
rename (fecha_ag1?) (day6 month6 year6)
gen fecha_ag_noti = daily(fecha_ag1, "DMY") if positivo_ag_noti == 1 | positivo_ag_noti == 0
format fecha_ag_noti %td

sort dni
duplicates report dni
duplicates tag dni, gen(dupli_noti)
quietly by dni: gen dup_noti = cond(_N==1,0,_n)
*br dni dupli_noti dup_noti if dup_noti != 0

* Un DNI y el numero de carnet de una persona coincide, se toma en cuenta 
replace dni = telefono if tipodoc == "CARNET DE EXTRANJERIA" & dupli_noti == 1 & dni == "19836727"

* Borrar duplicados en esta base NOTI
duplicates drop dni, force

* Mantener los archivos de interés
keep dni positivo_pcr1 positivo_pcr2 positivo_pcr3 positivo_pr1_noti positivo_pr2_noti positivo_ag_noti fecha_pcr1 fecha_pcr2 fecha_pcr3 fecha_pr1_noti fecha_pr2_noti fecha_ag_noti fecha_inicio_noti

* Guardar la base de datos NOTI
save "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\data_noti"

********************************************************************************
* 2. Pruebas Antigénica
********************************************************************************

* Cargar la base de datos del SISCOVID
import excel "G:\Mi unidad\Datos_Dengue\datos\raw\base_sis_ag.xlsx", sheet("Hoja1") firstrow clear

* Mantener sólo los de Cusco
keep if Departamento == "Cusco"

* Mantener las variables de interés 
keep NroDocumento Resultado ResultadoSegundaPrueba FechaRegistroPrueba FechaInicioSintomasdelaFich

* Crear la variable DNI
rename NroDocumento dni 

gen positivo_ag_sis=.
replace positivo_ag_sis = 1 if Resultado == "Reactivo" | ((Resultado == "Inválido" |Resultado == "Indeterminado") & ResultadoSegundaPrueba == "Reactivo")
replace positivo_ag_sis = 0 if Resultado == "No Reactivo" | ((Resultado == "Inválido" |Resultado == "Indeterminado") & ResultadoSegundaPrueba == "No Reactivo")
tab positivo_ag_sis

rename FechaRegistroPrueba fecha_antigena
split fecha_antigena, parse(-) destring
rename (fecha_antigena?) (year month day)
gen fecha_ag_sis = daily(fecha_antigena, "YMD") if positivo_ag_sis == 1 | positivo_ag_sis == 0
format fecha_ag_sis %td

split FechaInicioSintomasdelaFich, parse(-) destring
rename (FechaInicioSintomasdelaFich?) (year1 month1 day1)
gen fecha_inicio_ag = daily(FechaInicioSintomasdelaFich, "YMD")  if positivo_ag == 1
format fecha_inicio_ag %td
*borrar fecha de inicio menos que el 2020 primero de enero
replace fecha_inicio_ag = . if fecha_inicio_ag < 21915

sort dni
duplicates report dni
duplicates tag dni, gen(dupli_sis)
quietly by dni: gen dup_sis = cond(_N==1,0,_n)

*br dni repe_ag repeti_ag fecha_ag_sis positivo_ag_sis if repe_ag != 0

*duplicates drop dni if (positivo_ag_sis == positivo_ag_sis), force

keep dni positivo_ag_sis fecha_ag_sis repe_ag repeti_ag fecha_inicio_ag

save "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\data_sis_ag"

********************************************************************************
* 3. Pruebas Rápida
********************************************************************************

* Cargar la base de datos del SISCOVID
import excel "D:\covid_cusco\datos\raw\base_sis_pr.xlsx", sheet("Hoja1") firstrow clear

* Mantener las variables de interés
keep NroDocumento VALIDOS Resultado1 FechaInicioSintomasPaciente  TieneSintomas FechaPrueba

* Renombrar las variables para que coincidan con las variables de la misma base pero del 2020
rename NroDocumento nro_docume
rename VALIDOS validos
rename Resultado1 resultado1
rename FechaInicioSintomasPaciente fecha_inic
rename TieneSintomas tiene_sint

split FechaPrueba, parse(-) destring
rename (FechaPrueba?) (year month day)
gen fecha_pr = daily(FechaPrueba, "YMD")
format fecha_pr %td

* Positivo para identificar los duplicados 
gen positivo_pr = .
replace positivo_pr = 1 if resultado == "IgG POSITIVO" | resultado == "IgG Reactivo" | resultado == "IgM POSITIVO" | resultado == "IgM Reactivo" | resultado == "IgM e IgG POSITIVO" | resultado == "IgM e IgG Reactivo" | resultado == "POSITIVO" | (resultado == "Indeterminado" & (resultado1 == "IgG Reactivo"| resultado1 == "IgM Reactivo" | resultado1 == "IgM e IgG Reactivo"))
replace positivo_pr = 0 if resultado == "NEGATIVO" | resultado == "No Reactivo" | (resultado1 == "Indeterminado" & (resultado1 == "Indeterminado" | resultado1 == "No reactivo"))
tab positivo_pr

* Convertir la 'fecha de resultado' en el formato que lea la variable
gen fecha_pr_sis = fecha_pr  if positivo_pr == 1 | positivo_pr == 0
format fecha_pr_sis %d

* Fecha de inicio de síntoma
split fecha_inic, parse(-) destring
rename (fecha_inic?) (year1 month1 day1)
gen fecha_inicio_pr = daily(fecha_ini, "YMD") if positivo_pr == 1
format fecha_inicio_pr %td
replace fecha_inicio_pr = . if fecha_inicio_pr < 21915

gen fecha_inicio = fecha_inicio_pr 
format fecha_inicio %td

* Unir con la base de datos (con las mismas variables) del 2020
append using "G:\Mi unidad\Datos_Dengue\datos\output\base_sis_pr_2020.dta", force

gen dni = nro_docume
sort dni

* Mantener sólo los que tienen fecha de inicio de síntoma 
*keep if fecha_inicio_pr != .

rename positivo_pr positivo_sis_pr
rename fecha_pr fecha_sis_pr

keep dni positivo_sis_pr fecha_sis_pr

save "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\data_sis_pr", replace

*-------------------------------------------------------------------------------

********************************************************************************
* 3. Juntar ambas bases de datos Notificación, SISCOVID
use "datos\data_noti", clear

merge 1:m dni using "datos\data_sis_ag", force generate(noti_a_anti)
merge m:m dni using "datos\data_sis_pr", force generate(noti_a_anti_a_pr)
*br dni repe_ag positivo_ag_noti positivo_ag_sis fecha_ag_noti fecha_ag_sis if repe_ag != 0 & repe_ag != . 

sort dni fecha_ag_sis

duplicates tag dni, gen(dupli_noti_sis)
quietly by dni: gen dup_noti_sis = cond(_N==1,0,_n)

* Mantener sólo los positivos
keep if positivo_pcr1 == 1 | positivo_pcr2 == 1 | positivo_pcr3 == 1 | positivo_ag_sis == 1 | positivo_ag_noti == 1 | positivo_sis_pr == 1

* Mantener las variables de interés
keep dni positivo_pcr1 positivo_pcr2 positivo_pcr3 positivo_ag_sis positivo_ag_noti fecha_pcr1 fecha_pcr2 fecha_pcr3 fecha_ag_sis fecha_ag_noti positivo_sis_pr fecha_sis_pr

* Guardar la base de datos 
save "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_covid_positivos.dta", replace


*-------------------------------------------------------------------------------
use "datos\data_noti", clear

merge 1:m dni using "datos\data_sis_ag", force generate(noti_a_anti)

sort dni fecha_ag_sis

duplicates tag dni, gen(dupli_noti_ag)
quietly by dni: gen dup_noti_ag = cond(_N==1,0,_n)

* Mantener sólo los positivos
keep if positivo_pcr1 == 1 | positivo_pcr2 == 1 | positivo_pcr3 == 1 | positivo_ag_sis == 1 | positivo_ag_noti == 1 

* Mantener las variables de interés
keep dni positivo_pcr1 positivo_pcr2 positivo_pcr3 positivo_ag_sis positivo_ag_noti fecha_pcr1 fecha_pcr2 fecha_pcr3 fecha_ag_sis fecha_ag_noti 

gen criterio_positivo_pcr_ag = 1
* Guardar la base de datos 
save "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_covid_positivos_pcr_ag.dta", replace
