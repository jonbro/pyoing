-- we continue to half assedly rip stuff from flixel, realizing that we need it slightly after it would have been useful, and requiring backtracking. yay!

Camera = class(Rectangle, function(o, x, y, width, height)
  Rectangle.init(o, x, y, width, height)
end)
function Camera:getOffset(x, y)
  _x = x - (self.pos.x)
  _y = y - (self.pos.y)
  local _x, junk = math.modf(_x)
  local _y, junk = math.modf(_y)
  return _x, _y
end
-- works the opposite of getOffset, gives the actual value in the world being displayed by the camera
function Camera:getPosition(x, y)
  _x = x + (self.pos.x)
  _y = y + (self.pos.y)
  local _x, junk = math.modf(_x)
  local _y, junk = math.modf(_y)
  return _x, _y
end