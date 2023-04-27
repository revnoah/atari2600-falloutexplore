
 rem ** Fallout Explore
 rem ** by Noah J Stewart

 set kernel_options no_blank_lines

 scorecolor=$C8

 COLUP0=$C8
 COLUP1=$C8
 COLUBK=$D0
 COLUPF=$C8
 NUSIZ0=$10
 CTRLPF=$15
 AUDV0=0

 dim frame=1
 dim direction=b
 dim exploring=0
 dim itemCount=0
 dim foundItem=0
 dim soundPlaying=0
 dim ballSpeed=1

 const minPlayer0y = 40
 const maxPlayer0y = 70
 const minBallX = 20
 const maxBallX = 120
 const minBallY = 40
 const maxBallY = 80
 dim ballCounter = 0
 dim playerAnimation = 0

 player0x=90:player0y=60
 score=0
 ballx=minBallX:bally=40:ballheight=4


  playfield:
  .......................XXXXXXX.
  ..XXX..XXX..XXX.......XXXXXXXXX
  .XXXXXXXXXXXXXXXXXXXXXXX.XX.XXX
  .X...................XXXXXXXXXXX
  X.....................XXXXXXXXXX
  X.....................XXXXXXXXX
  X.....................XXXXXXXXXX
  X.....................XXXXXXXXXX
  XX...................XXXXXXXXXX
  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  .XXXXXXXXXXXXXXXXXXXXXXXXXXXXX.
end

 rem vault dweller
 player0:
 %00000000
 %01000001
 %01000001
 %00100010
 %00011100
 %00001000
 %00001001
 %00001010
 %01111100
 %00000100
 %00001100
 %00011110
 %00011110
 %00011110
 %00001100
 %00000000
end

 rem ** position the other objects, to prove we still can
 rem player1x=-30:player1y=40
 rem missile1x=100:missile1y=40:missile1height=6

mainloop

  if joy0up && player0y > minPlayer0y then gosub movePlayerUp
  if joy0down && player0y < maxPlayer0y then gosub movePlayerDown

  if collision(ball, player0) then gosub hitBall

  rem if playerAnimation = 1 then animatePlayer2:playerAnimation = 0 else animatePlayer1

  if ballx > maxBallX then gosub positionBall else ballx = ballx + ballSpeed
  if bally < minBallY || bally > maxBallY then gosub positionBall

  rem if frame > 100 then gosub animatePlayer1 else gosub animatePlayer2

  frame = frame + 1
  if frame = 30 then gosub animatePlayer2
  if frame = 60 then gosub animatePlayer1:frame=1

  if soundPlaying > 1 && (soundPlaying + 5) < frame then AUDV0=0

  drawscreen

  goto mainloop

end
  return


movePlayerUp
  player0y = player0y - 1
  
  return

movePlayerDown
  player0y = player0y + 1

  return

hitBall
  score = score + 10
  bally = -10
  ballx = minBallX
  itemCount = itemCount + 1
  soundPlaying=frame
  AUDC0=8
  AUDF0=15
  rem AUDV0=3

  return

positionBall
  ballx = minBallX
  bally = (rand&31) + 35

  return

activateMonster
  player1x=minBallX:player1y=player0y
  AUDC1=2
  AUDF1=20
  rem AUDV1=3

  return

animatePlayer1
  player0:
  %00000000
  %01000001
  %01000001
  %00100010
  %00011100
  %00001000
  %00001001
  %00001010
  %01111100
  %00000100
  %00001100
  %00011110
  %00011110
  %00011110
  %00001100
  %00000000
end

  rem frame = 1

  return

animatePlayer2
  player0:
  %11000000
  %01000011
  %01000001
  %00100010
  %00011100
  %00001000
  %01001000
  %00101001
  %00011111
  %00000100
  %00001100
  %00011110
  %00011110
  %00011110
  %00001100
  %00000000
end

  rem frame = 2

  return
