local timetype = 'bar' -- compass, bar, none/false/nil
local scoreboard = true -- enable the scoreboard

function toPercentage(value, total)
    if total > 0 then
        return ((value / total) * 100)
    end
end

local timePercent = 0

function onCreate()
    makeQuickSprite('accuracybar', 'minecraft/accuracybar', 'hud', false, false)
    if downscroll then
        setPosition('accuracybar', nil, 39)
    else
        setPosition('accuracybar', nil, 681)
    end
    screenCenter('accuracybar', 'x')
    makeQuickSprite('accbg', nil, 'hud', true, false, 800.05, 9.4, '19241E')
    setPosition('accbg', (getProperty('accuracybar.x') + 3.7), (getProperty('accuracybar.y') + 3.95))
    makeQuickSprite('accfg', nil, 'hud', true, false, 800.05, 9.4, '86C457')
    setPosition('accfg', getProperty('accbg.x'), getProperty('accbg.y'))
    setPosition('accfg.origin', getProperty('accfg.width') - getProperty('accfg.width'),
        getProperty('accfg.height') * 0.5)
    createTextQuick('accuracytext', round((getProperty('ratingPercent') * 100), 2) .. '%', 0, 0, 0, 'center', 32, 3, 1,
        '000000')
    setTextColor('accuracytext', '86C457')

    setPosition('accuracytext', (getProperty('accuracybar.x') + getProperty('accuracybar.width') / 2 -
        getProperty('accuracytext.width') / 2),
        (getProperty('accuracybar.y') + getProperty('accuracybar.height') / 2 -
            getProperty('accuracytext.height') / 2) - 3)

    if downscroll then
        createHearts('hearts', 235.35, 79.7, 'heart', 10, 'hud')
        createHearts('armors', 656.3, 79.7, 'armor', 10, 'hud')
    else
        createHearts('hearts', 235.35, 640.3, 'heart', 10, 'hud')
        createHearts('armors', 656.3, 640.3, 'armor', 10, 'hud')
    end

    if timetype == 'compass' then

        makeQuickSprite('compassbase', 'minecraft/compassbase', 'hud', false, false)
        if downscroll then
            setPosition('compassbase', 1190, 20)
        else
            setPosition('compassbase', 1190, 629)
        end
        setProperty('compassbase.visible', true)

        makeQuickSprite('compassarrow', 'minecraft/compassarrow', 'hud', false, false)
        setPosition('compassarrow', getProperty('compassbase.x') + (getProperty('compassbase.width') / 2) -
            (getProperty('compassarrow.width') / 2),
            getProperty('compassbase.y') + (getProperty('compassbase.height') / 2) -
            ((getProperty('compassarrow.height') * 1.5) - 12))
        setProperty('compassarrow.origin.x', (getProperty('compassarrow.width') / 2) - 0.5)
        setProperty('compassarrow.origin.y', getProperty('compassarrow.height') - 3.5)
    elseif timetype == 'bar' then
        makeQuickSprite('timebarmc', 'minecraft/timebar', 'hud', false, false)
        if downscroll then
            setPosition('timebarmc', nil, 687)
        else
            setPosition('timebarmc', nil, 23)
        end
        screenCenter('timebarmc', 'x')
        createTextQuick('timetext', milliToHuman(
            math.floor(songLength - (getPropertyFromClass('Conductor', 'songPosition') - noteOffset))), 0, 0, 0,
            'center', 32, 3, 1, '000000')

        setPosition('timetext', (getProperty('timebarmc.x') + getProperty('timebarmc.width') / 2 -
            getProperty('timetext.width') / 2), (getProperty('timebarmc.y') + getProperty('timebarmc.height') / 2 -
            getProperty('timetext.height') / 2) - 3)
        makeQuickSprite('tbmcbg', nil, 'hud', true, false, 462, 9.4, '393939')
        setPosition('tbmcbg', (getProperty('timebarmc.x') + 3.7), (getProperty('timebarmc.y') + 3.95))
        makeQuickSprite('tbmcfg', nil, 'hud', true, false, 462, 9.4, 'ECECEC')
        setPosition('tbmcfg', getProperty('tbmcbg.x'), getProperty('tbmcbg.y'))
        setPosition('tbmcfg.origin', getProperty('tbmcfg.width') - getProperty('tbmcfg.width'),
            getProperty('tbmcfg.height') * 0.5)
    else

    end

    if scoreboard == true then
        createQuickBox('Scoreboard', 0, 0, 1, 1, '000000', 0.5, false)
        for i = 0, 2 do
            createTextQuick('ScoreName' .. i, string.upper(songName .. ' - ' .. difficultyName), 0 + (0.5 * i), 0, 0,
                'center', 24, 0, 0,
                '00x000000')
            setTextColor('ScoreName' .. i, 'FFFF55')
        end
        createTextQuick('ScoreText1', 'Score:', 0, 20, 0, 'center', 24, 0, 0, '00x000000')
        createTextQuick('ScoreText2', string.upper(score), 0, 40, 0, 'center', 24, 0, 0, '00x000000')
        createTextQuick('ScoreText3', 'Misses:', 0, 60, 0, 'center', 24, 0, 0, '00x000000')
        createTextQuick('ScoreText4', string.upper(misses), 0, 80, 0, 'center', 24, 0, 0, '00x000000')
        createTextQuick('ScoreText5', 'Deaths:', 0, 100, 0, 'center', 24, 0, 0, '00x000000')
        createTextQuick('ScoreText6', string.upper(getPropertyFromClass('PlayState', 'deathCounter')), 0, 120, 0,
            'center', 24, 0, 0, '00x000000')
        createTextQuick('ScoreText7', 'Rank:', 0, 140, 0, 'center', 24, 0, 0, '00x000000')
        createTextQuick('ScoreText8', string.upper(ratingFC), 0, 160, 0, 'center', 24, 0, 0, '00x000000')
        for i = 1, 8 do
            setGraphicSize('Scoreboard', 312,
                (getProperty('ScoreText1.height') * i - (getProperty('ScoreText1.height') / 2)))
            createTextQuick('ScoreNumbers' .. i, i, 0, getProperty('ScoreText8.y') - (20 * (i - 1)), 0, 'center', 24, 0,
                0, '00x000000')
            setTextColor('ScoreNumbers' .. i, 'FF5555')
        end
    end
