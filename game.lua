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
    blockLength = 4
    curBlock = nil
    nextBlock = nil
    math.randomseed(os.time())
    
    --coordinate
    for i = minW,maxW do
        map[i] = {}
        for j = minH,maxH do
            map[i][j] = {}
            map.val = false
        end
    end
    
    startLoc = {x = 4, y = 1}
    curLoc = { x = nil, y = nil}
    active = false
    
    --set all elements of block.x, block.y to nil, set value to 0 when SetBlock() is called
    
    block = 
    {
    x = {nil,nil,nil,nil},
    y = {nil,nil,nil,nil},
    rotation = 1
    }
    
    --make rotated blocks
    tetI = {}
    tetO = {}
    tetJ = {}
    tetL = {}
    tetS = {}
    tetZ = {}
    tetT = {}
    
    tetI[1] = {x = {-1, 0, 1, 2}, y = {0,0,0,0}}
    tetI[2] = {x = {0, 0, 0, 0}, y = {-2,-1,0,1}}
    tetI[3] = {x = {-1, 0, 1, 2}, y = {0,0,0,0}}
    tetI[4] = {x = {0, 0, 0, 0}, y = {-2,-1,0,1}}
    
    tetO[1] = {x = {0, 1, 0, 1}, y = {0, 0, 1, 1}}
    tetO[2] = {x = {0, 1, 0, 1}, y = {0, 0, 1, 1}}
    tetO[3] = {x = {0, 1, 0, 1}, y = {0, 0, 1, 1}}
    tetO[4] = {x = {0, 1, 0, 1}, y = {0, 0, 1, 1}}
    
    tetJ[1] = {x = {-1,-1,0,1}, y = {-1,0,0,0}}
    tetJ[2] = {x = {0,0,0,1}, y = {-1,0,1,-1}}
    tetJ[3] = {x = {-1,0,1,1}, y = {0,0,0,1}}
    tetJ[4] = {x = {-1,0,0,0}, y = {1,-1,0,1}}
    
    tetL[1] = {x = {-1,0,1,1}, y = {0,0,0,-1}}
    tetL[2] = {x = {0,0,0,1}, y = {-1,0,1,1}}
    tetL[3] = {x = {-1,-1,0,1}, y = {1,0,0,0}}
    tetL[4] = {x = {-1,0,0,0}, y = {-1,-1,0,1}}
    
    tetS[1] = {x = {-1,0,0,1}, y = {1,1,0,0}}
    tetS[2] = {x = {-1,-1,0,0}, y = {-1,0,0,1}}
    tetS[3] = {x = {-1,0,0,1}, y = {1,1,0,0}}
    tetS[4] = {x = {-1,-1,0,0}, y = {-1,0,0,1}}
    
    tetZ[1] = {x = {-1,0,0,1}, y = {0,0,1,1}}
    tetZ[2] = {x = {0,0,1,1}, y = {-1,0,0,1}}
    tetZ[3] = {x = {-1,0,0,1}, y = {0,0,1,1}}
    tetZ[4] = {x = {0,0,1,1}, y = {-1,0,0,1}}
    
    tetT[1] = {x = {0,-1,0,1}, y = {-1,0,0,0}}
    tetT[2] = {x = {0,0,0,1}, y = {-1,0,1,0}}
    tetT[3] = {x = {0,-1,0,1}, y = {1,0,0,0}}
    tetT[4] = {x = {-1,0,0,0}, y = {0,-1,0,1}}
    
    blocks = {tetI, tetO, tetJ, tetL, tetS, tetZ, tetT}
    
end

function game:update(dt)

    elapsedTime = elapsedTime + dt
    if elapsedTime > timeUnit then
        --print '1sec'
        --game:moveDown()
        elapsedTime = 0
    end
    
    if active == false then
        --game:blockToMap()
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

    for i = minW,maxW do
        for j = minH,maxH do        
        
            if map[i][j].val == true then
                love.graphics.draw(pink, i*unit, j*unit, 0, scale, scale,0,0)
            else
            
            love.graphics.draw(white, i*unit, j*unit, 0, scale, scale,0,0)
            
            end
        end        
    end

end

