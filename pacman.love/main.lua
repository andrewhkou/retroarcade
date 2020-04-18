screenDimX = 725;
screenDimY = 725;
block = 25;
vel = 12.5;
timeElapsed = 0;
dir = {
	up = "w",
	left = "a",
	down = "s",
	right = "d"
}
topBar = {
	x = 0,
	y = 0,
	width = screenDimX,
	height = block
}

va = {
	x = 0,
	y = 0,
	width = block,
	height = 175
}
vb = {
	x = screenDimX/2 - block/2,
	y = 0,
	width = block,
	height = (3 * block)
}
ha = {
	x = va.x + 2 * block,
	y = 2 * block,
	width = (vb.x - va.x - block - (3 * block)) / 2,
	height = block
}
hb = {
	x = ha.x + ha.width + block,
	y = ha.y,
	width = ha.width,
	height = block
}
hc = {
	x = vb.x + vb.width + block,
	y = ha.y,
	width = ha.width,
	height = block
}
hd = {
	x = hc.x + hc.width + block,
	y = ha.y,
	width = ha.width,
	height = block

}
he = {
	x = ha.x,
	y = ha.y + 2 * block,
	width = ha.width,
	height = ha.height

}
hf = { 
	x = he.x + he.width + 3 * block,
	y = he.y,
	width = hd.x - (2 * block) - (he.x + he.width + (2 * block)) - (2 * block),
	height = block
}
hg = {
	x = hd.x,
	y = hd.y + 2 * block,
	width = hd.width,
	height = hd.height
}
hh = {
	x = 0,
	y = va.height - block,
	width = ha.width + 2 * block,
	height = block
}
hk = { 
	x = hd.x,
	y = hh.y,
	width = hd.width + 2 * block,
	height = block
}
hl = {
	x = 0,
	y = va.height + 2 * block,
	width = hh.width,
	height = block
}
hm = {
	x = hk.x,
	y = hl.y,
	width = hk.width,
	height = block
}
hi = {
	x = hb.x,
	y = hh.y,
	width = hb.width,
	height = block
}
hj = {
	x = hi.x + hi.width + 3 * block,
	y = hi.y,
	width = hc.width,
	height = block
}
hn = {
	x = hl.x,
	y = hl.y + (2 * block),
	width = hl.width,
	height = block
}
ho = {
	x = hm.x,
	y = hn.y,
	width = hm.width,
	height = block
}
hp = {
	x = hn.x,
	y = hn.y + (2 * block),
	width = hn.width,
	height = block
}
hq = {
	x = hf.x,
	y = hp.y,
	width = hf.width,
	height = block
}
hr = {
	x = ho.x,
	y = hp.y,
	width = hp.width,
	height = block
}
hs = {
	x = he.x,
	y = hp.y + 2 * block,
	width = ha.width,
	height = block
}
ht = {
	x = hb.x,
	y = hs.y,
	width = ha.width,
	height = block
}
hu = {
	x = hc.x,
	y = hs.y,
	width = ha.width,
	height = block
}
hv = {
	x = hd.x,
	y = hs.y,
	width = ha.width,
	height = block
}
hw = {
	x = hs.x,
	y = hp.y + (2*block) + hs.height + block,
	width = 3 * block,
	height = block
}
hx = {
	x = hq.x,
	y = hw.y,
	width = hf.width,
	height = block
}
hy = {
	x = hv.x + (2*block),
	y = hw.y,
	width = 3 * block,
	height = block
}
hz = {
	x = hs.x,
	y = hw.y + (2*block),
	width = hs.width + block + ht.width,
	height = block
}
haa = {
	x = hu.x,
	y = hz.y,
	width = hz.width,
	height = block
}
bottomBar = {
	x = 0,
	y = hz.y + 2 * block,
	width = screenDimX,
	height = block
}
vc = {
	x = screenDimX - block,
	y = 0,
	width = block,
	height = va.height
}
vd = { 
	x = ha.x + ha.width - block,
	y = hh.y,
	width = block, 
	height = 3 * block
}
ve = {
	x = he.x + block + he.width,
	y = he.y,
	width = block,
	height = 6 * block
}
vf = {
	x = vb.x,
	y = he.y,
	width = block,
	height = 3 * block
}
vg = {
	x = hg.x - (2 * block),
	y = hg.y,
	width = block,
	height = ve.height
}
vh = {
	x = hg.x,
	y = vd.y,
	width = block,
	height = vd.height
}
vi = {
	x = vd.x,
	y = hn.y,
	width = block,
	height = vd.height
}
vj = {
	x = ve.x,
	y = vi.y,
	width = block,
	height = vd.height
}
vk = {
	x = vf.x,
	y = hq.y,
	width = block,
	height = vf.height
}
vl = {
	x = vg.x,
	y = vj.y,
	width = block,
	height = vd.height
}
vm = {
	x = vh.x,
	y = vi.y,
	width = block,
	height = vd.height
}
vn = {
	x = va.x,
	y = vi.y + 2 * block,
	width = block,
	height = 9 * block
}
vo = {
	x = vi.x,
	y = hs.y,
	width = block,
	height = 3 * block
}
vp = {
	x = vk.x,
	y = hx.y,
	width = block,
	height = 3 * block
}
vq = {
	x = vm.x,
	y = vo.y,
	width = block,
	height = 3 * block
}
vr = {
	x = vj.x,
	y = hw.y,
	width = block,
	height = 3 * block
}
vs = {
	x = vl.x,
	y = vr.y,
	width = block,
	height = 3 * block
}
vt = {
	x = vc.x,
	y = vn.y,
	width = block,
	height = vn.height
}
b1 = {
	x = hf.x, 
	y = hl.y - block,
	width = block,
	height = 4 * block
}
b2 = {
	x = hf.x, 
	y = b1.y ,
	width = 3 * block,
	height = block
}
b3 = {
	x = hc.x, 
	y = b1.y,
	width = b2.width,
	height = block
}
b4 = {
	x = hc.x + 2 * block, 
	y = b1.y,
	width = block,
	height = b1.height
}
b5 = {
	x = hf.x, 
	y = hn.y,
	width = hq.width,
	height = block
}

