# src: The Main Code #

These are the files where the actual implementation of different parts of the game is made. The game speed is calculated by multiplying a factor with the input reading rate (10ms per default). The factor becomes smaller each time the cactus moves, thus increasing the game speed. The input reading rate can be changed, aswell as the factor. Consult lib/lib_game_constants.asm if you want to change the values.
  
In the diagram you can see how some of the files work together. It all starts with start_game.asm which is the main file of the game.  
Note that the bot simulates actual keyboard input. For it the diagram stays the same, except that now inputs that are read are done artificially by the bot.


![Untitled Diagram drawio (1)](https://user-images.githubusercontent.com/83597198/140538140-7dd46c80-2419-476f-932f-e253671ff9ff.png)
