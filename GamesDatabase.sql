-------------------------------------------------------------------------------------
-- 1. Drop Existing Tables (if any) and Create New Tables
-------------------------------------------------------------------------------------
DROP TABLE IF EXISTS game_modes, modes,
                    game_genre, game_platform, 
                    games, genres, platforms, publishers;

CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    publisher_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE platforms (
    platform_id SERIAL PRIMARY KEY,
    platform_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT CHECK (release_year BETWEEN 2000 AND 2024),
    publisher_id INT REFERENCES publishers(publisher_id),
    metascore DECIMAL(3,1),
    sales DECIMAL(10,2),
    country VARCHAR(50) NOT NULL
);

CREATE TABLE game_genre (
    game_id INT REFERENCES games(game_id),
    genre_id INT REFERENCES genres(genre_id),
    PRIMARY KEY (game_id, genre_id)
);

CREATE TABLE game_platform (
    game_id INT REFERENCES games(game_id),
    platform_id INT REFERENCES platforms(platform_id),
    PRIMARY KEY (game_id, platform_id)
);

-------------------------------------------------------------------------------------
-- 2. Insert Publishers
-------------------------------------------------------------------------------------
INSERT INTO publishers (publisher_name) 
VALUES 
('Nintendo'), ('FromSoftware'), ('Rockstar Games'), ('Larian Studios'),
('Square Enix'), ('Valve'), ('CD Projekt Red'), ('Sony Interactive Entertainment'),
('Capcom'), ('Bethesda'), ('Mojang Studios'), ('Naughty Dog'), ('Epic Games'),
('Bandai Namco'), ('Ubisoft'), ('Electronic Arts'), ('Blizzard Entertainment'),
('Hello Games'), ('ConcernedApe'), ('Team Cherry'), ('Remedy Entertainment'),
('Arkane Studios'), ('Guerrilla Games'), ('BlueTwelve Studio'), ('Saber Interactive'),
('Pocketpair'), ('Sega'), ('Meta'), ('Hoyoverse'), ('Annapurna Interactive'),
('Activision'), ('Warner Bros. Games'), ('Xbox Game Studios'), ('Focus Entertainment'),
('Dream Games'), ('Taleworlds Entertainment'), ('Soner Kara (Dice & Fold)'),
('Core Loop Games (New Cycle)'), ('Nokta Games (Supermarket Simulator)'),
('Firenut Games (Anomaly Agent)');

-------------------------------------------------------------------------------------
-- 3. Insert Genres
-------------------------------------------------------------------------------------
INSERT INTO genres (genre_name) 
VALUES
('Action RPG'), ('CRPG'), ('Action-Adventure'), ('RPG'), ('Survival Horror'),
('Platform'), ('Battle Royale'), ('Simulation'), ('FPS'), ('Metroidvania'),
('Roguelike'), ('Bulmaca'), ('Dövüş'), ('MMORPG'), ('Souls-like'), ('Sandbox'),
('Open World'), ('Horror'), ('Shooter'), ('Strategy'), ('Sports'), ('Rhythm'),
('Stealth'), ('Visual Novel'), ('Retro Koleksiyon'), ('Taktiksel RPG'),
('Mecha Simülasyon'), ('Görsel Roman'), ('Psikolojik Korku'), ('Dedektiflik'),
('Kart');

-------------------------------------------------------------------------------------
-- 4. Insert Platforms
-------------------------------------------------------------------------------------
INSERT INTO platforms (platform_name)
VALUES
('Nintendo Switch'), ('PS5'), ('PC'), ('Xbox Series X/S'), ('PS4'), ('Xbox One'),
('Wii U'), ('Mobile'), ('VR'), ('PS3'), ('Xbox 360'), ('GameCube'), ('PS2'),
('Stadia'), ('MacOS'), ('Linux'), ('PS Vita'), ('Nintendo 3DS'), ('Meta Quest 3');

