local Holy = require 'Holywood'
local showText = false

function love.load()
    anim = Holy()
    anim:setSpeed(1):onDone(function() showText = true end)
end

function love.update(dt)

end

function love.draw()
    anim:draw()
    if not showText == false then love.graphics.print("it's done", 100, 100) end
end
