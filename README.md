# MMCM clock base example for Artix-7 Basys3 board

Most trivial example how to use MMCM IP "Clock Wizard" to generate 8 MHz clock from 100 MHz on-board
clock for Artix-7 Digilent Basys3 board and Vivado 2024.1.

> Work in Progress.

It is based on "IP Design Example..." code (see [clk_wiz_0_exdes.v](clk_wiz_0_exdes.v),
that handles properly RESET using several `ASYNC_REG` shift registers (not trivial stuff).
