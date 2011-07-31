if bg == nil then bg = bludGraphics(); end
if bb == nil then bb = bludShapeBatch(); end

Vec2 = class(function(vec,x,y)
  vec.x = x
  vec.y = y
end)
function Vec2:add(v)
  self.x = self.x + v.x;
  self.y = self.y + v.y;
end
function Vec2:add(v)
  self.x = self.x + v.x;
  self.y = self.y + v.y;
end
function Vec2:mult(s) -- by scalar
  self.x = self.x * s;
  self.y = self.y * s;
end
function Vec2:sub(v)
  self.x = self.x - v.x;
  self.y = self.y - v.y;
end
function Vec2:length()
  return math.sqrt(self.x*self.x + self.y * self.y)
end
function Vec2:normalize()
  length = math.sqrt(self.x*self.x + self.y*self.y)
  if length > 0 then
    self.x = self.x/length
    self.y = self.y/length
  else
    self.x = 0
    self.y = 0
  end
end
function Vec2:distance(v)
  return math.sqrt((self.x-v.x)^2 + (self.y-v.y)^2)
end

function Vec2:__eq(b)
  return self.x == b.x and self.y == b.y
end

function Vec2:__tostring()
  return "Vector: " .. self.x .. ", " .. self.y
end

Line2d = class(function(line,x1,y1,x2,y2)
  line.v1 = Vec2(x1,y1)
  line.v2 = Vec2(x2,y2)
end)

-- http://www.angelfire.com/fl/houseofbartlett/solutions/lineinter2d.html
function Line2d:check_tri_clock_dir(v1,v2,v3)
  test = (((v2.x - v1.x)*(v3.y - v1.y)) - ((v3.x - v1.x)*(v2.y - v1.y)));
  if (test > 0) then return 0 -- counter clockwise
  elseif(test < 0) then return 1 -- clockwise
  else return 3 end -- line
end

function Line2d:check_intersection(l2)
  test1_a = self:check_tri_clock_dir(self.v1,self.v2,l2.v1)
  test1_b = self:check_tri_clock_dir(self.v1,self.v2,l2.v2)
  if(test1_a ~= test1_b) then  
    test2_a = self:check_tri_clock_dir(l2.v1,l2.v2,self.v1)
    test2_b = self:check_tri_clock_dir(l2.v1,l2.v2,self.v2)
    if(test2_a ~= test2_b) then
      return true
    end
  end
  return false
end

-- Rectangle Class
Rectangle = class(function(rect, x, y, w, h)
  rect.w = w
  rect.h = h
  rect.pos = Vec2(0,0)
  rect.x1 = 0
  rect.y1 = 0  
  rect.x2 = 0
  rect.y2 = 0  
  rect.red = 0;
  rect.green = 0;
  rect.blue = 0;
  rect:setPosition(x, y)
end)

function Rectangle:setPosition(x,y)
-- added some type coersion
  self.pos.x = x+0
  self.pos.y = y+0
  self.x1 = x+0
  self.y1 = y+0
  self.x2 = x+self.w
  self.y2 = y+self.h
end

function Rectangle:setColor(r,g,b)
	self.red = r;
	self.green = g;
	self.blue = b;
end
function Rectangle:sync()
end
function Rectangle:draw()
  bb:setColor(self.red, self.green, self.blue, 255)
  bb:addRect(self.pos.x, self.pos.y, 0, self.w, self.h)
end

function Rectangle:doesPointTouch(v)
  if (v.x >= self.pos.x and v.x < self.pos.x+self.w) then
    if (v.y >= self.pos.y and v.y < self.pos.y+self.h) then
      return true
    end
  end
  return false
end
function Rectangle:doesRectangleTouch(r)
  return
    (r.pos.x + r.w > self.pos.x) and
    (r.pos.x < self.pos.x+self.w) and
    (r.pos.y + r.h > self.pos.y) and
    (r.pos.y < self.pos.y + self.h)
end
function Rectangle:whatSideDoesLineTouch(line, velocity)
  -- check the top and bottom intersections
  if velocity.y > 0 then
    side = Line2d(self.x1,self.y1,self.x2,self.y1)
    if(line:check_intersection(side)) then
      return 1
    end
  elseif velocity.y < 0 then
    side = Line2d(self.x1,self.y2,self.x2,self.y2)
    if(line:check_intersection(side)) then
      return 3
    end
  end 
  -- check the left and right intersections
  if velocity.x > 0 then
    side = Line2d(self.x1,self.y1,self.x1,self.y2)
    if(line:check_intersection(side)) then
      return 4
    end
  elseif velocity.x < 0 then
    side = Line2d(self.x2,self.y1,self.x2,self.y2)
    if(line:check_intersection(side)) then 
      return 2
    end
  end 
  return 0
end