-------------------------------------------------------------------------------------
-- 5. Insert All Games (with Country and Sales Data)
-------------------------------------------------------------------------------------
INSERT INTO games (title, release_year, publisher_id, metascore, sales, country)
VALUES
('The Legend of Zelda: Breath of the Wild', 2017, 1, 97, 30.0, 'Japonya'),
('Elden Ring', 2022, 2, 96, 20.5, 'Japonya'),
('Grand Theft Auto V', 2013, 3, 97, 180.0, 'ABD'),
('Baldur''s Gate 3', 2023, 4, 96, 25.0, 'Belçika'),
('Final Fantasy VII Rebirth', 2024, 5, 92, 15.2, 'Japonya'),
('Half-Life: Alyx', 2020, 6, 93, 2.1, 'ABD'),
('The Witcher 3: Wild Hunt', 2015, 7, 93, 50.0, 'Polonya'),
('God of War Ragnarök', 2022, 8, 94, 15.0, 'ABD'),
('Resident Evil 4 Remake', 2023, 9, 93, 6.5, 'Japonya'),
('Starfield', 2023, 10, 87, 12.0, 'ABD'),
('Minecraft', 2011, 11, 93, 300.0, 'İsveç'),
('The Last of Us Part II', 2020, 12, 93, 10.0, 'ABD'),
('Fortnite', 2017, 13, 78, 27.0, 'ABD'),
('Dark Souls', 2011, 2, 89, 15.0, 'Japonya'),
('Red Dead Redemption 2', 2018, 3, 97, 53.0, 'ABD'),
('Hades', 2020, 14, 93, 2.0, 'ABD'),
('Stardew Valley', 2016, 15, 89, 20.0, 'ABD'),
('Disco Elysium', 2019, 16, 97, 1.5, 'Estonya'),
('Hollow Knight', 2017, 17, 90, 3.0, 'Avustralya'),
('Animal Crossing: New Horizons', 2020, 1, 90, 43.0, 'Japonya'),
('Cyberpunk 2077', 2020, 7, 86, 25.0, 'Polonya'),
('Portal 2', 2011, 6, 95, 10.0, 'ABD'),
('The Elder Scrolls V: Skyrim', 2011, 10, 94, 60.0, 'ABD'),
('Super Mario Odyssey', 2017, 1, 97, 26.0, 'Japonya'),
('Sekiro: Shadows Die Twice', 2019, 2, 91, 10.0, 'Japonya'),
('Death Stranding', 2019, 8, 82, 5.0, 'Japonya'),
('Bloodborne', 2015, 8, 92, 3.0, 'Japonya'),
('Persona 5 Royal', 2020, 18, 95, 3.5, 'Japonya'),
('Celeste', 2018, 19, 94, 1.5, 'Kanada'),
('It Takes Two', 2021, 20, 89, 7.0, 'İsveç'),
('Returnal', 2021, 8, 86, 1.0, 'Japonya'),
('Metal Gear Solid V: The Phantom Pain', 2015, 21, 93, 6.0, 'Japonya'),
('Shadow of the Colossus', 2005, 8, 91, 2.0, 'Japonya'),
('Apex Legends', 2019, 22, 88, 25.0, 'ABD'),
('Super Smash Bros. Ultimate', 2018, 1, 93, 32.0, 'Japonya'),
('Stray', 2022, 23, 83, 5.0, 'Fransa'),
('Ghost of Tsushima', 2020, 8, 83, 9.0, 'ABD'),
('Horizon Forbidden West', 2022, 24, 88, 8.0, 'Hollanda'),
('Dead Cells', 2018, 25, 91, 5.0, 'Fransa'),
('Tetris Effect: Connected', 2020, 26, 93, 1.0, 'ABD'),
('Mass Effect 2', 2010, 27, 94, 7.0, 'Kanada'),
('Undertale', 2015, 28, 93, 1.0, 'ABD'),
('Fallout: New Vegas', 2010, 10, 84, 12.0, 'ABD'),
('Alan Wake 2', 2023, 29, 89, 4.0, 'Finlandiya'),
('Hogwarts Legacy', 2023, 30, 84, 22.0, 'ABD'),
('Helldivers 2', 2024, 8, 85, 8.0, 'İsveç'),
('Dragon''s Dogma 2', 2024, 9, 87, 5.0, 'Japonya'),
('Final Fantasy XVI', 2023, 5, 87, 7.0, 'Japonya'),
('Star Wars Jedi: Survivor', 2023, 31, 85, 10.0, 'ABD'),
('Lies of P', 2023, 32, 84, 2.0, 'Güney Kore'),
('Paper Mario: The Thousand-Year Door (Remastered)', 2024, 1, 94, 3.0, 'Japonya'),
('Palworld', 2024, 33, 85, 15.0, 'Japonya'),
('Tales of Kenzera: Zau', 2024, 34, 88, 1.5, 'Birleşik Krallık'),
('Indika', 2024, 35, 87, 0.8, 'Rusya'),
('Stardew Valley 1.6 Update', 2024, 15, 96, 25.0, 'ABD'),
('Deep Rock Galactic: Survivor', 2024, 36, 82, 2.0, 'Danimarka'),
('Unicorn Overlord', 2024, 5, 92, 4.0, 'Japonya'),
('Frostpunk 2', 2024, 37, 89, 5.0, 'Polonya'),
('Persona 3 Reload', 2024, 18, 90, 6.0, 'Japonya'),
('The Crimson Diamond', 2024, 38, 78, 0.12, 'ABD'),
('I Am Your Beast', 2024, 39, 82, 0.3, 'Almanya'),
('Star Wars Outlaws', 2024, 40, 87, 12.0, 'ABD'),
('The Plucky Squire', 2024, 38, 90, 3.0, 'Avustralya'),
('Like a Dragon: Infinite Wealth', 2024, 14, 89, 8.0, 'Japonya'),
('1000xResist', 2024, 33, 88, 0.15, 'Kanada'),
('Grunn', 2024, 13, 70, 0.08, 'Türkiye'),
('Call of Duty: Black Ops 6 (Campaign)', 2024, 6, 88, 25.0, 'ABD'),
('Llamasoft: The Jeff Minter Story', 2024, 23, 85, 0.25, 'Birleşik Krallık'),
('Sorry We''re Closed', 2024, 7, 75, 0.1, 'ABD'),
('Children of the Sun', 2024, 4, 83, 0.4, 'Almanya'),
('Homeworld 3', 2024, 11, 82, 3.0, 'Kanada'),
('Botany Manor', 2024, 5, 89, 0.6, 'Birleşik Krallık'),
('MechWarrior 5: Clans', 2024, 1, 79, 0.7, 'Kanada'),
('Arranger: A Role-Puzzling Adventure', 2024, 14, 87, 0.2, 'ABD'),
('Fear the Spotlight', 2024, 3, 81, 0.15, 'ABD'),
('Batman: Arkham Shadow (VR)', 2024, 15, 91, 1.2, 'ABD'),
('Zenless Zone Zero', 2024, 16, 86, 5.0, 'Çin'),
('Lorelei and the Laser Eyes', 2024, 26, 90, 1.0, 'İsveç'),
('Prince of Persia: The Lost Crown', 2024, 19, 89, 5.0, 'Fransa'),
('The Rise of the Golden Idol', 2024, 8, 88, 1.0, 'Birleşik Krallık'),
('Shin Megami Tensei V: Vengeance', 2024, 18, 89, 4.0, 'Japonya'),
('Slay the Princess: The Pristine Cut', 2024, 9, 90, 0.5, 'ABD'),
('Steamworld Heist 2', 2024, 10, 84, 0.3, 'İsveç'),
('Wild Bastards', 2024, 1, 84, 0.3, 'Kanada'),
('World of Warcraft: The War Within', 2024, 18, 89, 10.0, 'ABD'),
('Backyard Baseball ''97', 2024, 33, 68, 0.05, 'ABD'),
('UFO 50', 2024, 21, 91, 2.0, 'ABD'),
('Neva', 2024, 23, 89, 1.0, 'İspanya'),
('Lego Horizon Adventures', 2024, 5, 83, 3.0, 'ABD'),
('Dragon''s Dogma 2', 2024, 9, 87, 5.0, 'Japonya'),
('Metaphor: ReFantazio', 2024, 18, 94, 6.0, 'Japonya'),
('Balatro', 2024, 7, 90, 4.0, 'Birleşik Krallık'),
('Animal Well', 2024, 33, 91, 2.0, 'ABD'),
('Hades 2 (Early Access)', 2024, 14, 93, 2.5, 'ABD'),
('Helldivers 2', 2024, 8, 85, 8.0, 'İsveç'),
('Indiana Jones and the Great Circle', 2024, 19, 89, 7.0, 'ABD'),
('Final Fantasy XIV: Dawntrail', 2024, 5, 89, 5.5, 'Japonya'),
('Tekken 8', 2024, 20, 90, 9.0, 'Japonya'),
('Destiny 2: The Final Shape', 2024, 31, 89, 12.0, 'ABD'),
('Silent Hill 2 Remake', 2024, 32, 89, 6.0, 'Japonya'),
('Dice & Fold', 2024, 33, 80, 1.2, 'Türkiye'),
('New Cycle', 2024, 34, 75, 0.8, 'Türkiye'),
('Supermarket Simulator', 2024, 35, 78, 2.5, 'Türkiye'),
('Anomaly Agent', 2024, 36, 82, 1.5, 'Türkiye');

