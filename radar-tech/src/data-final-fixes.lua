for _,radar in pairs(data.raw["radar"]) do
    if string.sub(radar.name, 0, 3) ~= "rt-" then print(radar.name) end
end
