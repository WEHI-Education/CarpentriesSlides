function Pandoc(doc)
    local slides = pandoc.List({
        pandoc.Header(1, doc.meta.title),
        pandoc.HorizontalRule()
    })

    -- Only keep certain elements: figures and challenges
    doc:walk({
        Image = function(image)
            table.insert(slides, image)
            table.insert(slides, pandoc.HorizontalRule())
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
