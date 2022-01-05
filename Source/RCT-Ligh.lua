--[[
	---------------------------------------------------------
    RCT Lights is a simple app to take care of light-channels
    values depending on switch assignment.
	
	For DC/DS-12/14/16/24.
	---------------------------------------------------------
	Localisation-file has to be as /Apps/Lang/RCT-Ligh.jsn
	---------------------------------------------------------
	RCT-Lights is part of RC-Thoughts Jeti Tools.
	---------------------------------------------------------
	Released under MIT-license by Tero @ RC-Thoughts.com 2019
	---------------------------------------------------------
--]]
----------------------------------------------------------------------
-- Locals for the application
local swM, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9
local swMOn, sw1On, sw2On, sw3On, sw4On, sw5On, sw6On, sw7On, sw8On, sw9On
local channelDefault, channelDefaultOn, channelValue1, channelValue2, channelValue3
----------------------------------------------------------------------
-- Read translation-file
local function setLanguage()
    local lng = system.getLocale()
    local file = io.readall("Apps/Lang/RCT-Ligh.jsn")
    local obj = json.decode(file)
    if(obj) then
        trans33 = obj[lng] or obj[obj.default]
    end
    collectgarbage()
end
----------------------------------------------------------------------
-- Store chaned settings
local function swMChanged(value)
    local pSave = system.pSave
	swM = value
	pSave("swM", value)
end

local function sw1Changed(value)
    local pSave = system.pSave
	sw1 = value
	pSave("sw1", value)
end

local function sw2Changed(value)
    local pSave = system.pSave
	sw2 = value
	pSave("sw2", value)
end

local function sw3Changed(value)
    local pSave = system.pSave
	sw3 = value
	pSave("sw3", value)
end

local function sw4Changed(value)
    local pSave = system.pSave
	sw4 = value
	pSave("sw4", value)
end

local function sw5Changed(value)
    local pSave = system.pSave
	sw5 = value
	pSave("sw5", value)
end

local function sw6Changed(value)
    local pSave = system.pSave
	sw6 = value
	pSave("sw6", value)
end

local function sw7Changed(value)
    local pSave = system.pSave
	sw7 = value
	pSave("sw7", value)
end

local function sw8Changed(value)
    local pSave = system.pSave
	sw8 = value
	pSave("sw8", value)
end

local function sw9Changed(value)
    local pSave = system.pSave
	sw9 = value
	pSave("sw9", value)
end

local function channelValue1Changed(value)
    local pSave = system.pSave
	channelValue1 = value
	pSave("channelValue1", value)
end

local function channelValue2Changed(value)
    local pSave = system.pSave
	channelValue2 = value
	pSave("channelValue2", value)
end

local function channelValue3Changed(value)
    local pSave = system.pSave
	channelValue3 = value
	pSave("channelValue3", value)
end

local function channelDefaultChanged(value)
    local pSave = system.pSave
	channelDefault = value
	pSave("channelDefault", value)
end

local function channelDefaultOnChanged(value)
    local pSave = system.pSave
	channelDefaultOn = value
	pSave("channelDefaultOn", value)
end
----------------------------------------------------------------------
-- Let's draw the form! Wheeeee!
local function initForm()
    local form, addRow, addLabel = form, form.addRow ,form.addLabel
    local addIntbox, addCheckbox = form.addIntbox, form.addCheckbox
    local addSelectbox, addInputbox = form.addSelectbox, form.addInputbox

    addRow(1)
    addLabel({label="---     RC-Thoughts Jeti Tools      ---",font=FONT_BIG})

    addRow(1)
    addLabel({label=trans33.labelCom,font=FONT_BOLD})

    addRow(2)
    addLabel({label=trans33.labelswM, width=220})
    addInputbox(swM, true, swMChanged)
	
	addRow(2)
    addLabel({label=trans33.labelOnVal, width=220})
    addIntbox(channelDefaultOn, -125, 125, 0, 0, 1, channelDefaultOnChanged)

    addRow(2)
    addLabel({label=trans33.labelOffVal, width=220})
    addIntbox(channelDefault, -125, 125, 0, 0, 1, channelDefaultChanged)

    addRow(1)
    addLabel({label=trans33.labelPos1,font=FONT_BOLD})
    
    addRow(2)
    addLabel({label=trans33.labelsw1, width=220})
    addInputbox(sw1, true, sw1Changed)

    addRow(2)
    addLabel({label=trans33.labelsw2, width=220})
    addInputbox(sw2, true, sw2Changed)

    addRow(2)
    addLabel({label=trans33.labelsw3, width=220})
    addInputbox(sw3, true, sw3Changed)

    addRow(2)
    addLabel({label=trans33.labelChan, width=220})
    addIntbox(channelValue1, -125, 125, 0, 0, 1, channelValue1Changed)

    addRow(1)
    addLabel({label=trans33.labelPos2,font=FONT_BOLD})

    addRow(2)
    addLabel({label=trans33.labelsw1, width=220})
    addInputbox(sw4, true, sw4Changed)

    addRow(2)
    addLabel({label=trans33.labelsw2, width=220})
    addInputbox(sw5, true, sw5Changed)

    addRow(2)
    addLabel({label=trans33.labelsw3, width=220})
    addInputbox(sw6, true, sw6Changed)

    addRow(2)
    addLabel({label=trans33.labelChan, width=220})
    addIntbox(channelValue2, -125, 125, 0, 0, 1, channelValue2Changed)

    addRow(1)
    addLabel({label=trans33.labelPos3,font=FONT_BOLD})

    addRow(2)
    addLabel({label=trans33.labelsw1, width=220})
    addInputbox(sw7, true, sw7Changed)

    addRow(2)
    addLabel({label=trans33.labelsw2, width=220})
    addInputbox(sw8, true, sw8Changed)

    addRow(2)
    addLabel({label=trans33.labelsw3, width=220})
    addInputbox(sw9, true, sw9Changed)

    addRow(2)
    addLabel({label=trans33.labelChan, width=220})
    addIntbox(channelValue3, -125, 125, 0, 0, 1, channelValue3Changed)

    addRow(1)
	addLabel({label="Powered by RC-Thoughts.com - v."..lightsVersion.." ", font=FONT_MINI, alignRight=true})
    collectgarbage()
