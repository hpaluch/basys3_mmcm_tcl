# MMCM clock base example for Artix-7 Basys3 board

Most trivial example how to use MMCM IP "Clock Wizard" to generate 8 MHz clock from 100 MHz on-board
clock for Artix-7 Digilent Basys3 board and Vivado 2024.1.

> Work in Progress.

Status:
- TCL script [aa-gen-project.tcl](aa-gen-project.tcl) now generates project `../basys3_mmcm_work/basys3_mmcm_work.xpr`
  without error
- Project `../basys3_mmcm_work/basys3_mmcm_work.xpr` now builds without fatal error (but some warnings)

This project is based on "IP Design Example..." code (see
[clk_wiz_0_exdes.v](clk_wiz_0_exdes.v), generated from "Clock Wizard", that
handles properly RESET using several `ASYNC_REG` shift registers - it is serous
stuff where intuition is not enough.

# Setup

Tested Vivado 2024.1 on Linux (Alma Linux 8.7). Command has to be run in this directory:
```shell
bash$ /opt/Xilinx/Vivado/2024.1/bin/vivado -mode tcl
Vivado% ls
Vivado% source aa-gen-project.tcl
Vivado% exit   # exit vivado to avoid project sharing clashes
```

Now open generated project `../basys3_mmcm_work/basys3_mmcm_work.xpr` in normal `Vivado 2024.1` GUI.
And generate bitstream using Flow Navigator -> Program and Debug -> Generate Bitstream (confirm
that you want to use all previous steps).


# Notes

Unlike Vivado 2015.1 (using with AC701) I must admit that Vivado 2024.1 is like
hell. When I used File -> Project -> Write Tcl...  - the results was largely
unusable and I have to change many things including:

- use `import_ip` instead of `add_files` for `.xci` to avoid `[Vivado 12-13650]` that completely
  screws IP generation path (to absolute that is not writable causing Synthesis crash)
- removed all `.dcp` stuff to avoid adding binary files to Git
- and many others smaller changes.

NOTE: All files (but `.xci`) are referenced back to this project - so when you edit them  you can
directly commit changes to git in this project.

But in case of `.xci` you have to manually watch and compare contents
of `../basys3_mmcm_work/basys3_mmcm_work.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci`,
and  `../basys3_mmcm_work/basys3_mmcm_work.gen/sources_1/ip/clk_wiz_0/*.*` and manually
merge them back to this repo.

I don't know - why something that worked pretty well in Vivado 2015.1
(generating TCL script to create project) is now screwed...

Some related resources:
- https://adaptivesupport.amd.com/s/question/0D54U00008W1LZzSAN/best-practice-for-xci-add-in-project-creation-tcl?language=en_US
- https://adaptivesupport.amd.com/s/question/0D54U00006VE0bTSAT/outputdir-and-gendirectory-in-xci-json-files?language=en_US
- https://docs.amd.com/r/en-US/ug939-vivado-designing-with-ip-tutorial
- https://docs.amd.com/r/2020.2-English/ug835-vivado-tcl-commands/import_ip
