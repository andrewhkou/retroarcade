screenDimX = 725
screenDimY = 625
block = 25
vel = block/10
timeElapsed = 0
lives = 3
score = 0
highScore = 0
totalDots = 0
dotsEaten = 0
scared = false
scaredStart = 0
gameStart = nil
iteration = 0
dead = false
deathTime = 0
startX = screenDimX / 2 - block / 2
startY = block * 16

require("walls") -- import walls
require("dots") -- import dots

dir = {
	up = "w",
	left = "a",
	down = "s",
	right = "d",
	up2 = "up",
	left2 = "left",
	down2 = "down",
	right2 = "right"
}

l = love.graphics.newImage("images/8bit_left.jpg")
r = love.graphics.newImage("images/8bit_right.jpg")
u = love.graphics.newImage("images/8bit_up.jpg")
d = love.graphics.newImage("images/8bit_down.jpg")
scaredPic = love.graphics.newImage("images/scaredGhost.jpg")
scaredPicWhite = love.graphics.newImage("images/whiteGHost.jpg") -- flashing ghost when timer is about to end

require("reset")

pacman = {
	sprite = r,
	x = startX,
	y = startY,
	xvel = 0,
	yvel = 0,
	prevXvel = 0,
	prevYvel = 0,
	angle = 0
}

redGhost = {
	sprite = love.graphics.newImage("images/redGhost.png"),
	x = bgate.x,
	y = bgate.y + block,
	xvel = 0,
	yvel = 0,
	width = 25,
	height = 25,
	prevDir = nil,
	moveIteration = 0,
	startPic = love.graphics.newImage("images/redGhost.png")
}

greenGhost = {
	sprite = love.graphics.newImage("images/greenGhost.png"),
	x = redGhost.x,
	y = redGhost.y + block,
	xvel = 0,
	yvel = 0,
	width = 25,
	height = 25,
	prevDir = nil,
	moveIteration = 0,
	startPic = love.graphics.newImage("images/greenGhost.png")
}

yellowGhost = {
	sprite = love.graphics.newImage("images/yellowGhost.png"),
	x = redGhost.x + block,
	y = redGhost.y,
	xvel = 0,
	yvel = 0,
	width = 25,
	height = 25,
	prevDir = nil,
	moveIteration = 0,
	startPic = love.graphics.newImage("images/yellowGhost.png")
}

pinkGhost = {
	sprite = love.graphics.newImage("images/pinkGhost.png"),
	x = redGhost.x + block,
	y = redGhost.y + block,
	xvel = 0,
	yvel = 0,
	width = 25,
	height = 25,
	prevDir = nil,
	moveIteration = 0,
	startPic = love.graphics.newImage("images/pinkGhost.png")
}
ghosts = {redGhost, greenGhost, yellowGhost, pinkGhost}

allDots = {}

function intToIndex(x, y)
	return tostring(x) .. "," .. tostring(y)
end

function drawScared(image, ratio)
	love.graphics.draw(image, redGhost.x, redGhost.y, 0, ratio, ratio)
	love.graphics.draw(image, greenGhost.x, greenGhost.y, ratio, ratio)
	love.graphics.draw(image, yellowGhost.x, yellowGhost.y, 0, ratio, ratio)
	love.graphics.draw(image, pinkGhost.x, pinkGhost.y, 0, ratio, ratio)
end

function drawGhosts()
	time = os.time()
	if scared and time - scaredStart <= 10 then 
		if time  - scaredStart > 5 then -- ghosts flash blue/white when power up timer is ending
			if time % 2 == 0 then
				drawScared(scaredPic, 25/320)
			else
				drawScared(scaredPicWhite, 25/600)
			end
		else
			drawScared(scaredPic, 25/320)
		end
	else
		scared = false
		love.graphics.draw(redGhost.sprite, redGhost.x, redGhost.y, 0, 25/360, 25/360)
		love.graphics.draw(greenGhost.sprite, greenGhost.x, greenGhost.y, 25/360, 25/360)
		love.graphics.draw(yellowGhost.sprite, yellowGhost.x, yellowGhost.y, 0, 25/360, 25/360)
		love.graphics.draw(pinkGhost.sprite, pinkGhost.x, pinkGhost.y, 0, 25/360, 25/360)
	end
