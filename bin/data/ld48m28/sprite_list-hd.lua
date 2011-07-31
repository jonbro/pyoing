
-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:5f6640b0769ea92490c18e4c526649fa$
-- 
-- Usage example:
--			local sheetData = require "ThisFile.lua"
--          local data = sheetData.getSpriteSheetData()
--			local spriteSheet = sprite.newSpriteSheetFromData( "Untitled.png", data )
-- 
-- For more details, see http://developer.anscamobile.com/content/game-edition-sprite-sheets

function getSpriteSheetData()
    local sheet = {
        frames = {
            {
                name = "blue_bg.png",
                spriteColorRect = { x = 0, y = 0, width = 640, height = 480 },
                textureRect = { x = 640, y = 0, width = 640, height = 480 },
                spriteSourceSize = { width = 640, height = 480 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "blue_circle.png",
                spriteColorRect = { x = 0, y = 0, width = 300, height = 300 },
                textureRect = { x = 1580, y = 121, width = 300, height = 300 },
                spriteSourceSize = { width = 300, height = 300 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "border.png",
                spriteColorRect = { x = 0, y = 0, width = 80, height = 80 },
                textureRect = { x = 1486, y = 421, width = 80, height = 80 },
                spriteSourceSize = { width = 80, height = 80 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "bw_circle.png",
                spriteColorRect = { x = 0, y = 0, width = 100, height = 100 },
                textureRect = { x = 1920, y = 0, width = 100, height = 100 },
                spriteSourceSize = { width = 100, height = 100 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "center_line.png",
                spriteColorRect = { x = 0, y = 0, width = 640, height = 40 },
                textureRect = { x = 1280, y = 81, width = 640, height = 40 },
                spriteSourceSize = { width = 640, height = 40 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "fill.png",
                spriteColorRect = { x = 0, y = 0, width = 80, height = 80 },
                textureRect = { x = 1920, y = 100, width = 80, height = 80 },
                spriteSourceSize = { width = 80, height = 80 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "loser_text.png",
                spriteColorRect = { x = 0, y = 0, width = 154, height = 154 },
                textureRect = { x = 1880, y = 180, width = 154, height = 154 },
                spriteSourceSize = { width = 154, height = 154 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "play_text.png",
                spriteColorRect = { x = 0, y = 0, width = 130, height = 130 },
                textureRect = { x = 1880, y = 334, width = 130, height = 130 },
                spriteSourceSize = { width = 130, height = 130 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "red_bg.png",
                spriteColorRect = { x = 0, y = 0, width = 640, height = 480 },
                textureRect = { x = 0, y = 0, width = 640, height = 480 },
                spriteSourceSize = { width = 640, height = 480 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "red_circle.png",
                spriteColorRect = { x = 0, y = 0, width = 300, height = 300 },
                textureRect = { x = 1280, y = 121, width = 300, height = 300 },
                spriteSourceSize = { width = 300, height = 300 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "text_bg.png",
                spriteColorRect = { x = 0, y = 0, width = 640, height = 81 },
                textureRect = { x = 1280, y = 0, width = 640, height = 81 },
                spriteSourceSize = { width = 640, height = 81 },
                spriteTrimmed = false,
                textureRotated = false
            },
            {
                name = "winner_text.png",
                spriteColorRect = { x = 0, y = 0, width = 206, height = 206 },
                textureRect = { x = 1280, y = 421, width = 206, height = 206 },
                spriteSourceSize = { width = 206, height = 206 },
                spriteTrimmed = false,
                textureRotated = false
            },
        }
    }
    return sheet
end

