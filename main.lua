
function love.load()

    unit = 30
    scale = 0.6
    blue = love.graphics.newImage("blue.png")
    white = love.graphics.newImage("white.png")
    pink = love.graphics.newImage("pink.png")
    map = {}
    elapsedTime = 0
    timeUnit = 1
    minW = 1
    maxW = 8
    minH = 1
    maxH = 16
    
    --coordinate
    for i = minW,maxW do
        map[i] = {}
        for j = minH,maxH do
            map[i][j] = {}
            map[i][j].val = 0
        end
    end
    
    startLoc = {x = 4, y = 1}
    
    block = {x = 0, y = 0, val = 1}
    active = true
    
    block1 = {block.x - 2, block.x - 1, block.x, block.x + 1}

    
    block.x, block.y = startLoc.x, startLoc.y
    map[block.x][block.y].val = block.val
    --map[4][6].val = 1
    
    --print 'love.load'
    
end

function love.update(dt)

    elapsedTime = elapsedTime + dt
    --print (elapsedTime)
    if elapsedTime > timeUnit then
        --print '1sec'
        if moveCheckDown() then
            moveDown()
            --print 'moveDown'
        end
        elapsedTime = 0
    end
    
    if active == false then
        block.x, block.y = startLoc.x, startLoc.y
        active = true
    end
    
    
    
    
end

function love.draw()

    for i = minW,maxW do
        for j = minH,maxH do
        
            if map[i][j].val == 0 then
                love.graphics.draw(white, i*unit, j*unit, 0, scale, scale,0,0)
            end
            if map[i][j].val == 1 then
                love.graphics.draw(blue, i*unit, j*unit, 0, scale, scale,0,0)
            end

        end        
    end

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'down' then
        if moveCheckDown() then
            moveDown()
        end
    end
    if key == 'left' then
        if moveCheck(-1) then
            print 'moving left'
            move(-1)
        else
            print 'not moved'
        end
    end
    if key == 'right' then
        if moveCheck(1) then
            print 'moving right'
            move(1)
        else
            print 'not moved'
        end
    end
    if key == 'up' then
        rotate()
    end
    if key == 'space' then
        print 'hard drop'
        hardDrop()
    end
    
end

function getRandomBlock()
    num = love.math.random(7)
end

function moveCheck(i)

    print (block.x + i, block.y)

--    if  map[block.x + i][block.y] == nil then --check index is nil
    if block.x + i < minW or block.x + i > maxW then
        if i < 0 then
            print 'left wall'
        end
        if i > 0 then
            print 'right wall'
        end
        print 'moveCheck false'
        return false
    end
    
    if map[block.x + i][block.y].val == 1 then
        print 'moveCheck false'
        return false
    else
        print 'moveCheck true'
        return true
    end

end

function move(i)
    map[block.x][block.y].val = 0
    block.x = block.x + i
    map[block.x][block.y].val = 1
end

function moveCheckDown()
    if  map[block.x][block.y + 1] == nil then
        print 'end of map'
        active = false
        return false
    end

    if map[block.x][block.y + 1].val == 1 then
        print 'moveCheckDown false'
        active = false
        return false
    else
        print 'moveCheckDown true'
        return true
    end
end

function moveDown()
    map[block.x][block.y].val = 0
    block.y = block.y + 1
    map[block.x][block.y].val = 1
    elapsedTime = 0
end

function hardDrop()

end
