##
#	This file specifies some constants that are used in start_game.asm
##

.eqv DISPLAY_WIDTH 512				# dont change this
.eqv DISPLAY_HEIGHT 256				# dont change this
.eqv DISPLAY_ADDRESS 0x10010000  # dont change this

.eqv READ_INPUT_RATE 10				# can be changed; [-> interval in ms in which the input register is checked 
											# 		  for new input]
						
.eqv DEFAULT_READ_INPUT_CYCLE_MULTIPLICATOR 80	# can be changed; [-> (READ_INPUT_RATE * 'this value') = interval in ms in which
																#		  the cactus waits until it makes its next move] 
																#		  -->> aka default GAME SPEED
						
.eqv NUMBER_OF_CYCLES_IN_THE_AIR 1000		# can be changed; [-> when the player is in the air the time until he/she falls back down
														#		  is calculated by (READ_INPUT_RATE * 'this value']
