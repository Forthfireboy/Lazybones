--[[ 
[Español]
    |HUD MINI SIMPLE V3.5 [Improv] | 0.6.3 - 1.0 | |LuaXdea|

Este script te permite personalizar el HUD (la interfaz) en Psych Engine de forma sencilla. Añade opciones como animación de los iconos, ajustes de la cámara y reducción de salud del oponente. Asegúrate de que tu versión de Psych Engine esté entre 0.6.3 a 1.0.

[Youtube]: https://youtube.com/@lua-x-dea?si=vH4ommC_t3CGrDqn
[Gamebanana]: https://gamebanana.com/mods/502653
]]

-- | HUD MINI SIMPLE | Ajustes |
-- | True: Activado | false: Desactivado |

-- | Ajustes de personalización |
local IconAnim = false -- Animación de iconos [default false]
local IconAnimExtra = true -- Animación extra para los iconos [default true]
local MiddlescrollON = true -- HUD personalizado para middlescroll [default true]
local HideBotplayTxt = true -- Opción para ocultar el texto de botplay [default true]
local ScoreTxtMini = true -- Opción para que se vean el ScoreMini y MissesMini [default true]


-- | Ayuda de eventos |
local InfoEvent = false -- Te permite ver qué eventos se está usando en el momento con su configuración de Value 1 y Value 2 [default false]
local TextoFont = 'MAHAWA__.TTF' -- Aquí puedes elegir que fuente de letra quieres usar para el [InfoEvent] (default MAHAWA__.TTF)


-- | Escala de cámaras |
local CamScale = false -- Es para aumentar la escala de las camaras (default false)
local CamerasScale = {'camGame','camHUD','camOther'} -- Elige las camaras que quieres cambiar su escala (default {'camGame','camHUD','camOther'} )
local CamScaleX = 1.05 -- Escala horizontal (default 1.05)
local CamScaleY = 1.03 -- Escala vertical (default 1.03)


-- | Configuración de reducción de salud del oponente |
local healthOp = true -- Activar o desactivar la reducción de salud [default true]
local QuitaV = 0.012 -- Reducción de salud [default 0.012]
local LimiteDeVida = 0.4 -- Reducción Maxima [default 0.4]
local PocaVida = true -- El icono del bf parpadea cuando la vida es por debajo de 0.4 [default true]


-- | Configuración de CamFollow |
local CustomCam = false -- Si quieres usar la poción de la cámara por defecto de los personajes (false) o personalizada (true) [default false] [beta]
local IndividualOffsets = false -- Es para si quieres usar los Offsets por individual cada uno [default false]
local GeneralOffset = 15 -- Reemplaza a los offsets de dad,boyfriend y gf si el IndividualOffsets está en false [default 15]
local AngleSwitch = false -- Inclinar Cámara [default false]
local angleTime = 1 -- Velocidad de Angle [default 1]
local followCharacters = true -- CamFollow [default true]
local cameraSpeed = 1 -- Velocidad de CamFollow [default 1]

-- | Posiciones de las cámaras | [Configurado para Test]
-- Esto solo funciona si CustomCam está en true
-- camX: es la posición horizontal
-- camY: es la posición vertical
local camX_opponent = 600
local camY_opponent = 600
local camX_player = 700
local camY_player = 600
-- [Puede que el de gf no funcione en la versión 0.7.3]
local camX_gf = 650
local camY_gf = 450
    
-- | Offsets de las cámaras |
-- Offset: Define hasta dónde puede desplazarse la cámara al seguir a los personajes.
local offset_opponent = 25
local offset_player = 25
local offset_gf = 25

-- | Ángulos generales | [Recomendable usar zCameraFix para Psych Engine 0.7.x, 1.0 Pre y 1.0]
-- angle: es cuánto se inclinara la cámara
local angle_left = 3
local angle_right = -3
local angle_up = -5
local angle_down = 5

