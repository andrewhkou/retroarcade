function love.load()
    screenDimX = 1920;
    screenDimY = 1200;
    love.window.setTitle("Debugger");
    love.window.setMode(screenDimX, screenDimY)
    pressedKey = "none";
    gamePadjoystick1x = "none";
    gamePadjoystick1y = "none";
    gamePadButton = "none";
end

function love.keypressed(key)
    pressedKey = key;
end

function love.joystickpressed(joystick, button)
    gamePadButton = button;
    gamePadjoystick1x = love.joystick.getJoysticks()[1].getAxis(love.joystick.getJoysticks()[1], 1);
    gamePadjoystick1y = love.joystick.getJoysticks()[1].getAxis(love.joystick.getJoysticks()[1], 2);
end

function love.update(dt)
    if (love.joystick.gamepadpressed(love.joystick.getJoysticks()[1], 14)) then
        love.event.push("quit");
    end
end

function love.draw()
    love.graphics.setColor(.82, .57, 0);
    love.graphics.rectangle('fill', 0, 0, screenDimX, screenDimY);
    love.graphics.setColor(.36, 0, 0);
    love.graphics.print("keyboard: "..pressedKey, screenDimX/4 - 1, screenDimY/2, 0, 5);
    love.graphics.print("gamePadjoystick1 x axis: "..gamePadjoystick1x, screenDimX/4 - 1, screenDimY/3, 0, 5)
    love.graphics.print("gamePadjoystick1 y axis: "..gamePadjoystick1y, screenDimX/4 - 1, screenDimY/3 +100, 0, 5)
    love.graphics.print("gamePadButton: "..gamePadButton, screenDimX/2 - 1, screenDimY/4 - 1, 0, 5)
end