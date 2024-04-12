function Div(div)
    if div.classes:includes("collapse") then
        div.classes:insert("show")
        div.classes = div.classes:filter(function(cls) return cls ~= "collapse" end)
    end
    return div
end