end
----------------------------------------------------------------------
local function loop()

    -- Check switches only if they are used
    if (swM) then swMOn = system.getInputsVal(swM) else swMOn = 2 end
    if (sw1) then sw1On = system.getInputsVal(sw1) else sw1On = 2 end
    if (sw2) then sw2On = system.getInputsVal(sw2) else sw2On = 2 end
    if (sw3) then sw3On = system.getInputsVal(sw3) else sw3On = 2 end
    if (sw4) then sw4On = system.getInputsVal(sw4) else sw4On = 2 end
    if (sw5) then sw5On = system.getInputsVal(sw5) else sw5On = 2 end
    if (sw6) then sw6On = system.getInputsVal(sw6) else sw6On = 2 end
    if (sw7) then sw7On = system.getInputsVal(sw7) else sw7On = 2 end
    if (sw8) then sw8On = system.getInputsVal(sw8) else sw8On = 2 end
    if (sw9) then sw9On = system.getInputsVal(sw9) else sw9On = 2 end

    if(swMOn == 1 or sw1On == 2) then
        if(sw1On == 1 and (sw2On == 1 or sw2On == 2) and (sw3On == 1 or sw3On == 2)) then
			-- Position 1
            system.setControl(1, channelValue1/100, 0, 0)
            -- Position 2
            elseif(sw4On == 1 and (sw5On == 1 or sw5On == 2) and (sw6On == 1 or sw6On == 2)) then
                system.setControl(1, channelValue2/100, 0, 0)
            -- Position 3
            elseif(sw7On == 1 and (sw8On == 1 or sw8On == 2) and (sw9On == 1 or sw9On == 2)) then
                system.setControl(1, channelValue3/100, 0, 0)
            else
            system.setControl(1, channelDefaultOn/100, 0, 0)
        end
        else
        system.setControl(1, channelDefault/100, 0, 0)
    end
    collectgarbage()
end
----------------------------------------------------------------------
-- Application initialization
local function init()
    local pLoad, registerControl, registerForm = system.pLoad, system.registerControl, system.registerForm
    swM = pLoad("swM")
	sw1 = pLoad("sw1")
    sw2 = pLoad("sw2")
    sw3 = pLoad("sw3")
    sw4 = pLoad("sw4")
    sw5 = pLoad("sw5")
    sw6 = pLoad("sw6")
    sw7 = pLoad("sw7")
    sw8 = pLoad("sw8")
    sw9 = pLoad("sw9")
    channelValue1 = pLoad("channelValue1", 0)
    channelValue2 = pLoad("channelValue2", 0)
    channelValue3 = pLoad("channelValue3", 0)
    channelDefault = pLoad("channelDefault", 0)
    channelDefaultOn = pLoad("channelDefaultOn", 0)
    registerControl(1, trans33.labelCtrlLong, trans33.labelCtrlShort)
    registerForm(1,MENU_FINE,trans33.appName,initForm,keyPressed);
    collectgarbage()
end
----------------------------------------------------------------------
lightsVersion = "1.1"
setLanguage()
return {init=init, loop=loop, author="RC-Thoughts", version=lightsVersion, name=trans33.appName}