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
    active = false
    
    --block = {x = 0, y = 0, val = 1}
    block = 
    {
    x = {0,0,0,0,0,0},
    y = {0,0,0,0,0,0}
    }
--    blocks = {}
    b1 = {x = -1}
    b1 = {}
    b2 = {}
    b3 = {}
    b4 = {}
    b5 = {}
    b6 = {}
    blocks = {tetI}
    tetI = {{-2,-1,0,1},{0,0,0,0}}
--[[     
   
    tetI = {{x = block.x-2, y = block.y}, {x = block.x-1, y = block.y}, {x = block.x, y = block.y}, {x = block.x+1, y = block.y}}
    tetO = {x = 0, y = 0, val = 1, {x = block.x, y = block.y}, {x = block.x+1, y = block.y}, {x = block.x, y = block.y+1}, {x = block.x+1, y = block.y+1}}
    tetJ = {}
    tetL = {}
    tetS = {}
    tetZ = {}
    tetT = {}
--]]
    --block.x, block.y = startLoc.x, startLoc.y
    --map[block.x][block.y].val = block.val
    --map[4][6].val = 1
    
    --print 'love.load'
    
end

function game:update(dt)

    elapsedTime = elapsedTime + dt
    --print (elapsedTime)
    if elapsedTime > timeUnit then
        --print '1sec'
--        if game:moveCheckDown() then
--            game:moveDown()
            --print 'moveDown'
--        end
        elapsedTime = 0
    end
    
    if active == false then
        block.x, block.y = startLoc.x, startLoc.y
        game:checkLine()
        block = game:getRandomBlock()
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

function game:getRandomBlock()
    num = love.math.random(#blocks)
    block = blocks[num]
    print('getRandomBlock : '..num)
    game:setBlock()
end

function game:setBlock()
    for i = 1, #self.block do
        map[map.x + block[i].x][map.y + block[i].y].val = 1
        print('setBlock : '..map.x + block[i].x, map.y + block[i].y)
    end
end

function game:moveCheck(i)

    print (block.x + i, block.y)

    if block.x + i < minW or block.x + i > maxW then
        if i < 0 then
            --print 'left wall'
        end
        if i > 0 then
            --print 'right wall'
        end
        --print 'moveCheck false'
        return false
    end
    
    if map[block.x + i][block.y].val == 1 then
        --print 'moveCheck false'
        return false
    else
        --print 'moveCheck true'
        return true
    end

end

function game:move(i)
    map[block.x][block.y].val = 0
    block.x = block.x + i
    map[block.x][block.y].val = 1
end

function game:moveCheckDown()
    for i = 1, #self.block.x do
    
        for j = 1, #block.y do
            if  map[block.x[i]][block.y[i] + 1] == nil then
            print 'end of map'
            active = false
            return false
        end

        if map[block.x[i]][block.y[i] + 1].val == 1 then
            print 'moveCheckDown false'
            active = false
            return false
        else
            print 'moveCheckDown true'
            return true
        end

        end
    
    end
--[[
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
--]]
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
    print 'rotate'
end

return game
