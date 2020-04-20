function restart()
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
end