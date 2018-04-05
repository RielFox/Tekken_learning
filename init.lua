--local screen = manager:machine().screens[":screen"]
--local cpu = manager:machine().devices[":maincpu"]
--local mem = cpu.spaces["program"]
local machine = manager:machine()
--local ioport = manager:machine():ioport()

 local exports = {}
    exports.name = "tekken_learning"
    exports.version = "0.0.1"
    exports.description = "Cycles through different Tekken games, communicates with Python neural network."
    exports.license = "The BSD 3-Clause License"
    exports.author = { name = "Riel Fox" }

    local dummy = exports
    change_game = true
    

    function sleep (a)
        local sec = tonumber(os.clock() + a);
        while (os.clock() < sec) do
        end
    end

    local function main()

        --get a seed for random numbers  
        math.randomseed(os.time())  

        --Randomly select between Tekken 1,2,3 and Tag  
        tekken_played = math.random(4)  
        print('Number selected: ' .. tostring(tekken_played))  

        --local tekken_played = 1  
        local driver
        --Load the correct Tekken, driver is the name of the rom file in /roms directory of MAME
        if tekken_played == 1  then   
            print('Loading Tekken (1994)...')  
            driver = 'tekken'  
            
        elseif tekken_played == 2  then
            emu.print_verbose('Loading Tekken 2 (1995)...')  
            driver = 'tekken2ub'  
           
        elseif tekken_played == 3  then
            emu.print_verbose('Loading Tekken 3 (1996)...') 
            driver = 'tekken3ud'
            
        elseif tekken_played == 4  then
            emu.print_verbose('Loading Tekken TAG (1999)...')
            driver = 'tektagtub'
        end

        local co = coroutine.create(function()
        
        while true do
            emu.unpause() -- at the menu the program is paused so wait will hang
            emu.wait(1)
            print('starting ' .. driver)
            emu.start(driver)
            coroutine.yield()
            end
        end)

        --os.pullEvent("key")

        --sleep(3) 
        print('aaa')
        print(coroutine.status(co))
        if change_game
        then
          print('bbb')
          change_game = false
          coroutine.resume(co)
        
        end
        print(coroutine.status(co))
        --sleep(5)
        --emu.pause()
        
       --print(machine)
        
    end


    function dummy.startplugin()
        emu.register_start(function()
            
            emu.print_verbose("Starting " .. emu.gamename())
            main()
            
        end)


        emu.register_stop(function()  
            emu.print_verbose("Exiting " .. emu.gamename())  
        end)  
    end

    return exports
