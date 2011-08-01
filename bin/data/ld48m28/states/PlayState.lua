-- 

PlayState = class(Group, function(o)
	Group.init(o)
	-- add the main bases for the two players
	o.bases = Group()
	o.b_main = o.bases:add(Base(bludG.screen_rect.w/2, 0))
	o.r_main = o.bases:add(Base(bludG.screen_rect.w/2, bludG.screen_rect.h))
	local centerLineY = 10
	if retina then
		centerLineY = 20
	end
	o.text_bg = o:add(Object(0,bludG.screen_rect.h/2-centerLineY, 640, centerLineY*2))
	o.text_bg.sprite = sprites["center_line.png"]
	o.pucks = o:add(Group())
	o.pucks:add(Puck(bludG.screen_rect.w/3,bludG.screen_rect.h/2))
	o.pucks:add(Puck(bludG.screen_rect.w/3*2,bludG.screen_rect.h/2))
	o.bulletCount = 0
end)

function PlayState:draw()
	-- draw the positions that the players can add bases in
	local drawn = {}
	-- for i, v in pairs(self.bases.members) do
	-- 	-- for each base, loop around the n, s, e, w and draw the places you can add a base
	-- 	local n = Vec2(v.pos.x, v.pos.y - vgridSize)
	-- 	local s = Vec2(v.pos.x, v.pos.y + vgridSize)
	-- 	local e = Vec2(v.pos.x+hgridSize, v.pos.y)
	-- 	local w = Vec2(v.pos.x-hgridSize, v.pos.y)
	-- 	for j, dir in pairs({n, s, e, w}) do
	-- 		if drawn[dir.x .. "_" .. dir.y] == nil then
	-- 			drawn[dir.x .. "_" .. dir.y] = true
	-- 			sheet:addTile(sprites["fill.png"], dir.x, dir.y, 0,0, 0, 255, 0, 150);
	-- 		end
	-- 	end
	-- end
	-- draw all the objects
	Group.draw(self)
	self.bases:draw()
end
function PlayState:update()
	for i, puck in ipairs(self.pucks.members) do
		-- check to see if the puck has moved to one player or another
		if puck.pos.y < puck.radius*1.125 then
			mainState = EndState(mainState, "p2")
		end
		if bludG.screen_rect.h - puck.pos.y < puck.radius*1.125 then
			mainState = EndState(mainState, "p1")
			-- delete the pucks
		end
	end
	Group.update(self)
end
function PlayState:touchDown(x, y, id)
	-- check to see which player is firing
	self.bulletCount = self.bulletCount + 1
	finger = Vec2(x, y)
	start = 0;
	local baseToAdd;
	local baseFloat;
	if y > bludG.screen_rect.h/2 then
		start = Vec2(bludG.screen_rect.w/2, bludG.screen_rect.h)
		if self.r_main.health <= 0 then return true end
		self.r_main:shoot()
		baseToAdd = self.b_main
		baseFloat = 1;
	else
		start = Vec2(bludG.screen_rect.w/2, 5)
		if self.b_main.health <= 0 then return true end
		self.b_main:shoot()
		baseToAdd = self.r_main
		baseFloat = 2;
	end
	finger:sub(start)
	finger:normalize()
	pd:startList("fromOF")
	pd:addSymbol("sync")
	pd:addFloat(baseFloat)
	pd:finish();
	local b = self:add(Bullet(bludG.screen_rect.w/2, start.y, finger, baseToAdd))

end