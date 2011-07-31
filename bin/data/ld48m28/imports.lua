package.path = package.path .. ";"..blud.bundle_root.."ld48m28/?.lua"
do
  local filesToImport = {"class", "underscore", "Rectangle", "Group", "Object", "Camera", "bludGlobal", "Particles", "Tweener",
  "states/PlayState",
  "states/EndState",  
  "states/StartState",  
  "Objects/Base",
  "Objects/Bullet",
  "Objects/Puck"
	}
  for i, v in ipairs(filesToImport) do
    dofile(blud.bundle_root .. "/ld48m28/".. v ..".lua")
  end
end

_ = require 'underscore'