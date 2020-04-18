screenDimX = 1280;
screenDimY = 720;

dir = {
	up = "w",
	left = "a",
	down = "s",
	right = "d"
}
topBar = {
	x = 40,
	y = 0,
	width = 1200,
	height = 25
}
bottomBar = {
	x = 40,
	y = screenDimX - 50,
	width = 1200,
	height = 25
}
va = {
	x = 40,
	y = 0,
	width = 25,
	height = 350
}
vb = {
	x = screenDimX/2 - 25,
	y = 0,
	width = 25,
	height = 150
}
ha = {
	x = va.x + 50 + 50,
	y = 50 + 50,
	width = (vb.x - va.x - 50 - 150) / 2,
	height = 25
}
hb = {
	x = ha.x + ha.width + 50,
	y = ha.y,
	width = ha.width,
	height = 25
}
hc = {
	x = vb.x + vb.width + 50,
	y = 100,
	width = ha.width,
	height = 25
}
hd = {
	x = hc.x + hc.width + 50,
	y = 100,
	width = ha.width,
	height = 25

}
he = {
	x = ha.x,
	y = ha.y + 100,
	width = ha.width,
	height = ha.height

}
hf = { 
	x = hb.x + 100,
	y = he.y,
	width = 325,
	height = 25
}
hg = {
	x = hd.x,
	y = hf.y,
	width = hd.width,
	height = hd.height
}
hh = {
	x = 40,
	y = va.height - 50,
	width = ha.width + 50,
	height = 25
}
hk = { 
	x = hd.x,
	y = hh.y,
	width = hd.width + 50,
	height = 25
}
hl = {
	x = 0,
	y = va.height + 25,
	width = hh.width + 40,
	height = 25
}
hm = {
	x = hk.x,
	y = hl.y,
	width = hk.width + 40,
	height = 25
}
hi = {
	x = hb.x,
	y = hh.y,
	width = hb.width,
	height = 25
}
hj = {
	x = hi.x + hi.width + 150,
	y = hi.y,
	width = hc.width,
	height = 25
}
hn = {
	x = hl.x,
	y = hl.y + 100,
	width = hl.width,
	height = 25
}
ho = {
	x = hm.x,
	y = hn.y,
	width = hm.width,
	height = 25
}


vc = {
	x = screenDimX - 90,
	y = 0,
	width = 25,
	height = va.height
}
vd = { 
	x = 40 + hh.width - 25,
	y = hh.y,
	width = 25, 
	height = 150

}
ve = {
	x = he.x + 50 + he.width,
	y = he.y,
	width = 25,
	height = 250
}
vf = {
	x = vb.x,
	y = he.y,
	width = 25,
	height = 150
}
vg = {
	x = screenDimX - ve.x - 25,
	y = hf.y,
	width = 25,
	height = ve.height
}
vh = {
	x = hg.x,
	y = vd.y,
	width = 25,
	height = vd.height
}




rectangles = {va=va,vb=vb,vc=vc,vd=vd,ve=ve,vf=vf,vg=vg,vh=vh,ha=ha,
hb=hb,hc=hc,hd=hd,he=he, hf=hf, hg=hg, hh=hh, hk=hk, hl=hl, hm=hm, hi=hi, 
hj=hj, hn=hn, ho=ho}

l = love.graphics.newImage("8bit_left.jpg");
r = love.graphics.newImage("8bit_right.jpg");
u = love.graphics.newImage("8bit_up.jpg");
d = love.graphics.newImage("8bit_down.jpg");

pacman = {
	sprite = r,
	x = 700,
	y = 700,
	xvel = 0,
	yvel = 0,
	angle = 0
}

moveL = true
moveR = true
moveU = true
moveD = true

function leftDetect(x, ytop, ybot)
	currYtop = pacman.y
	currYbot = pacman.y + 36
	fire1 = currYtop
	fire2 = ytop
	fire3 = ybot
	if ((currYbot >= ytop and currYbot <= ybot) or (currYtop >= ytop and currYtop <= ybot)) and math.abs(x-pacman.x) <= 5 then
		moveR = false
	else
		moveR = true
	end
end

function rightDetect(x, ytop, ybot)
	currYtop = pacman.y
	currYbot = pacman.y + 36
	if ((currYbot >= ytop and currYbot <= ybot) or (currYtop >= ytop and currYtop <= ybot)) and math.abs(x-pacman.x) <= 5 then
		moveL = false
	else
		moveL = true
	end
end

function topDetect(y, xleft, xright)
	currXleft = pacman.x
	currXright = pacman.x + 43.2
	if ((currXleft >= xleft and currXleft <= xright) or (currXright >= xleft and currXright <= xright)) and math.abs(y-pacman.y) <= 5 then
		moveD = false
	else
		moveD = true
	end
end

function botDetect(y, xleft, xright)
	currXleft = pacman.x
	currXright = pacman.x + 43.2
	if ((currXleft >= xleft and currXleft <= xright) or (currXright >= xleft and currXright <= xright)) and math.abs(y-pacman.y) <= 5 then
		moveU = false
	else
		moveU = true
	end
end

function collisionDetect(rectangle)
	tlx = rectangle.x -- top left x value
	tly = rectangle.y -- top left y value
	brx = rectangle.x + rectangle.width -- bottom right x val
	bry = rectangle.y + rectangle.height -- bottom right y val
	if moveR then
		leftDetect(tlx, tly, bry)
	end
	if moveL then
		rightDetect(tlx, tly, bry)
	end
	if moveU then
		botDetect(bry, tlx, brx)
	end
	if moveD then
		topDetect(bry, tlx, brx)
	end
end

function love.load()
    love.window.setTitle("Pacman")
    love.window.setMode(screenDimX, screenDimY)
    love.graphics.setNewFont(40)
end

function love.update(dt)
	for i,v in pairs(rectangles) do
		collisionDetect(v)
	end
	if love.keyboard.isDown(dir.up) then
		pacman.xvel = 0;
		pacman.yvel = -5;
		pacman.sprite = u;
	end
	if love.keyboard.isDown(dir.left) then
		pacman.yvel = 0;
		pacman.xvel = -5;
		pacman.sprite = l;
	end
	if love.keyboard.isDown(dir.right) then
		pacman.yvel = 0;
		pacman.xvel = 5;
		pacman.sprite = r;
	end
	if love.keyboard.isDown(dir.down) then
		pacman.xvel = 0;
		pacman.yvel = 5;
		pacman.sprite = d;
	end
	if love.keyboard.isDown("p") then
		moveL = false
		moveR = false
		moveU = false
		moveD = false
	end
	if (moveU and pacman.yvel < 0) or (moveD and pacman.yvel > 0) then
		pacman.y = pacman.y + pacman.yvel;
	end
	if (moveR and pacman.xvel > 0) or (moveL and pacman.xvel < 0) then
		pacman.x = pacman.x + pacman.xvel;
	end
	moveL = true
	moveR = true
	moveU = true
	moveD = true
end

function love.draw()
	love.graphics.print(tostring(fire1), 700, 670)
	love.graphics.print(tostring(fire2), 800, 670)
	love.graphics.print(tostring(fire3), 900, 670)
	love.graphics.draw(pacman.sprite, pacman.x, pacman.y, pacman.angle, 0.09, 0.1)
	love.graphics.setColor(0, 128, 128)
	love.graphics.rectangle('fill', topBar.x, topBar.y, topBar.width, topBar.height)
	for i, v in pairs(rectangles) do
		love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
	end
	love.graphics.setColor(247, 255, 0)
end