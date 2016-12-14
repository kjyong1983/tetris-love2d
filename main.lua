local game = require 'game'

function love.load()
    game: load()    
end

function love.update(dt)

    game:update(dt)

end

function love.draw()

    game:draw()

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'down' then
        game:moveDown()
    end
    if key == 'left' then
        game:moveSide(-1)
    end
    if key == 'right' then
        game:moveSide(1)
    end
    if key == 'up' then
        game:rotate()
    end
    if key == 'space' then
        print 'hard drop'
        game:hardDrop()
    end
    
end


