Bullet = class(Object, function(o, x, y, dir, baseToAdd)
	-- init the object
	Object.init(o, x, y, 1, 1)
	-- init the box 2d object
	o.radius = 5
	if retina then o.radius = 10 end
	o.b2dc = bludBox2dCircle(box2d, 2, 0.53, 0.1, o.pos.x, o.pos.y, o.radius)
	if retina then
		o.b2dc:addForce(dir.x, dir.y, o.radius*40)
	else
		o.b2dc:addForce(dir.x, dir.y, o.radius*8)
	end
	o.age = 0
	o.updated = false
	o.baseToAdd = baseToAdd
	o.rot = 0
end)

function Bullet:draw()
	if self.updated then
		local spriteSize = 50;
		if retina then spriteSize = 100 end
		local scale = self.radius*2/spriteSize;
		sheet:addCenterRotatedTile(sprites["bw_circle.png"], self.pos.x, self.pos.y, 0, 0, scale, self.rot);
	end
end
function Bullet:update()
	self.updated = true
	self.age = self.age + 1
	
	if not self.dead then
		self:setPosition(self.b2dc:getX(), self.b2dc:getY())
		self.rot = self.b2dc:getRot()
	end

	if self.age > 120 and not self.dead then
		self.b2dc:destroy()
		self.b2dc = nil
		self.dead = true
		pd:startList("fromOF")
		pd:addSymbol("bulletReturn")
		pd:addFloat(1)
		pd:finish();

		Tweener:addTween(self.pos, {x=self.baseToAdd.pos.x, y=self.baseToAdd.pos.y}, {func="easeInOutSine", time=.25, onComplete=function()
			self.baseToAdd.health = self.baseToAdd.health + 1
			self:kill()		
		end}) 
	end
end