game = {}

--local tiles = {}

function game:new()
    newObj = 
    {
    --game variables
        tiles = {},
        tileDrawUnit = 30,
        whiteBlock = love.graphics.newImage('cube.png'),
        blueBlock = love.graphics.newImage('block1.png'),
        PinkBlock = love.graphics.newImage('block2.png'),
        tileScale = 0.6,
        gameTime = 60,
        difficulty = 60,
        
        
        tetrisBlocks = {tet_I, tet_O, tet_J, tet_L, tet_S, tet_Z, tet_T},
        tet_I = {offset = {1,1,1,1}, loc = {}, pivot = {1,3}},
        tet_O = {offset = {{1,1},{1,1}}, loc = {}, pivot = {1,1}},
        tet_J = {offset = {{1,0,0},{1,1,1}}, loc = {2,2}, pivot = {2,2}},
        tet_L = {offset = {{0,0,1},{1,1,1}}, loc = {2,2}, pivot = {2,2}},
        tet_S = {offset = {{0,1,1},{1,1,0}}, loc = {1,2}, pivot = {}},
        tet_Z = {offset = {{1,1,0},{0,1,1}}, loc = {1,2}, pivot = {}},
        tet_T = {offset = {{0,1,0},{1,1,1}}, loc = {}, pivot = {}},
        blockStartLoc = {0,4},
        blockCreateSwitch = true,
        blocksLanded = {}
        
    }
    
    self.__index = self
    
    return setmetatable(newObj, self)
    
end

function game:hello()
    print 'hello'
end

function game:initialize()
    for i = 1, 16 do
        self.tiles[i] = {}
        for j = 1, 8 do
            self.tiles[i][j] = { num = 1, block = 0}
        end
    end    
    
    print 'tiles initialized'
    
    
end

function game:tileCall()
    for i = 1, 16 do
        for j = 1, 8 do
            print(i, j, ':', self.tiles[i][j].num) 
        end
    end
end

function love.keypressed(key)
    
    if key == 'up' then
        rotate(currentBlock)
    end
    if key == 'left' then
        move(-1, 0)
    end
    if key == 'right' then
        move(1, 0)
    end
    if key == 'down' then
        move(0, 1)
    end
    
    
    
end

function move()

end

function rotate(block)
    
end

function game:blockCreate()
    num = love.math.random(7)
    print(num)
    self.tetrisBlocks[num].loc = self:blockStartLoc
    block = self.tetrisBlocks[num]
    return block
end

function blockDescend()

end

function checkLine()

end

function eraseLine()

end


function game:load()

end

function game:update(dt)

    self.blockCreate()
--[[
    if self.blockCreateSwitch == true then
        currentBlock = self.blockCreate()
        self.blockCreateSwitch = false
    end
    
    blockDescend()
    
    if blockLanded == true then
        self.blockCreateSwitch = true
    end
    
    if checkLine() == true then
        eraseLine()
    end
--]]
    
    
    

end

function game:draw()

    for i = 1, 16 do
        for j = 1, 8 do
            --print( j * self.tileDrawUnit, i * self.tileDrawUnit)
            love.graphics.draw(self.block, j * self.tileDrawUnit, i * self.tileDrawUnit, 0, tileScale, tileScale)
        end
    end

end


return game