-------------------------------------------------------------------------------------
-- 6. Insert Game-Genre Relationships
-------------------------------------------------------------------------------------
/*
  (game_id, genre_id) -- "Game Title" + "Genre Name"
  Each line annotated with the matching game and genre for clarity.
*/
INSERT INTO game_genre (game_id, genre_id) VALUES
(1,1)   -- The Legend of Zelda: Breath of the Wild + Action RPG
,(1,3)  -- The Legend of Zelda: Breath of the Wild + Action-Adventure
,(2,1)  -- Elden Ring + Action RPG
,(2,15) -- Elden Ring + Souls-like
,(3,3)  -- Grand Theft Auto V + Action-Adventure
,(4,2)  -- Baldur's Gate 3 + CRPG
,(5,4)  -- Final Fantasy VII Rebirth + RPG
,(6,9)  -- Half-Life: Alyx + FPS
,(7,4)  -- The Witcher 3: Wild Hunt + RPG
,(8,3)  -- God of War Ragnarök + Action-Adventure
,(9,5)  -- Resident Evil 4 Remake + Survival Horror
,(10,4) -- Starfield + RPG
,(10,17)-- Starfield + Open World
,(11,16)-- Minecraft + Sandbox
,(12,3) -- The Last of Us Part II + Action-Adventure
,(13,7) -- Fortnite + Battle Royale
,(14,1) -- Dark Souls + Action RPG
,(14,15)-- Dark Souls + Souls-like
,(15,3) -- Red Dead Redemption 2 + Action-Adventure
,(16,11)-- Hades + Roguelike
,(17,8) -- Stardew Valley + Simulation
,(18,2) -- Disco Elysium + CRPG
,(19,10)-- Hollow Knight + Metroidvania
,(20,8) -- Animal Crossing + Simulation
,(21,4) -- Cyberpunk 2077 + RPG
,(21,17)-- Cyberpunk 2077 + Open World
,(22,12)-- Portal 2 + Bulmaca (Puzzle)
,(23,4) -- Skyrim + RPG
,(23,17)-- Skyrim + Open World
,(24,6) -- Super Mario Odyssey + Platform
,(25,1) -- Sekiro + Action RPG
,(25,15)-- Sekiro + Souls-like
,(26,3) -- Death Stranding + Action-Adventure
,(27,1) -- Bloodborne + Action RPG
,(27,15)-- Bloodborne + Souls-like
,(28,4) -- Persona 5 Royal + RPG
,(29,6) -- Celeste + Platform
,(30,3) -- It Takes Two + Action-Adventure
,(31,11)-- Returnal + Roguelike
,(32,3) -- Metal Gear Solid V + Action-Adventure
,(32,23)-- Metal Gear Solid V + Stealth
,(33,3) -- Shadow of the Colossus + Action-Adventure
,(34,7) -- Apex Legends + Battle Royale
,(35,13)-- Super Smash Bros. Ultimate + Dövüş (Fighting)
,(36,3) -- Stray + Action-Adventure
,(37,3) -- Ghost of Tsushima + Action-Adventure
,(38,1) -- Horizon Forbidden West + Action RPG
,(39,10)-- Dead Cells + Metroidvania
,(39,11)-- Dead Cells + Roguelike
,(40,12)-- Tetris Effect: Connected + Bulmaca
,(41,4) -- Mass Effect 2 + RPG
,(42,4) -- Undertale + RPG
,(43,4) -- Fallout: New Vegas + RPG
,(44,18)-- Alan Wake 2 + Horror
,(45,4) -- Hogwarts Legacy + RPG
,(46,19)-- Helldivers 2 + Shooter
,(47,1) -- Dragon's Dogma 2 + Action RPG
,(48,4) -- Final Fantasy XVI + RPG
,(49,3) -- Star Wars Jedi: Survivor + Action-Adventure
,(50,18)-- Lies of P + Horror
,(51,12)-- Paper Mario TTYD (Remastered) + Bulmaca
,(51,3) -- Paper Mario TTYD (Remastered) + Action-Adventure
,(52,17)-- Palworld + Open World
,(52,7) -- Palworld + Battle Royale
,(53,10)-- Tales of Kenzera: Zau + Metroidvania
,(54,29)-- Indika + Psikolojik Korku
,(55,8) -- Stardew Valley 1.6 Update + Simulation
,(56,20)-- Deep Rock Galactic: Survivor + Strategy
,(57,26)-- Unicorn Overlord + Taktiksel RPG
,(58,20)-- Frostpunk 2 + Strategy
,(59,4) -- Persona 3 Reload + RPG
,(60,28)-- The Crimson Diamond + Görsel Roman
,(61,3) -- I Am Your Beast + Action-Adventure
,(62,19)-- Star Wars Outlaws + Shooter
,(63,24)-- The Plucky Squire + Visual Novel
,(64,29)-- Like a Dragon: Infinite Wealth + Psikolojik Korku
,(65,22)-- 1000xResist + Rhythm
,(66,20)-- Grunn + Strategy
,(67,19)-- Call of Duty: Black Ops 6 + Shooter
,(68,24)-- Llamasoft: The Jeff Minter Story + Visual Novel
,(69,26)-- Sorry We're Closed + Taktiksel RPG
,(70,12)-- Children of the Sun + Bulmaca
,(71,4) -- Homeworld 3 + RPG
,(72,28)-- Botany Manor + Görsel Roman
,(73,26)-- MechWarrior 5: Clans + Taktiksel RPG
,(74,15)-- Arranger: A Role-Puzzling Adventure + Souls-like
,(75,30)-- Fear the Spotlight + Dedektiflik
,(76,28)-- Batman: Arkham Shadow (VR) + Görsel Roman
,(77,1) -- Zenless Zone Zero + Action RPG
,(78,12)-- Lorelei and the Laser Eyes + Bulmaca
,(79,10)-- Prince of Persia: The Lost Crown + Metroidvania
,(80,15)-- The Rise of the Golden Idol + Souls-like
,(81,31)-- Shin Megami Tensei V: Vengeance + Kart
,(82,24)-- Slay the Princess: The Pristine Cut + Visual Novel
,(83,10)-- Steamworld Heist 2 + Metroidvania
,(84,26)-- Wild Bastards + Taktiksel RPG
,(85,29)-- World of Warcraft: The War Within + Psikolojik Korku
,(86,3) -- Backyard Baseball '97 + Action-Adventure
,(87,1) -- UFO 50 + Action RPG
,(88,4) -- Neva + RPG
,(89,31)-- Lego Horizon Adventures + Kart
,(90,26)-- Dragon's Dogma 2 (second) + Taktiksel RPG
,(91,4) -- Metaphor: ReFantazio + RPG
,(92,11)-- Balatro + Roguelike
,(93,10)-- Animal Well + Metroidvania
,(94,11)-- Hades 2 (Early Access) + Roguelike
,(95,3) -- Helldivers 2 (second) + Action-Adventure
,(96,29)-- Indiana Jones and the Great Circle + Psikolojik Korku
,(97,4) -- Final Fantasy XIV: Dawntrail + RPG
,(98,19)-- Tekken 8 + Shooter (?)
,(99,4) -- Destiny 2: The Final Shape + RPG
,(100,18)-- Silent Hill 2 Remake + Horror
;
-------------------------------------------------------------------------------------
-- 7. Insert Game-Platform Relationships
-------------------------------------------------------------------------------------
/*
  (game_id, platform_id) -- "Game Title" + "Platform Name"
*/
INSERT INTO game_platform (game_id, platform_id) VALUES
(1,1)   -- The Legend of Zelda: Breath of the Wild + Nintendo Switch
,(1,7)  -- The Legend of Zelda: Breath of the Wild + Wii U
,(2,2)  -- Elden Ring + PS5
,(2,3)  -- Elden Ring + PC
,(2,4)  -- Elden Ring + Xbox Series X/S
,(3,2)  -- GTA V + PS5
,(3,3)  -- GTA V + PC
,(3,4)  -- GTA V + Xbox Series X/S
,(4,3)  -- Baldur's Gate 3 + PC
,(4,2)  -- Baldur's Gate 3 + PS5
,(5,2)  -- Final Fantasy VII Rebirth + PS5
,(6,9)  -- Half-Life: Alyx + VR
,(7,3)  -- The Witcher 3 + PC
,(7,5)  -- The Witcher 3 + PS4
,(7,6)  -- The Witcher 3 + Xbox One
,(8,2)  -- God of War Ragnarök + PS5
,(9,2)  -- Resident Evil 4 Remake + PS5
,(9,3)  -- Resident Evil 4 Remake + PC
,(10,3) -- Starfield + PC
,(10,4) -- Starfield + Xbox Series X/S
,(11,3) -- Minecraft + PC
,(11,8) -- Minecraft + Mobile
,(12,5) -- The Last of Us Part II + PS4
,(13,3) -- Fortnite + PC
,(13,2) -- Fortnite + PS5
,(13,4) -- Fortnite + Xbox Series X/S
,(14,10)-- Dark Souls + PS3
,(14,11)-- Dark Souls + Xbox 360
,(14,3)  -- Dark Souls + PC
,(15,5)  -- Red Dead Redemption 2 + PS4
,(15,6)  -- Red Dead Redemption 2 + Xbox One
,(15,3)  -- Red Dead Redemption 2 + PC
,(16,3)  -- Hades + PC
,(16,1)  -- Hades + Nintendo Switch
,(17,3)  -- Stardew Valley + PC
,(17,1)  -- Stardew Valley + Nintendo Switch
,(17,5)  -- Stardew Valley + PS4
,(18,3)  -- Disco Elysium + PC
,(18,5)  -- Disco Elysium + PS4
,(18,6)  -- Disco Elysium + Xbox One
,(19,3)  -- Hollow Knight + PC
,(19,1)  -- Hollow Knight + Nintendo Switch
,(19,5)  -- Hollow Knight + PS4
,(20,1)  -- Animal Crossing: New Horizons + Nintendo Switch
,(21,3)  -- Cyberpunk 2077 + PC
,(21,5)  -- Cyberpunk 2077 + PS4
,(21,6)  -- Cyberpunk 2077 + Xbox One
,(22,3)  -- Portal 2 + PC
,(22,10) -- Portal 2 + PS3
,(22,11) -- Portal 2 + Xbox 360
,(23,3)  -- Skyrim + PC
,(23,5)  -- Skyrim + PS4
,(23,6)  -- Skyrim + Xbox One
,(24,1)  -- Super Mario Odyssey + Nintendo Switch
,(25,5)  -- Sekiro + PS4
,(25,6)  -- Sekiro + Xbox One
,(25,3)  -- Sekiro + PC
,(26,5)  -- Death Stranding + PS4
,(26,3)  -- Death Stranding + PC
,(27,5)  -- Bloodborne + PS4
,(28,5)  -- Persona 5 Royal + PS4
,(28,1)  -- Persona 5 Royal + Nintendo Switch
,(28,3)  -- Persona 5 Royal + PC
,(29,3)  -- Celeste + PC
,(29,1)  -- Celeste + Nintendo Switch
,(29,5)  -- Celeste + PS4
,(30,3)  -- It Takes Two + PC
,(30,2)  -- It Takes Two + PS5
,(30,4)  -- It Takes Two + Xbox Series X/S
,(31,2)  -- Returnal + PS5
,(32,5)  -- MGS V: The Phantom Pain + PS4
,(32,6)  -- MGS V: The Phantom Pain + Xbox One
,(32,3)  -- MGS V: The Phantom Pain + PC
,(33,12) -- Shadow of the Colossus + GameCube (unusual, but example)
,(33,5)  -- Shadow of the Colossus + PS4
,(34,3)  -- Apex Legends + PC
,(34,2)  -- Apex Legends + PS5
,(34,4)  -- Apex Legends + Xbox Series X/S
,(35,1)  -- Super Smash Bros. Ultimate + Nintendo Switch
,(36,2)  -- Stray + PS5
,(36,3)  -- Stray + PC
,(37,5)  -- Ghost of Tsushima + PS4
,(37,2)  -- Ghost of Tsushima + PS5
,(38,2)  -- Horizon Forbidden West + PS5
,(38,3)  -- Horizon Forbidden West + PC (hypothetical)
,(39,1)  -- Dead Cells + Nintendo Switch
,(39,2)  -- Dead Cells + PS5
,(39,5)  -- Dead Cells + PS4
,(40,3)  -- Tetris Effect: Connected + PC
,(40,2)  -- Tetris Effect: Connected + PS5
,(40,4)  -- Tetris Effect: Connected + Xbox Series X/S
,(41,11) -- Mass Effect 2 + Xbox 360
,(41,10) -- Mass Effect 2 + PS3
,(41,3)  -- Mass Effect 2 + PC
,(42,3)  -- Undertale + PC
,(42,1)  -- Undertale + Nintendo Switch
,(42,5)  -- Undertale + PS4
,(43,2)  -- Fallout: New Vegas + PS5 (example)
,(43,4)  -- Fallout: New Vegas + Xbox Series X/S
,(43,3)  -- Fallout: New Vegas + PC
,(44,2)  -- Alan Wake 2 + PS5
,(44,3)  -- Alan Wake 2 + PC
,(45,2)  -- Hogwarts Legacy + PS5
,(45,3)  -- Hogwarts Legacy + PC
,(46,2)  -- Helldivers 2 + PS5
,(46,3)  -- Helldivers 2 + PC
,(47,3)  -- Dragon's Dogma 2 + PC
,(48,2)  -- Final Fantasy XVI + PS5
,(49,2)  -- Star Wars Jedi: Survivor + PS5
,(49,4)  -- Star Wars Jedi: Survivor + Xbox Series X/S
,(49,3)  -- Star Wars Jedi: Survivor + PC
,(50,1)  -- Lies of P + Nintendo Switch (example)
,(50,3)  -- Lies of P + PC
,(50,5)  -- Lies of P + PS4
,(51,3)  -- Paper Mario: TTYD Remastered + PC (example)
,(51,10) -- Paper Mario: TTYD Remastered + PS3
,(51,11) -- Paper Mario: TTYD Remastered + Xbox 360
,(52,2)  -- Palworld + PS5
,(52,3)  -- Palworld + PC
,(52,4)  -- Palworld + Xbox Series X/S
,(53,2)  -- Tales of Kenzera: Zau + PS5
,(53,3)  -- Tales of Kenzera: Zau + PC
,(53,4)  -- Tales of Kenzera: Zau + Xbox Series X/S
,(54,2)  -- Indika + PS5
,(54,3)  -- Indika + PC
,(54,4)  -- Indika + Xbox Series X/S
,(55,1)  -- Stardew Valley 1.6 Update + Nintendo Switch
,(55,3)  -- Stardew Valley 1.6 Update + PC
,(55,5)  -- Stardew Valley 1.6 Update + PS4
,(56,3)  -- Deep Rock Galactic: Survivor + PC
,(57,1)  -- Unicorn Overlord + Nintendo Switch
,(57,2)  -- Unicorn Overlord + PS5
,(57,4)  -- Unicorn Overlord + Xbox Series X/S
,(58,3)  -- Frostpunk 2 + PC
,(59,2)  -- Persona 3 Reload + PS5
,(59,3)  -- Persona 3 Reload + PC
,(59,4)  -- Persona 3 Reload + Xbox Series X/S
,(60,3)  -- The Crimson Diamond + PC
,(61,3)  -- I Am Your Beast + PC
,(62,2)  -- Star Wars Outlaws + PS5
,(62,3)  -- Star Wars Outlaws + PC
,(62,4)  -- Star Wars Outlaws + Xbox Series X/S
,(63,3)  -- The Plucky Squire + PC
,(64,3)  -- Like a Dragon: Infinite Wealth + PC
,(65,3)  -- 1000xResist + PC
,(66,3)  -- Grunn + PC
,(67,19) -- COD: Black Ops 6 + Meta Quest 3 (example)
,(68,2)  -- Llamasoft: The Jeff Minter Story + PS5
,(68,3)  -- Llamasoft: The Jeff Minter Story + PC
,(69,3)  -- Sorry We're Closed + PC
,(69,5)  -- Sorry We're Closed + PS4
,(70,3)  -- Children of the Sun + PC
,(71,2)  -- Homeworld 3 + PS5
,(71,4)  -- Homeworld 3 + Xbox Series X/S
,(71,3)  -- Homeworld 3 + PC
,(72,2)  -- Botany Manor + PS5
,(72,3)  -- Botany Manor + PC
,(73,1)  -- MechWarrior 5: Clans + Nintendo Switch (example)
,(74,2)  -- Arranger: A Role-Puzzling Adventure + PS5
,(74,3)  -- Arranger: A Role-Puzzling Adventure + PC
,(74,4)  -- Arranger: A Role-Puzzling Adventure + Xbox Series X/S
,(75,2)  -- Fear the Spotlight + PS5
,(75,3)  -- Fear the Spotlight + PC
,(75,4)  -- Fear the Spotlight + Xbox Series X/S
,(76,2)  -- Batman: Arkham Shadow (VR) + PS5
,(76,3)  -- Batman: Arkham Shadow (VR) + PC
,(76,4)  -- Batman: Arkham Shadow (VR) + Xbox Series X/S
,(77,1)  -- Zenless Zone Zero + Nintendo Switch
,(77,3)  -- Zenless Zone Zero + PC
,(77,5)  -- Zenless Zone Zero + PS4
,(78,3)  -- Lorelei and the Laser Eyes + PC
,(79,1)  -- Prince of Persia: The Lost Crown + Nintendo Switch
,(79,2)  -- Prince of Persia: The Lost Crown + PS5
,(79,4)  -- Prince of Persia: The Lost Crown + Xbox Series X/S
,(80,3)  -- The Rise of the Golden Idol + PC
,(81,2)  -- Shin Megami Tensei V: Vengeance + PS5
,(81,3)  -- Shin Megami Tensei V: Vengeance + PC
,(81,4)  -- Shin Megami Tensei V: Vengeance + Xbox Series X/S
,(82,3)  -- Slay the Princess: The Pristine Cut + PC
,(83,3)  -- Steamworld Heist 2 + PC
,(84,3)  -- Wild Bastards + PC
,(85,3)  -- World of Warcraft: The War Within + PC
,(86,3)  -- Backyard Baseball '97 + PC
,(87,2)  -- UFO 50 + PS5
,(87,3)  -- UFO 50 + PC
,(88,3)  -- Neva + PC
,(89,2)  -- Lego Horizon Adventures + PS5
,(89,4)  -- Lego Horizon Adventures + Xbox Series X/S
,(89,3)  -- Lego Horizon Adventures + PC
,(90,3)  -- Dragon's Dogma 2 (second) + PC
,(91,3)  -- Metaphor: ReFantazio + PC
,(92,3)  -- Balatro + PC
,(93,3)  -- Animal Well + PC
,(94,3)  -- Hades 2 (Early Access) + PC
,(95,3)  -- Helldivers 2 (second) + PC
,(96,3)  -- Indiana Jones and the Great Circle + PC
,(97,2)  -- Final Fantasy XIV: Dawntrail + PS5
,(97,3)  -- Final Fantasy XIV: Dawntrail + PC
,(98,3)  -- Tekken 8 + PC
,(99,3)  -- Destiny 2: The Final Shape + PC
,(100,2)-- Silent Hill 2 Remake + PS5
,(100,3)-- Silent Hill 2 Remake + PC
;

