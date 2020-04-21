Fighter = {}

function Fighter.new(name, x, y, keyMap, direction, screenDimX, regHeight, animations, player, screenDimX, joystickLeft, joystickRight, joystickUp, joystickDown)
    local f = {}
    f.name = name
    f.health = 100
    f.keyMap = keyMap
    f.direction = direction
    f.velY = 0
    f.x = x
    f.y = y
    f.width = 250
    f.height = 250
    f.hitboxX = f.width/2
    f.hitboxY = f.height/2
    f.screenDimX = screenDimX
    f.regHeight = regHeight
    f.walkRight = false;
    f.walkLeft = false;
    f.jumpUp = false;
    f.jumpFall = false;
    f.punch = false;
    f.punchCooldown = false
    f.onCooldown = 0;
    f.animations = animations
    f.punchCounter = 0;
    f.animationCounter = 0;
    f.player = player
    f.screenDimX = screenDimX
    f.displayHealthLoss = 0
    f.healthLost = 0
    f.collisionRight = false;
    f.collisionLeft = false;
    f.joystickLeft = joystickLeft
    f.joystickRight = joystickRight
    f.joystickUp = joystickUp
    f.joystickDown = joystickDown
    setmetatable(f, {__index = Fighter})
    return f
end



function Fighter:getState()
    return self.state
end

function Fighter:getCoord()
    return {x = self.x, y = self.y}
end

function Fighter:getHeight()
    return self.height
end

function Fighter:getWidth()
    return self.width
end

function Fighter:checkCollisionLeft(player2)
  if self.direction == 'right' then
      self.collisionLeft = false
  elseif player2.y - self.height/2 - self.y > 0 then
      self.collisionLeft = false
  elseif self.x - player2.x <= 25 and player2.x <= self.x then
      self.collisionLeft =  true
  else
      self.collisionleft = false
  end
end

function Fighter:checkCollisionRight(player2)
    if self.direction =='left' then
        self.collisionRight = false
    elseif player2.y - self.height/2 - self.y > 0 then
          self.collisionRight = false
    elseif player2.x - self.x <= 25 and player2.x >= self.x then
        self.collisionRight = true
    else
        self.collisionRight = false
    end
end

function Fighter:walkRightAction()
    --if not self.collisionRight then
        if self.x >= (self.screenDimX - self.width) then
            self.x = self.screenDimX - self.width
        elseif self.x < (self.screenDimX - self.width) then
            self.x = self.x + 10
        end
    --end
    self.direction = 'right'
end

function Fighter:walkLeftAction()
    --if not self.collisionLeft then
        if self.x <= 0 then
            self.x = 0
        elseif self.x > 0 then
            self.x = self.x - 10
        end
    --end
    self.direction = 'left'
end

function Fighter:loseHealth(player2)
    if player2.punchCounter == 0 then
        loss = math.random(5, 10)
        self.displayHealthLoss = 25
        self.healthLost = loss
        if self.health - loss < 0 then
            self.health = 0
        else
            self.health = self.health - loss
        end
    end
end

function Fighter:isDead()
    if self.health <= 0 then
        return true
    end
    return false
end

function Fighter:jumpUpAction()
    if self.velY > 0 then
        self.y = self.y - self.velY
        self.velY = self.velY - 1
    else
        self.jumpUp = false
        self.jumpFall = true
    end
end

function Fighter:jumpFallAction()
    if self.y >= self.regHeight then
        self.y = self.regHeight
        self.jumpFall = false
    else
        self.y = self.y - self.velY
        self.velY = self.velY - 1
    end
end


