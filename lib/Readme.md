## lib: The Data Libraries ##

These are the files where the src and the test folder draw their constants (e.g. strings or memory addresses) from.  

Some constants in game_constants.asm can be changed.  
- **READ_INPUT_RATE** controls the interval in which new user input is retrieved.  
- **DEFAULT_READ_INPUT_CYCLE_MULTIPLICATOR** determines the game speed indirectly as this value is multipled by *READ_INPUT_RATE*
- **NUMBER_OF_CYCLES_IN_THE_AIR** how many read input cycles until the player falls back to the ground when being in the air.
