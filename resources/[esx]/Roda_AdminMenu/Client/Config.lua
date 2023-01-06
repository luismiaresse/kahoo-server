Config = {}
Config.Perms = {}
Config.ServerPlayers = 64   --This is for the menu of players.
Config.SpeedNoClip = 3.0  -- Only that format, 1.0, 2.0, 3.6, etc.
Config.TakeScreenshot = true
Config.KeyToOpen = 'DELETE' --Change this before start the resource.
Config.verTag = true
--For Search
Config.CustomTrigger = false -- If put this in true, you need tu put your trigger down.
--Default ESX--
Config.TriggerForSearch = 'inventory:openPlayerInventory'  --Chezza Inventory, You can put your own trigger. 


--Mythic Notifications.
Config.Mythic = false -- Default ESX

--Clothes
Config.StaffClothes = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 388,   ['torso_2'] = 1,
        ['arms'] = 8,  
        ['bproof_1'] = 56,
    },
    female = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 4,   ['torso_2'] = 14,
        ['arms'] = 4,
        ['pants_1'] = 25,   ['pants_2'] = 1,
        ['shoes_1'] = 16,   ['shoes_2'] = 4,
    }
}




Config.Perms = {

    ['godmode'] = {
        'steam:76561198422623007',
        'steam:11000010ec79864'
    },
    ['dock'] = {
        'steam:76561198422623007',
        'steam:11000010ec79864'
    },
    ['ped'] = {
        'steam:76561198422623007',
        'steam:11000010ec79864'
    }
}

Config.GroupLabels = {
    mod = "~g~Mod",
    admin = "~u~Admin",
}

--Spanish, si quieres en español descomenta todo esto y comenta lo de abajo en ingles--

