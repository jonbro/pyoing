StartState = class(Group, function(o)
	Group.init(o)
	o.p1ready = false
	o.p2ready = false

	o.p1bg = o:add(Object(0, 0, bludG.screen_rect.w, bludG.screen_rect.h/2))
	o.p1bg.sprite = sprites["blue_bg.png"]

	o.p2bg = o:add(Object(0, bludG.screen_rect.h/2, bludG.screen_rect.w, bludG.screen_rect.h/2))
	o.p2bg.sprite = sprites["red_bg.png"]

	o.p1readySpinner = o:add(CenteredRotText(bludG.screen_rect.w/2, bludG.screen_rect.h/4, 0))	
	o.p1readySpinner.sprite = sprites["blue_circle.png"]
	o.p1readySpinner.scale = 0
	o.p1readySpinner.rotRate = 0

	o.p2readySpinner = o:add(CenteredRotText(bludG.screen_rect.w/2, bludG.screen_rect.h/4*3, 0))	
	o.p2readySpinner.sprite = sprites["red_circle.png"]
	o.p2readySpinner.scale = 0
	o.p2readySpinner.rotRate = 0

	o.p1t = o:add(CenteredRotText(bludG.screen_rect.w/2, bludG.screen_rect.h/4, 180))
	o.p2t = o:add(CenteredRotText(bludG.screen_rect.w/2, math.floor(bludG.screen_rect.h/4*3), 0))

	o.p1t.sprite = sprites["play_text.png"]
	o.p2t.sprite = sprites["play_text.png"]
	o.playState = nil
end)

function StartState:update()
	self.p2readySpinner.rot = self.p2readySpinner.rot + self.p2readySpinner.rotRate
	self.p1readySpinner.rot = self.p1readySpinner.rot + self.p1readySpinner.rotRate
	if self.p1ready and self.p2ready and not self.starting then
		pd:startList("fromOF")
		pd:addSymbol("start")
		pd:addFloat(1)
		pd:finish();

		self.allReady = true
		self.playState = PlayState()
		self.starting = true
		-- Tween everything off the screen
		local top = {y = -bludG.screen_rect.h/2}
		local bottom = {y = bludG.screen_rect.h/2*3}
		local time = 2
		Tweener:addTween(self.p1readySpinner.pos, top, {func="easeInOutSine", time=time})
		Tweener:addTween(self.p1bg.pos, top, {func="easeInOutSine", time=time})
		Tweener:addTween(self.p1t.pos, top, {func="easeInOutSine", time=time})

		Tweener:addTween(self.p2readySpinner.pos, bottom, {func="easeInOutSine", time=time})
		Tweener:addTween(self.p2bg.pos, {y=bludG.screen_rect.h}, {func="easeInOutSine", time=time})
		Tweener:addTween(self.p2t.pos, bottom, {func="easeInOutSine", time=time, onComplete=function()
			mainState = self.playState
		end})
	end
end
function StartState:draw()
	if self.playState then
		self.playState:draw()
	end
	Group.draw(self)
end
function StartState:touchDown(x, y, id)
	if not self.allReady then
		if y > bludG.screen_rect.h/2 then
			Tweener:addTween(self.p2readySpinner, {scale=1, rotRate=10}, {func="outExpo", time=0.5}) 
			self.p2ready = id
		else
			Tweener:addTween(self.p1readySpinner, {scale=1, rotRate=10}, {func="outExpo", time=0.5}) 
			self.p1ready = id
		end
	end
end

function StartState:touchUp(x, y, id)
	if not self.allReady then
		if id == self.p1ready then
			self.p1ready = nil
			Tweener:addTween(self.p1readySpinner, {scale=0, rotRate=0}, {func="inExpo", time=0.8}) 
		else
			self.p2ready = nil
			Tweener:addTween(self.p2readySpinner, {scale=0, rotRate=0}, {func="inExpo", time=0.8}) 
		end
	end
end

