ConfigServer = {}

ConfigServer.TriggerAmbulance = 'esx_ambulancejob:revive'  --Put your trigger
ConfigServer.SkinTrigger = 'esx_skin:openSaveableMenu' -- put Your trigger
ConfigServer.esx_advancedgarage = false --This only if u use esx_advancedgarage.
ConfigServer.LanguageSv = {

    job = "Le diste el trabajo de ",
    grade = "Con grado ",
    toplayer = "Al jugador ",
    invalidjob = "Ingresa un trabajo valido.",
    revplayerid = "Reviviste al jugador ",
    kicksv = "Kickeaste al jugador: ",
    reasonsv = "Por la siguiente razón: ",
    give = "Le diste ",
    account = "En la cuenta ",
    novalid = "Ingresa una cuenta valida",
    kickreason = "Has sido kickeado por la siguiente razón: ",
    ball = "Trajo a todos a su posición",
    bringall = "Bring All",
    --Name of logs--
    logveh = "Borrado de Vehiculos",
    logobj = "Borrado de objetos",
    logped = "Borrado de peds",
    logannounce = "Anuncio Enviado",
    logchat = "Chat eliminado",
    logname = "Cambiado de Nombre",
    logmoney = "Dar dinero",
    logjob = "Dar trabajo",
    logrevive = "Revivir Jugador ",
    logck = "Ck Player",
    logreviveall = "Revivio a todos",
    allidentifiers = "Player Identifiers solicitado por: ",
    cargarage = "Dar auto al garage",
    --End name of logs--

    --Message of logs--
    theadmin = "El admin ",
    delallveh = "Borro todos los vehiculos.",
    delallobj = "Borro todos los objetos.",
    delallped = "Borro todos los peds.",
    sendannounce = "Envio el siguiente anuncio: ",
    delallchat = "Borro todo el chat.",
    kicktoplayer = "Kickeo al jugador ",
    kickreason = "Por la siguiente razón: ",
    nametoplayer = "Cambiaste el nombre del jugador: ",
    newname = "Al: ",
    givecar = "Le dio el siguiente auto ",
    givemoney = "Le dio ",
    theaccount = "En la cuenta ",
    setjob = "Le dio el trabajo de ",
    setgrade = "Con rango ",
    revive = "Revivio al jugador ",
    dock = "Le hizo ck al jugador ",
    reviveall = "Revivio a todos",
    errorphoto = "Hubo un error al tomar la captura de pantalla",
    photo = "La captura se tomo con exito.",
    Recibiste = "Recibiste el siguiente auto: ",
    errorplate = "La placa ya existe, Dale otra vez. ",
    disteauto = "Entregaste el siguiente auto: ",

    --End Message of logs--
}

--This is English Translation--
--The same of the Config from client, you need to comment the spanish language above.--

-- ConfigServer.LanguageSv = {

--     job = "You gave him the job of ",
--     grade = "With grade ",
--     toplayer = "To Player ",
--     invalidjob = "Enter a valid job.",
--     revplayerid = "Revived the player ",
--     kicksv = "You kicked the player: ",
--     reasonsv = "For the following reason: ",
--     give = "You gave him ",
--     account = "On the account ",
--     novalid = "Enter a valid account",
--     kickreason = "You have been kicked for the following Reason: ",
--     ball = "Bring everyone",
--     bringall = "Bring All",
--     --Name of logs--
--     logveh = "Deletion of Vehicles",
--     logobj = "Delete objects",
--     logped = "Deleted peds",
--     logannounce = "Announcement Sent",
--     logchat = "Chat deleted",
--     logname = "Name Changed",
--     logmoney = "Give money",
--     logjob = "Set Job",
--     logrevive = "Revive Player",
--     logck = "Ck Player",
--     logreviveall = "Revive everyone",
--     allidentifiers = "Player Identifiers requested by: ",
--     --End name of logs--

--     --Message of logs--
--     theadmin = "The admin",
--     delallveh = "Delete all vehicles.",
--     delallobj = "Delete all the objects.",
--     delallped = "Delete all peds.",
--     sendannounce = "Send the following announcement:",
--     delallchat = "Delete all chat.",
--     kicktoplayer = "Kick the player",
--     kickreason = "For the following reason:",
--     nametoplayer = "Changed the player's name:",
--     newname = "To: ",
--     givemoney = "Gave",
--     theaccount = "On the account",
--     setjob = "Gave the job of",
--     setgrade = "With rank",
--     revive = "Revive the player",
--     dock = "Ck the player",
--     reviveall = "Revive everyone",
--     Recibiste = "You get this car:  ",
--     errorplate = "The plate is taken.",
--        givecar = "Give this car: ",
--     disteauto = "You give this car: ",
--      cargarage = "Give car to garage",

--     --End Message of logs--
-- }


ConfigServer.BanName = '😎🤚 [Roda_Admin]'  
ConfigServer.MessagePermaBan = 'You are banned permanent for this reason: '
ConfigServer.MessageBanTemp = 'You are banned for ' -- Minutes
ConfigServer.DeferralMessage = 'Checking if you are banned'
ConfigServer.BannedForWhat = 'You are banned for this reason: '

ConfigServer.MythicSv = false -- If false, it use esx notification, if true use mythic notific

ConfigServer.PhotoUrl = 'https://i.imgur.com/UnKqQAp.png'
ConfigServer.WebHookForPhotos = 'https://discord.com/api/webhooks/952019245909286953/PsOFrQs46QY_5Unb9KvQQqwWnREEt2KWXJRJhINhXXQJaEU3-LTDy4SI28dalfe9_-hQ'
ConfigServer.Webhooks = {
    ["adminlogs"] = "https://discord.com/api/webhooks/952019372245930054/d50ctdPGY1EoW_pTf6LC_DQEfzEZWJBIpZJrWd7qBYi-PJ_0hgIuQZg3ZrCAqfaXm7V-"
}

ConfigServer.UsernameForWebhook = 'Admin Menu'

ConfigServer.Colors = {
    ["default"] = 16711680,
    ["blue"] = 25087,
    ["green"] = 762640, 
    ["white"] = 16777215,
    ["black"] = 0,
    ["orange"] = 16743168,
    ["lightgreen"] = 65309,
    ["yellow"] = 15335168,
    ["turqois"] = 62207,
    ["pink"] = 16711900,
    ["red"] = 16711680, 
}