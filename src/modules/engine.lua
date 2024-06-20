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


return engine