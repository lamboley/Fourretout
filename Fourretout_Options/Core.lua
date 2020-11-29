local Engine = unpack(select(2, ...))

function Engine:Description(order, name, width, fontSize)
    return {
        type = 'description',
        order = order,
        name = name,
        width = width,
        fontSize = fontSize,
    }
end

function Engine:BigSpacer(order, fontSize)
    return {
        type = 'description',
        order = order,
        name = ' ',
        fontSize = fontSize,
    }
end

function Engine:Spacer(order, fontSize)
    return {
        type = 'description',
        order = order,
        name = '',
        fontSize = fontSize,
    }
end