-------------------------------------------------------------------------------------
-- 8. Create Modes and Game_Modes for Single/Multiplayer/Co-op/MMO
-------------------------------------------------------------------------------------
-- 8.1 Create modes table
CREATE TABLE modes (
    mode_id SERIAL PRIMARY KEY,
    mode_name VARCHAR(50) UNIQUE NOT NULL
);

-- 8.2 Insert base modes (IDs will be 1=Single, 2=Multiplayer, 3=Co-op, 4=MMO)
INSERT INTO modes (mode_name)
VALUES 
    ('Single Player'), 
    ('Multiplayer'), 
    ('Co-op'),
    ('MMO');

-- 8.3 Create game_modes junction table
CREATE TABLE game_modes (
    game_id INT REFERENCES games(game_id),
    mode_id INT REFERENCES modes(mode_id),
    PRIMARY KEY (game_id, mode_id)
);

-------------------------------------------------------------------------------------
-- 9. Map Each Game to Correct Mode(s)
--    Using sub-queries (INSERT ... SELECT) for clarity
-------------------------------------------------------------------------------------
----------------------------------------
-- Single Player ONLY (mode_id=1)
----------------------------------------
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'The Legend of Zelda: Breath of the Wild';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Final Fantasy VII Rebirth';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Half-Life: Alyx';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'The Witcher 3: Wild Hunt';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'God of War Ragnarök';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Resident Evil 4 Remake';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Starfield';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'The Last of Us Part II';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Hades';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Stardew Valley';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Disco Elysium';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Hollow Knight';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Animal Crossing: New Horizons';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'The Elder Scrolls V: Skyrim';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Super Mario Odyssey';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Sekiro: Shadows Die Twice';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Death Stranding';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Bloodborne';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Persona 5 Royal';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Celeste';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Returnal';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Metal Gear Solid V: The Phantom Pain';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Shadow of the Colossus';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Stray';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Ghost of Tsushima';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Horizon Forbidden West';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Dead Cells';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Mass Effect 2';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Undertale';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Fallout: New Vegas';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Alan Wake 2';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Hogwarts Legacy';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Dragon''s Dogma 2';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Final Fantasy XVI';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Star Wars Jedi: Survivor';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Lies of P';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Paper Mario: The Thousand-Year Door (Remastered)';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Tales of Kenzera: Zau';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Indika';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Stardew Valley 1.6 Update';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Frostpunk 2';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Persona 3 Reload';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'The Crimson Diamond';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'I Am Your Beast';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'The Plucky Squire';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Like a Dragon: Infinite Wealth';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = '1000xResist';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Grunn';