local function configureHUD()
    local hudConfig = {
        iconP1 = {x = 900, y = downscroll and 0 or 100},
        iconP2 = {x = 1050, y = downscroll and 0 or 100},
        healthBar = {x = 750, y = downscroll and 130 or 100, scale = 0.5},
        timeBar = {x = 900, y = downscroll and 155 or 50, scale = 0.4},
        timeTxt = {x = 750, y = downscroll and 145 or 40},
        ScoreMini = {x = 750, y = downscroll and 175 or 40},
        MissesMini = {x = 750, y = downscroll and 195 or 40},
        botplayTxt = not HideBotplayTxt
    }
    if MiddlescrollON and middlescroll then
        hudConfig = {
            iconP1 = {x = 1120, y = downscroll and 590 or 0},
            iconP2 = {x = 10, y = downscroll and 590 or 15},
            healthBar = {x = 335, y = downscroll and 675 or 35, scale = 0.5},
            timeBar = {x = 380, y = downscroll and 695 or 13, scale = 0.4},
            timeTxt = {x = 500, y = downscroll and 690 or 5},
            ScoreMini = {x = 10, y = 10},
            MissesMini = {x = 10, y = 30},
            botplayTxt = not HideBotplayTxt
        }
    end
    setProperty('iconP1.x',hudConfig.iconP1.x)
    setProperty('iconP1.y',hudConfig.iconP1.y)
    setProperty('iconP2.x',hudConfig.iconP2.x)
    setProperty('iconP2.y',hudConfig.iconP2.y)
    setProperty('healthBar.x',hudConfig.healthBar.x)
    setProperty('healthBar.y',hudConfig.healthBar.y)
    setProperty('healthBar.scale.x',hudConfig.healthBar.scale)
    setProperty('healthBarBG.scale.x',hudConfig.healthBar.scale)
    setProperty('timeBar.x',hudConfig.timeBar.x)
    setProperty('timeBar.y',hudConfig.timeBar.y)
    setProperty('timeBar.scale.x',hudConfig.timeBar.scale)
    setProperty('timeBarBG.scale.x',hudConfig.timeBar.scale)
    setProperty('timeTxt.x',hudConfig.timeTxt.x)
    setProperty('timeTxt.y',hudConfig.timeTxt.y)
    setProperty('ScoreMini.x',hudConfig.ScoreMini.x)
    setProperty('ScoreMini.y',hudConfig.ScoreMini.y)
    setProperty('MissesMini.x',hudConfig.MissesMini.x)
    setProperty('MissesMini.y',hudConfig.MissesMini.y)
    setProperty('botplayTxt.visible',hudConfig.botplayTxt)
    setProperty('scoreTxt.visible',false)
end
local function animateIconsExtra(elapsed)
    if IconAnimExtra then
        setProperty('iconP1.scale.y', math.sin(elapsed * 0.5) * 0.05 + 1)
        setProperty('iconP2.scale.y', math.cos(elapsed * 0.5) * 0.05 + 1)
    end
end
function onBeatHit()
    if IconAnim then
        local angle = curBeat % 2 == 0 and -9 or 9
        setProperty('iconP1.angle',angle)
        setProperty('iconP2.angle',-angle)
        doTweenAngle('return1', 'iconP1',0,0.25 / playbackRate,'circOut')
        doTweenAngle('return2','iconP2',0,0.25 / playbackRate,'circOut')
    end
    if PocaVida and getProperty('health') < 0.4 then
        setProperty('iconP1.alpha',0.3)
        doTweenAlpha('iconP1Alpha','iconP1',1,0.4)
    else
        doTweenAlpha('iconP1AlphaNormal','iconP1',1,0.5)
    end
end
function onCamScale()
    if CamScale then
    for _,Cam in pairs(CamerasScale) do
        setProperty(Cam..'.flashSprite.scaleX',CamScaleX)
        setProperty(Cam..'.flashSprite.scaleY',CamScaleY)
    end
    end
end
function opponentNoteHit()
    if healthOp then
        local currentHealth = getProperty('health')
        if currentHealth > LimiteDeVida then
            setProperty('health',currentHealth - QuitaV)
        end
    end
end
function onSongStart()
    if not getProperty('cpuControlled') then
        doTweenAlpha('ScoreMiniAlpha','ScoreMini',1,0.5)
        doTweenAlpha('MissesMiniAlpha','MissesMini',1,0.5)
    end
end
function onCreate()
    makeLuaText('ScoreMini','0')
    setTextSize('ScoreMini',20)
    setProperty('ScoreMini.alpha',0)
    addLuaText('ScoreMini')
    makeLuaText('MissesMini','0')
    setTextColor('MissesMini','FF0000')
    setTextSize('MissesMini',20)
    setProperty('MissesMini.alpha',0)
    addLuaText('MissesMini')
    setProperty('ScoreMini.visible',ScoreTxtMini)
    setProperty('MissesMini.visible',ScoreTxtMini)
    if healthOp then
    setProperty('guitarHeroSustains',false)
    else
    setProperty('guitarHeroSustains',true)
    end
