
* Definir usuario: 1 para la carpeta GitHub de F y 2 para la carpeta de J
global user 3

* Definir los globales 

if $user == 1 {
 global path "C:\Users\PC\Dropbox\Mi PC (DESKTOP-72MA2AK)\Documents\proyecto_dengue_covid"
}

if $user == 2 {
 global path "C:\Users\unsaac\Documents\GitHub\proyecto_dengue_covid"
}

if $user == 3 {
 global path "C:\Users\HP\Documents\GitHub\covid-cusco\proyecto_dengue_covid"
}

* Definir el directorio
cd "$path"

x
* Limpieza de datos
	*do "1a_datos_covid"
	*do "programas\1b_datos_dengue"
	*do "programas\1c_datos_sinadef"
	*do "programas\1c_juntar"
	
* Criterios
	*do "2_criterios"