
use "datos\base_dengue_sinadef", clear

keep dni f* 

merge 1:1 dni using "datos\base_sinadef"

keep if _merge == 3

export excel using "datos\dengue_sinadef_causas.xlsx", firstrow(variables) replace