function Fighter:update(dt)
    -- if self.onCooldown > 0 then
    --     self.onCooldown = self.onCooldown - 1;
    -- end
    if self.displayHealthLoss > 0 then
        self.displayHealthLoss = self.displayHealthLoss - 1
    end
    if self.animationCounter > 20 then
        self.animationCounter = 0
    end
    if self.punchCounter == 0 then
        self.punch = false
    end
    if self.punchCounter > 0 then
        self.punchCounter = self.punchCounter - 1
    end
    if not love.keyboard.isDown(self.keyMap['right']) and not self.joystickRight then
        self.walkRight = false
    end
    if not love.keyboard.isDown(self.keyMap['left']) and not self.joystickLeft then
        self.walkLeft = false
    end
    if not love.keyboard.isDown(self.keyMap['left']) and not love.keyboard.isDown(self.keyMap['right']) and not self.joystickLeft and not self.joystickRight then
        self.animationCounter = 0
    end
    if love.keyboard.isDown(self.keyMap['right']) or self.joystickRight then
        self.walkRight = true;
        self.animationCounter = self.animationCounter + 1
    end
    if love.keyboard.isDown(self.keyMap['left']) or self.joystickLeft then
        self.walkLeft = true
        self.animationCounter = self.animationCounter + 1
    end
    if not self.jumpUp and not self.jumpFall and (love.keyboard.isDown(self.keyMap['up']) or self.joystickUp) then
        self.velY = 27
        self.y = self.y - 20
        self.jumpUp = true
    end
    if self.walkRight then
       self:walkRightAction()
    end
    if self.walkLeft then
        self:walkLeftAction()
    end
    if self.jumpUp then
        self:jumpUpAction()
    end
    if self.jumpFall then
        self:jumpFallAction()
    end

    self:animate(currentTime)
end

function Fighter:gamepadpressed(button)
    if button == 5 and self.punchCounter == 0 and not self.punch then
        self.punch = true
        self.punchCounter = 10;
    end
end

function Fighter:keypressed(key, unicode)
    if key == self.keyMap['punch'] and self.punchCounter == 0 and not self.punch then
        self.punch = true
        self.punchCounter = 10;
    end
end

function Fighter:animate(dt)
    if self.displayHealthLoss > 0 then
        love.graphics.print("-" .. self.healthLost, self.x + self.width/2, self.y - 110)
    end
    if self.player == 1 then
        scale = 0.19
        moveLeft = 140
        moveUp = 70
        if self.punch then
            if self.direction == "right" then
                love.graphics.draw(self.animations.punchright, self.x-moveLeft, self.y - moveUp, 0, scale, scale)
            else
                love.graphics.draw(self.animations.punchleft, self.x-moveLeft, self.y - moveUp, 0, scale, scale)
            end
        elseif self.walkRight and not self.jumpUp and not self.jumpFall then
            if self.animationCounter < 10 then
                love.graphics.draw(self.animations.stance1right, self.x-moveLeft, self.y - moveUp, 0, scale, scale)
            else
                love.graphics.draw(self.animations.stance2right, self.x-moveLeft, self.y - moveUp, 0, scale, scale)
            end
        elseif self.walkLeft and not self.jumpUp and not self.jumpFall then
            if self.animationCounter < 10 then
                love.graphics.draw(self.animations.stance2left, self.x-moveLeft, self.y - moveUp, 0, scale, scale)
            else
                love.graphics.draw(self.animations.stance1left, self.x-moveLeft, self.y - moveUp, 0, scale, scale)
            end
        else
            if self.direction == "right" then
                love.graphics.draw(self.animations.stance1right, self.x-moveLeft, self.y - moveUp, 0, scale, scale)
            else
                love.graphics.draw(self.animations.stance2left, self.x-moveLeft, self.y - moveUp, 0, scale, scale)
            end
        end
    else
        moveUp = 80
        moveLeft = 200
        scale = 0.17
        if self.punch then
            if self.direction == "right" then
                love.graphics.draw(self.animations.punchright, self.x-moveLeft, self.y-moveUp, 0, scale, scale)
            else
                love.graphics.draw(self.animations.punchleft, self.x-moveLeft, self.y-moveUp, 0, scale, scale)
            end
        elseif self.walkRight and not self.jumpUp and not self.jumpFall  then
            if self.animationCounter < 10 then
                love.graphics.draw(self.animations.stance1right, self.x-moveLeft, self.y-moveUp, 0, scale, scale)
            else
                love.graphics.draw(self.animations.stance2right, self.x-moveLeft, self.y-moveUp, 0, scale, scale)
            end
        elseif self.walkLeft and not self.jumpUp and not self.jumpFall then
            if self.animationCounter < 10 then
                love.graphics.draw(self.animations.stance2left, self.x-moveLeft, self.y-moveUp, 0, scale, scale)
            else
                love.graphics.draw(self.animations.stance1left, self.x-moveLeft, self.y-moveUp, 0, scale, scale)
            end
        else
            if self.direction == "right" then
                love.graphics.draw(self.animations.stance1right, self.x-moveLeft, self.y-moveUp, 0, scale, scale)
            else
                love.graphics.draw(self.animations.stance1left, self.x-moveLeft, self.y-moveUp, 0, scale, scale)
            end
        end
    end
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
