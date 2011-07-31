bludGlobal = class(function(o)
  o.elapsed = 0;
  o.last_t = 0;
  o.fade_alpha = 0;
  -- need to keep a copy of the screen rect around for quick onscreen testing
  o.screen_rect = Rectangle(0,0,bg:getWidth(), bg:getHeight());
  o.camera = Camera(0,0,bg:getWidth(), bg:getHeight()) -- by default, make a camera the size of the screen
  o.cameras = {o.camera}
end)
function bludGlobal:update(t)
  t = t/1000; self.elapsed = t - self.last_t; self.last_t = t;
  -- handle the flash
  if self.isFlashing then
    self.flash_color[4] = math.max(0,self.flash_color[4] - (self.elapsed/self.flash_duration)*255);
    sheet:addCenteredTile(sprites["white.png"], 0, 0, 2, 1, 200, self.flash_color[1], self.flash_color[2], self.flash_color[3], self.flash_color[4])
    if(self.flash_color[4] <= 0) then
      self.isFlashing = false
      if self.flashOnComplete then self.flashOnComplete() end
    end
  end
  -- handle the fade
  if self.isFading then
    self.fade_alpha = math.min(255,self.fade_alpha + (self.elapsed/self.fade_duration)*255);
    if(self.fade_alpha >= 255) then
      self.isFading = false
      self.fade_alpha = 0;
      if self.fadeOnComplete then self.fadeOnComplete() end
    end
  end
  if(self.fade_alpha > 0) then
    sheet:addCenteredTile(sprites["white.png"], 0, 0, 2, 1, 200, self.fade_color[1], self.fade_color[2], self.fade_color[3], self.fade_alpha)
  end
end
function bludGlobal:draw()
  
end
function bludGlobal:flash(...)
  local arg = {...}
  self.flash_color = arg[1] or {255,255,255,255}
  self.flash_duration = arg[2] or 1
  self.flashOnComplete = arg[3] or function()end
  self.isFlashing = true
end
function bludGlobal:fade(...)
  local arg = {...}
  self.fade_color = arg[1] or {255,255,255,255}
  self.fade_duration = arg[2] or 1
  self.fadeOnComplete = arg[3] or function()end
  self.fade_alpha = 0
  self.isFading = true
end
