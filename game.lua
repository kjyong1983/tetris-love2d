game = {}

function game:load()

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

function game:update(dt)

    elapsedTime = elapsedTime + dt
    --print (elapsedTime)
    if elapsedTime > timeUnit then
        --print '1sec'
        if game:moveCheckDown() then
            game:moveDown()
            --print 'moveDown'
        end
        elapsedTime = 0
    end
    
    if active == false then
        block.x, block.y = startLoc.x, startLoc.y
        game:checkLine()
        active = true
    end
    
    
    
    
end

function game:draw()

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

--[[
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
--]]
function game:getRandomBlock()
    num = love.math.random(7)
end

function game:moveCheck(i)

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

function game:move(i)
    map[block.x][block.y].val = 0
    block.x = block.x + i
    map[block.x][block.y].val = 1
end

function game:moveCheckDown()
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

function game:moveDown()
    map[block.x][block.y].val = 0
    block.y = block.y + 1
    map[block.x][block.y].val = 1
    elapsedTime = 0
end

function game:hardDrop()
    
    for i = minH, maxH do
        if active ~= false then
            if game:moveCheckDown() then
                game:moveDown()
            end
        else
            break
        end
    end
end

function game:checkLine()
    check = 0
    for j = minH, maxH do
        for i = minW, maxW do
            if map[i][j].val == 1 then
                check = check + 1
                print ('check : '..check)
            else
                break
            end
        end
        if check == maxW then
            game:eraseLine(j)
        else
            check = 0
        end
    end

end

function game:eraseLine(j)
    for i = minW, maxW do
        map[i][j].val = 0
    end

    for i = minW, maxW do
        for k = j, minH + 1, -1 do
            map[i][k].val = map[i][k-1].val
        end
    end
    
    
end

function game:rotate()

end

return game