end

function onCreatePost()
    setProperty('timeBar.y', -1000)
    setProperty('timeTxt.y', -1000)
    setProperty('scoreTxt.alpha', 0)
    setProperty('healthBar.y', -1000)
    setProperty('iconP1.y', -1000)
    setProperty('iconP2.y', -1000)

    setObjectOrder('accuracybar', getObjectOrder('iconP1') - 1)
    setObjectOrder('accuracytext', getObjectOrder('accuracybar') + 1)

    for i = 0, 10 do
        setObjectOrder('hearts'..i, getObjectOrder('accuracytext'))
        setObjectOrder('armors'..i, getObjectOrder('accuracytext'))
    end

    if scoreboard == true then
        setObjectOrder('Scoreboard', getObjectOrder('accuracytext'))
        for n = 0, 2 do
            setObjectOrder('ScoreName'..n, getObjectOrder('Scoreboard') + 1)
        end
        for b = 1, 8 do
            setObjectOrder('ScoreText'..b, getObjectOrder('ScoreName2'))
            setObjectOrder('ScoreNumbers'..b, getObjectOrder('ScoreName2'))
        end
    end

    if timetype == 'compass' then

        setObjectOrder('compassbase', getObjectOrder('accuracybar'))
        setObjectOrder('compassarrow', getObjectOrder('compassbase') + 1)
    elseif timetype == 'bar' then
        setObjectOrder('timebarmc', getObjectOrder('accuracybar'))
        setObjectOrder('tbmcbg', getObjectOrder('timebarmc') - 2)
        setObjectOrder('tbmcfg', getObjectOrder('tbmcbg') + 1)
        setObjectOrder('timetext', getObjectOrder('timebarmc') + 1)
    else

    end
    setObjectOrder('accbg', getObjectOrder('accuracybar') - 2)
    setObjectOrder('accfg', getObjectOrder('accbg') + 1)