end
function onCreatePost()
    CamDefault() -- Remplazo de onMoveCamera()
end
function onUpdate(elapsed)
    InfoEventUpdate(elapsed)
end
function onUpdatePost(elapsed)
    configureHUD()
    onCamScale()
    onCamFollowPos()
    ObjectOrderPost()
    animateIconsExtra(elapsed)
    ScoreMiniPost(elapsed)
end
function ObjectOrderPost()
    setObjectOrder('ScoreMini',getObjectOrder('scoreTxt') + 1)
    setObjectOrder('MissesMini',getObjectOrder('scoreTxt') + 1)
end
local activeTexts = {}
local maxTexts, textDuration,yOffsetStep,baseX,baseY,offsetXNewText = 6,5,25,0,200,400
local eventCooldown = {}
function customPrint(message)
    if #activeTexts >= maxTexts then
        local oldestText = table.remove(activeTexts,1)
        doTweenAlpha(oldestText.tag..'FadeQuick',oldestText.tag,0,0.15,'linear')
        runTimer('removeOldText'..oldestText.tag,0.15)
    end
    local textTag = 'customText'..math.random(10000)
    for i, textData in ipairs(activeTexts) do
        doTweenY(textData.tag..'MoveDown',textData.tag,baseY + (i * yOffsetStep),0.3,'linear')
    end
    makeLuaText(textTag,message,1000,baseX + offsetXNewText,baseY + 300)
    setTextSize(textTag,14)
    setTextBorder(textTag,0.1,'000000')
    setTextColor(textTag,'00FF00')
    setTextAlignment(textTag,'left')
    setTextFont(textTag,TextoFont or 'vcr.ttf')
    setProperty(textTag..'.alpha',0)
    if version == '1.0' then
    setProperty(textTag..'.camera',instanceArg('camOther'),false,true) -- Psych Engine 1.0 [Fix]
    else
    setObjectCamera(textTag,'camOther')
    end
    addLuaText(textTag)

    doTweenAlpha(textTag..'FadeIn',textTag,1,0.15,'linear')
    doTweenX(textTag..'MoveIn',textTag,baseX,0.15,'linear')
    table.insert(activeTexts, {tag = textTag,lifetime = textDuration,alphaTime = 0,isNew = true})
end
function InfoEventUpdate(elapsed)
    for n,cooldown in pairs(eventCooldown) do
        if cooldown > 0 then eventCooldown[n] = cooldown - elapsed end
    end
    for i = #activeTexts,1,-1 do
        local textData = activeTexts[i]
        textData.lifetime = textData.lifetime - elapsed
        if textData.lifetime <= 0 then
            if textData.isNew then
                doTweenAlpha(textData.tag..'FadeOut', textData.tag,0,0.15,'linear')
                runTimer('removeOldText'..textData.tag,0.15)
                textData.isNew = false
            end
        end
    end
end
function onTimerCompleted(t)
    if t:find('removeOldText') then
        local textTag = t:gsub('removeOldText','')
        removeLuaText(textTag, true)
    end
end
local ScoreActual = 0
local timerUp,timerDown,incrementStageUp,incrementStageDown = 0,0,0,0
local incrementSpeed = {up = 1,down = 1}
function ScoreMiniPost(elapsed)
    local TargetScore = getProperty('songScore')
    local TargetMisses = getProperty('songMisses')
    timerUp = timerUp + elapsed
    timerDown = timerDown + elapsed
    if timerUp >= 0.5 then
        incrementStageUp = incrementStageUp + 1
        incrementSpeed.up = 1 + (2 * incrementStageUp)
        timerUp = 0
    end
    if timerDown >= 0.5 then
        incrementStageDown = incrementStageDown + 1
        incrementSpeed.down = math.min(1 + incrementStageDown, 4)
        timerDown = 0
    end
    if ScoreActual ~= TargetScore then
        local direction = (ScoreActual < TargetScore) and 'up' or 'down'
        ScoreActual = ScoreActual + ((direction == 'up') and incrementSpeed.up or -incrementSpeed.down)
        setProperty('ScoreMini.color',getColorFromHex((direction == 'up') and '00FF00' or 'FF0000'))
        if (direction == 'up' and ScoreActual > TargetScore) or (direction == 'down' and ScoreActual < TargetScore) then
            ScoreActual = TargetScore
        end
        if ScoreActual == TargetScore then
            doTweenColor('ScoreR','ScoreMini','FFFFFF',0.3)
            incrementSpeed.up,incrementSpeed.down = 1,1
            incrementStageUp,incrementStageDown = 0,0
        end
    end
    setTextString('ScoreMini',math.floor(ScoreActual))
    setTextString('MissesMini',TargetMisses)
