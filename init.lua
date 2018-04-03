

 local exports = {}
    exports.name = "tekken_learning"
    exports.version = "0.0.1"
    exports.description = "Cycles through different Tekken games, >communicates with Python neural network"
    exports.license = "The BSD 3-Clause License"
    exports.author = { name = "Riel Fox" }

    local dummy = exports

    function sleep (a)
        local sec = tonumber(os.clock() + a);
        while (os.clock() < sec) do
        end
    end

    local function main()

        --get a seed for random numbers  
        math.randomseed(os.time())  

        --randomly select between Tekken 1,2,3 and Tag  
        tekken_played = math.random(4)  
        print('Number selected: ' .. tostring(tekken_played))  

        local tekken_played = 1  
        local driver
        --load the correct Tekken  
        if tekken_played == 1  then   
            emu.print_verbose('Loading Tekken (1994)...')  
            driver = 'tekken'  
        elseif tekken_played == 2  then
            print('Loading Tekken 2 (1995)...')  
        elseif tekken_played == 3  then
            print('Loading Tekken 3 (1996)...')  
        elseif tekken_played == 4  then
            print('Loading Tekken TAG (1999)...')  

        end

        local co = coroutine.create(function()
            emu.unpause() -- at the menu the program is paused so wait will hang
            emu.wait(3)
            print('starting ' .. driver)
            emu.start(driver)
        end)

        --os.pullEvent("key")

        --sleep(3) 
        print('aaa')
        coroutine.resume(co)
        --sleep(5)
        emu.pause()
        
    end


    function dummy.startplugin()
        emu.register_start(function()
            main()
            emu.print_verbose("Starting " .. emu.gamename())
        end)

        emu.register_stop(function()  
            emu.print_verbose("Exiting " .. emu.gamename())  
        end)  
    end

    return exports