function love.load()
  screenDimX = 1280;
  screenDimY = 720;
  blockSize = 20;
  mainMenu = true;
  gameOver = false;
  twoPlayer = false;
  singlePlayer = false;

  love.window.setTitle("Pong");
  love.window.setMode(screenDimX, screenDimY)

  function mainMenuOptions()
      if (love.keyboard.isDown(1)) then
          mainMenu = false;
          singlePlayer = true;
      elseif (love.keyboard.isDown(2)) then
          mainMenu = false;
          twoPlayer = true;
      end
  end
end
