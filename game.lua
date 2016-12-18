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
            --map[i][j].val = 0
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
    tetI = {x = {-1, 0, 1, 2}, y = {0,0,0,0}}
    tetI.b = {x = {0, 0, 0, 0}, y = {-2,-1,0,1}}
    tetO = {x = {0, 1, 0, 1}, y = {0, 0, 1, 1}}
    tetJ = {}
    tetL = {}
    tetS = {}
    tetZ = {}
    tetT = {}
    blocks = {tetO}
    --tetI = {{-2,-1,0,1},{0,0,0,0}}
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
    if elapsedTime > timeUnit then
        --print '1sec'
        --game:moveDown()
        elapsedTime = 0
    end
    
    if active == false then
        --randomblock 1
        --block.x[1], block.y[1] = startLoc.x, startLoc.y
        --map[block.x[1]][block.y[1]].val = 1
        game:getRandomBlock()
        game:checkLine()
        active = true
    end
    game:draw()
end

function game:draw()

    MapDraw()
    BlockDraw()



end

function MapDraw()

--    print 'mapdraw'
    for i = minW,maxW do
        for j = minH,maxH do
        
            --if map[i][j].val == 0 then
                love.graphics.draw(white, i*unit, j*unit, 0, scale, scale,0,0)
            --end
--[[
            if map[i][j].val == 1 then
                love.graphics.draw(blue, i*unit, j*unit, 0, scale, scale,0,0)
            end
--]]
        end        
    end


end

function BlockDraw()

--    print 'blockdraw'

    for i = 1, #block.x do
        
        
        for j = 1, #block.y do
        
            if block.x[i] ~= 0 and block.y[j] ~= 0 then
        
                love.graphics.draw(blue, i*unit, j*unit, 0, scale, scale, 0,0)
            
            end
        end
    
    
    end


end


function game:getRandomBlock()
    num = love.math.random(#blocks)
    --block = blocks[num]
    print('getRandomBlock : '..num)
    game:setBlock(blocks[num])
end

function game:setBlock(tet)
--[[
    for i = 1, #self.block do
        map[map.x + block[i].x][map.y + block[i].y].val = 1
        print('setBlock : '..map.x + block[i].x, map.y + block[i].y)
    end
    --]]
    for i = 1,#tet.x do
        for j = 1,#tet.y do
            block.x[i] = startLoc.x + tet.x[i]
            block.y[i] = startLoc.y + tet.y[i]
            --map[block.x[i]][block.y[i]].val = 1
        end
    end
    
end

function game:moveSide(s)
    if game:moveSideCheck(s) then
        print ('moving side '..s)
        game:move(s,0)
    else
        print 'not moved'
    end
end

function game:moveSideCheck(s)

    --print (block.x + i, block.y)
    if s > 0 then
        startC = {x = #block.x, y = #block.y}
        endC = {x = 1, y = 1}
        iterC = -1
    end
    
    if s < 0 then
        startC = {x = 1, y = 1}
        endC = {x = #block.x, y = #block.y}
        iterC = 1
    end
    
    
    for i = startC.x, endC.x, iterC do
    
        for j = startC.y, endC.y, iterC do
        
            if block.x[i] + s < minW or block.x[i] + s > maxW then
                if s < 0 then
                    print 'left wall'
                end
                if s > 0 then
                    print 'right wall'
                end
                    print 'moveSideCheck false by wall'
                    return false
            end
                
            if block.x[i] + s == 0 or block.y[j] == 0 then
                    print ('zero value detected on moveSideCheck : '..i..' : '..block.x[i] ..', '..j..' : '..block.y[j])
            else 
                print ('check '..block.x[i] + s , block.y[j])
                --[[
                if map[block.x[i] + s][block.y[j]].val == 1 then --+오른쪽으로 갈때 에러
                    print 'moveSideCheck false by val is 1'
                    return false
                else
                    print 'moveSideCheck true'
                    return true
                end
                --]]
            end
            
            
        
        
        
        end
    
    end
    
    
    

end

function game:move(a, b)
    --needs iteration
    
    for j = #block.y, 1, -1 do

        for i = #block.x, 1, -1 do
        
            if block.x[i] == 0 or block.y[j] == 0 then
                print ('zero value detected on move : '..block.x[i]..' '..block.y[j])
            else
                print (block.x[i],block.y[j])
                --print (block.x[i],block.y[j])
                --debug.debug()
                --map[block.x[i]][block.y[j]].val = 0
                block.x[i] = block.x[i] + a
                block.y[j] = block.y[j] + b
                print ('moved '..block.x[i],block.y[j])
                
                if block.x[i] == 0 or block.y[j] == 0 then
                    print ('zero value detected on move')
                else
                    if block.x[i] < minW or block.x[i] > maxW or block.y[j] < minH or block.y[j] > maxH then
                        print ('out of index detected : '..block.x[i]..' '..block.y[j])
                    else
                
                        --print('assign val '..block.x[i]..' '..block.y[j])
                        --print('val : '..map[block.x[i]][block.y[j]].val)
                        --map[block.x[i]][block.y[j]].val = 1
                    end
                end
            end

        end
        
    end
    
    
    
    
    
    
    if j ~= 0 then
        elapsedTime = 0
    end
    
end

function game:moveDown()
    if game:moveCheckDown() then
        game:move(0,1)
        print 'moveDown'
    end
end

function game:moveCheckDown()

    for i = #block.x, 1, -1 do
    
        for j = #block.y, 1, -1 do
            --debug.debug()
            --if  map[block.x[i]][block.y[i] + 1] == nil then
            if block.y[i] + 1 > maxH then
            print 'end of map'
            active = false
            return false
        end
        
        if block.x[i] == 0 or block.y[i] + 1 == 0 then
            print ('zero value detected on moveCheckDown : '..i..' '..j)
        else
        --[[
            if map[block.x[i]][block.y[i] + 1].val == 1 then
                print 'moveCheckDown false'
                active = false
                return false
            else
                print 'moveCheckDown true'
                return true
            end
        --]]
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

--obsolete
--[[
function game:moveDown()
    map[block.x][block.y].val = 0
    block.y = block.y + 1
    map[block.x][block.y].val = 1
    elapsedTime = 0
end
--]]
function game:hardDrop()
    
    for i = minH, maxH do
        if active ~= false then
            game:moveDown()
        else
            break
        end
    end
    
end

function game:checkLine()
    check = 0
    for j = minH, maxH do
        for i = minW, maxW do
--[[
            if map[i][j].val == 1 then
                check = check + 1
                print ('check : '..check)
            else
                break
            end
--]]
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
        --map[i][j].val = 0
    end

    for i = minW, maxW do
        for k = j, minH + 1, -1 do
            --map[i][k].val = map[i][k-1].val
        end
    end    
end

function game:rotate()
    print 'rotate'
end

return game
