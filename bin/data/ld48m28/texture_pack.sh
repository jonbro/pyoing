TexturePacker --auto-sd --no-trim --format corona --data sprite_list-hd.lua --width 2048 --height 2048 --algorithm MaxRects --sheet assets/cute@2x.png ungroupedSprites/*;
sed -i"" "/module/d" sprite_list.lua;
sed -i"" "/module/d" sprite_list-hd.lua;