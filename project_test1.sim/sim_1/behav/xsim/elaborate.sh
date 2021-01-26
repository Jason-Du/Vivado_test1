#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Jan 26 14:54:42 CST 2021
# SW Build 3064766 on Wed Nov 18 09:12:47 MST 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto b712558a09f941108162c7781b1c4cad --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot clocked_led_behav xil_defaultlib.clocked_led -log elaborate.log"
xelab -wto b712558a09f941108162c7781b1c4cad --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot clocked_led_behav xil_defaultlib.clocked_led -log elaborate.log

