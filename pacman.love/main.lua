screenDimX = 1280;
screenDimY = 720;

dir = {
	up = "w",
	left = "a",
	down = "s",
	right = "d"
}

pacman = {
	sprite = love.graphics.newImage("8bit.jpg"),
	x = 0,
	y = 0,
	xvel = 0,
	yvel = 0,
	angle = 0
}

function love.load()
    love.window.setTitle("Pacman");
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
end

function love.update(dt)
	if love.keyboard.isDown(dir.up) then
		pacman.angle = math.pi * 1.5;
		pacman.xvel = 0;
		pacman.yvel = -5;
	end
	if love.keyboard.isDown(dir.left) then
		pacman.angle = math.pi;
		pacman.yvel = 0;
		pacman.xvel = -5;
	end
	if love.keyboard.isDown(dir.right) then
		pacman.angle = 0;
		pacman.yvel = 0;
		pacman.xvel = 5;
	end
	if love.keyboard.isDown(dir.down) then
		pacman.angle = math.pi / 2;
		pacman.xvel = 0;
		pacman.yvel = 5;
	end
	pacman.y = pacman.y + pacman.yvel;
	pacman.x = pacman.x + pacman.xvel;
end

function love.draw()
	love.graphics.draw(pacman.sprite, pacman.x, pacman.y, pacman.angle, 0.1, 0.1)
end