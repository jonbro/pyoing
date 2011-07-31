CenteredRotText = class(Object, function(o, x, y, rot)
	Object.init(o, x, y, 10, 10)
	o.rot = rot
	o.scale = 1
end)
function CenteredRotText:draw()
	if self.sprite then
		sheet:addCenterRotatedTile(self.sprite, math.floor(self.pos.x), math.floor(self.pos.y), 0, 0, self.scale, self.rot);
	end
end

EndState = class(Group, function(o, lastState, winner)
	Group.init(o)
	for i, v in pairs(lastState.pucks.members) do
		v:destroy()
	end
	pd:startList("fromOF")
	pd:addSymbol("over")
	pd:addFloat(1)
	pd:finish();

	o.layer1 = Group()
	o.layer2 = Group()
	-- player 1 background
	o.p1bg = o.layer1:add(Object(0, -bludG.screen_rect.h/2, bludG.screen_rect.w, bludG.screen_rect.h/2))
	o.p1bg.sprite = sprites["blue_bg.png"]
	Tweener:addTween(o.p1bg.pos, {y=0}, {func="outBounce", time=1.2}) 
	
	-- player 2 background
	o.p2bg = o.layer1:add(Object(0, bludG.screen_rect.h, bludG.screen_rect.w, bludG.screen_rect.h/2))
	o.p2bg.sprite = sprites["red_bg.png"]
	Tweener:addTween(o.p2bg.pos, {y=bludG.screen_rect.h/2}, {func="outBounce", time=1.2}) 

	-- player text
	o.p1t = o.layer2:add(CenteredRotText(bludG.screen_rect.w/2, bludG.screen_rect.h/4, 180))
	o.p2t = o.layer2:add(CenteredRotText(bludG.screen_rect.w/2, math.floor(bludG.screen_rect.h/4*3), 0))
	if winner == "p1" then
		o.p1t.sprite = sprites["winner_text.png"]
		o.p2t.sprite = sprites["loser_text.png"]
	else
		o.p1t.sprite = sprites["loser_text.png"]
		o.p2t.sprite = sprites["winner_text.png"]
	end
	o.lastState = lastState
	o.countDown = 2
	o.touchCount = 0
end)

function EndState:draw()
	self.lastState:draw()
	self.layer1:draw()
	self.layer2:draw()
end
function EndState:touchDown(x, y, id)
	self.touchCount = self.touchCount + 1
end
function EndState:update()
	self.countDown = self.countDown - bludG.elapsed
	if self.touchCount > 2 and self.countDown < 0 and not self.started then
		self.started = true
		local top = {y = -bludG.screen_rect.h/2}
		local bottom = {y = bludG.screen_rect.h/2*3}
		local time = 0.7
		Tweener:addTween(self.p1t.pos, top, {func="easeInOutSine", time=time})

		Tweener:addTween(self.p2t.pos, bottom, {func="easeInOutSine", time=time, onComplete=function()
			mainState = StartState()
		end})
	end
end