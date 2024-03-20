function Pandoc(doc)
    slides = {}

    doc:walk({
        Image = function(image)
            table.insert(slides, image)
            table.insert(slides, pandoc.HorizontalRule())
        end,
        Div = function(div)
            cls = div.classes[1]
            if cls == "challenge" then
                table.insert(slides, div)
                table.insert(slides, pandoc.HorizontalRule())
            end
        end
    })

    -- Remove the last element
    table.remove(slides)
    return pandoc.Pandoc(slides, doc.meta)
end
