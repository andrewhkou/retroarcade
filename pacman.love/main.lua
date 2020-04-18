screenDimX = 725
screenDimY = 725
block = 25
vel = block/2
timeElapsed = 0

require("walls") -- import walls
require("dots") -- import dots

dir = {
	up = "w",
	left = "a",
	down = "s",
	right = "d"
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

for row = 1, 29, 1 do
	for col = 1, 29, 1 do
		if dots[row][col] == 1 then addDot(row, col) end
	end
end

function eatDot()
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

function overlap(corner, rect)
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

function noCollision(nextx, nexty)
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
			if overlap(corner, rect) then return false end
		end
	end
	return true
end

function love.load()
    love.window.setTitle("Pacman")
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
end

function love.update(dt)
	timeElapsed = timeElapsed + dt
	if timeElapsed > 0.1 then
		timeElapsed = 0
		if love.keyboard.isDown(dir.up) then
			pacman.xvel = 0
			pacman.yvel = -vel
			pacman.sprite = u
		end
		if love.keyboard.isDown(dir.left) then
			pacman.yvel = 0
			pacman.xvel = -vel
			pacman.sprite = l
		end
		if love.keyboard.isDown(dir.right) then
			pacman.yvel = 0
			pacman.xvel = vel
			pacman.sprite = r
		end
		if love.keyboard.isDown(dir.down) then
			pacman.xvel = 0
			pacman.yvel = vel
			pacman.sprite = d
		end

		if noCollision(pacman.x + pacman.xvel, pacman.y + pacman.yvel)
		then
			pacman.x = pacman.x + pacman.xvel;
			pacman.y = pacman.y + pacman.yvel;
		end
		eatDot()
	end
end

function love.draw()
	love.graphics.print(tostring(pacman.x), 500, 600)
	love.graphics.print(tostring(pacman.y), 620, 600)
	love.graphics.setColor(247, 255, 0) -- draw pacman
	love.graphics.draw(pacman.sprite, pacman.x, pacman.y, pacman.angle, 25/360, 25/360)
	love.graphics.setColor(0, 0, 255)
	for _, v in pairs(rectangles) do -- draw walls
		love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
	end
	love.graphics.setColor(255, 255, 255) -- draw dots
	for _, circle in pairs(allDots) do
		love.graphics.circle('fill', circle.x, circle.y, circle.radius)
	end
end
