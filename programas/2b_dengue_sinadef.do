
use "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_dengue_positivos", clear

merge m:1 dni using "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_sinadef"

keep if _merge == 3

save "C:\Users\PC\Documents\GitHub\Dengue_Cusco\datos\base_dengue_sinadef", replace