end

function addDot(r, c, super) -- adds normal dot or super dot
	totalDots = totalDots + 1
	x = block * (c - 1)
	y = block * (r - 1)
	circle = {
			x = x + block / 2,
			y = y + block / 2,
			radius = 2.5
		}
	if super then circle["radius"] = 6 end
	allDots[intToIndex(x + block/2, y + block/2)] = circle
end

function initialDotAdd() -- add all dots into allDots array
	for row = 1, 22, 1 do
		for col = 1, screenDimX / block, 1 do
			if dots[row][col] ~= 0 then addDot(row, col, dots[row][col] == 2) end
		end
	end
end

function updateScore(super)
	if super then 
		score = score + 100
	else 
		score = score + 10
	end
	dotsEaten = dotsEaten + 1
	if score > highScore then
		highScore = score
	end
end

function superDot() -- when power up is eaten 
	scared = true
	scaredStart = os.time()
end

function eatDot() -- checks collision with dots and "eats" the dots
	edges = {
		center = {pacman.x + block/2, pacman.y + block/2},
		topmid = {pacman.x + block/2, pacman.y},
		botmid = {pacman.x + block/2, pacman.y + block},
		leftmid = {pacman.x, pacman.y + block/2},
		rightmid = {pacman.x + block, pacman.y + block/2}
	}
	for _, dot in pairs(allDots) do
		centerx = dot.x
		centery = dot.y
		super = dot.radius == 6
		for _, edge in pairs(edges) do
			if edge[1] == centerx and edge[2] == centery then
				if super then superDot() end
				allDots[intToIndex(centerx, centery)] = nil
				updateScore(super)
				break
			end
		end
	end
end

function wallOverlap(corner, rect) -- helper for noCollision
	x = corner[1]
	y = corner[2]
	topLX = rect.x
	topLY = rect.y
	botRX = rect.x + rect.width
	botRY = rect.y + rect.height
	if x > topLX and x < botRX and y > topLY and y < botRY then
		return true
	end
	return false
end

function noCollision(nextx, nexty) -- checks collision with walls
	corners = {
		topL = {nextx, nexty}, 
		topR = {nextx + block, nexty}, 
		botL = {nextx, nexty + block}, 
		botR = {nextx + block, nexty + block},
		topmid = {nextx + block/2, nexty},
		botmid = {nextx + block/2, nexty + block},
		leftmid = {nextx, nexty + block/2},
		rightmid = {nextx + block, nexty + block/2}
	}
	for _, rect in pairs(rectangles) do
		for _, corner in pairs(corners) do
			if wallOverlap(corner, rect) then return false end
		end
	end
	return true
end

function sideScreenTeleport() -- teleports pacman from opposite horizontal sides
	if pacman.x == -block and pacman.y == block * 10 then
		pacman.x = screenDimX - block
	end
	if pacman.x == screenDimX and pacman.y == block * 10 then
		pacman.x = -block/2
	end
end

-- Will not allow pacman to stop movement and face a wall
-- Only allows movement where there is open space
function wallCollisionUpdate(noCollide, dir)
	if noCollide then 
		pacman.sprite = dir
		pacman.prevXvel = pacman.xvel
		pacman.prevYvel = pacman.yvel
	else 
		pacman.xvel = pacman.prevXvel
		pacman.yvel = pacman.prevYvel
	end
end

function winChecker()
	if dotsEaten == totalDots then
		love.graphics.setNewFont("coolfont.ttf", 50)
		love.graphics.print("You Win!", screenDimX / 2 - 5 * block, screenDimY / 2 - 2 * block)
		love.graphics.setNewFont("coolfont.ttf", 22)
	end
end

function updatePacman()
	if noCollision(pacman.x + pacman.xvel, pacman.y + pacman.yvel) then
			if dead then 
				pacman.xvel = 0
				pacman.yvel = 0
			end
			pacman.x = pacman.x + pacman.xvel;
			pacman.y = pacman.y + pacman.yvel;
			sideScreenTeleport()
	end
	eatDot()
