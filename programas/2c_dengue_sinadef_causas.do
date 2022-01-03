
use "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_dengue_sinadef", clear

keep dni f* 

merge 1:1 dni using "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_sinadef"

keep if _merge == 3

export excel using "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\dengue_sinadef_causas.xlsx", firstrow(variables) replace