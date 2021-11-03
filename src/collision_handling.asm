##
# IDENTIFY COLLISIONS
##
# --- input ---
# a0: player x1
# a1: player x2
# a2: player y2
# a4: cactus x1
# a6: cactus x2
# a7: cactus y1
#
# --- output ---
# a0: collision? [y/n -> 1/0]
check_for_collision:

## --CASE 1:-- is x1 of cactus is bigger than or equal x1 of player and less than or equal x2 of player
	blt a4, a0, x2_condition # if cx1 < px1 [cx1: cactus x1; px1: player x1]
	ble a4, a1, y_condition

## --CASE 2:-- is x2 of cactus bigger than or equal x1 of player and less than x2 of player
x2_condition:
	blt a6, a0, no_collision # if cx2 < px1
	ble a6, a1, y_condition
	j no_collision

## -- Y CONDITION:-- is the player above the cactus?
y_condition:
	bge a2, a7, collision
	j no_collision

no_collision:
	li a0, 0
	j end

collision:
	li a0, 1
	j end

end:
	ret
