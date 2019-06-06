function ClassicLFG:IteratorToArray(iterator)
    local array = {}
    for v in iterator do
      array[#array + 1] = v
    end
    return array
  end

function string:SplitString(seperator)
    local fields = {}
    local pattern = string.format("([^%s]+)", seperator)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

function ClassicLFG:SplitString(text, sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    text:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

function ClassicLFG:StringContainsTableValue(text, values)
    for key in pairs(values) do
        if (string.match(text, values[key]:lower()) ~= nil) then
            return values[key]
        end
    end
    return nil
end

function ClassicLFG:RandomHash(length)
    if( length == nil or length <= 0 ) then length = 32; end;
    local holder = "";
    hash_chars = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E",
                    "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                    "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                    "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"};

    for i = 1, length do
        local index = math.random(1, #hash_chars);
        holder = holder .. hash_chars[index];
    end

    return holder;
end


function ClassicLFG:DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function ClassicLFG:RecursivePrint(object, maxDepths, layer)
    layer = layer or 1
    if (type(object) == "table" and (maxDepths == nil or layer <= maxDepths)) then
        for key in pairs(object) do
            if (type(object[key]) == "table") then
                ClassicLFG:DebugPrint("Printing Table ", key, object[key])
                ClassicLFG:RecursivePrint(object[key], maxDepths, layer + 1)
            else
                ClassicLFG:DebugPrint(key, object[key])
            end
        end
    end
end

function ClassicLFG:ArrayContainsValue(array, val)
    for index, value in ipairs(array) do
        if value == val then
            return true
        end
    end
    return false
end

function ClassicLFG:IsIgnored(playerName)
    for i = 1, C_FriendList.GetNumIgnores() do
        if (C_FriendList.GetIgnoreName(i) == playerName) then
            return true
        end
    end
    return false
end