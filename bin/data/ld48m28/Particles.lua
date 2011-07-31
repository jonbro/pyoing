ParticleSystems = class(function(ps)
  ps.systems = {}
end)

function ParticleSystems:addSystem(sprite, x, y, ...)
  local arg = {...}
  if arg[1] == nil then
    options = {}
  else
    options = arg[1]
  end
  -- going to roll with a bunch of defaults on this
  defaultUpdate = function(particle)
    -- update the position of the particles
    particle.vel:mult(0.99)
    particle.pos:add(particle.vel)
    -- draw the particle on the screen
    particle.size = particle.startSize*(1-particle.age/30)
  end
  defaultSpawn = function(i, total)
    return math.sin(math.rad(i/total*360))*4, math.cos(math.rad(i/total*360))*4, 0
  end
  self:_addSystem(x, y, sprite, options.updateFunction or defaultUpdate, options.tint or {r=255,g=255,b=255,a=255}, options.lifetime or 30, options.spawner or defaultSpawn, options.count or 20, options.size or 1)
end

function ParticleSystems:_addSystem(x, y, sprite, updateFunction, tint, lifetime, spawner, count, _size)
  system = {update=updateFunction, sprite=sprite, lifetime=lifetime, spawner=spawner, count=count}
  for i=0,system.count do
    velx, vely, velRot = system.spawner(i, system.count)
    table.insert(system, {vel=Vec2(velx, vely), pos = Vec2(x,y), age=0, tint=tint, size=_size, startSize=_size})
  end
  table.insert(self.systems, system)
end

function ParticleSystems:update()
  for i=table.maxn(self.systems),1,-1 do
      system = self.systems[i]
      -- if the system is old, then remove it
      if (system[1].age > system.lifetime) then
        table.remove(self.systems,i)
      else
        for i,v in ipairs(system) do
          v.age = v.age + 1
          system.update(v)
        end
      end
  end
end

function ParticleSystems:draw()
  for i=table.maxn(self.systems),1,-1 do
    system = self.systems[i]
    for i,v in ipairs(system) do
      sheet:addCenteredTile(system.sprite, v.pos.x, v.pos.y, 3, 0, v.size, v.tint.r, v.tint.g, v.tint.b, v.tint.a)
    end
  end  
end