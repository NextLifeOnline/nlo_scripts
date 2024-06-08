Config = {}

Config.AFK = {
    {
        label = "Bergwerk",
        coords = {
            vec3(3002.0413, 2789.8418, 44.5109),
            vec3(2997.2073, 2750.2397, 44.4594)
        },

        radius = 3,
        process = false,
        
        items = {
            { item = "aluminium", label = "Aluminium"},
            { item = "iron", label = "Eisen" },
            { item = "diamond", label = "Diamant" },
            { item = "gold", label = "Gold" },
            { item = "copper", label = "Kupfer" },
        },

        needItem = {
            needs = false,
            item = "pickaxe"
        },

        dur = 3000,
    }
}