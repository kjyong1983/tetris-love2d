local game = require 'game'

    g = game:new()


function love.load()
    --game:hello()
    g:hello()
    g:initialize()
    --g:tileCall()
    
end

function love.update(dt)

    g:update(dt)

end

function love.draw()

    g:draw()

end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

end


