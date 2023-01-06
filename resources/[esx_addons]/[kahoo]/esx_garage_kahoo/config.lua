Config = {}
Config.Locale = "es"
Config.RepairOnSpawn = true		-- Repara automáticamente el coche
Config.DrawDistance = 20.0

Config.Markers = {
	EntryPoint = {
		Type = 21,
		Size = {
			x = 1.0,
			y = 1.0,
			z = 0.5,
		},
		Color = {
			r = 255,
			g = 255,
			b = 255,
		},
	},
	GetOutPoint = {
		Type = 21,
		Size = {
			x = 1.0,
			y = 1.0,
			z = 0.5,
		},
		Color = {
			r = 255,
			g = 255,
			b = 255,
		},
	},
}

Config.Garages = {
	VespucciBoulevard = {
		EntryPoint = {
			x = -285.2,
			y = -886.5,
			z = 31.0,
		},
		SpawnPoint = {
			x = -309.3,
			y = -897.0,
			z = 31.0,
			heading = 351.8,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 0,
	},
	SanAndreasAvenue = {
		EntryPoint = {
			x = 216.4,
			y = -786.6,
			z = 30.8,
		},
		SpawnPoint = {
			x = 218.9,
			y = -779.7,
			z = 30.8,
			heading = 338.8,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 0,
	}
}

exports("getGarages", function()
	return Config.Garages
end)