end
function CamDefault()
    if not CustomCam then
    camX_playerDefault = (getMidpointX('boyfriend') - 100) - (getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]'))
    camY_playerDefault  = (getMidpointY('boyfriend') - 100) + (getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]'))
    camX_opponentDefault = (getMidpointX('dad') + 150) + (getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]'))
    camY_opponentDefault = (getMidpointY('dad') - 100) + (getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]'))
    camX_gfDefault = getMidpointX('gf') + (getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]'))
    camY_gfDefault = getMidpointY('gf') + (getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]'))
    end
    camX_opponentEvent = CustomCam and camX_opponent or camX_opponentDefault
    camY_opponentEvent = CustomCam and camY_opponent or camY_opponentDefault
    camX_playerEvent = CustomCam and camX_player or camX_playerDefault
    camY_playerEvent = CustomCam and camY_player or camY_playerDefault
    camX_gfEvent = CustomCam and camX_gf or camX_gfDefault
    camY_gfEvent = CustomCam and camY_gf or camY_gfDefault
end
function onCamFollowPos()
    setProperty('cameraSpeed',cameraSpeed)
    if followCharacters then
        local character = 'dad'
        if gfSection then
            character = 'gf'
        elseif mustHitSection then
            character = 'boyfriend'
        end
        local gfAnim = getProperty('gf.animation.curAnim.name')
        if gfAnim:find('singLEFT') or gfAnim:find('singRIGHT') or gfAnim:find('singUP') or gfAnim:find('singDOWN') then
            character = 'gf'
        end
        local x,y,offset,angle = 0,0,0,0
        if character == 'dad' then
            x,y = camX_opponentEvent,camY_opponentEvent
            offset = IndividualOffsets and offset_opponent or GeneralOffset
        elseif character == 'boyfriend' then
            x,y = camX_playerEvent,camY_playerEvent
            offset = IndividualOffsets and offset_player or GeneralOffset
        elseif character == 'gf' then
            x,y = camX_gfEvent,camY_gfEvent
            offset = IndividualOffsets and offset_gf or GeneralOffset
        end
        local anim = getProperty(character..'.animation.curAnim.name')
        if anim:find('LEFT') then
            x = x - offset
            angle = angle_left
        elseif anim:find('RIGHT') then
            x = x + offset
            angle = angle_right
        elseif anim:find('UP') then
            y = y - offset
            angle = angle_up
        elseif anim:find('DOWN') then
            y = y + offset
            angle = angle_down
        end
        setProperty('camFollow.x',x)
        setProperty('camFollow.y',y)
        if AngleSwitch then
            doTweenAngle('camGameAngle','camGame',angle,angleTime)
        else
            doTweenAngle('camGameAngle','camGame',0,angleTime)
        end
    end
