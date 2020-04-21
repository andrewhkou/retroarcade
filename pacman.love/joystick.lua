joysticks = love.joystick.getJoysticks();
joystick1 = joysticks[1];
joystick2 = joysticks[2];

startButton = 7;


function startPressed1()
    return (not onComputer) and joystick1.isDown(joystick1, startButton);
end

function startPressed2()
    return (not onComputer) and joystick2.isDown(joystick2, startButton);
end

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

joysticks = {joystick1Up, joystick1Down, joystick1Left, joystick1Right, joystick2Up, joystick2Down, joystick2Left, joystick2Right}
