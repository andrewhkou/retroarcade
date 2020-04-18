screenDimX = 725
screenDimY = 725
block = 25
vel = 12.5
timeElapsed = 0

require("walls") -- import walls
require("dots") -- import dots

dir = {
	up = "w",
	left = "a",
	down = "s",
	right = "d"
}

rectangles = {va=va,vb=vb,vc=vc,vd=vd,ve=ve,vf=vf, vg=vg, vh=vh, vi=vi, vj=vj, vk=vk, 
vl=vl, vm=vm, vn=vn, vo=vo, vp=vp, vq=vq, vr=vr, vs=vs, vt=vt, ha=ha,
hb=hb, hc=hc, hd=hd, he=he, hf=hf, hg=hg, hh=hh, hi=hi, hj=hj, hk=hk, hl=hl, hm=hm,  
hn=hn, ho=ho, hp=hp, hq=hq, hr=hr, hs=hs, ht=ht, hu=hu, hv=hv, hw=hw, hx=hx, hy=hy,
hz=hz, haa=haa, topBar=topBar, bottomBar=bottomBar, b1=b1, b2=b2, b3=b3, b4=b4, b5=b5}

allDots = {}

function addDot(r, c)
	x = block * (c - 1)
	y = block * (r - 1)
	circle = {
		x = x + block / 2,
		y = y + block / 2,
		radius = 3
	}
	table.insert(allDots, circle)
end

for row = 1, 29, 1 do
	for col = 1, 19, 1 do
		if dots[row][col] == 1 then addDot(row, col) end
	end
end

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
fire = 0
fire1 = 0
function overlap(corner, rect)
	x = corner[1]
	y = corner[2]
	topLX = rect.x
	topLY = rect.y
	botRX = rect.x + rect.width
	botRY = rect.y + rect.height
	if x > topLX and x < botRX and y > topLY and y < botRY then
		fire = rect.x
		fire1 = rect.y
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
	end
end

function love.draw()
	love.graphics.print(tostring(fire), 500, 600)
	love.graphics.print(tostring(fire1), 660, 600)
	love.graphics.draw(pacman.sprite, pacman.x, pacman.y, pacman.angle, 25/360, 25/360)
	love.graphics.setColor(0, 128, 128)
	for _, v in pairs(rectangles) do
		love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
	end
	for i = 1, #allDots, 1 do
		circle = allDots[i]
		love.graphics.circle('fill', circle.x, circle.y, circle.radius)
	end
	love.graphics.setColor(247, 255, 0)
end
