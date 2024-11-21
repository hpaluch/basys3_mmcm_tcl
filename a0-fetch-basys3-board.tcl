# a0-fetch-basys3-board.tcl - Download board definitions including Digilent Basys 3 board for Artix-7 FPGA
# tested on Vivado 2023.2 Linux
# run this script with command:
#   /opt/Xilinx/Vivado/2023.2/bin/vivado -mode tcl -script ./a0-fetch-basys3-board.tcl

set ver [version -short]
puts "Vivado version is '$ver'"
set repo_path "$::env(HOME)/.Xilinx/Vivado/$ver/xhub/board_store/xilinx_board_store"
puts "Using board repo path '$repo_path'"
xhub::refresh_catalog [xhub::get_xstores xilinx_board_store]
set_param board.repoPaths "$repo_path"
xhub::install [xhub::get_xitems digilentinc.com:xilinx_board_store:basys3:1.2]
puts "OK: Basys 3 board installed into $repo_path"