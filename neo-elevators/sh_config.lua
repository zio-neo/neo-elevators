Config = {}

Config.Lang = {
    OnThisFloor = "(On This Floor)",
    AlreadyInElevator = "You are already in elevator...",
    ChangedMind = "You have changed your mind...",
    NotAllowed = "You are not allowed...",
}

Config.Anim = {
    Dict = "anim@apt_trans@elevator",
    Name = "elev_1",
    Flags = 16,
}

Config.Fade = false -- Fully Fades When You Are Changing Floors
Config.SecondalFade = true -- Only Fades When You Are Teleporting

Config.Target = false -- Uses qb-target

Config.DrawTextKey = {
    Key = 38,
    String = "[E] ",
}

Config.Elevators = {
    ["Mazebank Elevator"] = {
        Target = "Elevator",
        TargetIcon = "fas fa-elevator",
        Distance = 2,
        Job = nil,
        SoundEffect = {
            WhereToPlay = "Both", -- OnFinish, OnStart, Both
            OnStartSoundEffect = "elevatormusic",
            OnFinishSoundEffect = "LiftSoundRingBell",
            Loudness = 0.2,
        },
        Progressbar = {
            Label = "Using Elevator",
            Duration = 15000,
        },
        Floors = {
            [1] = {
                Label = "Top Floor",
                Coord = vector3(-74.432, -824.0109, 321.3338),
                Poly = {
                    minZ = 320.292,
                    maxZ = 322.6069,
                    Length = 1.0,
                    Width = 1.0,
                    Heading = 343.44,
                },
                Spawn = {
                    PlayerSpawn = vector3(-75.05, -824.43, 321.29),
                    PlayerHeading = 162.02,
                },
            },
            [2] = {
                Label = "Bottom Floor",
                Coord = vector3(-84.1352, -821.4475, 35.029),
                Poly = {
                    minZ = 35.02825,
                    maxZ = 38.4517,
                    Length = 8.5,
                    Width = 7.0,
                    Heading = 169.93,
                },
                Spawn = {
                    PlayerSpawn = vector3(-84.23, -820.34, 36.03),
                    PlayerHeading = 349.98,
                }
            },
        }
    },
    ["Arcadius Business Center"] = {
        Target = "Elevator",
        TargetIcon = "fas fa-elevator",
        Distance = 2,
        Job = nil,
        SoundEffect = {
            WhereToPlay = "Both", -- OnFinish, OnStart or Both
            OnStartSoundEffect = "elevatormusic",
            OnFinishSoundEffect = "LiftSoundRingBell",
            Loudness = 0.2,
        },
        Progressbar = {
            Label = "Using Elevator",
            Duration = 8000,
        },
        Floors = {
            [1] = {
                Label = "Top Floor",
                Coord = vector3(-143.8982, -598.4178, 207.0207),
                Poly = {
                    minZ = 205.9197,
                    maxZ = 208.2022,
                    Length = 0.2,
                    Width = 0.2,
                    Heading = 342.44,
                },
                Spawn = {
                    PlayerSpawn = vector3(-144.63, -598.95, 206.92),
                    PlayerHeading = 163.14,
                },
            },
            [2] = {
                Label = "Office Floor",
                Coord = vector3(-142.029, -618.5567, 169.0284),
                Poly = {
                    minZ = 168.8488,
                    maxZ = 169.1849,
                    Length = 0.2,
                    Width = 0.2,
                    Heading = 97.01,
                },
                Spawn = {
                    PlayerSpawn = vector3(-141.83, -617.87, 168.82),
                    PlayerHeading = 273.91,
                },
            },
            [3] = {
                Label = "Bottom Floor",
                Coord = vector3(-117.6286, -604.3972, 36.6181),
                Poly = {
                    minZ = 35.2857,
                    maxZ = 38.4641,
                    Length = 0.2,
                    Width = 0.2,
                    Heading = 70.24,
                },
                Spawn = {
                    PlayerSpawn = vector3(-117.06, -604.74, 36.28),
                    PlayerHeading = 249.68,
                },
            },
            [4] = {
                Label = "Garage Floor",
                Coord = vector3(-144.0578, -576.3058, 31.4245),
                Poly = {
                    minZ = 31.4245,
                    maxZ = 34.8457,
                    Length = 8.5,
                    Width = 7.0,
                    Heading = 339.42,
                },
                Spawn = {
                    PlayerSpawn = vector3(-143.85, -575.93, 32.42),
                    PlayerHeading = 161.27,
                }
            },
        }
    },
    -- ADD AFTER THIS LINE
}