end

function createTextQuick(tag, text, x, y, width, alignment, size, bsize, bq, bcolor)
    makeLuaText(tag, text, width, x, y)
    setTextSize(tag, size)

    setTextAlignment(tag, alignment);
    updateHitbox(tag)
    setProperty(tag .. '.borderSize', bsize)
    setProperty(tag .. '.borderQuality', bq)
    setProperty(tag .. '.borderColor', getColorFromHex(bcolor));
    addLuaText(tag)
    setObjectCamera(tag, 'hud')
end

function createQuickBox(tag, x, y, width, height, color, alpha, downscrollcheck, dsy)
    makeLuaSprite(tag, '', x, y)
    makeGraphic(tag, width, height, color)
    setProperty(tag .. '.alpha', alpha)
    if downscrollcheck == true then
        if downscroll then
            setProperty(tag .. '.y', dsy)
        end
    end
    addLuaSprite(tag, true)
    setObjectCamera(tag, 'hud')
end

function onUpdate()
    local songPos = getPropertyFromClass('Conductor', 'songPosition') -- songPos is short for song's Position
    local songDur = (songLength - (songPos - noteOffset)) + songPos -- songDur is short for song's Duration

    timePercent = round(toPercentage(math.floor(songPos), math.floor(songDur)), 2)

    if timetype == 'compass' then
        if timePercent < 0 then
            setProperty('compassarrow.angle', 0)
        else
            setProperty('compassarrow.angle', (360 * (timePercent / 100)))
        end
    elseif timetype == 'bar' then

        if timePercent < 0 then
            setProperty('tbmcfg.scale.x', 0)
        else
            setProperty('tbmcfg.scale.x', (timePercent / 100))
        end

        setTextString('timetext', milliToHuman(
            math.floor(songLength - (songPos - noteOffset))))

        setPosition('timetext', (getProperty('timebarmc.x') + getProperty('timebarmc.width') / 2 -
            getProperty('timetext.width') / 2), (getProperty('timebarmc.y') + getProperty('timebarmc.height') / 2 -
            getProperty('timetext.height') / 2) - 3)
    else

    end

    if scoreboard == true then
        setTextString('ScoreText2', string.upper(score))
        setTextString('ScoreText4', string.upper(misses))
        setTextString('ScoreText6', string.upper(getPropertyFromClass('PlayState', 'deathCounter')))
        if getProperty('songHits') > 0 then
            setTextString('ScoreText8', string.upper(ratingFC))
        else
            setTextString('ScoreText8', '...')
        end

        if middlescroll then
            setPosition('Scoreboard', screenWidth - getProperty('Scoreboard.width'))
        else
            setPosition('Scoreboard', 0)
        end
        screenCenter('Scoreboard', 'Y')

        for i = 1, 8 do
            for h = 0, 2 do
                setPosition('ScoreName' .. h, (getProperty('Scoreboard.x') + getProperty('Scoreboard.width') / 2 -
                    (getProperty('ScoreName0.width') + (0.5 * h) + 2) / 2), getProperty('Scoreboard.y'))

                if (getProperty('ScoreName0.width') + (0.5 * h) + 2) > getProperty('Scoreboard.width') then
                    setGraphicSize('Scoreboard', (getProperty('ScoreName0.width') + (0.5 * h) + 2),
                        getProperty('Scoreboard.height'))
                elseif getProperty('ScoreText' .. i .. '.width') > getProperty('Scoreboard.width') then
                    setGraphicSize('Scoreboard', getProperty('ScoreText' .. i .. '.width'),
                        getProperty('Scoreboard.height'))
                end
            end
            setPosition('ScoreText' .. i, getProperty('Scoreboard.x'), getProperty('Scoreboard.y') + (20 * i))

            setPosition('ScoreNumbers' .. i,
                (
                getProperty('Scoreboard.x') + getProperty('Scoreboard.width') -
                    getProperty('ScoreNumbers' .. i .. '.width')), getProperty('ScoreText8.y') - (20 * (i - 1)))
        end
    else

    end

    setProperty('accfg.scale.x', getProperty('ratingPercent'))

    for h = 1, 10 do
        if (getProperty('health') * 50) >= (5 * h) then
            objectPlayAnimation('hearts' .. h, 'heartsnorm', true)
        elseif (getProperty('health') * 50) >= ((5 * h) - 2.5) then
            objectPlayAnimation('hearts' .. h, 'heartshalf', true)
        elseif (getProperty('health') * 50) >= ((5 * h) - 5) then
            objectPlayAnimation('hearts' .. h, 'heartsnone', true)
        end

        if (getProperty('health') * 50) <= (((5 * h) - 5) + 50) then
            objectPlayAnimation('armors' .. h, 'armorsnone', true)
        elseif (getProperty('health') * 50) <= ((5 * h) - 2.5) + 50 then
            objectPlayAnimation('armors' .. h, 'armorshalf', true)
        elseif (getProperty('health') * 50) <= (5 * h) + 50 then
            objectPlayAnimation('armors' .. h, 'armorsnorm', true)
        end
    end

    if (getProperty('health') * 50) <= 50 then
        for d = 1, 10 do
            setProperty('armors' .. d .. '.visible', false)
        end
    else
        for d = 1, 10 do
            setProperty('armors' .. d .. '.visible', true)
        end
    end

    setTextString('accuracytext', round((getProperty('ratingPercent') * 100), 2) .. '%')

    setPosition('accuracytext', (getProperty('accuracybar.x') + getProperty('accuracybar.width') / 2 -
        getProperty('accuracytext.width') / 2),
        (getProperty('accuracybar.y') + getProperty('accuracybar.height') / 2 -
            getProperty('accuracytext.height') / 2) - 3)
