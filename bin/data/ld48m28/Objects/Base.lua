Base = class(Object, function(o, x, y)
	Object.init(o, x, y, hgridSize, vgridSize)
	o.health = 10
	o.bulletWatch = Group()
end)

function Base:draw()
	local spriteSize = 50;
	local scaleMult = 5
	if retina then spriteSize = 100; scaleMult = 10 end
	local scale = self.health*scaleMult/spriteSize;
	sheet:addCenterRotatedTile(sprites["bw_circle.png"], self.pos.x, self.pos.y, 0, 0, scale)
end

function Base:shoot()
	self.health = self.health - 1
end