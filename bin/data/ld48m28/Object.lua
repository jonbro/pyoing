Object = class(Rectangle, function(o, x, y, width, height)
  Rectangle.init(o, x, y, width, height)
  o.alive = true
  o.exists = true
  o.scrollFactor = Vec2(1, 1)
  o.offset = Vec2(0,0)
end)

function Object:draw()
  if self.sprite then
    -- loop through all the cameras
    for i,camera in pairs(bludG.cameras) do
      -- draw the sprite if it is on the current camera
      if self:doesRectangleTouch(camera) then
        -- calculate the position on the current camera
        _x, _y = self:getCameraOffset(camera)
        sheet:addTile(self.sprite, _x, _y, 0, 0)
      end
    end
  else
    Rectangle.draw(self)
  end
end
function Object:getCameraOffset(camera)
  _x = self.pos.x - (camera.pos.x*self.scrollFactor.x) - self.offset.x
  _y = self.pos.y - (camera.pos.y*self.scrollFactor.y) - self.offset.y
  local _x, junk = math.modf(_x)
  local _y, junk = math.modf(_y)
  return _x, _y
end
function Object:overlap(other, ...)
  local arg = {...}
  notifyCallback = arg[1]
  if other:is_a(Group) then
    return other:overlap(self, unpack(arg))
  else
    if self.alive and Rectangle.doesRectangleTouch(self, other) then
      if notifyCallback then notifyCallback(self, other) end
      return true
    end
  end
  return false
end
function Object:kill()
  self.alive = false
  self.exists = false
end