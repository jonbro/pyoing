Puck = class(Object, function(o, x, y)
	-- init the object
	Object.init(o, x, y, 1, 1)
	-- init the box 2d object
	o.radius = 25
	if retina then o.radius = 50 end
	o.b2dc = bludBox2dCircle(box2d, 20, 0.53, 0.8, x, y, o.radius)
end)

function Puck:draw()
	local spriteSize = 50;
	if retina then spriteSize = 100 end
	local scale = self.radius*2/spriteSize;
	sheet:addCenterRotatedTile(sprites["bw_circle.png"], self.pos.x, self.pos.y, 0, 0, scale, self.b2dc:getRot());
end
function Puck:destroy()
	self.destroyed = true
	self.b2dc:destroy()
end
function Puck:update()
	if not self.destroyed then
		self:setPosition(self.b2dc:getX(), self.b2dc:getY())
	end
end