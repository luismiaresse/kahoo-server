Config = {}
Config.Locale = "es"
Config.RepairOnSpawn = true		-- Repara automáticamente el coche
Config.OutPrice = 250 			-- Precio para recuperar un coche fuera del garaje
Config.ImpoundPrice = 1000 		-- Precio para recuperar un coche en el depósito
Config.DrawDistance = 25.0

Config.Markers = {
	EntryPoint = {
		Type = 21,
		Size = {
			x = 1.0,
			y = 1.0,
			z = 0.5,
		},
		Color = {
			r = 93,
			g = 240,
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
			r = 93,
			g = 240,
			b = 255,
		},
	},
}

Config.Garages = {
	VespucciBoulevard = {
		EntryPoint = vector3(-285.2, -886.5, 31.0),
		SpawnPoint = vector4(-309.3, -897.0, 31.0, 351.8),
		Sprite = 357,
		Scale = 0.8,
		Colour = 0,
	},
	SanAndreasAvenue = {
		EntryPoint = vector3(216.4, -786.6, 30.8),
		SpawnPoint = vector4(218.9, -779.7, 30.8, 338.8),
		Sprite = 357,
		Scale = 0.8,
		Colour = 0,
	},
	LaMesa = {
		EntryPoint = vector3(1002.09, -1858.37, 30.68),
		SpawnPoint = vector4(994.83, -1858.68, 30.88, 178.58),
		Sprite = 357,
		Scale = 0.8,
		Colour = 0,
	},
	LosSantosAirport = {
		EntryPoint = vector3(-1016.65, -2696.04, 13.98),
		SpawnPoint = vector4(-980.4, -2701.06, 12.86, 56.0),
		Sprite = 357,
		Scale = 0.8,
		Colour = 0,
	},
	SandyShores = {
		EntryPoint = vector3(1729.89, 3711.2, 34.14),
		SpawnPoint = vector4(1737.84, 3719.28, 33.04, 21.22),
		Sprite = 357,
		Scale = 0.8,
		Colour = 0,
	},
	PaletoBay = {
		EntryPoint = vector3(110.83, 6608.25, 31.80),
		SpawnPoint = vector4(128.78, 6622.99, 30.78, 315.01),
		Sprite = 357,
		Scale = 0.8,
		Colour = 0,
	},
	CayoPerico = {
		EntryPoint = vector3(4490.25, -4511.40, 4.41),
		SpawnPoint = vector4(4511.52, -4517.73, 4.11, 22.2),
		Sprite = 357,
		Scale = 0.8,
		Colour = 0,
	}
}

exports("getGarages", function()
	return Config.Garages
end)
