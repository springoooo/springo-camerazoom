-- By Springo! Contact me on discord at springo_1 if you have any questions or need support.
-- https://github.com/springoooo

Config = {}
-- Enable the zoom feature or not 
Config.EnableZoom = true 
-- The key to toggle the zoom feature by default. NOTE: Keybind can be changed in FiveM Settings.
Config.ZoomKey = "mouse_button" 
-- The FOV (kinda like amount / depth of zoom) when zoom is active. Best to set around 20-50 for immersive experience.
Config.ZoomFOV = 30.0
-- Normal FOV that zoomed in FOV will return to when zoom is deactivated. Keep around 65-75.
Config.NormalFOV = 70.0
-- How fast / sensitivity of camera when rotating. Change as you like. Recommended between 5-15.
Config.RotationSpeed = 8.0
-- Do you want the zoom to be disabled when in first person? True = Yes, False = No
Config.DisableInFirstPerson = false
-- Do you want the zoom to be disabled when the player is not stationary? True = Yes, False = No    
Config.RequireStationary = false
-- Do you want the zoom to be disabled when the player is in a vehicle? True = Yes, False = No  
Config.DisableInVehicle = true
-- Do you want the rotation to be restricted to a certain radius on the x and y axis? True = Yes, False = No 
Config.EnableConeRestriction = true
-- If Config.EnableConeRestriction is set to true, you can set the angle of the cone here.
Config.ConeAngle = 65 -- For example, a 65 degree cone will mean the player can rotate cam 32.5 deg left and right.
