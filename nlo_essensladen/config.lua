Config = {}

Config.Locations = {
    ["burgershot"] = {
        {
            label = 'Burgershot',
            coords = {
                vector3(-1200.3972, -893.4263, 13.8862),
            },
            radius = 2,
            icon = "burger",
            items = { 
                {
                    title = "Hamburger",
                    description = "1x Tomato, 1x Patty, 1x Brot",
                    progressbar = "Making Hamburger",
                    duration = 1000, 
                    requireditems = { 
                        {name = "tomato", amount = 1},
                        {name = "fvburger", amount = 1},
                        {name = "vbread", amount = 1},
                    },
                    additems = { 
                        {name = "vhamburger", amount = 1},
                    },
                },
            },
        }
    },
}
