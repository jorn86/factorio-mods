for _, fluid in pairs(data.raw.fluid) do
    if not fluid.auto_barrel then
        fluid.auto_barrel = true
    end
end

if settings.startup["bo-remove-fluid-wagon"].value then
    data.raw.technology["fluid-wagon"] = nil
end
