import excel "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_sinadef_total.xlsx", sheet("Data1") firstrow clear

keep if DEPARTAMENTO == "CUSCO"

drop if Nº == .

drop if ESTADO == "ANULACIÓN SOLICITADA" | ESTADO == "ANULADO"

gen distrito = DISTRITODOMICILIO


* Generar la variable de identificación
rename DOCUMENTO dni

destring MES, replace force
destring AÑO, replace force 
gen fecha_sinadef = mdy(MES,DIA,AÑO)
format fecha_sinadef %td

* Otras variables relevantes para que sean similares a la base NOTICOVID y SISCOVID
rename SEXO sexo
*rename EDAD edad
*destring edad, replace

sort dni
duplicates report dni
duplicates tag dni, gen(repe_def)
quietly by dni: gen repeti_def = cond(_N==1,0,_n)

set seed 98034
generate u1 = runiform()

tostring u1, replace force
replace dni = u1 if dni == "SIN REGISTRO"
replace dni = u1 if dni == ""
duplicates drop dni, force

*keep dni sexo edad distrito fecha_sinadef

save "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_sinadef", replace
