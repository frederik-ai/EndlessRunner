##
# The main game; played by a BOT and/or a HUMAN PLAYER
#
# constantly saves and updates the x1-position of the cactus for "bot.asm"
# --> output register for cactus-x1: a0
#
# the obstacle is refered to as 'cactus' in the code of the game and thus in this file
##

.include "../lib/lib_start_game.asm"
.data
.eqv BOT_ACTIVE 0 # human_player[0] / bot[1]
score_display_message: .ascii "Your score is: \0" 

.text
# --- overview of some of the used registers --- #
li s5, 0 # game over = false
li t1, 0 # score
li t2, 0 # input cycles until new frame
li t3, DEFAULT_READ_INPUT_CYCLE_MULTIPLICATOR # curr input cycle multiplicator
li t5, BOT_ACTIVE
li s10, 0 # frames in the air left

#player
li a3, 10 # x1
li a4, 236 # y1
li a5, 30 # x2
li a6, 256 # y2
li a7, 0xFF5733 # color
jal draw_rectangle
add s2, zero, a3 # x1
add s4, zero, a5 # x2
add s3, zero, a6 # y2

# cactus
li a3, 500 # x1
li a4, 200 # y1
li a5, 512 # x2
li a6, 256 # y2
li a7, 0x13FC03 # color
jal draw_rectangle
# s6 - s9: curr cactus ccordinates
add s6, zero, a3
add s7, zero, a4
add s8, zero, a5
add s9, zero, a6
add a0, zero, a3 # for the bot

li t4, READ_INPUT_RATE
mul t2, t4, t3

read_input_loop:
	# read input
	bgt s10, zero, player_is_in_air #if player is currently in the air, skip input; just flush it
	bne t5, zero, read_bot_input # if bot is activated; then read whether bot wants to jump
	continue5:
	jal read_userinput
	bgt s11, zero, move_rectangle_up # if space bar was pressed
	continue:
	# sleep
	sw a0, 0(sp)
	li a0, READ_INPUT_RATE
	li a7, 32
	lw a0, 0(sp)

	bne t2, zero, decrement_t2
	continue4:
	beq t2, zero, next_frame
	continue2:
	beq zero, zero, read_input_loop

next_frame:
	addi t3, t3, -1 # game gets a bit faster
	li t4, READ_INPUT_RATE
	mul t2, t4, t3

	j move_cactus

	continue3:
	#check whether game over:
	sw a0, 0(sp)
	add a0, zero, s2
	add a1, zero, s4
	add a2, zero, s3
	add a4, zero, s6
	add a6, zero, s8
	add a7, zero, s7
	jal check_for_collision
	bne a0, zero, game_over # if collision: game over
	lw a0, 0(sp)
	addi t1, t1, 10 # increment score by 10
	j continue2

game_over:
	# print score in a message box
	li a7, 56
	la a0, score_display_message
	add a1, zero, t1
	ecall
	#terminate program
	li a7, 10
	ecall

move_rectangle_up:
	li s10, NUMBER_OF_CYCLES_IN_THE_AIR
	## remove old rectangle
	li a3, 10 # x1
	li a4, 236 # y1
	li a5, 30 # x2
	li a6, 256 # y2
	li a7, 0x0 # color
	jal draw_rectangle

	## rectangle up
	li a3, 10 # x1
	li a4, 136 # y1
	li a5, 30 # x2
	li a6, 156 # y2
	li a7, 0xFF5733 # color
	add s2, zero, a3 # x1
	add s4, zero, a5 # x2
	add s3, zero, a6 # y2
	jal draw_rectangle
	j continue

move_rectangle_down:
	## remove old rectangle
	li a3, 10 # x1
	li a4, 136 # y1
	li a5, 30 # x2
	li a6, 156 # y2
	li a7, 0x0 # color
	jal draw_rectangle

	## rectangle down
	li a3, 10 # x1
	li a4, 236 # y1
	li a5, 30 # x2
	li a6, 256 # y2
	li a7, 0xFF5733 # color
	add s2, zero, a3 # x1
	add s4, zero, a5 # x2
	add s3, zero, a6 # y2
	jal draw_rectangle
	j finish_player_is_in_air

move_cactus:
	# remove current cactus
	add a3, zero, s6
	add a4, zero, s7
	add a5, zero, s8
	add a6, zero, s9
	li a7, 0x0
	jal draw_rectangle
	#move cactus to the left
	ble s6, zero, reset_cactus_position
	addi s6, s6, -32
	addi s8, s8, -32
	continue_draw_new_cactus:
	add a3, zero, s6
	add a4, zero, s7
	add a5, zero, s8
	add a6, zero, s9
	li a7, 0x13FC03
	jal draw_rectangle
	add a0, zero, s6
	j continue3


player_is_in_air:
	addi s10, s10, -1 # one jump frame has been "used"
	jal flush_input_register_only
	li t0, 1
	beq s10, t0, move_rectangle_down
	finish_player_is_in_air:
	j continue

decrement_t2:
	addi t2, t2, -1
	j continue4

reset_cactus_position:
	li s6, 500
	li s8, 512
	j continue_draw_new_cactus

read_bot_input:
	jal bot_input
	nop
	j continue5

.include "draw_rectangle.asm"
.include "read_userinput.asm"
.include "collision_handling.asm"
.include "bot.asm"
