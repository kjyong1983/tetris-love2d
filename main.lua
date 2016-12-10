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
        if game:moveCheckDown() then
            game:moveDown()
        end
    end
    if key == 'left' then
        if game:moveCheck(-1) then
            print 'moving left'
            game:move(-1)
        else
            print 'not moved'
        end
    end
    if key == 'right' then
        if game:moveCheck(1) then
            print 'moving right'
            game:move(1)
        else
            print 'not moved'
        end
    end
    if key == 'up' then
        game:rotate()
    end
    if key == 'space' then
        print 'hard drop'
        game:hardDrop()
    end
    
end


