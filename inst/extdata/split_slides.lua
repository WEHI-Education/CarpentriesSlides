package.path = package.path .. ";/Users/milton.m/Programming/logging/?.lua"
local logging = require 'logging'

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
        Figure = function(figure)
            pandoc.walk_block(figure, {
                Image = function(image)
                    -- If we already captured this as an Image,
                    -- remove that, because a Figure is better
                    previous = seen_images:indexOf(image)
                    logging.info(previous)
                    if previous ~= nil then
                        seen_images:remove(previous)
                    end

                    table.insert(seen_images, image)
                end
            })
            table.insert(slides, figure)
            table.insert(slides, pandoc.HorizontalRule())
        end,
        Image = function(image)
            -- Skip this if we've already seen it in a figure
            if not seen_images:includes(image) then
                table.insert(slides, image)
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
