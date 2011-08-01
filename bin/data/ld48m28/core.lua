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



PI = 3.14159265

function lerp(start, stop, amt)
	return start + (stop-start) * amt;
end

bludG = bludGlobal()
bb = bludShapeBatch(2000, 2);
bbt = bludShapeBatch(2000, 2);


particles = ParticleSystems();

--oscRec = Receiver();


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
end
function blud.update(t)
  box2d:update();
  Tweener:update();
  bb:clear();
  bbt:clear();
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
