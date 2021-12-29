
use "datos\base_dengue_positivos", clear

merge m:1 dni using "datos\base_sinadef"

keep if _merge == 3

save "datos\base_dengue_sinadef", replace