local Holywood = {}
Holywood.__index = Holywood

local w, h = love.graphics.getWidth(), love.graphics.getHeight()
-- TODO

function screen(opacity)
    love.graphics.setColor(1, 1, 1, opacity)
    love.graphics.rectangle('fill', 0, 0, w, h)
    love.graphics.setColor(1, 1, 1, 1)
end    

local animations = { {name = 'simple_screen', func = screen} , {name = 'point', func = nil} , {name = 'screen_shake' , func = nil} }

local function new(speed, opacity)
    return setmetatable({
        _name = 'holy'          , 
        _animation = nil        ,
        _shapes = {}            ,
        _speed = speed or 1     ,
        _opacity = opacity or 1 ,
        _onStart = nil          ,
        _onDone = nil           ,
        _debugMode = false      
    }, Holywood)
end

function Holywood:setAnimation(index)
    self._animation = animations[index]
    return self
end

function Holywood:startTransition()
    return self
end

function Holywood:endTransition()
    return self
end

function Holywood:onStart(callback)
    self._onStart = callback 
    return self
end

function Holywood:setSpeed(speed)
    self._speed = speed or 1
    return self
end

function Holywood:addShape(shape)
    table.insert(_shapes, shape)
    return self
end

function Holywood:onDone(callback)
    self._onDone = callback or (function() print('onDone') end)
    return self
end

function Holywood:update(dt)
    self._opacity = self._opacity - (dt * self._speed)
    if self._opacity <= 0 and self._onDone ~= nil then self._onDone() self._onDone = nil  end
    print(self._opacity)
end

function Holywood:draw()
    local dt = love.timer.getDelta()
    self:update(dt)
    animations[1].func(self._opacity)
end

function Holywood:setDebug(foo)
    self._debugMode = foo
    return self
end

return setmetatable({new = new},
{__call = function(_, ...) return new(...) end})
