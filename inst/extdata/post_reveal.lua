function Pandoc(doc)
    -- Add the title slide for the whole lesson
    doc.blocks:insert(1, pandoc.Header(1, doc.meta.title, {
        classes = "presentation-title"
    }))
    if doc.meta.subtitle ~= nil then
        doc.blocks:insert(1, pandoc.Header(2, doc.meta.subtitle))
    end
    if doc.meta.author ~= nil then
        doc.blocks:insert(1, pandoc.Header(2, doc.meta.author))
    end
    doc.blocks:insert(1, pandoc.HorizontalRule())
end

function Div(div)
    -- Expand the solution box for challenges
    if div.classes:includes("collapse") then
        div.classes:insert("show")
        div.classes = div.classes:filter(function(cls) return cls ~= "collapse" end)
    end
    return div
end

-- TODO: fix the figure handling to add appropriate titles
function Figure(fig)
    local img = nil
    -- Find the image inside the figure
    fig:walk({
        Image = function(image) 
            img = image
        end
    })
    return img
    --[[
    local caption = img.caption
    local alt = img.attributes["alt"]
    local ret = pandoc.List()
    -- Remove the caption so that Pandoc doesn't convert it to an HTML <figure>
    -- This ensures that the image is the top-level element
    img.caption = {}
    img.attributes["alt"] = nil
    -- Then we can add r-stretch and the image will auto-resize
    img.classes:insert("r-stretch")
    if alt ~= nil and alt:len() > 0 then
        -- The alt text generally makes for a good title
        table.insert(ret, pandoc.Header(2, alt))
    elseif caption ~= nil and #caption > 0 then
    end
    table.insert(ret, img)
    if #caption > 0 then
        -- Add the caption as text under the image.
        -- This is preferable to using an actual figure (see comment above)
        table.insert(ret, caption)
    end
    return ret
    --]]
end