rectangles = {va=va,vb=vb,vc=vc,vd=vd,ve=ve,vf=vf, vg=vg, vh=vh, vi=vi, vj=vj, vk=vk, 
vl=vl, vm=vm, vn=vn, vo=vo, vp=vp, vq=vq, vr=vr, vs=vs, vt=vt, ha=ha,
hb=hb, hc=hc, hd=hd, he=he, hf=hf, hg=hg, hh=hh, hi=hi, hj=hj, hk=hk, hl=hl, hm=hm,  
hn=hn, ho=ho, hp=hp, hq=hq, hr=hr, hs=hs, ht=ht, hu=hu, hv=hv, hw=hw, hx=hx, hy=hy,
hz=hz, haa=haa, topBar=topBar, bottomBar=bottomBar, b1=b1, b2=b2, b3=b3, b4=b4, b5=b5}

l = love.graphics.newImage("8bit_left.jpg");
r = love.graphics.newImage("8bit_right.jpg");
u = love.graphics.newImage("8bit_up.jpg");
d = love.graphics.newImage("8bit_down.jpg");

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
	timeElapsed = timeElapsed + dt;
	if timeElapsed > 0.1 then
		timeElapsed = 0
		if love.keyboard.isDown(dir.up) then
			pacman.xvel = 0;
			pacman.yvel = -vel;
			pacman.sprite = u;
		end
		if love.keyboard.isDown(dir.left) then
			pacman.yvel = 0;
			pacman.xvel = -vel;
			pacman.sprite = l;
		end
		if love.keyboard.isDown(dir.right) then
			pacman.yvel = 0;
			pacman.xvel = vel;
			pacman.sprite = r;
		end
		if love.keyboard.isDown(dir.down) then
			pacman.xvel = 0;
			pacman.yvel = vel;
			pacman.sprite = d;
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
	for i, v in pairs(rectangles) do
		love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
	end
	love.graphics.setColor(247, 255, 0)
end