end

function setPosition(tag, x, y)
    if x ~= nil then
        setProperty(tag .. '.x', x)
    end
    if y ~= nil then
        setProperty(tag .. '.y', y)
    end
end

function createHearts(tag, x, y, type, amount, cam)
    for i = 1, amount do
        makeAnimatedLuaSprite(tag .. i, 'minecraft/healthicons', 0, 0)
        addAnimationByPrefix(tag .. i, tag .. 'norm', type, 24, true);
        addAnimationByPrefix(tag .. i, tag .. 'half', 'half' .. type, 24, true);
        addAnimationByPrefix(tag .. i, tag .. 'none', 'none' .. type, 24, true);
        setObjectCamera(tag .. i, cam)
        setPosition(tag .. i, (x + ((getProperty(tag .. i .. '.width') * (i - 1)) * 0.95)), y)
        scaleObject(tag .. i, 0.95, 0.95)
        addLuaSprite(tag .. i, false);
    end
end

-- functions that are taken from the place called internet (credits are included so dw) --

function makeQuickSprite(tag, spr, cam, isGraphic, isAnimated, w, h, hex) -- Cherif#9382 from Psych Discord Server
    if not isGraphic and not isAnimated then
        makeLuaSprite(tag, spr)
        setObjectCamera(tag, cam)
    elseif isGraphic and not isAnimated then
        makeLuaSprite(tag, '')
        makeGraphic(tag, w, h, hex)
        setObjectCamera(tag, cam)
    elseif not isGraphic and isAnimated then
        makeAnimatedLuaSprite(tag, spr)
        setObjectCamera(tag, cam)
    end
end

function milliToHuman(milliseconds) -- https://forums.mudlet.org/viewtopic.php?t=3258 (modified a bit so that it doesn't have an extra zero on the minutes like from 05:00 to 5:00 [i don't know how to explain it better so uhh there's that])
    local totalseconds = math.floor(milliseconds / 1000)
    local seconds = totalseconds % 60
    local minutes = math.floor(totalseconds / 60)
    minutes = minutes % 60
    return string.format("%2d:%02d", minutes, seconds)
end

function round(x, n) -- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then
        x = math.floor(x + 0.5)
    else
        x = math.ceil(x - 0.5)
    end
    return x / n
end
