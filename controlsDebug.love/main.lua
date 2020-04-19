function love.load()
    screenDimX = 1920;
    screenDimY = 1200;
    love.window.setTitle("Debugger");
    love.window.setMode(screenDimX, screenDimY)
    pressedKey = "none";
    gamePadjoystick = "none";
    gamePadButton = "none";
end

function love.keypressed(key)
    pressedKey = key;
end

function love.joystickpressed(joystick, button)
    gamePadButton = button;
    gamePadjoystick = joystick;
 end

function love.update(dt)
    
    
end

function love.draw()
    love.graphics.setColor(.82, .57, 0);
    love.graphics.rectangle('fill', 0, 0, screenDimX, screenDimY);
    love.graphics.setColor(.36, 0, 0);
    love.graphics.print("key: "..pressedKey, screenDimX/2 - 1, screenDimY/2, 0, 5);
    love.graphics.print("stick: "..gamePadjoystick, screenDimX/2 - 1, screenDimY/3, 0, 5)
    love.graphics.print("button: "..gamePadButton, screenDimX/2 - 1, screenDimY/4, 0, 5)
end