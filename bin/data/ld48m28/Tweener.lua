-- just going to use a static thing here, becuase I don't need multiple ones

Tweener = {}

Tweener.runningTweens = {} -- for storing all of the tweens that we are running
Tweener.equations = {}

function Tweener.equations.easeNone (t, b, c, d)
 return c*t/d + b;
end
-- function Tweener.equations.easeInQuad (t, b, c, d)
--   t=t/d
--  return c*(t)*t + b;
-- end
-- function Tweener.equations.easeOutQuad (t, b, c, d)
--   t=t/d
--  return -c *(t)*(t-2) + b;
-- end
-- function Tweener.equations.easeInOutQuad (t, b, c, d)
--   t = t/d/2
--  if ((t) < 1) then return c/2*t*t + b end
--  return -c/2 * ((t-1)*(t-2) - 1) + b
-- end
function Tweener.equations.inOutElastic(t, b, c, d, a, p)
  local s
  if t == 0 then return b end
  t = t / d * 2
  if t == 2 then return b + c end
  p,a,s = calculatePAS(p,a,c,d)
  t = t - 1
  if t < 0 then return -0.5 * (a * math.pow(2, 10 * t) * math.sin((t * d - s) * (2 * PI) / p)) + b end
  return a * math.pow(2, -10 * t) * math.sin((t * d - s) * (2 * PI) / p ) * 0.5 + c + b
end
function calculatePAS(p,a,c,d)
  p, a = p or d * 0.3, a or 0
  if a < math.abs(c) then return p, c, p / 4 end -- p, a, s
  return p, a, p / (2 * PI) * math.asin(c/a) -- p,a,s
end
function Tweener.equations.inElastic(t, b, c, d, a, p)
  local s
  if t == 0 then return b end
  t = t / d
  if t == 1  then return b + c end
  p,a,s = calculatePAS(p,a,c,d)
  t = t - 1
  return -(a * math.pow(2, 10 * t) * math.sin((t * d - s) * (2 * PI) / p)) + b
end
function Tweener.equations.outElastic(t, b, c, d, a, p)
  local s
  if t == 0 then return b end
  t = t / d
  if t == 1 then return b + c end
  p,a,s = calculatePAS(p,a,c,d)
  return a * math.pow(2, -10 * t) * math.sin((t * d - s) * (2 * PI) / p) + c + b
end
function Tweener.equations.outBounce(t, b, c, d)
  t = t / d
  if t < 1 / 2.75 then return c * (7.5625 * t * t) + b end
  if t < 2 / 2.75 then
    t = t - (1.5 / 2.75)
    return c * (7.5625 * t * t + 0.75) + b
  elseif t < 2.5 / 2.75 then
    t = t - (2.25 / 2.75)
    return c * (7.5625 * t * t + 0.9375) + b
  end
  t = t - (2.625 / 2.75)
  return c * (7.5625 * t * t + 0.984375) + b
end
function Tweener.equations.outExpo (t, b, c, d)
	return t==d and b+c or c * 1.001 * (-math.pow(2, -10 * t/d) + 1) + b;
end
function Tweener.equations.inExpo(t, b, c, d)
  if t == 0 then
    return b
  else
    return c * math.pow(2, 10 * (t / d - 1)) + b - c * 0.001
  end
end
function Tweener.equations.easeInOutSine (t, b, c, d)
	return -c/2 * (math.cos(PI*t/d) - 1) + b;
end

function Tweener:addTween(object, props, ...)
  local arg = {...}
  local t = {}
  t.object = object
  t.props = {}
  for j, v in pairs(props) do
    table.insert(t.props, {prop=j, start=object[j], target=v-object[j]})
  end
  arg[1] = arg[1] or {}
  t.time = arg[1].time or 1
  t.func = arg[1].func or "outExpo"
  t.onComplete = arg[1].onComplete or function() end
  t.currentTime = 0
  table.insert(self.runningTweens, t);
  return t
end
function Tweener:removeTween(tween)
  for i=table.maxn(self.runningTweens),1,-1 do
    if self.runningTweens[i] == tween then table.remove(self.runningTweens, i); end
  end
end
function Tweener:update()
  for i=table.maxn(self.runningTweens),1,-1 do
    -- update the current time
    local tt = self.runningTweens[i]
    tt.currentTime = tt.currentTime + bludG.elapsed
    if tt.currentTime > tt.time then
      -- make sure that the property moved all the way to the end
      for j, v in ipairs(tt.props) do
        tt.object[v.prop] = v.target+v.start
      end
      tt.onComplete(tt.object)
      table.remove(self.runningTweens, i)
    else
      for j, v in ipairs(tt.props) do
        if tt.object[v.prop] ~= v.target+v.start then -- don't tween if they are already the same
          tt.object[v.prop] = self.equations[tt.func](tt.currentTime, v.start, v.target, tt.time)
        end
      end
    end
  end
end
