screenDimX = 725
screenDimY = 725
block = 25
vel = block/10
timeElapsed = 0
lives = 3

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

l = love.graphics.newImage("8bit_left.jpg")
r = love.graphics.newImage("8bit_right.jpg")
u = love.graphics.newImage("8bit_up.jpg")
d = love.graphics.newImage("8bit_down.jpg")

pacman = {
	sprite = r,
	x = 25,
	y = 25,
	xvel = 0,
	yvel = 0,
	prevXvel = 0,
	prevYvel = 0,
	angle = 0
}

allDots = {}

function intToIndex(x, y)
	return tostring(x) .. "," .. tostring(y)
end

function addDot(r, c)
	x = block * (c - 1)
	y = block * (r - 1)
	circle = {
		x = x + block / 2,
		y = y + block / 2,
		radius = 2.5
	}
	allDots[intToIndex(x + block/2, y + block/2)] = circle
end

function initialDotAdd()
	for row = 1, 29, 1 do
		for col = 1, 29, 1 do
			if dots[row][col] == 1 then addDot(row, col) end
		end
	end
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
		for _, edge in pairs(edges) do
			if edge[1] == centerx and edge[2] == centery then
				allDots[intToIndex(centerx, centery)] = nil
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

function updateDrawings()
	love.graphics.setColor(247, 255, 0) -- draw pacman
	love.graphics.draw(pacman.sprite, pacman.x, pacman.y, pacman.angle, 25/360, 25/360)

	for i = 1, lives, 1 do -- draw lives
		love.graphics.draw(r, 50 * (i - 1) + 15, screenDimY - 100, 0, 40/360, 40/360)
	end

	love.graphics.setColor(0, 0, 255)
	for _, v in pairs(rectangles) do -- draw walls
		love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
	end

	love.graphics.setColor(255, 255, 255) 
	for _, circle in pairs(allDots) do -- draw dots
		love.graphics.circle('fill', circle.x, circle.y, circle.radius)
	end
end

function love.load()
    love.window.setTitle("Pacman")
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
    initialDotAdd()
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

		if noCollision(pacman.x + pacman.xvel, pacman.y + pacman.yvel) then
			pacman.x = pacman.x + pacman.xvel;
			pacman.y = pacman.y + pacman.yvel;
			sideScreenTeleport()
		end
		eatDot()
	end
end

function love.draw()
	love.graphics.print(tostring(pacman.x), 500, 600)
	love.graphics.print(tostring(pacman.y), 620, 600)
	updateDrawings()
end
