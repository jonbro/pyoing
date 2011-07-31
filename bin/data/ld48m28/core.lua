-- utility for getting around tables
function findNode(rootNode, name)
  if rootNode.name == name then
    return rootNode
  else
    if type(rootNode) == "table" then
      for i, v in ipairs(rootNode) do
        found = findNode(v, name)
        if(found ~= false) then
          return found
        end
      end
    end
  end
  return false
end

bg = bludGraphics();
-- http://www.colourlovers.com/photocopa/67015/Unnamed_Photo

vgridSize = 40
hgridSize = 40
dofile(blud.bundle_root .. "/ld48m28/imports.lua")
-- we need to customize the sprites on importing, so they can't come frome the import list
if bg:getWidth() > 320 then
  dofile(blud.bundle_root ..  "/ld48m28/sprite_list-hd.lua")
  vgridSize = vgridSize*2
  hgridSize = hgridSize*2
  retina = true
else
  dofile(blud.bundle_root ..  "/ld48m28/sprite_list.lua")
end

dofile(blud.bundle_root ..  "/ld48m28/setupSprites.lua")


-- profiler = newProfiler()
-- profiler:start()
-- print(blud.doc_root)

-- local outfile = io.open( "profile.txt", "w+" )
-- profiler:report( outfile )
-- outfile:close()

function math.randomRange(min, max)
  return min + (math.random() * (max - min))
end

LineBatch = class(function(o)
  o:clear()
  o.r = 0
  o.g = 0
  o.b = 0
end)
function LineBatch:setColor(r, g, b)
  self.r = r
  self.g = g
  self.b = b
end
function LineBatch:clear()
  self.batch = {}
end
function LineBatch:addLine(x1, y1, x2, y2)
  table.insert(self.batch, {x1=x1, y1=y1, x2=x2, y2=y2})
end
function LineBatch:draw()
  for i, v in pairs(self.batch) do
    line:drawLine(v.x1, v.y1, v.x2, v.y2)
  end
end
lb = LineBatch();

TextBatch = class(LineBatch, function(o)
  LineBatch.init(o)
  o.smallBatch = {}
end)
function TextBatch:clear()
  LineBatch.clear(self)
  self.smallBatch = {}
end
function TextBatch:addText(output, x, y, ...)
  local arg = {...}
  small = arg[1]
  width = arg[2]
  line_height = arg[3]
  if small then
    table.insert(self.smallBatch, {output=output, x=x, y=y, r=self.r, g=self.g, b=self.b, w=width, line_height=line_height})
  else
    table.insert(self.batch, {output=output, x=x, y=y, r=self.r, g=self.g, b=self.b, w=width, line_height=line_height})
  end
end
function TextBatch:draw()
  for i, v in pairs(self.batch) do
    bg:setColor(v.r, v.g, v.b)
    font:draw(v.output, v.x, v.y, v.w, v.line_height)
  end
  for i, v in pairs(self.smallBatch) do
    bg:setColor(v.r, v.g, v.b)
    sfont:draw(v.output, v.x,v.y, v.w, v.line_height)
  end
end
tb = TextBatch();

PI = 3.14159265

function lerp(start, stop, amt)
	return start + (stop-start) * amt;
end

bludG = bludGlobal()
bb = bludShapeBatch(2000, 2);
bbt = bludShapeBatch(2000, 2);

circle = bludImage();
circle:load(blud.bundle_root .. "/namcap/assets/circle.png")
line = bludLine(circle, 1);

particles = ParticleSystems();

--oscRec = Receiver();

font = bludFont();
sfont = bludFont();
if retina then
  font:load(blud.bundle_root .. "/arial_rounded.ttf", 52, true)
  sfont:load(blud.bundle_root .. "/arial_rounded.ttf", 32, true)
else
  font:load(blud.bundle_root .. "/arial_rounded.ttf", 26, true)
  sfont:load(blud.bundle_root .. "/arial_rounded.ttf", 16, true)
end

function gridQuantize(x, y)
  x = math.floor(x/hgridSize)*hgridSize
  y = math.floor(y/vgridSize)*vgridSize
  return x, y
end
pd = bludPd();
box2d = bludBox2d();
mainState = StartState();

function blud.draw()
  -- debug to see the off screen area
  -- bg:translate(bg:getWidth()/2, bg:getHeight()/2, 0);
  -- bg:scale(0.5, 0.5, 0.5)
  -- bg:translate(-bg:getWidth()/2, -bg:getHeight()/2, 0);
  particles:draw();
  mainState:draw();
  bb:draw();
  sheet:draw();
  bbt:draw();
  bg:setColor(0,0,0,255);
  lb:draw();
  tb:draw();
end
function blud.update(t)
  box2d:update();
  Tweener:update();
  bb:clear();
  bbt:clear();
  lb:clear();
  tb:clear();
  sheet:clear();

  bb:setColor(255,241,199)
  if retina then
    bb:addRect(0,0,0, 640, 960);
  else
    bb:addRect(0,0,0, 320, 480);
  end

  sheet:update(t);
  mainState:update();
  bludG:update(t);
--  oscRec:update();
  particles:update()
end

function blud.touch.down(x, y, id)
  mainState:touchDown(x, y, id)
end
function blud.touch.moved(x, y, id)
  -- mainState:touchMoved(x, y, id)
end
function blud.touch.up(x, y, id)
  mainState:touchUp(x, y, id)
end
function blud.touch.double_tap(x, y, id)
end
function blud.exit()
end
