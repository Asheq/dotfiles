local success, module = pcall(require, 'colorizer')

if success then
    module.setup()
else
    -- print('Error: Module "colorizer" not found')
end
