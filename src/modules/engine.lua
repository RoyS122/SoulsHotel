local engine = {}

function engine.sign(number)
    if number < 0 then
        return -1
    else
        if number > 0 then
            return 1
        end
    end
    return 0
end

function engine.abs(number)
    if number < 0 then
        return number / - 1
    end
    return number
end

function engine.saveHS(hsTab) 
    local success, message =love.filesystem.write( filename, hsTab)
    if success then 
	    print ('Fichier créé')
    else 
	    print ('Fichier non créé : '..message)
    end
end

function engine.array_contains(arr, s)
    for i = 1, #arr do 
        if arr[i] == s then 
         
            return true 
        end
    end
    return false
end 

return engine