##
# This file contains two memory addresses which are related to the identification of MMIO keybaord input
##

.eqv RECEIVER_DATA_REGISTER 0xffff0004 # dont change this; the register where the most 
													# previous keyboard input is written to in ascii format
													
.eqv RECEIVER_CONTROL_REGISTER 0xffff0000 # dont change this; is 1 if new data that hasnt been read via lw is inside the register
