##
# THE BOT LOGIC
# 
# -- this file is used when start_game needs to decide at a given moment, whether the bot wants to jump or not.
# -- the bot makes simulated keyboard input based on its decision
# -- the bot should not be able to lose -> infinite game
##

bot_input:
	sw t0, 0(sp)
	sw t1, -4(sp)
	sw t2, -8(sp)
	sw s0, -12(sp)
	sw s1, -16(sp)
	li t0, 65 			# at which maximum x value of cactus to jump
	ble a0, t0, jump	# if x value of cactus reaches/subceeds the value
	bot_continue:
	lw t0, 0(sp)
	lw t1, -4(sp)
	lw t2, -8(sp)
	lw s0, -12(sp)
	lw s1, -16(sp)
	ret

jump:
	li s0, RECEIVER_DATA_REGISTER
	li t1, 0x20 # spacebar
	sw t1, 0(s0) # save spacebar in input register
	li s1, RECEIVER_CONTROL_REGISTER
	li t2, 1
	sw t2, 0(s1) # tell read_input that a new input was made
	j bot_continue