-- Call of Duty: Black Ops 6 (Campaign) typically has single + multi => we will insert single below, and multi in next section

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Call of Duty: Black Ops 6 (Campaign)';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Llamasoft: The Jeff Minter Story';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Sorry We''re Closed';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Children of the Sun';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Botany Manor';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Arranger: A Role-Puzzling Adventure';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Fear the Spotlight';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Batman: Arkham Shadow (VR)';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Lorelei and the Laser Eyes';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Prince of Persia: The Lost Crown';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'The Rise of the Golden Idol';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Shin Megami Tensei V: Vengeance';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Slay the Princess: The Pristine Cut';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Steamworld Heist 2';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Wild Bastards';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Neva';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Lego Horizon Adventures';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Metaphor: ReFantazio';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Balatro';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Animal Well';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Hades 2 (Early Access)';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Indiana Jones and the Great Circle';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Silent Hill 2 Remake';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Dice & Fold';

INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Anomaly Agent';


----------------------------------------
-- Single + Multiplayer
----------------------------------------
-- Elden Ring (primarily single, optional multiplayer)
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Elden Ring';
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Elden Ring';

-- Dark Souls (single + invasions)
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Dark Souls';
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Dark Souls';

-- Red Dead Redemption 2 (Story + Red Dead Online)
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Red Dead Redemption 2';
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Red Dead Redemption 2';