end
function onEvent(n,v1,v2)
    if InfoEvent then
    if eventCooldown[n] and eventCooldown[n] > 0 then return end
    eventCooldown[n] = 0.2
    customPrint('Evento: '..n..(v1 ~= '' and '  Value1: '..v1 or '')..(v2 ~= '' and '  Value2: '..v2 or ''))
    end
    if v1 then v1 = string.lower(v1) end
    if n == 'CamFollowGeneral' or n == 'LifeDrain' then
        if v2 then v2 = string.lower(v2) end
        if v2 == 'true' or v2 == 't' then
            B = true
        elseif v2 == 'false' or v2 == 'f' then
            B = false
        end
    end
    if n == 'CamFollowGeneral' then
        if v1 == 'as' then  -- AngleSwitch
            AngleSwitch = B
        elseif v1 == 'cs' then  -- cameraSpeed
            cameraSpeed = tonumber(v2)
        elseif v1 == 'fc' then  -- followCharacters
            followCharacters = B
        elseif v1 == 'io' then  -- IndividualOffsets
            IndividualOffsets = B
        elseif v1 == 'go' then  -- IndividualOffsets
            GeneralOffset = tonumber(v2)
        elseif v1 == 'at' then  -- angleTime
            angleTime = tonumber(v2)
        elseif v1 == 'al' then  -- angle_left
            angle_left = tonumber(v2)
        elseif v1 == 'ar' then  -- angle_right
            angle_right = tonumber(v2)
        elseif v1 == 'au' then  -- angle_up
            angle_up = tonumber(v2)
        elseif v1 == 'ad' then  -- angle_down
            angle_down = tonumber(v2)
        end
    elseif n == 'CamFollowPlayer' then
        local isAdd = string.find(v1,'Add')
            if CustomCam then
            if string.find(v1,'x') then  -- camX_player
            if isAdd then
                camX_playerEvent = tonumber(camX_playerEvent + v2)
            else
                camX_playerEvent = tonumber(v2)
            end
            elseif string.find(v1,'y') then  -- camY_player
            if isAdd then
                camY_playerEvent = tonumber(camY_playerEvent + v2)
            else
                camY_playerEvent = tonumber(v2)
            end
            elseif v1 == 'of' then  -- offset_player
            offset_player = tonumber(v2)
        end
    else
        if string.find(v1,'x') then  -- camX_player
            camX_playerEvent = tonumber(camX_playerEvent + v2)
        elseif string.find(v1,'y') then  -- camY_player
            camY_playerEvent = tonumber(camY_playerEvent + v2)
        elseif v1 == 'of' then  -- offset_player
            offset_player = tonumber(v2)
        end
    end
    elseif n == 'CamFollowOpponent' then
        local isAdd = string.find(v1,'Add')
            if CustomCam then
            if string.find(v1,'x') then  -- camX_opponent
            if isAdd then
                camX_opponentEvent = tonumber(camX_opponentEvent + v2)
            else
                camX_opponentEvent = tonumber(v2)
            end
            elseif string.find(v1,'y') then  -- camY_opponent
            if isAdd then
                camY_opponentEvent = tonumber(camY_opponentEvent + v2)
            else
                camY_opponentEvent = tonumber(v2)
            end
            elseif v1 == 'of' then  -- offset_opponent
            offset_opponent = tonumber(v2)
        end
    else
        if string.find(v1,'x') then  -- camX_opponent
            camX_opponentEvent = tonumber(camX_opponentEvent + v2)
        elseif string.find(v1,'y') then  -- camY_opponent
            camY_opponentEvent = tonumber(camY_opponentEvent + v2)
        elseif v1 == 'of' then  -- offset_opponent
            offset_opponent = tonumber(v2)
        end
    end
    elseif n == 'CamFollowGf' then
        local isAdd = string.find(v1,'Add')
            if CustomCam then
            if string.find(v1, 'x') then  -- camX_gf
            if isAdd then
                camX_gfEvent = tonumber(camX_gfEvent + v2)
            else
                camX_gfEvent = tonumber(v2)
            end
            elseif string.find(v1,'y') then  -- camY_gf
            if isAdd then
                camY_gfEvent = tonumber(camY_gfEvent + v2)
            else
                camY_gfEvent = tonumber(v2)
            end
            elseif v1 == 'of' then  -- offset_gf
            offset_gf = tonumber(v2)
        end
    else
        if string.find(v1,'x') then  -- camX_gf
            camX_gfEvent = tonumber(camX_gfEvent + v2)
        elseif string.find(v1,'y') then  -- camY_gf
            camY_gfEvent = tonumber(camY_gfEvent + v2)
        elseif v1 == 'of' then  -- offset_gf
            offset_gf = tonumber(v2)
        end
    end
    elseif n == 'LifeDrain' then
        if v1 == 'ho' then  -- healthOp
            healthOp = B
        elseif v1 == 'qv' then  -- QuitaV
            QuitaV = tonumber(v2)
        elseif v1 == 'ld' then  -- LimiteDeVida
            LimiteDeVida = tonumber(v2)
        elseif v1 == 'pv' then  -- PocaVida
            PocaVida = B
        end
    end
end

