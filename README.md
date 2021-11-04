# Endless Runner

This project implements an endless runner game consisting of a player and an obstacle. The obstacle constantly moves towards the player with an increasing amount of speed while the player is able to dodge the obstacle by jumping. This game can either be played by a human or a bot. It was programmed entirely in RISC-V assembly. No compiler explorer or any other form of C code has been used.

## Authors

Frederik Esau (github username: frederikcpp)  
Mail: inf20092@lehre.dhbw-stuttgart.de or f.esau@gmx.de

## Demo Video

[![IMAGE ALT TEXT](http://img.youtube.com/vi/-h3eH4ubuno/0.jpg)](http://www.youtube.com/watch?v=-h3eH4ubuno "Video Title")

Replace -h3eH4ubuno in the this .md by your YT video

## Description

As mentioned before, this game is settled inside the endless runner genre. Therefore the goal is to achieve a score that is as high as possible while there is virtually no limit as to how high of a score is at most achievable. This means that you cannot *beat* the game, as it is infinite.  
When starting a game, you see a red rectangle on the left hand side of the 512x256 screen and a green rectangle on the right hand side (seek "How to Run" for more details on the screen size). In the following description and in the program code the red rectangle is refered to as the 'player' and the green rectangle is refered to as the 'cactus'.  
The cactus is the obstacle. It moves towards the player with an increasing amount of speed as the game moves on. If the cactus and the player overlap, i.e. they collide, the game is over. The player can jump by pressing 'spacebar' and thus prevent a collision. If a collision has been prevented and the cactus is at the left of the screen, it starts at the right side again, getting to its initial position and moving towards the player again. This is the inifite loop. Once the player loses, the achieved score is displayed in a new window.  
  
  
 <img width="582" alt="initial game screen" src="https://user-images.githubusercontent.com/83597198/140415346-06072ad8-75a1-4b34-8f34-77686dfbf2ff.png">

However, the game can also be played by a bot. The bot jumps automatically and, as it is intended, cannot lose, which means that the games are never ending until you stop the application.  
  
**Note:** There should be a practical limit to the game speed as it is 10ms per frame at its maximum peak. However, the drawing speed of the "Bitmap Display" tool is significantly higher than that, which limits the maximum game speed. Depending on how fast the bitmap display draws, the game speedup is either quite significant or barely noticable. If latter is the case, try restarting rars as it becomes slower the longer you use it.

**Note:** For more info about specific parts of the game consult the READMEs of the specific folders (lib, src and test)

### How to run

#### Play as a Human Player
1. Open and assemble the file "start_game.asm"
2. Open "Bitmap Display" from the tools section of rars
    1. Only supported settings that were tested: **Display width: 512px** and **Display height: 256px**
    2. Make sure that you hit the "Connect to Program" button
3. Open "Keyboard and Display MMIO Simulator"
    1. Make sure that you hit the "Connect to Program" button
    2. During the game: use the text input field in the lower half of the tool to make your keyboard input (**Jump: Spacebar**)  
  
  
<img width="529" alt="mmio input" align="center" src="https://user-images.githubusercontent.com/83597198/140415182-8ab5d1c6-6a03-407a-820c-7ef1952c1b89.png">  
  
4. Run the previously assembled file "start_game.asm

#### Let the Bot play for you
1. Open the file "start_game.asm"
2. In line 12 change "BOT_ACTIVE 0" to "BOT_ACTIVE 1"  
3. _... The next steps are as above for the human player. Note that you don't have to open the "Keyboard and Display MMIO Simulator", but if you choose to do it you can actually play yourself while the bot jumps for you if possible and if necesarry.
Also: To only play as a human player again, change "BOT_ACTIVE 1" back to "BOT_ACTIVE 0"._  

## Files
### [lib] Data/Constants Library Files
File                        | Description
----------------------------|----------------
cesplib_rars.asm            | Copied from lecture content; Used for draw_pixel.asm and draw_rectangle.asm
lib_game_constants.asm      | Constants that define parts of the overall game (e.g. game speed, window width/height) --> some values can be changed by the user if desired, some should **not** be changed; Whether a value is fixed or not is marked inside the file
lib_start_game.asm          | Holds the contents of all libraries which are necessary for *scr/start_game.asm* (*lib_game_constants.asm* and lib_userinput.asm)
lib_userinput.asm           | Necesarry memory addresses for MMIO
lib_utest_strings.asm       | Strings used for the console prints of the unit tests

### [src] Logic Implementation
File                        | Description
----------------------------|----------------
bot.asm                     | In this file the bot logic is implemented, meaning the decision making, whether the bot wants to jump or not in a given situation
collision_handling.asm      | Identifies whether the current positions of player and cactus result in a collision
draw_pixel.asm              | Copied from lecture content; Draw a pixel on the display
draw_rectangle.asm          | Copied from lecture content; Draw a rectangle, using draw_pixel.asm
read_userinput.asm          | Read the MMIO Keyboard registers and identify whether a keyboard input was made and whether the input was a valid input (*spacebar*) or not
start_game.asm              | The main game. Here player and cactus are drawn, actions are executed according to user input and the increasing game speed aswell as the score are implemented

### [test] Unit Tests
File                          | Description
------------------------------|----------------
utest_collision_handling .asm | 5 test cases which determine whether collision_handling.asm gives correct output in various situations
utest_readuserinput.asm       | 4 test cases which determine whether user input is read and returned accordingly

## Test
Collision Handling (utest_collision_handling.asm)  
<img width="600" alt="collision_handling_utest" src="https://user-images.githubusercontent.com/83597198/140412573-3c5dd7b3-2198-4790-878a-45f4de05a91c.png">
  
User Input (utest_read_userinput.asm)  
<img width="543" alt="read_userinput_utest" src="https://user-images.githubusercontent.com/83597198/140412669-464a0402-12d2-44db-a6d7-5284dce6c174.png">