function BlockPairs()
    local blockPairs = {}
    for i=1, blockLength do
        blockPairs[i] = {x=block.x[i], y=block.y[i]}
    end
    return blockPairs
end

function BlockDraw()

    for i, xyPair in ipairs(BlockPairs()) do

        --print (xyPair.x, xyPair.y)
        love.graphics.draw(blue, xyPair.x * unit, xyPair.y * unit, 0, scale, scale, 0,0)
    
    end


end


function game:getRandomBlock()
    num = love.math.random(#blocks)
    print('getRandomBlock : '..num)
    curBlock = blocks[num]
    curLoc.x = startLoc.x
    curLoc.y = startLoc.y
    print('curLoc'..curLoc.x..' '..curLoc.y)
    game:setBlock(blocks[num][1])
    
end

function game:setBlock(tet)

    for i = 1,#tet.x do
        for j = 1,#tet.y do
            print('b ')
            print(block.x[i])
            print('c ')
            print(curLoc.x)
            print('t ')
            print(tet.x[i])
            
            block.x[i] = curLoc.x + tet.x[i]
            block.y[j] = curLoc.y + tet.y[j]
            --print (block.x[i], block.y[j])
        end
    end
    
    print('setBlock end')
    
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
        startC = blockLength
        endC = 1
        iterC = -1
    end
    
    if s < 0 then
        startC = 1
        endC = blockLength
        iterC = 1
    end
    
    --[[
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
    
            end
            
            
        
        
        
        end
    
    end
    --]]
    
    
    
    for i = startC, endC, iterC do
    
        if block.x[i] + s < minW or block.x[i] + s > maxW then
            
            return false
            
        end
        
        
        
        return true
        
    
    end
    
    

end

function game:move(a, b)
    --needs iteration
--[[
    for j = #block.y, 1, -1 do

        for i = #block.x, 1, -1 do
        
            if block.x[i] == 0 or block.y[j] == 0 then
                print ('zero value detected on move : '..block.x[i]..' '..block.y[j])
            else
                print (block.x[i],block.y[j])
                block.x[i] = block.x[i] + a
                block.y[j] = block.y[j] + b
                print ('moved '..block.x[i],block.y[j])
                
                if block.x[i] == 0 or block.y[j] == 0 then
                    print ('zero value detected on move')
                else
                    if block.x[i] < minW or block.x[i] > maxW or block.y[j] < minH or block.y[j] > maxH then
                        print ('out of index detected : '..block.x[i]..' '..block.y[j])
                    else
                
                    end
                end
            end

        end
        
    end
    
--]]

     for i = 1, blockLength do
        
            block.x[i] = block.x[i] + a
            block.y[i] = block.y[i] + b
    
    end
    
    curLoc.x = curLoc.x + a
    curLoc.y = curLoc.y + b
    

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
--[[
    for i = #block.x, 1, -1 do
    
        for j = #block.y, 1, -1 do
    
            if block.y[i] + 1 > maxH then
            print 'end of map'
            active = false
            return false
            
        end
        
        if block.x[i] == 0 or block.y[i] + 1 == 0 then
            print ('zero value detected on moveCheckDown : '..i..' '..j)
        else
        
        end
        

        end
    
    end
--]]
    
    --check block down
    for i = blockLength, 1, -1 do
    
        --end of map check
    
        if block.y[i] + 1 > maxH then
            print 'end of map'
            game:blockToMap()
            active = false
            return false
            
        end
        
        --check blocks in map
        
        if map[block.x[i]][block.y[i] + 1].val == true then
            game:blockToMap()
            active = false
            return false
        end
        
    
    end
    
    
    
    
    --map
    return true
    
    
end

function game:hardDrop()
    
    for i = minH, maxH do
        if active ~= false then
            game:moveDown()
        else
            break
        end
    end
    
end

function game:blockToMap()

    for i = 1, blockLength do
    
        map[block.x[i]][block.y[i]].val = true
    
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

function game:rotate(tet)
    print 'rotate'

    if block.rotation == 4 then
        block.rotation = 0
    end
    
    block.rotation = block.rotation + 1
    print('debug')
    
    game:setBlock(curBlock[block.rotation])

    --check down, if there is no space, rise block by 1 unit
    --moveCheckDown()
    --move(0,-1)
    
end

return game
