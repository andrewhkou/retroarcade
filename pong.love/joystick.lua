joysticks = love.joystick.getJoysticks();
joystick1 = joysticks[1];
joystick2 = joysticks[2];

up1 = "w";
right1 = "d";
down1 = "s";
left1 = "a";
up2 = "up";
right2 = "right";
down2 = "down";
left2 = "left";
enter = "return"
enterButton = 4;
startButton = 1;

function joystick1Up()
    if ((not onComputer) and joystick1.getAxis(joystick1, 2) < - 0.5) then
        return true;
    end
    return false;
end

function joystick1Down()
    if ((not onComputer) and joystick1.getAxis(joystick1, 2) > 0.5) then
        return true;
    end
    return false;
end

function joystick1Left()
    if ((not onComputer) and joystick1.getAxis(joystick1, 1) < -0.5) then
        return true;
    end
    return false;
end

function joystick1Right()
    if ((not onComputer) and joystick1.getAxis(joystick1, 1) > 0.5) then
        return true;
    end
    return false;
end

function joystick2Up()
    if ((not onComputer) and joystick2.getAxis(joystick2, 2) < - 0.5) then
        return true;
    end
    return false;
end

function joystick2Down()
    if ((not onComputer) and joystick2.getAxis(joystick2, 2) > 0.5) then
        return true;
    end
    return false;
end

function joystick2Left()
    if ((not onComputer) and joystick2.getAxis(joystick2, 1) < -0.5) then
        return true;
    end
    return false;
end

function joystick2Right()
    if ((not onComputer) and joystick2.getAxis(joystick2, 1) > 0.5) then
        return true;
    end
    return false;
end

function player1up() 
    return love.keyboard.isDown(up1) or joystick1Up();
end

function player1down()
    return love.keyboard.isDown(down1) or joystick1Down();
end

function player1right()
    return love.keyboard.isDown(right1) or joystick1Right();
end

function player1left()
    return love.keyboard.isDown(left1) or joystick1Left();
end

function player2up() 
    return love.keyboard.isDown(up2) or joystick2Up();
end

function player2down()
    return love.keyboard.isDown(down2) or joystick2Down();
end

function player2right()
    return love.keyboard.isDown(right2) or joystick2Right();
end

function player2left()
    return love.keyboard.isDown(left2) or joystick2Left();
end

function enterPressed()
    return love.keyboard.isDown(enter) or 
    (not onComputer) and joystick1.isDown(joystick1, enterButton);
end

joysticks = {player1up, player1down, player1right, player1left, player2up, player2down,player2right,player2left,joystick1Up, joystick1Down, joystick1Left, joystick1Right, joystick2Up, joystick2Down, joystick2Left, joystick2Right}
