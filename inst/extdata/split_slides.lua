function pandoc.List:indexOf(self, needle)
    for index, value in ipairs(self) do
        if value == needle then
            return index
        end
    end
    return nil
end

function Pandoc(doc)
    local slides = pandoc.List({
        pandoc.Header(1, doc.meta.title),
        pandoc.HorizontalRule()
    })
    local seen_images = pandoc.List()

    -- Only keep certain elements: figures and challenges
    doc:walk({
        Image = function(image)
            -- Skip this if we've already seen it in a figure
            if not seen_images:includes(image) then
                local caption = image.caption
                local alt = image.attributes["alt"]
                -- Remove the caption so that Pandoc doesn't convert it to an HTML <figure>
                -- This ensures that the image is the top-level element
                -- Then we can add r-stretch and the image will auto-resize
                image.caption = {}
                image.attributes["alt"] = nil
                image.classes:insert("r-stretch")
                if alt ~= nil and alt:len() > 0 then
                    table.insert(slides, pandoc.Header(2, alt))
                end
                table.insert(slides, image)
                if #caption > 0 then
                    table.insert(slides, caption)
                end
                table.insert(slides, pandoc.HorizontalRule())

                table.insert(seen_images, image)
            end
        end,
        Div = function(div)
            if div.classes:includes("challenge") then
                -- Find the solution block, and remove it from inside the challenge
                -- since we want them on separate slides
                solution = nil
                challenge = div:walk({
                    Div = function(subdiv) 
                        if subdiv.classes:includes("solution") then
                            solution = subdiv
                            return {}
                        else
                            return subdiv
                        end
                    end
                })
                table.insert(slides, challenge)
                table.insert(slides, pandoc.HorizontalRule())

                if solution ~= nil then
                    table.insert(slides, solution)
                    table.insert(slides, pandoc.HorizontalRule())
                end
            end
        end
    })

    return pandoc.Pandoc(slides)
end