-- Cyberpunk 2077 (currently single, but user note says "Primarily singleplayer with optional MP"? 
-- Not official, but let's insert both if desired:
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Cyberpunk 2077';
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Cyberpunk 2077';

-- Minecraft (Single + Multiplayer)
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Minecraft';
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Minecraft';

-- Call of Duty: Black Ops 6 (Campaign) => single + multi
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Call of Duty: Black Ops 6 (Campaign)';

-- UFO 50 => single + multi
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'UFO 50';

-- Supermarket Simulator (Optional MP mods => single + multi)
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Supermarket Simulator';

----------------------------------------
-- Single + Co-op
----------------------------------------
-- Baldur's Gate 3 => single + co-op
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Baldur''s Gate 3';
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 3 FROM games WHERE title = 'Baldur''s Gate 3';

-- Portal 2 => single + co-op
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 1 FROM games WHERE title = 'Portal 2';
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 3 FROM games WHERE title = 'Portal 2';

----------------------------------------
-- Multiplayer ONLY
----------------------------------------
-- Fortnite
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Fortnite';

-- Apex Legends
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Apex Legends';

-- Super Smash Bros. Ultimate
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Super Smash Bros. Ultimate';

-- Helldivers 2
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Helldivers 2';

-- Palworld
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Palworld';

-- Deep Rock Galactic: Survivor
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Deep Rock Galactic: Survivor';

-- Backyard Baseball '97
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Backyard Baseball ''97';

-- New Cycle
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'New Cycle';

----------------------------------------
-- Multiplayer + MMO
----------------------------------------
-- World of Warcraft: The War Within
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'World of Warcraft: The War Within';
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 4 FROM games WHERE title = 'World of Warcraft: The War Within';

-- Final Fantasy XIV: Dawntrail
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Final Fantasy XIV: Dawntrail';
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 4 FROM games WHERE title = 'Final Fantasy XIV: Dawntrail';

----------------------------------------
-- Additional Multiplayer
----------------------------------------
-- Tekken 8
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Tekken 8';

-- Destiny 2: The Final Shape
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Destiny 2: The Final Shape';

-- Zenless Zone Zero
INSERT INTO game_modes (game_id, mode_id)
SELECT game_id, 2 FROM games WHERE title = 'Zenless Zone Zero';

-------------------------------------------------------------------------------------
-- END OF SCRIPT
-------------------------------------------------------------------------------------

-- 2024'te çıkan tüm oyunları listele
SELECT title, release_year 
FROM games 
WHERE release_year = 2024 
ORDER BY title;

-- Metascore'u 90 üzeri olan oyunlar
SELECT title, metascore 
FROM games 
WHERE metascore > 90 
ORDER BY metascore DESC;

-- Japonya'da geliştirilen oyun sayısı
SELECT COUNT(*) AS japonya_oyun_sayisi 
FROM games 
WHERE country = 'Japonya';


-- Her oyunun yayıncı adıyla listelenmesi
SELECT g.title, p.publisher_name 
FROM games g
JOIN publishers p ON g.publisher_id = p.publisher_id;

-- RPG türündeki oyunları listele
SELECT g.title, gn.genre_name 
FROM games g
JOIN game_genre gg ON g.game_id = gg.game_id
JOIN genres gn ON gg.genre_id = gn.genre_id
WHERE gn.genre_name = 'RPG';

-- Nintendo Switch'te çıkan oyunlar
SELECT g.title, pl.platform_name 
FROM games g
JOIN game_platform gp ON g.game_id = gp.game_id
JOIN platforms pl ON gp.platform_id = pl.platform_id
WHERE pl.platform_name = 'Nintendo Switch';

-- Sadece multiplayer oyunlar
SELECT g.title, m.mode_name 
FROM games g
JOIN game_modes gm ON g.game_id = gm.game_id
JOIN modes m ON gm.mode_id = m.mode_id
WHERE m.mode_name = 'Multiplayer';

-- Hem Single Player hem Co-op destekleyen oyunlar
SELECT g.title 
FROM games g
WHERE g.game_id IN (
    SELECT gm.game_id 
    FROM game_modes gm 
    WHERE gm.mode_id = 1
) AND g.game_id IN (
    SELECT gm.game_id 
    FROM game_modes gm 
    WHERE gm.mode_id = 3
);

-- Platform başına ortalama metascore
SELECT pl.platform_name, ROUND(AVG(g.metascore),1) AS ortalama_puan
FROM games g
JOIN game_platform gp ON g.game_id = gp.game_id
JOIN platforms pl ON gp.platform_id = pl.platform_id
GROUP BY pl.platform_name
ORDER BY ortalama_puan DESC;

-- Ülkelere göre satış liderleri
SELECT country, MAX(sales) AS en_yuksek_satis
FROM games
GROUP BY country
ORDER BY en_yuksek_satis DESC;

-- En çok türe sahip oyun
SELECT g.title, COUNT(gg.genre_id) AS tur_sayisi
FROM games g
JOIN game_genre gg ON g.game_id = gg.game_id
GROUP BY g.title
ORDER BY tur_sayisi DESC
LIMIT 5;

-- Son 5 yılın en başarılı yayıncısı
SELECT p.publisher_name, COUNT(*) AS oyun_sayisi
FROM games g
JOIN publishers p ON g.publisher_id = p.publisher_id
WHERE g.release_year BETWEEN 2019 AND 2024
GROUP BY p.publisher_name
ORDER BY oyun_sayisi DESC
LIMIT 1;

-- Aynı anda hem PC hem PS5'te çıkan oyunlar
SELECT g.title
FROM games g
WHERE g.game_id IN (
    SELECT gp.game_id 
    FROM game_platform gp 
    JOIN platforms p ON gp.platform_id = p.platform_id 
    WHERE p.platform_name = 'PC'
) AND g.game_id IN (
    SELECT gp.game_id 
    FROM game_platform gp 
    JOIN platforms p ON gp.platform_id = p.platform_id 
    WHERE p.platform_name = 'PS5'
);

-- Türkiye'de geliştirilen oyunlar ve platformları
SELECT g.title, STRING_AGG(p.platform_name, ', ') AS platformlar
FROM games g
JOIN game_platform gp ON g.game_id = gp.game_id
JOIN platforms p ON gp.platform_id = p.platform_id
WHERE g.country = 'Türkiye'
GROUP BY g.title;

-- Türkiye yapımı oyunların genre dağılımı
SELECT gn.genre_name, COUNT(*) AS sayi
FROM games g
JOIN game_genre gg ON g.game_id = gg.game_id
JOIN genres gn ON gg.genre_id = gn.genre_id
WHERE g.country = 'Türkiye'
GROUP BY gn.genre_name;