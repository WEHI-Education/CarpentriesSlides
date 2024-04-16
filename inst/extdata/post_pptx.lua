function Div(div)
    -- Add the word "Challenge" to challenge divs, since in the powerpoint
    -- format we don't have a yellow box to distinguish challenges
    if div.classes:includes("challenge") then
        div = div:walk({
            Header = function(header)
                header.content:insert(1, "Challenge: ")
                return header
            end
        })
    end
    -- Remove all classes and attributes from divs
    return div.content
end

function Figure(fig)
    -- Remove captions etc from images since they mess up layout
    local ret = fig
    fig:walk({
        Image = function(img)
            img.caption = {}
            img.attributes["alt"] = nil
            ret = img
        end
    })
    return ret
end

function Para(para)
    local found_img = false
    ret = pandoc.List()
    for k, v in pairs(para.content) do
        -- Apply some image tweaks
        if v.tag == "Image" then
            found_img = true
            img = v
            local caption = img.caption
            local alt = img.attributes["alt"]
            -- Remove the caption so that Pandoc doesn't convert it to an HTML <figure>
            -- This ensures that the image is the top-level element
            img.caption = {}
            img.attributes["alt"] = nil

            if alt ~= nil and alt:len() > 0 then
                -- The alt text generally makes for a good title, if available
                ret:insert(pandoc.Header(2, alt))
            end
        end
        ret:insert(v)
    end

    if found_img then
        return ret
    else
        return para
    end
end
