# Endless Runner

This project implements an endless runner game consisting of a player and an obstacle. The obstacle constantly moves towards the player with an increasing amount of speed while the player is able to dodge the obstacle by jumping. This game can either be played by a human or by a bot. It was programmed entirely in RISC-V assembly. No compiler explorer or any other form of C code has been used.

## Authors

Frederik Esau (github username: frederikcpp)  
Mail: inf20092@lehre.dhbw-stuttgart.de or f.esau@gmx.de

## Demo Video

[![IMAGE ALT TEXT](http://img.youtube.com/vi/-h3eH4ubuno/0.jpg)](http://www.youtube.com/watch?v=-h3eH4ubuno "Video Title")

Replace -h3eH4ubuno in the this .md by your YT video

## Description

As mentioned before, this game is settled inside the endless runner genre. Therefore The goal is to achieve a score that is as high as possible while there is virtually no limit as to how high of a score is at most achievable. This means that you cannot *beat* the game, as it is infinite.  
When starting a game, you see a red rectangle on the left hand side of the 512x256 screen (seek "How to run" for more details) and a green rectangle on the right hand side. In the following description and in the program code the red rectangle is refered to as the 'player' and the green rectangle is refered to as the 'cactus'.  
The cactus is the obstacle. It moves towards the player with an increasing amount of speed as the game moves on. If the cactus and the player overlap, i.e. they collide, the game is over. The player can jump by pressing 'spacebar' and thus prevent a collision. If a collision has been prevented and the cactus is at the left of the screen, it starts at the right side again, getting to its initial position and moving towards the player again. This is the inifite loop.  

**Put this somewhere at the mid/end section** There should be a practical limit, as the game speed is 10ms per frame at it's maximum peak. However, the drawing speed of the "Bitmap Display" tool is significantly higher than that, which limits the maximum game speed.

### How to run

#### Play as a Human Player
1. Open and assemble the file "start_game.asm"
2. Open "Bitmap Display" from the tools section of rars
    1. Only supported settings that were tested: **Display width: 512px** and **Display height: 256px**
    2. Make sure that you hit the "Connect to Program" button
3. Open "Keyboard and Display MMIO Simulator"
    1. Make sure that you hit the "Connect to Program" button
    2. During the game: use the text input field in the lower half of the tool to make your keyboard input (**Jump: Spacebar**)
4. Run the previously assembled file "start_game.asm"

#### Let the Bot play for you
1. Open the file "start_game.asm"
2. In line 12 change "BOT_ACTIVE 0" to "BOT_ACTIVE 1"  
3. _... The next steps are as above for the human player. Note that you don't have to open the "Keyboard and Display MMIO Simulator", but if you choose to do it you can actually play yourself while the bot jumps for you if possible and if necesarry.
Also: To only play as a human player again, change "BOT_ACTIVE 1" back to "BOT_ACTIVE 0"._

## Files
Describe the content of each file of your application: e.g.

### Data/Constants Library Files
lib/lib_game_constants.asm      # Constants that define parts of the overall game (e.g. game speed, window width/height) --> some values can be changed by the user if desired,                                     some should NOT be changed; Whether a value is fixed or not is marked inside the file

### Unit Tests
test/utest_collision_handling.asm

src/main.c   # Main file of program

src/main.asm # compiled version of main.c for RV32IM

src/featureA.asm # A specific feature called in main

test/test1.asm - test9.asm # 9 unit tests for featureA


## Test
#### Collision Handling (collision_handling.asm) ####
<img width="363" alt="collision_handling_utest" src="https://user-images.githubusercontent.com/83597198/140101910-ca9ce438-2e4c-4105-a3eb-954f54a9719a.png"><img width="272" alt="read_userinput_utest" src="https://user-images.githubusercontent.com/83597198/140232305-daae9d3e-48f8-455f-9987-1cb22747508f.png">

