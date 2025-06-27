# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {design_1_wrapper}\
-hw {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper.xsa}\
-arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria}

platform write
domain create -name {standalone_psu_cortexa53_0} -display-name {standalone_psu_cortexa53_0} -os {standalone} -proc {psu_cortexa53_0} -runtime {cpp} -arch {64-bit} -support-app {empty_application}
platform generate -domains 
platform active {design_1_wrapper}
domain active {zynqmp_fsbl}
domain active {zynqmp_pmufw}
domain active {standalone_psu_cortexa53_0}
platform generate -quick
platform generate
platform active {design_1_wrapper}
platform generate
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/vivado_projects/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform create -name {design_1_wrapper}\
-hw {/home/lsriw/SR/SlusarzMaciej/image_processing/video_passthrough_kria/design_1_wrapper.xsa}\
-arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/lsriw/SR/SlusarzMaciej/image_processing/video_passthrough_kria}

platform write
domain create -name {standalone_psu_cortexa53_0} -display-name {standalone_psu_cortexa53_0} -os {standalone} -proc {psu_cortexa53_0} -runtime {cpp} -arch {64-bit} -support-app {empty_application}
platform generate -domains 
platform active {design_1_wrapper}
domain active {zynqmp_fsbl}
domain active {zynqmp_pmufw}
domain active {standalone_psu_cortexa53_0}
platform generate -quick
platform generate
platform config -updatehw {/home/lsriw/SR/SlusarzMaciej/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {/home/tendan/Projekty/FPGA/SR/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate
platform active {design_1_wrapper}
platform config -updatehw {/home/tendan/Projekty/FPGA/SR/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate
platform config -updatehw {/home/tendan/Projekty/FPGA/SR/image_processing/video_passthrough_kria/design_1_wrapper.xsa}
platform generate -domains 