Config.Language = {
    --First Menu
    personal = "Opciones Personales 🤵",
    server = "Opciones del Servidor 💻",
    players = "Opciones del Jugador ⛹️‍♂️",
    rockstar = "Rockstar Editor 🎥",
    --Personal Options Menu
    godmode = "God Mode 👳‍♂️",
    tag = "Admin Tag 💫",
    invisible = "Invisible 👻",
    shownames = "Mostrar Nombres 🤖",
    tpm = "TPM 🚀",
    jump = "Super Salto 🦘",
    fastspeed = "Correr Rapido 🐆",
    copycoords = "Copiar Coordenadas 📍",
    opencar = "Abrir Coche 🚗",
    noclip = "Noclip 👽",
    repair = "Reparar 🔧",
    staffclothes = "Ropa de Staff 🛡️",
    civilclothes = "Ropa de Civil 👕",
     ban = "Ban Player",
     seeall = "Ver Datos",
     tpmap = "Tp a punto marcado",

    --Rockstar Editor--

    startrecord = "Empezar a Grabar 🎥",
    stopsaves = "Parar y Guardar 🛑",
    stopdelete = "Parar y Borrar 🛑❌",
    openrockstar  = "Abrir Rockstar Editor 🎞️",
    --Rockstar Editor--
    
    --Personal Options Notifications
 
    activegod = "Activaste el modo Dios 👳‍♂️",
    delgod = "Desactivaste el modo Dios 👳‍♂️",
    nombretrue = "Activaste el Mostrar Nombre 🔎",
    nombrefalse = "Desactivaste el Mostrar Nombre 🔎",
    jumpon = "Activaste el Super Salto 🦘",
    jumpoff = "Desactivaste el Super Salto 🦘",
    fastrun = "Activas el correr rapido 🐆",
    nofastrun = "Ya no eres rapido 🐆",
    activeinvi = "Eres invisible. 👻",
    delinvi = "Ya no eres invisible.  🧑",
    donetpm = "Fuiste teletransportado al punto marcado. 🚀",
    nopoint = "Marca un punto. 🧪",
    caropen = "Abriste el Coche. 🔧",
    nosit = "Necesitas estar en un coche. 💡",
    fixcar = "Reparaste el auto. 🚗",
    actinoclip = "Activaste el Noclip.  👽", 
    delnoclip = "Desactivaste el Noclip.  👽",
    copycoord = "Tus coordenadas se copiaron en el portapapeles.",
    clothesstaff = "Te pusiste tu ropa de Staff.",
    clothescivil = "Te pusiste tu ropa de Civil.",
    activartag = "Activaste tu tag de admin",
    offtag = "Desactivaste tu tag de admin",
    nameornombre = "Nombre: ",

    --Server Options Menu
    deleteveh = "Borrar todos los Vehiculos 🚗",
    deleteobj = "Borrar todos los Objetos 📦",
    deleteped = "Borrar todos los peds 👶",
    clearchat = "Borrar Chat 💬",
    makeannounce = "Enviar Anuncio 📢 ",
    reviveall = "Revivir a todos 😇",
    insertannounce = "Inserta un anuncio 📢",
    noannounce = "El anuncio no puede estar vacio.",
    --Server Options Notifiactins

    delallveh = "Borraste todos los vehiculos. 🚗",
    delallobj = "Borraste todos los Objetos. 📦",
    delallpeds = "Borraste todos los Peds. 👶",
    delallchat = "Borraste todo el chat. 💬",

    --Player Options Menu
    listplayers = "Jugadores ",
    job = "Nombre del Trabajo",
    inventory = "Buscar Inventario",
    photo = "Capturar Pantalla",
    jobgrade = "Rango del Trabajo",
    kick = "Kickear Jugador",
    changename = "Cambiar Nombre del Jugador",
    givemoney = "Dar Dinero",
    revplayer = "Revivir Jugador",
    givecar = "Dar auto",
    setjob = "Cambiar Trabajo",
    dock = "Hacer CK",
    reason = "Ingresa una razón",
    insertreason = "Inserta una razón.",
    newname = "Ingresa un nombre.",
    newlastname = "Ingresa un apellido.",
    noname = "Ingresa un nombre.",
    nolast = "Ingresa un apellido valido.",
    donename = "Se cambio el nombre y apellido del jugador.",
    insertaccount = "Inserta una cuenta",
    insertmount = "Inserta un monto",
    nomount = "El monto no puede estar vacio.",
    nuevonombre = "Cambiaste el nombre del jugador al: ",
    sendidentifiers = "Enviar identifiers a discord",

    ---Player Options Notifications
    confirmck = "Necesitas poner si o yes.",
    yesck = "Ck Realizado con Exito.",
    nock = "Inserta si o yes para realizar el CK",
    yesrev = "Reviviste a todos.",
    norev = "Inserta si o yes para revivir a todos.",
    confrev = "Necesitas poner si o yes.",
    yesorno = "Para confirmar escribe si o yes.",
    nonull = "El grado no puede estar vacio.",

    nomodel = "No existe el modelo",
    spawncar = "Spawneast el coche: ",
    cartogarage = "Dar coche al garage",
    subete = "Subete al auto primero.",
     vision = "Menu de Vision 🔭",
     night = "Vision Nocturna",
     thermal = "Vision Termica",
     delthermal = "Vision Termica Off",
     onthermal = "Vision Termica On",
     onvision = "Vision Nocturna On", 
     offvision = "Vision Nocturna Off",
     health = "Vida ❤️: ",
     chaleco = "Armadura 🛡️: ",
     giveweapon = "Dar Armas",
     see_cars = "Eliminar un Auto",
     gotop = "Ir al Jugador",
     bring = "Traer Jugador",
     openclothes = "Dar Skin",
}