--[[
| Evento: CamFollowGeneral |
Configuracion general.
- Value 1, Value 2:
  - AS: AngleSwitch. Valores: true, false.
  - CS: Velocidad de la cámara. Valores: número.
  - FC: followCharacters. Valores: true, false.
  - IO: Desplazamientos individuales. Valores: true, false.
  - GO: Desplazamiento General. Valores: número.
  - AT: Tiempo del ángulo. Valores: número.
  - AL: Ángulo izquierdo. Valores: número.
  - AR: Ángulo derecho. Valores: número.
  - AU: Ángulo arriba. Valores: número.
  - AD: Ángulo abajo. Valores: número.
Ejemplos:
Value1: AS, Value2: true
Value1: CS, Value2: 1.8


| Evento: CamFollowPlayer |
Configura la cámara para seguir al jugador (boyfriend).
- Value 1, Value 2:
  - X: Posición X. Usa "Add" en Value 1 para sumar en Value 2.
  - Y: Posición Y. Usa "Add" en Value 1 para sumar en Value 2.
  - OF: Desplazamiento. Valores: número.
Ejemplos:
Value 1: X, Value 2: 750
Value 1: X,Add, Value 2: 50
Value 1: Y, Value 2: 650
Value 1: Y,Add, Value 2: 30
Value 1: OF, Value 2: 20


| Evento: CamFollowOpponent |
Configura la cámara para seguir al oponente (dad).
- Value 1, Value 2:
  - X: Posición X. Usa "Add" en Value 1 para sumar en Value 2.
  - Y: Posición Y. Usa "Add" en Value 1 para sumar en Value 2.
  - OF: Desplazamiento. Valores: número.
Ejemplos:
Value 1: X, Value 2: 650
Value 1: X,Add, Value 2: 40
Value 1: Y, Value 2: 650
Value 1: Y,Add, Value 2: 20
Value 1: OF, Value 2: 15


| Evento: CamFollowGf |
Configura la cámara para seguir a GF.
- Value 1, Value 2:
  - X: Posición X. Usa "Add" en Value 1 para sumar en Value 2.
  - Y: Posición Y. Usa "Add" en Value 1 para sumar en Value 2.
  - OF: Desplazamiento. Valores: número.
Ejemplos:
Value 1: X, Value 2: 550
Value 1: X,Add, Value 2: 30
Value 1: Y, Value 2: 620
Value 1: Y,Add, Value 2: 25
Value 1: OF, Value 2: 10


| Evento: LifeDrain |
Configura el robo de vida del oponente.
- Value 1, Value 2:
  - HO: healthOp. Valores: true, false.
  - QV: Quita vida. Valores: número.
  - LD: Limite de Vida. Valores: número.
  - PV: PocaVida. Valores: true, false.
Ejemplos:
Value1: HO, Value2: false
Value1: LD, Value2: 0.6
]]




--[[
    | HUD MINI SIMPLE [ v3.5 [Improv] ] |
  [NUEVAS COSAS]
  - [CamScale] Puedes modificar la escala de las cámaras.
        Opciones de CamScale:
        - (CamerasScale) Elige las camaras que quieres cambiar su escala.
        - (CamScaleX) Escala horizontal
        - (CamScaleY) Escala vertical
        (No usables en evento)
  [MEJORAS]
  - [(CamFollow) Eventos] Los eventos:
      - CamFollowOpponent
      - CamFollowPlayer
      - CamFollowGf
      Ahora en el Value 1, puedes usar Add para sumar.
      Ejemplo:
        Value 1: X,Add, Value 2: 50
      También si no usas Add entonces la cámara se moverá a esa posición, y no sumará la poción actual.
      El ADD solo funciona con el "CustomCam" activado, si no está activado "CustomCam" todo lo que coloques en Value 2 se sumarán.
  [CAMBIOS]
  [onMoveCamera] El "onMoveCamera()" fue cambiado por "CamDefault()".
  [(Programación) Orden] Ahora está mejor ordenado la programación del script.
  [(onCamFollowPos) CamFollow] Ahora el CamFollow usa el "onUpdatePost()"
  [(CamFollow) Eventos] Ahora los eventos:
      - CamFollowOpponent
      - CamFollowPlayer
      - CamFollowGf
      Ya funcionan con el "CustomCam" desactivado.

  [(Version) Compatibilidad]
  El HUD MINI SIMPLE es compatible con las siguientes versiones de Psych Engine:
  [0.6.3 | 0.7.1h | 0.7.2h | 0.7.3 | 1.0 Pre | 1.0]
]]