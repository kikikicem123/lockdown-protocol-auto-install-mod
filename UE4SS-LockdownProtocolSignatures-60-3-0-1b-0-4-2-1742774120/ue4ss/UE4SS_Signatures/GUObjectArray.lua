function Register()
    return "48 8D ?? ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 85 DB 74 ?? 48 8B CB FF 15 ?? ?? ?? ?? 48 8B 5C 24 60 33 C0"
end

function OnMatchFound(matchAddress)
    local movInstr = matchAddress -- + 0x1A
    local nextInstr = movInstr + 0x7
    local offset = movInstr + 0x3
    local dataMoved = nextInstr + DerefToInt32(offset) -- - 0x10
    
    return dataMoved
end