end

function randomMovement(ghost, time)
	if ghost.moveIteration % 100 == 0 then
		math.randomseed(time)
		directions = {
			top = noCollision(ghost.x, ghost.y - vel),
			down = noCollision(ghost.x, ghost.y + vel),
			left = noCollision(ghost.x - vel, ghost.y),
			right = noCollision(ghost.x + vel, ghost.y)
		}
		openDirections = {}
		for dir, open in pairs(directions) do
			if open then table.insert(openDirections, dir) end
		end
		index = math.random(#openDirections)
		ghost.prevDir = openDirections[index]
	end
	if ghost.prevDir == "top" and noCollision(ghost.x, ghost.y - vel) then
		ghost.y = ghost.y - vel
	elseif ghost.prevDir == "down" and noCollision(ghost.x, ghost.y + vel) then
		ghost.y = ghost.y + vel
	elseif ghost.prevDir == "left" and noCollision(ghost.x - vel, ghost.y) then
		ghost.x = ghost.x - vel
	elseif ghost.prevDir == "right" and noCollision(ghost.x + vel, ghost.y) then
		ghost.x = ghost.x + vel
	end
	ghost.moveIteration = ghost.moveIteration + 1
end

function distanceToPacman(ghost)
	return math.sqrt((pacman.x - ghost.x)^2 + (pacman.y - ghost.y)^2)
end

function nearGhost(ghost)
	return (ghost.x == pacman.x or ghost.y == pacman.y) and distanceToPacman(ghost) <= 10 * block
end

function ghostChase(ghost) -- if pacman is near ghost and in same hallway then ghost will chase pacman
	if ghost.x == pacman.x then
		if ghost.y > pacman.y and noCollision(ghost.x, ghost.y - vel) then
			ghost.y = ghost.y - vel
		elseif noCollision(ghost.x, ghost.y + vel) then
			ghost.y = ghost.y + vel
		end
	elseif ghost.y == pacman.y then
		if ghost.x > pacman.x and noCollision(ghost.x - vel, ghost.y) then
			ghost.x = ghost.x - vel
		elseif noCollision(ghost.x + vel, ghost.y) then
			ghost.x = ghost.x + vel
		end
	end
end

function updateGhosts() -- initial ghost movement outside of the box and then random movement
	if dead then return end
	if os.time() - gameStart > 1 and iteration < 20 then
		redGhost.yvel = -vel
		redGhost.y = redGhost.y + redGhost.yvel
		iteration = iteration + 1
	elseif os.time() - gameStart > 3 and iteration < 40 then
		yellowGhost.yvel = -vel
		yellowGhost.y = yellowGhost.y + yellowGhost.yvel
		iteration = iteration + 1
	elseif os.time() - gameStart > 6 and iteration < 70 then
		greenGhost.yvel = -vel
		greenGhost.y = greenGhost.y + greenGhost.yvel
		iteration = iteration + 1
	elseif os.time() - gameStart > 9 and iteration < 100 then
		pinkGhost.yvel = -vel
		pinkGhost.y = pinkGhost.y + pinkGhost.yvel
		iteration = iteration + 1		
	end
	if iteration >= 20 then
		if nearGhost(redGhost) then ghostChase(redGhost) else randomMovement(redGhost, os.clock() * 100000) end
	end
	if iteration >= 40 then 
		if nearGhost(yellowGhost) then ghostChase(yellowGhost) else randomMovement(yellowGhost, os.clock() * 100000) end
	end
	if iteration >= 70 then 
		if nearGhost(greenGhost) then ghostChase(greenGhost) else randomMovement(greenGhost, os.clock() * 100000) end
	end
	if iteration >= 100 then 
		if nearGhost(pinkGhost) then ghostChase(pinkGhost) else randomMovement(pinkGhost, os.clock() * 100000) end
	end
end

function deathChecker()
	center = {pacman.x + block/2, pacman.y + block/2}
	for i = 1, 4, 1 do
		ghost = ghosts[i]
		if wallOverlap(center, ghost) and not dead then
			if scared then
				score = score + 200
				ghost.x = bgate.x
				ghost.y = bgate.y - block
				ghost.sprite = ghost.startPic
			else
				dead = true 
				lives = lives - 1
				deathTime = os.time()
			end
		end
	end
end

function drawDead()
	timeSinceDead = os.time() - deathTime
	if dead and timeSinceDead <= 2 then
		text = "You Died!"
		if lives == 0 then text = "You Lose!" end
		love.graphics.setNewFont("coolfont.ttf", 50)
		love.graphics.print(text, screenDimX / 2 - 5 * block, screenDimY / 2 - 2 * block)
		love.graphics.setNewFont("coolfont.ttf", 22)
	elseif dead then
		gameStart = os.time()
		dead = false
		pacman.x = startX
		pacman.y = startY
		iteration = 0
		deathTime = 0
		restart()
	end
end

function love.load()
    love.window.setTitle("Pacman")
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont("coolfont.ttf", 22)
    initialDotAdd()
    gameStart = os.time()
end

function love.update(dt)
	timeElapsed = timeElapsed + dt
	if timeElapsed > 0.01 then
		timeElapsed = 0
		if love.keyboard.isDown(dir.up) or love.keyboard.isDown(dir.up2) then
			pacman.xvel = 0
			pacman.yvel = -vel
			noCollide = noCollision(pacman.x + pacman.xvel, pacman.y + pacman.yvel)
			wallCollisionUpdate(noCollide, u)
		end
		if love.keyboard.isDown(dir.left) or love.keyboard.isDown(dir.left2) then
			pacman.yvel = 0
			pacman.xvel = -vel
			noCollide = noCollision(pacman.x + pacman.xvel, pacman.y + pacman.yvel)
			wallCollisionUpdate(noCollide, l)
		end
		if love.keyboard.isDown(dir.right) or love.keyboard.isDown(dir.right2) then
			pacman.yvel = 0
			pacman.xvel = vel
			noCollide = noCollision(pacman.x + pacman.xvel, pacman.y + pacman.yvel)
			wallCollisionUpdate(noCollide, r)
		end
		if love.keyboard.isDown(dir.down) or love.keyboard.isDown(dir.down2) then
			pacman.xvel = 0
			pacman.yvel = vel
			noCollide = noCollision(pacman.x + pacman.xvel, pacman.y + pacman.yvel)
			wallCollisionUpdate(noCollide, d)
		end
		updatePacman()
		updateGhosts()
		deathChecker()
	end
end

function love.draw()
	love.graphics.setColor(247, 255, 0) -- draw pacman
	love.graphics.draw(pacman.sprite, pacman.x, pacman.y, pacman.angle, 25/360, 25/360)

	for i = 1, lives, 1 do -- draw lives on the bottom left
		love.graphics.draw(r, 65 * (i - 1) + 25, screenDimY - block * 2.5, 0, 50/360, 50/360)
	end

	for item, v in pairs(rectangles) do -- draw walls
		love.graphics.setColor(0, 0, 255)
		if item == "bgate" then love.graphics.setColor(169,169,169) end
		love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
	end

	love.graphics.setColor(255, 255, 255) 
	for _, circle in pairs(allDots) do -- draw dots
		love.graphics.circle('fill', circle.x, circle.y, circle.radius)
	end

	-- draw ghosts
	drawGhosts()

	-- draw score
	love.graphics.setColor(255, 0, 0) 
	love.graphics.print("GAME SCORE", (screenDimX / 2) - 4 * block - 5, screenDimY - block * 2.75)
	love.graphics.print(tostring(score), (screenDimX / 2) - block - 3, screenDimY - block * 1.5)
	love.graphics.print("HIGH SCORE", screenDimX - 9 * block, screenDimY - block * 2.75)
	love.graphics.print(tostring(highScore), screenDimX - 6 * block, screenDimY - block * 1.5)

	winChecker()
	drawDead()
end
