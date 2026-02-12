#!bin/csh -f
# edit

module load fm/2021.06-SP5

setenv work_path /slowfs/dgscratch1/asic/ASIC_Project/1_FrontEnd/fm
setenv tool_path /global/apps/fm_2021.06-SP5

set path = (. $tool_path/bin $path)

alias g 'gvim'