---Ingles version, to work this you need to comment all of Config.Language was is in spanish--
-- Config.Language = {
--     --First Menu
--     personal = "Personal Options 🤵",
--     server = "Server Options 💻",
--     players = "Player Options ⛹️‍♂️",
--     rockstar = "Rockstar Editor 🎥",
--     --Personal Options Menu
--     godmode = "God Mode 👴",
--     invisible = "Invisible 👻",
--     tag = "Admin Tag 💫",
--     shownames = "Show Names🤖",
--     tpm = "TPM 🚀",
--     jump = "Super Jump 🦘",
--     fastspeed = "Super Run 🐆",
--     copycoords = "Copy Coordinates 📍",
--     opencar = "Open Car 🚗",
--     noclip = "Noclip 👽",
--     repair = "Fix Car 🔧",
--     staffclothes = "Staff Clothes 🛡️",
--     civilclothes = "Civilian clothes 👕",
--     ban = "Ban Player",
--     seeall = "See All Data",
--     tpmap = "Tp To WayPoint",
--         -- Rockstar Editor--

--     startrecord = "Start Record 🎥",
--     stopsaves = "Stop and Save 🛑",
--     stopdelete = "Stop and Delete 🛑❌",
--     openrockstar  = "Open Rockstar Editor 🎞️",
       
--         -- Rockstar Editor--


--     --Personal Options Notifications
 
--     activegod = "You activated God mode. 😎",
--     delgod = "You deactivated God mode. 😢",
--     nombretrue = "Show Names ON 🔎",
--     nombrefalse = "Show Names Off🔎",
--     jumpon = "You activated the Super Jump 🦘",
--     jumpoff = "You deactivated the Super Jump 🦘",
--     fastrun = "You Activated the Fast Run 🐆",
--     nofastrun = "You aren't fast 🐆",
--     activeinvi = "You're invisible. 👻",
--     delinvi = "You are no longer invisible.  🧑",
--     donetpm = "You were teleported to the marked point. 🚀",
--     nopoint = "Select a point 🧪",
--     caropen = "You opened the car. 🔧",
--     nosit = "You need to be in a car. 💡",
--     fixcar = "You repaired the car. 🚗",
--     actinoclip = "You activated the Noclip.  👽", 
--     delnoclip = "You disabled the Noclip.  👽",
--     copycoord = "Your coordinates were copied to the clipboard.",
--     clothesstaff = "You put on your Staff clothes.",
--     clothescivil = "You put on your Civilian clothes.",
--     nameornombre = "Name: ",

--     --Server Options Menu
--     deleteveh = "Delete all Vehicles 🚗",
--     deleteobj = "Delete all Objects 📦",
--     deleteped = "Delete all peds 👶",
--     clearchat = "Delete Chat 💬",
--     makeannounce = "Send Announcement 📢 ",
--     reviveall = "Revive all 😇",
--     insertannounce = "Insert an Announcement 📢",
--     noannounce = "The Announcement cannot be empty.",

--     --Server Options Notifiactins

--     delallveh = "You deleted all the vehicles. 🚗",
--     delallobj = "You deleted all the Objects. 📦",
--     delallpeds = "You erased all the Peds. 👶",
--     delallchat = "You deleted all the chat. 💬",

--     --Player Options Menu
--     listplayers = "Players ",
--     job = "Name of the job",
--     jobgrade = "Job Range",
--     kick = "Kick Player",
--     changename = "Change Player Name",
--     givecar = "Give Car",
--     inventory = "Search Inventory",
--     photo = "Take Screenshot",
--     givemoney = "Give money",
--     revplayer = "Revive Player",
--     setjob = "Change Job",
--     dock = "Do Ck",
--     reason = "Enter a reason",
--     insertreason = "Enter a reason",
--     newname = "Please enter a name.",
--     newlastname = "Please enter a last name.",
--     noname = "Please enter a name.",
--     nolast = "Please enter a valid last name.",
--     donename = "The player's first and last name was changed.",
--     insertaccount = "Insert an account",
--     insertmount = "Insert an amount",
--     nomount = "The amount cannot be empty.",
--     nuevonombre = "You changed the player's name to:",
--     sendidentifiers = "Send Player Identifiers to Discord",
--     activartag = "You Active your admin Tag",
--     offtag = "You desactivate your admin tag",
--     ---Player Options Notifications
--     confirmck = "You need to put yes or si.",
--     yesck = "Ck Successfully Done.",
--     nock = "Insert yes or si to perform the CK",
--     yesrev = "You revived everyone.",
--     norev = "Insert yes or si to revive everyone.",
--     confrev = "You need to put yes or si.",
--     yesorno = "To confirm write yes or si.",
--     nonull = "The degree cannot be empty.",
--     nomodel = "The model don't exist",
--     spawncar = "Spawn the car: ",
--     cartogarage = "Give car to garage.",
--     subete = "First sit in the car.",
--     vision = "Vision Menu 🔭",
--     night = "Night Vision",
--     thermal = "Thermal Vision",
--     delthermal = "Thermal Vision Off",
--     onthermal = "Thermal Vision On",
--     onvision = "Night Vision On", 
--     offvision = "Night Vision Off",
--     health = "Health ❤️: ",
--     chaleco = "Armor 🛡️: ",
--     giveweapon = "Give Weapon",
--     see_cars = "Delete a Car",
--     gotop =  "Go to Player",
--     bring = "Bring Player",
--     openclothes = "Give Skin",
-- }

