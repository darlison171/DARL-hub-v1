DB HUB - QUEST DATABASE Draft consolidated file for GitHub Names are
kept in their original English.

– ========================================== – DB HUB | QUEST DATABASE –
FIRST SEA + SECOND SEA + THIRD SEA – Catalog of quest islands, levels
and targets – ==========================================

local QUEST_DATABASE = {

    FirstSea = {
        {
            island = "Starter Island",
            minLevel = 1, maxLevel = 15,
            questNPC = {"Bandit Quest Giver", "Marine Leader"},
            targets = {"Bandits", "Trainees"}
        },
        {
            island = "Jungle",
            minLevel = 15, maxLevel = 50,
            questNPC = {"Jungle Quest Giver"},
            targets = {"Monkeys", "Gorillas", "Gorilla King"}
        },
        {
            island = "Pirate Village",
            minLevel = 30, maxLevel = 90,
            questNPC = {"Pirate Village Quest Giver"},
            targets = {"Pirates", "Brutes", "Bobby the Clown"}
        },
        {
            island = "Desert",
            minLevel = 60, maxLevel = 90,
            questNPC = {"Hasan"},
            targets = {"Desert Bandits", "Desert Officers"}
        },
        {
            island = "Middle Island",
            minLevel = 100, maxLevel = 100,
            questNPC = {"Weapon Dealer"},
            targets = {"Saw"}
        },
        {
            island = "Frozen Village",
            minLevel = 90, maxLevel = 120,
            questNPC = {"Sick Man", "Ability Teacher"},
            targets = {"Snow Bandits", "Snowmen", "Yeti"}
        },
        {
            island = "Marine Fortress",
            minLevel = 120, maxLevel = 150,
            questNPC = {"Parlus"},
            targets = {"Chief Petty Officers", "Vice Admiral"}
        },
        {
            island = "Skylands - Low",
            minLevel = 150, maxLevel = 190,
            questNPC = {"Mad Scientist"},
            targets = {"Sky Bandits", "Dark Masters"}
        },
        {
            island = "Prison",
            minLevel = 190, maxLevel = 275,
            questNPC = {"Military Detective"},
            targets = {
                "Prisoners", "Dangerous Prisoners",
                "Warden", "Chief Warden", "Swan"
            }
        },
        {
            island = "Colosseum",
            minLevel = 225, maxLevel = 300,
            questNPC = {"Colosseum Quest Giver"},
            targets = {"Toga Warriors", "Gladiators"}
        },
        {
            island = "Magma Village",
            minLevel = 300, maxLevel = 375,
            questNPC = {"Mayor"},
            targets = {
                "Military Soldiers", "Military Spies",
                "Magma Admiral"
            }
        },
        {
            island = "Underwater City",
            minLevel = 375, maxLevel = 450,
            questNPC = {"King Neptune"},
            targets = {
                "Fishman Warriors", "Fishman Commandos",
                "Fishman Lord"
            }
        },
        {
            island = "Skylands - High",
            minLevel = 450, maxLevel = 625,
            questNPC = {"Instinct Teacher"},
            targets = {
                "God's Guards", "Shandas", "Wysper",
                "Royal Squads", "Thunder God"
            }
        },
        {
            island = "Fountain City",
            minLevel = 625, maxLevel = 700,
            questNPC = {"Freezeburg Quest Giver"},
            targets = {
                "Galley Pirates", "Galley Captains", "Cyborg"
            }
        }
    },

    SecondSea = {
        {
            island = "Kingdom of Rose - Area 1",
            levels = {700, 725},
            questNPC = {"Area 1 Quest Giver"},
            targets = {"Raiders", "Mercenaries"},
            bosses = {"Diamond", "Jeremy"}
        },
        {
            island = "Kingdom of Rose - Area 2",
            levels = {775, 800},
            questNPC = {"Area 2 Quest Giver"},
            targets = {"Swan Pirates", "Factory Staff"},
            bosses = {"Diamond", "Jeremy"}
        },
        {
            island = "Green Zone",
            levels = {875, 900},
            questNPC = {"Marine Quest Giver"},
            targets = {"Marine Lieutenants", "Marine Captains"},
            bosses = {"Fajita"}
        },
        {
            island = "Graveyard Island",
            levels = {950, 975},
            questNPC = {"Graveyard Quest Giver"},
            targets = {"Zombies", "Vampires"}
        },
        {
            island = "Snow Mountain",
            levels = {1000, 1050},
            questNPC = {"Snow Quest Giver"},
            targets = {"Snow Troopers", "Winter Warriors"}
        },
        {
            island = "Hot and Cold - Cold",
            levels = {1100, 1125},
            questNPC = {"Cold Quest Giver"},
            targets = {"Lab Subordinates", "Horned Warriors"},
            bosses = {"Smoke Admiral"}
        },
        {
            island = "Hot and Cold - Hot",
            levels = {1175, 1200},
            questNPC = {"Hot Quest Giver"},
            targets = {"Magma Ninjas", "Lava Pirates"},
            bosses = {"Order"}
        },
        {
            island = "Cursed Ship",
            levels = {1250, 1275, 1300, 1325},
            questNPC = {"Ship Quest Giver"},
            targets = {
                "Ship Deckhands", "Ship Engineers",
                "Ship Stewards", "Ship Officers"
            },
            bosses = {"Cursed Captain"}
        },
        {
            island = "Ice Castle",
            levels = {1350, 1375},
            questNPC = {"Ice Quest Giver"},
            targets = {"Arctic Warriors", "Snow Lurkers"},
            bosses = {"Awakened Ice Admiral"}
        },
        {
            island = "Forgotten Island",
            levels = {1425, 1450},
            questNPC = {"Forgotten Quest Giver"},
            targets = {"Sea Soldiers", "Water Fighters"},
            bosses = {"Tide Keeper"}
        }
    },

    ThirdSea = {
        {
            island = "Port Town",
            levels = {1500, 1525},
            targets = {
                {name = "Pirate Millionaires", count = 8, money = 13000, xp = "53m"},
                {name = "Pistol Billionaires", count = 8, money = 15000, xp = "55.5m"}
            }
        },
        {
            island = "Hydra Island",
            levels = {1575, 1600, 1625, 1650},
            targets = {
                "Dragon Crew Warriors", "Dragon Crew Archers",
                "Hydra Enforcers", "Venomous Assailants"
            },
            targetCount = 8
        },
        {
            island = "Great Tree",
            levels = {1700, 1725},
            targets = {
                {name = "Marine Commodores", count = 8, money = 13000, xp = "68m"},
                {name = "Marine Rear Admirals", count = 8, money = 15000, xp = "70.5m"}
            }
        },
        {
            island = "Floating Turtle",
            levels = {1775, 1800, 1825, 1850, 1900, 1925},
            targets = {
                {name = "Fishman Raiders", count = 8, money = 13000, xp = "73m"},
                {name = "Fishman Captains", count = 8, money = 15000, xp = "75.5m"},
                {name = "Forest Pirates", count = 8, money = 13000, xp = "78m"},
                {name = "Mythological Pirates", count = 8, money = 13000, xp = "81m"},
                {name = "Jungle Pirates", count = 8, money = 15000, xp = "85m"},
                {name = "Musketeer Pirates", count = 8, money = 15000, xp = "87.5m"}
            }
        },
        {
            island = "Haunted Castle",
            levels = {1975, 2000, 2025, 2050},
            targets = {
                {name = "Reborn Skeletons", count = 8, money = 13000, xp = "91m"},
                {name = "Living Zombies", count = 8, money = 13300, xp = "93.5m"},
                {name = "Demonic Souls", count = 8, money = 13500, xp = "96m"},
                {name = "Possessed Mummies", count = 8, money = 13750, xp = "98.5m"}
            }
        },
        {
            island = "Peanut Land",
            levels = {2075, 2100},
            targets = {
                {name = "Peanut Scouts", count = 8, money = 14000, xp = "100m"},
                {name = "Peanut Presidents", count = 8, money = 14100, xp = "102.5m"}
            }
        },
        {
            island = "Ice Cream Land",
            levels = {2125, 2150},
            targets = {
                {name = "Ice Cream Chefs", count = 8, money = 14200, xp = "105m"},
                {name = "Ice Cream Commanders", count = 8, money = 14300, xp = "107.5m"}
            }
        },
        {
            island = "Cake Land",
            levels = {2200, 2225, 2250},
            targets = {
                {name = "Cookie Crafters", count = 8, money = 14400, xp = "110m"},
                {name = "Cake Guards", count = 8, money = 14500, xp = "112.5m"},
                {name = "Baking Staff", count = 8, money = 14400, xp = "115m"}
            }
        },
        {
            island = "Chocolate Land",
            levels = {2300, 2325, 2350},
            targets = {
                {name = "Cocoa Warriors", count = 8, money = 14600, xp = "120m"},
                {name = "Chocolate Bar Battlers", count = 8, money = 14700, xp = "122.5m"},
                {name = "Sweet Thieves", count = 8, money = 14800, xp = "125m"}
            }
        },
        {
            island = "Tiki Outpost",
            levels = {2450, 2475, 2500, 2525, 2550, 2575},
            questNPC = {
                "Tiki Quest Giver 1",
                "Tiki Quest Giver 2",
                "Tiki Quest Giver 3"
            },
            targets = {
                "Isle Outlaws", "Island Boys", "Sun-kissed Warriors",
                "Isle Champions", "Serpent Hunters", "Skull Slayers"
            },
            targetCount = 8
        },
        {
            island = "Submerged Island",
            levels = {2600, 2625, 2650, 2675, 2700, 2725},
            questNPC = {
                "Submerged Quest Giver 1",
                "Submerged Quest Giver 2",
                "Submerged Quest Giver 3"
            },
            targets = {
                "Reef Bandits", "Coral Pirates", "Sea Chanters",
                "Ocean Prophets", "High Disciples", "Grand Devotees"
            },
            targetCount = 8
        }
    }

}

– Find a quest entry by level. – Note: overlapping First Sea ranges are
preserved from supplied data. local function findLevelEntry(entries,
level) for _, entry in ipairs(entries) do if entry.minLevel and
entry.maxLevel and level >= entry.minLevel and level <= entry.maxLevel
then return entry end

        if entry.levels then
            for _, questLevel in ipairs(entry.levels) do
                if level == questLevel then
                    return entry
                end
            end
        end
    end

    return nil

end

local function getProgression(sea, level) local entries =
QUEST_DATABASE[sea] if not entries then return nil end

    return findLevelEntry(entries, level)

end

– Example: – local result = getProgression(“ThirdSea”, 2500) – if result
then print(result.island) end

return { QuestDatabase = QUEST_DATABASE, GetProgression = getProgression
}
