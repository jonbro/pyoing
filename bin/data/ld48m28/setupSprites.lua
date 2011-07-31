spriteSize = 72
sheetSize = 1024
sheet_name = "cute"
if bg:getWidth() > 320 then
  spriteSize = spriteSize*2
  sheetSize = sheetSize*2
  sheet_name = "cute@2x"
end

-- setup a new sprite sheet with 2 layer, 5000 tiles per layer, default layer of 0, tile size of 32
sheet = bludSpriteSheet(5, 2000, 0, spriteSize);

-- load the texture onto the sheet
-- takes the following parameters `(filename, sheetsize)`. The sheet must be a power of 2, and square.
sheet:loadTexture(blud.bundle_root .. "/ld48m28/assets/".. sheet_name ..".png", sheetSize)
sprites = {}


-- load sprites from the list
list = getSpriteSheetData()
for i, v in ipairs(list.frames) do
  sprite = bludSprite();
  sprite:setTotalFrames(1)
  
  sprite:setWidth(v.spriteSourceSize.width/spriteSize)
  sprite:setHeight(v.spriteSourceSize.height/spriteSize)
  
  -- determine the index based on the position in the sheet
  index = (v.textureRect.x/spriteSize)+math.floor(sheetSize/spriteSize)*v.textureRect.y/spriteSize
  sprite:setIndex(index)
  
  -- the new way just sets the sprite positioning based on x y offsets
  sprite:setTexX(v.textureRect.x)
  sprite:setTexY(v.textureRect.y)
  sprite:setTexWidth(v.textureRect.width)
  sprite:setTexHeight(v.textureRect.height)
  sprite:setWidth(v.spriteColorRect.width)
  sprite:setHeight(v.spriteColorRect.height)
  sprite:setSpriteX(v.spriteColorRect.x)
  sprite:setSpriteY(v.spriteColorRect.y)

  sprite:setLoops(-1)
  sprites[v.name] = sprite
  -- print(v.name, index)
end
