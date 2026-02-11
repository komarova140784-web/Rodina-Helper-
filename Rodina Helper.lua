---@diagnostic disable: undefined-global, lowercase-global

script_name("Rodina Helper")
script_description('Universal script for players Arizona Online')
script_author("Ðàçðàáîòêà áàçîâîé ÷àñòè ñêðèïòà îñóùåñòâëåíà êîìàíäîé MTG Ðàáîòû ïî äîðàáîòêå ñêðèïòà âûïîëíåíû Àíäðååì Ôèëëîì (ñîãëàñîâàíî MTG îò 23 äåêàáðÿ 2025).")
script_version("3.2")
----------------------------------------------- INIT ---------------------------------------------
function isMonetLoader() return MONET_VERSION ~= nil end
print('Èíèöèàëèçàöèÿ ñêðèïòà...')
print('Âåðñèÿ: ' .. thisScript().version)
print('Ïëàòôîðìà: ' .. (isMonetLoader() and 'MOBILE' or 'PC'))
------------------------------------------ INIT CRASH INFO ---------------------------------------
if not doesFileExist(getWorkingDirectory():gsub('\\','/') .. "/.Rodina Helper Crash Message.lua") then
	local file_path = getWorkingDirectory():gsub('\\','/') .. "/.Rodina Helper Crash Message.lua"
	local content = [[
function onSystemMessage(msg, type, script)
	if type == 3 and script and script.name == 'Rodina Helper' and msg and not msg:find('Script died due to an error') then
		local errorMessage = ('{ffffff}Ïðîèçîøëà íåïðåäóñìîòðåííàÿ îøèáêà â ðàáîòå ñêðèïòà, èç-çà ÷åãî îí áûë îòêëþ÷¸í!\n\n' ..
		'Îòïðàâüòå ñêðèíøîò è log â {ff9900}òåõ.ïîääåðæêó MTG MODS (Telegram/Discord/BlastHack){ffffff}.\n\n' ..
		'Äåòàëè âîçíèêøåé îøèáêè:\n{ff6666}' .. msg)
		sampShowDialog(789789, '{009EFF}Rodina Helper [' .. script.version .. ']', errorMessage, '{009EFF}Çàêðûòü', '', 0)
	end
end
	]]
	local file, errstr = io.open(file_path, 'w')
	if file then
		file:write(content)
		file:close()
		if not isMonetLoader() then
			os.execute('attrib +h "' .. file_path .. '"')
		end
	end
end
------------------------------------------- CONNECT LIBNARY ---------------------------------------
print('Ïîäêëþ÷åíèå íóæíûõ áèáëèîòåê...')
require('lib.moonloader')
require('encoding').default = 'CP1251'
require "lib.moonloader"
require 'lib.sampfuncs'
local u8 = require('encoding').UTF8
local ffi = require('ffi')
local ffi = require 'ffi'
local statuscheckafk = true
local inicfg = require 'inicfg'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'    
u8 = encoding.UTF8
CP1251 = encoding.CP1251
sw,sh = getScreenResolution()
local effil = require('effil')
local imgui = require('mimgui')
local fa = require('fAwesome6_solid')
local sampev = require('samp.events')
local monet_no_errors, moon_monet = pcall(require, 'MoonMonet')
local hotkey_no_errors, hotkey = pcall(require, 'mimgui_hotkeys')
local pie_no_errors, pie = pcall(require, 'mimgui_piemenu')
local sizeX, sizeY = getScreenResolution()
print('Áèáëèîòåêè óñïåøíî ïîäêëþ÷åíû!')
-------------------------------------------- JSON SETTINGS ---------------------------------------
local configDirectory = getWorkingDirectory():gsub('\\','/') .. "/Rodina Helper"
local settings = {}
local default_settings = {
	general = {
		version = thisScript().version,
        custom_dpi = 1.0,
		autofind_dpi = false,
        helper_theme = 0,
		message_color = 40703,
		moonmonet_theme_color = 40703,
		fraction_mode = '',
		bind_mainmenu = '[113]',
		bind_fastmenu = '[69]',
		bind_leader_fastmenu = '[71]',
		bind_action = '[13]',
		bind_command_stop = '[123]',
		piemenu = false,
		mobile_fastmenu_button = true,
		mobile_stop_button = true,
		payday_notify = true,
		cruise_control = true,
		auto_uninvite = false,
		ping = true,
		rp_guns = true,
	},
	player_info = {
		nick = '',
		name_surname = '',
		fraction = 'none',
		fraction_tag = '',
		fraction_rank = '',
		fraction_rank_number = 0,
		sex = 'Ìóæ÷èíà',
		accent_enable = true,
		accent = '[Èíîñòðàííûé àêöåíò]:',
		rp_chat = true,
	},
	departament = {
		anti_skobki = false,
		dep_fm = '-',
		dep_tag1 = '',
		dep_tag2 = '[Âñåì]',
		dep_tags = {
			"[Âñåì]",
			"[Ïîõèòèòåëè]",
			"[Òåðîðèñòû]",
			"[Äèñïåò÷åð]",
			'skip',
			"[ÃÓÂÄ]",
			"[ÃÈÁÄÄ]",
			"[ÔÑÁ]",
			"[ÔÑÈÍ]",
			'skip',
			"[Ìèí.ÌÂÄ]",
			"[Ìèí.ÌÎ]",
			"[Ìèí.ÌÇ]",
			"[Ìèí.ÑÐ]",
			'skip',
			"[ÃÊÁ]",
			"[ÎÊÁ]",
			'skip',
			"[Ïðà-âî]",
			"[Ïðî-ðà]",
			'skip',
			"[ÌÐÝÎ]",
			"[ÃÒÐÊ]",
			"[Àðìèÿ]",
		},
		dep_tags_custom = {},
		dep_fms = {
			'-',
			'- ç.ê. -',
		},
	},
	windows_pos = {
		megafon = {x = sizeX / 8.5, y = sizeY / 2.1},
		patrool_menu = {x = sizeX / 2, y = sizeY / 2},
		post_menu = {x = sizeX / 2, y = sizeY / 2},
		wanteds_menu = {x = sizeX / 1.2, y = sizeY / 2},
		mobile_fastmenu_button = {x = sizeX / 8.5, y = sizeY / 2.3},
		taser = {x = sizeX / 4.2, y = sizeY / 2.1},
	},
    mj = {
		auto_doklad_damage = false,
		mobile_meg_button = true,
		mobile_taser_button = true,
		auto_change_code_siren = true,
    },
	md = {
		auto_doklad_damage = false,
		auto_doklad_patrool = true,
	},
	mh = {
		price = {
			ant = 50000,
			recept = 100000,
			heal = 100000,
			heal_vc = 1000,
			healactor_vc = 1000,
			medosm = 800000,
			mticket = 400000,
			med7 = 70000,
			med14 = 100000,
			med30 = 150000,
			med60 = 200000,		
		},
		heal_in_chat = {
			enable = true,
		},
	},
	smi = {
		ads_history = true,
		use_ads_buttons = true,
	},
	lc = {
		price = {
			avto1 = 200000,
			avto2 = 360000,
			avto3 = 410000,
			moto1 = 300000,
			moto2 = 350000,
			moto3 = 450000,
			fish1 = 500000,
			fish2 = 550000,
			fish3 = 590000,
			swim1 = 500000,
			swim2 = 550000,
			swim3 = 590000,
			gun1 = 1000000,
			gun2 = 1090000,
			gun3 = 1150000,
			hunt1 = 1000000,
			hunt2 = 1100000,
			hunt3 = 1190000,
			klad1 = 1100000,
			klad2 = 1200000,
			klad3 = 1250000,
			taxi1 = 800000,
			taxi2 = 1150000,
			taxi3 = 1250000,
			mexa1 = 800000,
			mexa2 = 1150000,
			mexa3 = 1250000,
			fly1 = 1200000,
			fly2 = 1200000,
			fly3 = 1200000,
		},
		auto_find_clorest_repair_znak = true,
	},
	gov = {
		anti_trivoga = true,
		zeks_in_screen = true
	}
}
function load_settings()
    if not doesDirectoryExist(configDirectory) then createDirectory(configDirectory) end
    if not doesFileExist(configDirectory .. "/Settings.json") then
        settings = default_settings
		print('Ôàéë ñ íàñòðîéêàìè íå íàéäåí, èñïîëüçóþ ñòàíäàðòíûå íàñòðîéêè!')
    else
        local file = io.open(configDirectory .. "/Settings.json", 'r')
        if file then
            local contents = file:read('*a')
            file:close()
			if #contents ~= 0 then
				local result, loaded = pcall(decodeJson, contents)
				if result then	
					settings = loaded
					if settings.general.version ~= thisScript().version then
						print('Íîâàÿ âåðñèÿ, ñáðîñ íàñòðîåê!')
						local fraction_mode = settings.general.fraction_mode
						local player_info = settings.player_info
						settings = default_settings
						settings.player_info = player_info
						settings.general.fraction_mode = fraction_mode
						save_settings()
						reload_script = true
						thisScript():reload()
					else
						print('Íàñòðîéêè óñïåøíî çàãðóæåíû!')
					end
				else
					settings = default_settings
					print('Íå óäàëîñü îòêðûòü ôàéë ñ íàñòðîéêàìè, èñïîëüçóþ ñòàíäàðòíûå íàñòðîéêè!')
				end
			else
                settings = default_settings
				print('Íå óäàëîñü îòêðûòü ôàéë ñ íàñòðîéêàìè, èñïîëüçóþ ñòàíäàðòíûå íàñòðîéêè!')
			end
        else
            settings = default_settings
			print('Íå óäàëîñü îòêðûòü ôàéë ñ íàñòðîéêàìè, èñïîëüçóþ ñòàíäàðòíûå íàñòðîéêè!')
        end
    end
end
function save_settings()
    local file, errstr = io.open(configDirectory .. "/Settings.json", 'w')
    if file then
		local function looklike(array) 
			local dkok, dkjson = pcall(require, "dkjson") 
			if dkok then 
				local ok, encoded = pcall(dkjson.encode, array, {indent = true})
				if ok then return encoded end
			else
				local ok, encoded = pcall(encodeJson, array) 
				if ok then return encoded end 
			end
		end
		local content = looklike(settings)
		if content then
			file:write(content)
			print('Íàñòðîéêè õåëïåðà ñîõðàíåíû!')
		else
			print('Íå óäàëîñü ñîõðàíèòü íàñòðîéêè õåëïåðà! Îøèáêà êîäèðîâêè json')
		end
		file:close()
    else
        print('Íå óäàëîñü ñîõðàíèòü íàñòðîéêè õåëïåðà, îøèáêà: ', errstr)
    end
end
function isMode(mode_type)
	return settings.general.fraction_mode == mode_type
end
load_settings()
------------------------------------------- AUTO FIND DPI ----------------------------------------
if not settings.general.autofind_dpi then
	print('Ïðèìåíåíèå àâòî-ðàçìåðà ìåíþøåê...')
	if isMonetLoader() then
		settings.general.custom_dpi = MONET_DPI_SCALE
	else
		local width_scale = sizeX / 1366
		local height_scale = sizeY / 768
		settings.general.custom_dpi = (width_scale + height_scale) / 2
	end
	settings.general.autofind_dpi = true
	local format_dpi = string.format('%.3f', settings.general.custom_dpi)
	settings.general.custom_dpi = tonumber(format_dpi)
	print('Óñòàíîâëåíî çíà÷åíèå: ' .. settings.general.custom_dpi)
	print('Âû â ëþáîé ìîìåíò ìîæåòå èçìåíèòü çíà÷åíèå â íàñòðîéêàõ!')
	save_settings()
end
------------------------------------------ JSON & MODULES ----------------------------------------
local modules = {
	commands = {
		name = 'Êîìàíäû',
		path = configDirectory .. "/Commands.json",
		data = {
			commands = {
				my = {
					{cmd = 'time' , description = 'Ïîñìîòðåòü âðåìÿ' ,  text = '/me âçãëÿíóë{sex} íà ÷àñû ñ ãðàâèðîâêîé Rodina Helper è ïîñìîòðåë{sex} âðåìÿ&/time' , arg = '' , enable = true, waiting = '1.0', bind = "{}"},
					{cmd = 'cure' , description = 'Ïîäíÿòü èãðîêà èç ñòàäèè' ,  text = '/me íàêëîíÿåòñÿ íàä ÷åëîâåêîì è àêêóðàòíî ïðîùóïûâàåò ïóëüñ íà ñîííîé àðòåðèè&/cure {arg_id}&/do Ïóëüñ îòñóòñòâóåò.&/me íà÷èíàåò íåïðÿìîé ìàññàæ ñåðäöà, ïåðèîäè÷åñêè ïðîâåðÿÿ ïóëüñ&/do ×åðåç íåñêîëüêî ìèíóò ñåðäöå âîçîáíîâëÿåò ðàáîòó  ïóëüñ ïîÿâëÿåòñÿ.&/do ×åëîâåê ïðèõîäèò â ñîçíàíèå.&/todo «Îòëè÷íî!»  óëûáàåòñÿ ïåðñîíàæ.' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}"},
					},
				police = {
					{cmd = 'zd' , description = 'Ïðèâåòñòâèå èãðîêà' , text = 'Çäðàâèÿ æåëàþ, ÿâëÿþñü ñîòðóäíèêîì {fraction} {fraction_rank} ïî Âîñòî÷íîìó îêðóãó.&Ïðåäüÿâèòå ñâîè äîêóìåíòû äëÿ óäîñòîâåðåíèå ëè÷íîñòè.', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'mm' , description = 'Âêë/âûêë ìèãàëîê â ò/ñ' , text = '/m Âîäèòåëü {get_storecar_model} ,ïðèæìèòåñü ê îáî÷èíå è çàãëóøèòå äâèãàòåëü!!&/m Â ñëó÷àå íåïîä÷èíåíèÿ, íà âàñ áóäåò îòêðûò îãîíü íà ïîðàæåíèå!!', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'tt' , description = 'Çàïðîñ ìåñòî ðàñïîëîæåíèå(âñåõ)' , text = '/r Âñåì! Äîëîæèòå ñâî¸ ìåñòîïîëîæåíèå â ðàöèþ.&/r Åñëè íàõîäèòåñü ñ íàïàðíèêîì  óêàæèòå òàêæå åãî æåòîí', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'fara' , description = 'Îñòàâèòü îòïå÷àòîê íà ôàðå' , text = '/me ïîäîéäÿ ê òðàíñïîðòíîìó ñðåäñòâó, ïðîòèðàåò ëåâóþ ôàðó, îñòàâëÿÿ îòïå÷àòîê&/do Îòïå÷àòîê óñïåøíî îñòàâëåí íà ëåâîé ôàðå òðàíñïîðòíîãî ñðåäñòâà.', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'pas' , description = 'Çàïðîñ äîêóìåíòîâ' ,  text = 'Çäðàâñòâóéòå, óïðàâëåíèå {fraction_tag}. ß  {fraction_rank} {my_ru_nick}.&/do Íà ëåâîé ñòîðîíå ãðóäè ðàçìåù¸í æåòîí ïîëèöåéñêîãî, íà ïðàâîé  èìåííàÿ íàøèâêà ñ èìåíåì.&/me äîñòà¸ò óäîñòîâåðåíèå èç êàðìàíà&/showbadge {arg_id}&Ïðîøó ïðåäúÿâèòü äîêóìåíò, óäîñòîâåðÿþùèé ëè÷íîñòü.&/n @{get_nick({arg_id})}, ââåäèòå êîìàíäó /showpass {my_id}' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'ts' , description = 'Âûïèñàòü øòðàô' ,  text = '/do Ìèíè-ïëàíòåò íàõîäèòüñÿ â êàðìàíå ôîðìû.&/writeticket {arg_id} {arg2}&/me âíîñèò èçìåíåíèÿ â áàçó øòðàôîâ&/todo Îïëàòèòå øòðàô*óáèðàÿ ìèíè-ïëàíøåò îáðàòíî â êàðìàí' , arg = '{arg_id} {arg2}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'pur' , description = 'Ïîèñê èãðîêà' ,  text = '/me Çàøåë â Áàçó äàííûõ ñ ïîìîùüþ áîðîòîãî êîìïüþòåðà.&/me Ââåë äàííûå î ìàøèíå è íà÷àë ïîãîíþ.&/pursuit {arg_id}&/do GPS òðåêåð âêëþ÷åí.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'pr' , description = 'Ïîãîíÿ çà ïðåñòóïíèêîì' ,  text = '/me äîñòàë{sex} ñâîé ÊÏÊ è çàéäÿ â áàçó äàííûõ {fraction_tag} îòêðûë{sex} äåëî ïðåñòóïíèêà N{arg_id}&/me íàæàë{sex} íà êíîïêó GPS îòñëåæèâàíèÿ ìåñòîïîëîæåíèÿ ãðàæäàíèíà&/pursuit}' , arg = '' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'su' , description = 'Âûäàòü ðîçûñê' ,  text = '/su {arg_id} {arg2} {arg3}&/z {arg_id}&/me Äîñòàë ÊÏÊ ââåë äàííûå î ïîäîçðåâàåìîì.&/do Ïîäîçðåâàåìûé íàõîäèòñÿ â ðîçûñêå.' , arg = '{arg_id} {arg2} {arg3}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'clear' , description = 'Ñíÿòü ðîçûñê' ,  text = '/me äîñòà¸ò ñâîé ÊÏÊ è îòêðûâàåò áàçó äàííûõ ïðåñòóïíèêîâ&/me íàéäÿ äåëî N{arg_id} âíîñèò èçìåíåíèÿ â áàçó äàííûõ ïðåñòóïíèêîâ&/clear {arg_id}&/do Äåëî N{arg_id} áîëüøå íå íàõîäèòñÿ â ñïèñêå ðàçûñêèâàåìûõ ïðåñòóïíèêîâ.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'gcuff' , description = 'Íàäåòü íàðó÷íèêè è âåñòè çà ñîáîé' ,  text = '/do Íàðó÷íèêè íà òàêòè÷åñêîì ïîÿñå.&/todo ß íàäåíó íà âàñ íàðó÷íèêè*ñíèìàÿ íàðó÷íèêè ñ òàêòè÷åñêîãî ïîÿñà&/cuff {arg_id}&/todo Íå äâèãàéòåñü*íàäåâàÿ íàðó÷íèêè íà ÷åëîâåêà&/me ñõâàòûâàåò çàäåðæàííîãî çà ðóêè è âåä¸ò åãî çà ñîáîé&/gotome {arg_id}&/do Çàäåðæàííûé èä¸ò â êîíâîå.' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'cf', description = 'Íàäåòü íàðó÷íèêè' ,  text = '/me Äîñòàë íàðó÷íèêè ñ íàãðóäíîãî êàðìàíà è íàäåë èõ íà çàïÿñòüå çàäåðæàííîãî.&/cuff {arg_id}&/do Íàðó÷íèêè íà çàïÿñòüå.' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},
					{cmd = 'uncuff' , description = 'Ñíÿòü íàðó÷íèêè' ,  text = '/uncf {arg_id}&/me Äîñòàë êëþ÷è îò íàðó÷íèêîâ.&/me Îòêðûë ñ ïîìîùüþ êëþ÷åé íàðó÷íèêè.&/uncuff {arg_id}&/do Íàðó÷íèêè îòêðûòû.&/me Ñíÿë ñ çàïÿñòüå íàðó÷íèêè.&/do Çàïÿñòüå çàäåðæàííîãî ñâîáîäíû.', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'gtm' , description = 'Ïîâåñòè çà ñîáîé' ,  text = '/me Ñõâàòèë çà çàïÿñòüå è ïîâåë çàäåðæàííîãî.&/gotome {arg_id}&/do Çàäåðæàííûé â êîíâîå.', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'ungtm' , description = 'Ïåðåñòàòü âåñòè çà ñîáîé' ,  text = '/me Îòïóñòèë ðóêó ñ çàïÿñòüå çàäåðæàííîãî.&/ungotome {arg_id}&/do Çàäåðæàííûé ñâîáîäåí.', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'bot' , description = 'Èçüÿòü ñêðåïêè ó èãðîêà (âçëîì íàðó÷íèêîâ)' ,  text = '/me óâèäåë{sex} ÷òî çàäåðæàííûé èñïîëüçóåò ñêðåïêè äëÿ âçëîìà íàðó÷íèêîâ&/todo Âû ÷òî ñåáå ïîçâîëÿåòå?!*èçûìàÿ ñêðåïêè ó {get_rp_nick({arg_id})}&/bot {arg_id}' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'ss' , description = 'Êðè÷àëêà' ,  text = '/s Âñåì ïîäíÿòü ðóêè ââåðõ, ðàáîòàåò {fraction_tag}!', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'fris' , description = 'îáûñê' ,  text = '/me Äîñòàë ðåçèíîâûå ïåð÷àòêè è çàòåì íàäåë èõ íà ðóêè.&/me ïðîùóïûâàåò òåëî è êàðìàíû çàäåðæàííîãî ÷åëîâåêà&/me äîñòà¸ò èç êàðìàíîâ çàäåðæàííîãî âñå åãî âåùè äëÿ èçó÷åíèÿ&/me âíèìàòåëüíî îñìàòðèâàåò âñå íàéäåííûå âåùè ó çàäåðæàííîãî ÷åëîâåêà&/frisk {arg_id}&/me ñíèìàåò ðåçèíîâûå ïåð÷àòêè è óáèðàåò èõ.&/me Áåðåò â ðóêè áëîêíîò ñ ðó÷êîé, è çàïèñûâàåò âñþ èíôîðìàöèþ ïðî îáûñê.', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'take' , description = 'Èçüÿòèå ïðåäìåòîâ èãðîêà' , text = '/do Â ïîäñóìêå íàõîäèòüñÿ íåáîëüøîé çèï-ïàêåò.&/me äîñòà¸ò èç ïîäñóìêà çèï-ïàêåò è îòðûâàåò åãî&/me êëàä¸ò â çèï-ïàêåò èçúÿòûå ïðåäìåòû çàäåðæàííîãî ÷åëîâåêà&/take {arg_id}&/do èçúÿòûå ïðåäìåòû â çèï-ïàêåòå.&/todo Îòëè÷íî*óáèðàÿ çèï-ïàêåò â ïîäñóìîê', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true  },
					{cmd = 'camon' , description = 'Âêëþ÷èòü cêðûòóþ áîäè êàìåðó' ,  text = '/do Ê ôîðìå ïðèêðåïëåíà ñêðûòàÿ áîäè êàìåðà.&/me íåçàìåòíûì äâèæåíèåì ðóêè âêëþ÷èë{sex} áîäè êàìåðó.&/do Ñêðûòàÿ áîäè êàìåðà âêëþ÷åíà è ñíèìàåò âñ¸ ïðîèñõîäÿùåå.', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'camoff' , description = 'Âûêëþ÷èòü cêðûòóþ áîäè êàìåðó' ,  text = '/do Ê ôîðìå ïðèêðåïëåíà ñêðûòàÿ áîäè êàìåðà.&/me íåçàìåòíûì äâèæåíèåì ðóêè âûêëþ÷èë{sex} áîäè êàìåðó.&/do Ñêðûòàÿ áîäè êàìåðà âûêëþ÷åíà è áîëüøå íå ñíèìàåò âñ¸ ïðîèñõîäÿùåå.', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'inc' , description = 'Çàòàùèòü â òðàíñïîðò' ,  text = '/me îòêðûâàåò çàäíþþ äâåðü òðàíñïîðòà&/todo Íàêëîíèòå ãîëîâó, çäåñü äâåðü*çàòàëêèâàÿ çàäåðæàííîãî â òðàíñïîðòíîå ñðåäñòâî&/incar {arg_id} {arg2}&/me çàêðûâàåò çàäíþþ äâåðü òðàíñïîðòà&/do Çàäåðæàííûé â òðàíñïîðòíîì ñðåäñòâå.', arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'ej' , description = 'Âûáðîñèòü èç òðàíñïîðòà',  text = '/me îòêðûâàåò äâåðü òðàíñïîðòà&/me ïîìîãàåò ÷åëîâåêó âûéòè èç òðàíñïîðòà&/eject {arg_id}&/me çàêðûâàåò äâåðü òðàíñïîðòà', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},	
					{cmd = 'pl' , description = 'Âûáðîñèòü èãðîêà èç åãî òðàíñïîðòà',  text = '/me â îòâåò íà ïîïûòêó íàåçäà ðàçáèâàåò äóáèíêîé ëîáîâîå ñòåêëî, ÷òîáû íåéòðàëèçîâàòü óãðîçó.&/pull {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},	
					{cmd = 'mr' , description = 'Çà÷èòàòü ïðàâèëî Ìèðàíäû',  text = 'Òàê, ãðàæäàíèí, âû ãîòîâû?&Ãðàæäàíèí, ïåðåä òåì êàê ìû ïðîäîëæèì êàêèå-ëèáî ñëåäñòâåííûå äåéñòâèÿ,& ÿ îáÿçàí çà÷èòàòü âàì âàøè ïðàâà â ñîîòâåòñòâèè ñ çàêîíîäàòåëüñòâîì íàøåãî øòàòà. Âî-ïåðâûõ,& âû èìååòå ïðàâî õðàíèòü ìîë÷àíèå. Ýòî îçíà÷àåò& ÷òî ñ ýòîãî ìîìåíòà âû íå îáÿçàíû îòâå÷àòü íà êàêèå-ëèáî âîïðîñû,& êîòîðûå âàì áóäóò çàäàíû ñîòðóäíèêàìè ïðàâîîõðàíèòåëüñêîãî îðãàíà,& âêëþ÷àÿ ìåíÿ. Ýòî âàøå êîíñòèòóöèîííîå ïðàâî,& îíî çàùèùàåò âàñ îò âîçìîæíîñòè ñàìîîáîðîíû èëè ïðåäîñòàâëåíèÿ èíôîðìàöèè,& êîòîðàÿ ìîæåò áûòü èíòåðïðåòèðîâàíà ïðîòèâ âàñ â äàëüíåéøåì. ß ïîä÷åðêèâàþ, âñå,& ÷òî âû ñêàæåòå ñåé÷àñ, â äàëüíåéøåì ìîæåò è áóäåò èñïîëüçîâàíî ïðîòèâ âàñ.& Ýòî âêëþ÷àåò â ñåáÿ êàê óñòíûå, òàê è ïèñüìåííûå çàÿâëåíèÿ,& à òàêæå ëþáûå âàøè äåéñòâèÿ, çàôèêñèðîâàííûå â õîäå íàøåãî âçàèìîäåéñòâèÿ.& Äàæå åñëè âàøè ñëîâà îêàæóòñÿ âàì áåçîáèäíûìè,& âñå ìîæåò òðàêòîâàòüñÿ â ðàìêàõ óãîëîâíîãî äåëà.& Ïîýòîìó âû èìååòå ïîëíîå ïðàâî îòêàçàòüñÿ îò äà÷è êàêèõ-ëèáî ïîÿñíåíèé áåç ïðèñóòñòâèÿ àäâîêàòà.& Âî-âòîðûõ, âû èìååòå ïðàâî íà þðèäè÷åñêóþ çàùèòó,& òî åñòü ïðàâî íà àäâîêàòà. Âû ìîæåòå âîñïîëüçîâàòüñÿ óñëóãàìè ÷àñòíîãî àäâîêàòà ïî âàøåìó âûáîðó.& Ýòîò àäâîêàò ìîæåò ïðèñóòñòâîâàòü ïðè âñåõ äîïðîñàõ è äðóãèõ ñëåäñòâåííûõ äåéñòâèÿõ,& è îí áóäåò ïðåäñòàâëÿòü âàøè èíòåðåñû,& ñëåäèòü çà ñîáëþäåíèåì ïðîöåäóðû è ïîìîãàòü âàì äàâàòü èëè íå äàâàòü ïîêàçàíèÿ.& Â ðàìêàõ çàêîíîäàòåëüñòâà íàøåãî øòàòà ãîñçàùèòíèêè ïðåäîñòàâëÿþòñÿ,& òî åñòü âû ìîæåòå ðàññ÷èòûâàòü íà áåñïëàòíîãî àäâîêàòà îò ãîñóäàðñòâà,& îäíàêî ó âàñ åñòü ïðàâî íà îäèí òåëåôîí-çâîíîê èñêëþ÷èòåëüíî äëÿ òîãî,& ÷òîáû ñâÿçàòüñÿ ñ ÷àñòíûì àäâîêàòîì, åñëè ó âàñ òàêîãî íå èìååòñÿ èëè åñëè âû çíàåòå,& ê êîìó îáðàòèòüñÿ. Ýòîò çâîíîê áóäåò ïðåäîñòàâëåí âàì â ðàçóìíûå ñðîêè ïðè ïåðâîé âîçìîæíîñòè,& êàê òîëüêî ýòî áóäåò áåçîïàñíî è ïðîöåññóàëüíî âîçìîæíî.& Åñëè âû ñîîáùèòå íàì êîíòàêòíûå äàííûå âàøåãî àäâîêàòà,& ìû îáåñïå÷èì ñâÿçü. Îáðàòèòå âíèìàíèå,& ÷òî ëþáûå ðàçãîâîðû çà èñêëþ÷åíèåì îáùåíèÿ ñ âàøèì àäâîêàòîì ìîãóò áûòü çàïèñàíû è èñïîëüçîâàíû êàê äîêàçàòåëüñòâà.& Òàêæå õî÷ó ïîäìåòèòü,& ÷òî îòêàç îò èñïîëüçîâàíèÿ ýòèõ ïðàâ ýòî âàøå ëè÷íîå ðåøåíèå.& Âû ìîæåòå äîáðîâîëüíî îòêàçàòüñÿ îò ìîë÷àíèÿ è íà÷àòü äàâàòü ïîêàçàíèÿ.& Îäíàêî, åñëè âû ðåøèòå íà÷àòü ãîâîðèòü,& à çàòåì ïåðåäóìàåòå âû âñå åùå ìîæåòå â ëþáîé ìîìåíò çàÿâèòü ÷òî õîòèòå âîñïîëüçîâàòüñÿ& ïðàâîì íà ìîë÷àíèå èëè àäâîêàòà, ìû íå ìîæåì âàñ çàñòàâëÿòü ïðîäîëæàòü ãîâîðèòü,& êðîìå òîãî ëþáûå óãðîçû ïñèõîëîãè÷åñêîå äàâëåíèå,& ôèç.íàñèëèå èëè ïðîâîêàöèÿ ñ íàøåé ñòîðîíû íå äîïóñòèìû,& åñëè òàêîå ïðîèçîéäåò âû èìååòå ïðàâî ïîäàòü æàëîáó â ñîîòâåòñòâóþùèå èíñòàíöèè,& ìû îáÿçàíû ñîáëþäàòü ïðîöåäóðû à âû çàùèùåíû çàêîíîì,& ñåé÷àñ íà äàííûé ìîìåíò ïðîøó âàñ âíèìàòåëüíî ïîäóìàòü íàä ñâîèìè ïðàâàìè,& åñëè âû ÷òî-òî íå ïîíÿëè âû ìîæåòå çàäàòü âîïðîñû,& ÿ îáÿçàí îáúÿñíèòü âàì âñå ïóíêòû ìàêñèìàëüíî äîñòóïíî,& ïîäòâåðäèòå ïîæàëóéñòà ÷òî âû ïîíèìàåòå ñâîè ïðàâà êàê îíè áûëè âàì çà÷òåíû,& ïîñëå ýòîãî âû ìîæåòå ïðèíÿòü ðåøåíèå áóäåòå ëè âû ãîâîðèòü èëè âîñïîëüçóåòåñü ïðàâîì íà ìîë÷àíèå è ïðàâîì íà àäâîêàòà,& ìû íå òîðîïèìñÿ, âñå ÷òî âû ñêàæåòå èëè íå ñêàæåòå áóäåò îòðàæåíî â ïðîòîêîëå& èñïîëüçîâàíî ñòðîãî â ðàìêàõ çàêîíà.& Âàì ïîíÿòíî ãðàæäàíèí?', arg = '', enable = true, waiting = '2.5', bind = "{}"},	
					{cmd = 'unmask' , description = 'Ñíÿòü áàëàêëàâó ñ èãðîêà',  text = '/do Çàäåðæàííûé â áàëàêëàâå.&/me ñòÿãèâàåò áàëàêëàâó ñ ãîëîâû çàäåðàæííîãî&/unmask {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}" , in_fastmenu = true},
					{cmd = 'arrest' , description = 'Ïîñàäèòü â ÊÏÇ',  text = '/me áûñòðûìè äâèæåíèÿìè ââîäèò êîä íà êëàâèàòóðå áîðòîâîãî êîìïüþòåðà.&/me â ñèñòåìå îôîðìëÿåò è ðàñïå÷àòûâàåò ïðîòîêîë çàäåðæàíèÿ íà ïîäîçðåâàåìîãî.&/do Ïðîòîêîë ãîòîâ, ïîäïèñü ïîñòàâëåíà.&/me ñâÿçûâàåòñÿ ñ äåæóðíûì íàðÿäîì ïî ðàöèè: «Ïîäîéäèòå äëÿ ïðè¸ìêè çàäåðæàííîãî».&/arrest {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'drugs' , description = 'Ïðîâåñòè Drugs Test' ,  text = '/do Íà òàêòè÷åñêîì ïîÿñå ïðèêðåïë¸í ïîäñóìîê.&/me îòêðûâàåò ïîäñóìîê è äîñòà¸ò èç íåãî íàáîð Drugs Test&/me áåð¸ò èç íàáîðà ïðîáèðêó ñ ýòèëîâûì ñïèðîì&/me çàñûïàåò íàéäåííîå âåùåñòâî â ïðîáèðêó&/me äîñòà¸ò èç ïîäñóìêà òåñò Èìóíî-Õðîì-10 è äîáàâëÿåò åãî â ïðîáèðêó&/do Â ïðîáèðêå ñ ýòèëîâûì ñïèðòîì íàõîäèòñÿ íåèçâåñòíîå âåùåñòâî è Èìóíî-Õðîì-10.&/me àêêóðàòíûìè äâèæåíèÿìè âçáàëòûâàåò ïðîáèðêó&/do Îò òåñòà Èìóíî-Õðîì-10 ñîäåðæèìîå ïðîáèðêè èçìåíèëî öâåò.&/todo Äà, ýòî òî÷íî íàðêîòèêè*óâèäåâ ÷òî ñîäåðæèìîå ïðîáèðêè èçìåíèëî öâåò&/me óáèðàåò ïðîáèðêó îáðàòíî â ïîäñóìîê è çàêðûâàåò åãî', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'rbomb' , description = 'Äåàêòèâèðîâàòü áîìáó' ,  text = '/do Íà òàêòè÷åñêîì ïîÿñå ïðèêðåïë¸í ñàï¸ðíûé íàáîð.&/me ñíèìàåò ñ ïîÿñà ñàï¸ðíûé íàáîð è êëàäåò åãî íà çåìëþ, çàòåì îòêðûâàåò åãî&/do Îòêðûòûé ñàï¸ðíûé íàáîð íàõîäèòñÿ íà çåìëå.&/me äîñòà¸ò èç ñàï¸ðíîãî íàáîðà ïàêåò ñ æèäêèì àçîòîì è êëàäåò åãî íà çåìëþ&/me äîñòà¸ò èç ñàï¸ðíîãî íàáîðà îòâ¸ðòêó&/do Îòâåðòêà â ðóêàõ, à ïàêåò ñ æèäêèì àçîòîì íà çåìëå.&/do Íà êîðïóñå áîìáû íàõîäèòñÿ 2 áîëòèêà.&/me îòêðó÷èâàåò áîëòèêè ñ áîìáû è óáèðàåò èõ âìåñòå ñ îòâ¸ðòêîé â ñòîðîíó&/me àêêóðàòíûì äâèæåíèåì ðóêè âñêðûâàåò êðûøêó áîìáû&/me âíèìàòåëüíî îñìàòðèâàåò áîìáó&/do Âíóòðè áîìáû âèäíà äåòîíèðóþùàÿ ÷àñòü.&/me äîñòà¸ò èç ñàï¸ðíîãî íàáîðà êóñà÷êè&/do Êóñà÷êè â ðóêàõ.&/me àêêóðàòíûì äâèæåíèåì êóñî÷îê ðàçðåçàåò êðàñíûé ïðîâîä áîìáû&/do Òàéìåð îñòàíîâèëñÿ, òèêàíüå ñî ñòîðîíû áîìáû íå ñëûøíî.&/me áåð¸ò â ðóêè îõëàæäàþùèé ïàêåò ñ æèäêèì àçîòîì è êëàä¸ò åãî äåòîíèðóþùóþ ÷àñòü áîìáû&/removebomb&/do Áîìáà îáåçâðåæåíà.&/me óáèðàåò êóñà÷êè è îòâ¸ðòêó îáðàòíî â ñàïåðíûé íàáîð è çàêðûâàåò åãî', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'delo' , description = 'Ðàññëåäîâàíèå óáèéñòâà' ,  text = '/do Ñîòðóäíèê ïðèáûë íà ìåñòî óáèéñòâà.&/todo Òàêñ, ÷òî æå çäåñü ïðîèçîøëî*îñìàòðèâàÿ ìåñòî óáèéñòâà&/me îñìàòðèâàåò è  èçó÷àåò âñå óëèêè&{pause}&/me äîñòà¸ò èç ïîäñóìêà áëàíê äëÿ ðàññëåäîâàíèÿ è ðó÷êó&/me çàïîëíÿåò áëàíê ðàññëåäîâàíèÿ çàïèñûâàÿ âñå èçó÷åííûå óëèêè&{pause}&/me çàïèñûâàåò â áëàíê òî÷íóþ äàòó è âðåìÿ óáèéñòâà&{pause}&/do Íàéäåíî îðóäèå óáèéñòâà.&/me çàïèñûâàåò â áëàíê îðóäèå óáèéñòâà&{pause}&/do Áëàíê ðàññëåäîâàíèÿ óáèéñòâà ïîëíîñòüþ çàïîëíåí.&/todo Îòëè÷íî, ðàññëåäîâàíèå îêîí÷åíî*óáèðàÿ áëàíê â êàðìàí', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'siren' , description = 'Âêë/âûêë ìèãàëîê â ò/ñ' , text = '{switchCarSiren}', arg = '' , enable = true , waiting = '2.5', bind = "{}"}
				},
				fcb = {
					{cmd = 'pr', description = 'Çàïðîñèòü äîêóìåíòû' ,  text = 'Çäðàâèÿ æåëàþ.&ßâëÿþñü Ñîòðóäíèêîì ÔÑÁ ïî Âîñòî÷íîìó Îêðóãó.&Ïðåäüÿâèòå ñâîè äîêóìåíòû.&/n ââåäèòå /showpass {my_id}' , arg = '' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'badge', description = 'Ïîêàçàòü óäîñòîâåðåíèå.' ,  text = '/me Äîñòàë êñèâó ñ íàãðóäíîãî êàðìàíà áðîíåæèëåòå.&/me Îòêðûâ çàêðûë ïàëüöàìè ÔÈÎ è çâàíèå.&/do Êñèâà îòêðûòà.&/todo Âîò ìîå óäîñòîâåðåíèå*äåðæà óäîñòîâåðåíèå&/me Ïîñëå îçíàêîìëåíèÿ çàêðûë êñèâó ëåãêèì äâèæåíèåì ðóêè.&/me Ïîëîæèë êñèâó îáðàòíî â íàãðóäíîé êàðìàí áðîíåæèëåòà.' , arg = '' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'pur', description = 'Ïóðñóéò' ,  text = '/me Çàøåë â Áàçó äàííûõ ñ ïîìîùüþ áîðîòîãî êîìïüþòåðà.&/me Ââåë äàííûå î ìàøèíå è íà÷àë ïîãîíþ.&/pursuit {arg_id}&/do GPS òðåêåð âêëþ÷åí.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'gi', description = 'Èíôîðìàöèÿ î ñîòðóäíèêå' ,  text = '/me Äîñòàë ìèíè-ïëàíøåò, ââåë íîìåð æåòîíà ñîòðóäíèêà.&/getinfo {arg_id}&/do Æåòîí N{arg_id} áûë íàéäåí â áàçå äàííûõ.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'su', description = 'Âûäà÷à ðîçûñêà' ,  text = '/su {arg_id} {arg2} {arg3}&/z {arg_id}&/me Äîñòàë ÊÏÊ ââåë äàííûå î ïîäîçðåâàåìîì.&/do Ïîäîçðåâàåìûé íàõîäèòñÿ â ðîçûñêå.' , arg = '{arg_id} {arg2} {arg3}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'frs', description = 'Îáûñê' ,  text = '/me Äîñòàë ðåçèíîâûå ïåð÷àòêè è çàòåì íàäåë èõ íà ðóêè.&/me ïðîùóïûâàåò òåëî è êàðìàíû çàäåðæàííîãî ÷åëîâåêà&/me äîñòà¸ò èç êàðìàíîâ çàäåðæàííîãî âñå åãî âåùè äëÿ èçó÷åíèÿ&/me âíèìàòåëüíî îñìàòðèâàåò âñå íàéäåííûå âåùè ó çàäåðæàííîãî ÷åëîâåêà&/frisk {arg_id}&/me ñíèìàåò ðåçèíîâûå ïåð÷àòêè è óáèðàåò èõ.&/me Áåðåò â ðóêè áëîêíîò ñ ðó÷êîé, è çàïèñûâàåò âñþ èíôîðìàöèþ ïðî îáûñê.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'cf', description = 'Íàäåòü íàðó÷íèêè' ,  text = '/me Äîñòàë íàðó÷íèêè ñ íàãðóäíîãî êàðìàíà è íàäåë èõ íà çàïÿñòüå çàäåðæàííîãî.&/cuff {arg_id}&/do Íàðó÷íèêè íà çàïÿñòüå.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'uncf', description = 'Ñíÿòü íàðó÷íèêè' ,  text = '/me Äîñòàë êëþ÷è îò íàðó÷íèêîâ.&/me Îòêðûë ñ ïîìîùüþ êëþ÷åé íàðó÷íèêè.&/uncuff {arg_id}&/do Íàðó÷íèêè îòêðûòû.&/me Ñíÿë ñ çàïÿñòüå íàðó÷íèêè.&/do Çàïÿñòüå çàäåðæàííîãî ñâîáîäíû.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'gtm', description = 'Âåñòè â êîíâîå' ,  text = '/me Ñõâàòèë çà çàïÿñòüå è ïîâåë çàäåðæàííîãî.&/gotome {arg_id}&/do Çàäåðæàííûé â êîíâîå.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'ungtm', description = 'Îòïóñòèòü ñ êîíâîÿ' ,  text = '/me Îòïóñòèë ðóêó ñ çàïÿñòüå çàäåðæàííîãî.&/ungotome {arg_id}&/do Çàäåðæàííûé ñâîáîäåí.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'mm', description = 'Ìåãàôîí' ,  text = '/m Âîäèòåëü {get_storecar_model} ,ïðèæìèòåñü ê îáî÷èíå è çàãëóøèòå äâèãàòåëü!!&/m Â ñëó÷àå íåïîä÷èíåíèÿ, íà âàñ áóäåò îòêðûò îãîíü íà ïîðàæåíèå!!' , arg = '' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'wan', description = 'Âàíòåä' ,  text = '/me Îòêðûë áîðòîâîé êîìïüþòåð.&/me Ââåë â ïîèñê "Áàçà ðàçûñêèâàåìûõ ïðåñòóïíèêîâ"&/wanted&/do Áàçà äàííûõ îòêðûòà.' , arg = '' , enable = false, waiting = '2.5', bind = "{}"}			
				},
				army = {
					{cmd = 'pas', description = 'Ïðîâåðêà äîêóìåíòîâ (êïï)', text = 'Çäðàâñòâóéòå, ÿ {fraction_rank} {fraction_tag} - {my_doklad_nick}.&/do Óäîñòîâåðåíèå íàõîäèòüñÿ â ëåâîì êàðìàíå áðþê.&/me äîñòàë{sex} óäîñòîâåðåíèå è ðàñêðûë{sex} åãî ïåðåä ÷åëîâåêîì.&/do Â óäîñòîâåðåíèè óêàçàíî: {fraction} - {fraction_rank} {my_doklad_nick}.&Íàçîâèòå ïðè÷èíó ïðèáûòèÿ íà òåððèòîðèþ íà íàøó áàçó.&È ïðåäîñòàâüòå ìíå ñâîè äîêóìåíòû äëÿ ïðîâåðêè!', arg = '', enable = true, waiting = '2.5', in_fastmenu = true  },
					{cmd = 'agenda' , description = 'Âûäà÷à ïîâåñòêè èãðîêó' ,  text = '/do Â ïàïêå ñ äîêóìåíòàìè ëåæèò ðó÷êà è ïóñòîé áëàíê ñ íàäïèñüþ Ïîâåñòêà.&/me äîñòà¸ò èç ïàïêè ðó÷êó ñ ïóñòûì áëàíêîì ïîâåñòêè&/me íà÷èíàåò çàïîëíÿòü âñå íåîáõîäèìûå ïîëÿ íà áëàíêå ïîâåñòêè&/do Âñå äàííûå â ïîâåñòêå çàïîëíåíû.&/me ñòàâèò íà ïîâåñòêó øòàìï è ïå÷àòü {fraction_tag}&/do Ãîòîâûé áëàíê ïîâåñòêè â ðóêàõ.&/todo Íå çàáóäüòå ÿâèòüñÿ â âîåíêîìàò ïî óêàçàííîìó àäðåñó è âðåìåíè*ïåðåäàâàÿ ïîâåñòêó&/agenda {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'siren' , description = 'Âêë/âûêë ìèãàëîê â ò/ñ' , text = '{switchCarSiren}', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
				},
				prison = {
					{cmd = 't' , description = 'Äîñòàòü òàçåð' ,  text = '/taser', arg = '', enable = true, waiting = '2.5', },
					{cmd = 'cuff', description = 'Íàäåòü íàðó÷íèêè', text = '/cuff {arg_id}&/do Íàðó÷íèêè íà òàêòè÷åñêîì ïîÿñå.&/me ñíèìàåò íàðó÷íèêè ñ ïîÿñà è íàäåâàåò èõ íà çàäåðæàííîãî&/do Çàäåðæàííûé â íàðó÷íèêàõ.', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'uncuff', description = 'Ñíÿòü íàðó÷íèêè', text = '/uncuff {arg_id}&/do Íà òàêòè÷åñêîì ïîÿñå ïðèêðåïëåíû êëþ÷è îò íàðó÷íèêîâ.&/me ñíèìàåò ñ ïîÿñà êëþ÷ îò íàðó÷íèêîâ è âñòàâëÿåò èõ â íàðó÷íèêè çàäåðæàííîãî&/me ïðîêðó÷èâàåò êëþ÷ â íàðó÷íèêàõ è ñíèìàåò èõ ñ çàäåðæàííîãî&/do Íàðó÷íèêè ñíÿòû ñ çàäåðæàííîãî&/me êëàä¸ò êëþ÷ è íàðó÷íèêè îáðàòíî íà òàêòè÷åñêèé ïîÿñ', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'gotome', description = 'Ïîâåñòè çà ñîáîé', text = '/gotome {arg_id}&/me ñõâàòûâàåò çàäåðæàííîãî çà ðóêè è âåä¸ò åãî çà ñîáîé&/do Çàäåðæàííûé èä¸ò â êîíâîå.', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'ungotome', description = 'Ïåðåñòàòü âåñòè çà ñîáîé', text = '/ungotome {arg_id}&/me îòïóñêàåò ðóêè çàäåðæàííîãî è ïåðåñòà¸ò âåñòè åãî çà ñîáîé', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'take', description = 'Èçüÿòèå ïðåäìåòîâ èãðîêà', text = '/do Â ïîäñóìêå íàõîäèòüñÿ íåáîëüøîé çèï-ïàêåò.&/me äîñòà¸ò èç ïîäñóìêà çèï-ïàêåò è îòðûâàåò åãî&/me êëàä¸ò â çèï-ïàêåò èçúÿòûå ïðåäìåòû çàäåðæàííîãî ÷åëîâåêà&/take {arg_id}&/do èçúÿòûå ïðåäìåòû â çèï-ïàêåòå.&/todo Îòëè÷íî*óáèðàÿ çèï-ïàêåò â ïîäñóìîê', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'frisk', description = 'Îáûñê çàêëþ÷¸ííîãî', text = '/do Ïåð÷àòêè íà ïîÿñå.&/me ñõâàòèë ïåð÷àòêè è îäåë&/do Ïåð÷àòêè îäåòû.&/me íà÷àë íàùóïûâàòü ÷åëîâåêà íàïðîòèâ&/frisk {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true}
				},
				hospital = {	
					{cmd = 'siren' , description = 'Âêë/âûêë ìèãàëîê â ò/ñ' , text = '{switchCarSiren}', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'zd' , description = 'Ïðèâåñòâèå èãðîêà' , text = 'Çäðàâñòâóéòå {get_ru_nick({arg_id})}&ß {my_ru_nick} - {fraction_rank} {fraction_tag}&×åì ÿ ìîãó Âàì ïîìî÷ü?', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'hl' , description = 'Kå÷åíèå èãðîêà' , text = '/me äîñòà¸ò èç ñâîåãî ìåä.êåéñà íóæíîå ëåêàðñòâî è ïåðåäà¸ò åãî ÷åëîâåêó íàïðîòèâ&/todo Ïðèíèìàéòå ýòî ëåêàðñòâî, îíî âàì ïîìîæåò*óëûáàÿñü&/heal {arg_id} 1000&/n @{get_nick({arg_id})}, ïðèìèòå ïðåäëîæåíèå ÷òîáû âûëå÷èòüñÿ!', arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'hlb' , description = 'Ëå÷åíèå èãðîêà îò íàðêîçàâèñèìîñòè' ,  text = '/me äîñòà¸ò èç ñâîåãî ìåä.êåéñà òàáëåòêè îò íàðêîçàâèñèìîñòè è ïåðåäà¸ò èõ ïàöèåíòó íàïðîòèâ&/todo Ïðèíèìàéòå ýòè òàáëåòêè, è â ñêîðîì âðåìåíè Âû èçëå÷èòåñü îò íàðêîçàâèñèìîñòè*óëûáàÿñü&/head {arg_id}&/n @{get_nick({arg_id})}, ïðèìèòå ïðåäëîæåíèå ÷òîáû âûëå÷èòüñÿ!' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},	
					{cmd = 'med' , description = 'Îôîðìëåíèå èãðîêó ìåä.êàðòû' ,  text = 'Îôîðìëåíèå ìåä. êàðòû ïëàòíîå è çàâèñèò îò å¸ ñðîêà äåéñòâèÿ!&Ìåä. êàðòà íà 7 äíåé - Ãðàæäàíàì îêðóãà 7 äíåé 70.000 ðóáëåé Íåëåãàëüíûõ îðãàíèçàöèé 7 äíåé 80.000 ðóáëåé&Ñèëîâûõ ñòðóêòóð 7 äíåé - 40.000 ðóáëåé Ãðàæäàíñêèõ ñòðóêòóð 7 äíåé - 60.000 ðóáëåé&Ìåä. êàðòà íà 14 äíåé - Ãðàæäàíàì îêðóãà 14 äíåé - 110.000 ðóáëåé ðóáëåé Íåëåãàëüíûõ îðãàíèçàöèé 14 äíåé - 120.000&ðóáëåé ðóáëåé Ñèëîâûõ ñòðóêòóð 14 äíåé - 90.000 ðóáëåé Ãðàæäàíñêèõ ñòðóêòóð 14 äíåé - 100.000 ðóáëåé.&Ìåä. êàðòà íà 30 äíåé - Ãðàæäàíàì îêðóãà 30 äíåé  180.000 ðóáëåé ðóáëåé Íåëåãàëüíûõ îðãàíèçàöèé 30 äíåé  190.000&ðóáëåé Ñèëîâûõ ñòðóêòóð 30 äíåé  160.000 ðóáëåé ðóáëåé Ãðàæäàíñêèõ ñòðóêòóð 30 äíåé  170.000  ðóáëåé&Ìåä. êàðòà  íà 60 äíåé - Ãðàæäàíàì îêðóãà 60 äíåé - 260.000 ðóáëåé ðóáëåé Íåëåãàëüíûõ îðãàíèçàöèé 60 äíåé - 270.000&ðóáëåé ðóáëåé Ñèëîâûõ ñòðóêòóð 60 äíåé - 240.000 ðóáëåé Ãðàæäàíñêèõ ñòðóêòóð 60 äíåé - 250.000 ðóáëåé.&Ñêàæèòå, âàì íà êàêîé ñðîê îôîðìèòü ìåä. êàðòó?&{pause}&Õîðîøî, òîãäà ïðèñòóïèì ê îôîðìëåíèþ.&/me äîñòà¸ò èç ñâîåãî ìåä.êåéñà ïóñòóþ ìåä.êàðòó, ðó÷êó è ïå÷àòü {fraction_tag}&/me îòêðûâàåò ïóñòóþ ìåä.êàðòó è íà÷èíàåò å¸ çàïîëíÿòü, çàòåì ñòàâèò ïå÷àòü {fraction_tag}&/me ïîëíîñòüþ çàïîëíèâ ìåä.êàðòó óáèðàåò ðó÷êó è ïå÷àòü îáðàòíî â ñâîé ìåä.êåéñ&/todo Âîò âàøà ìåä.êàðòà, áåðèòå*ïðîòÿãèâàÿ çàïîëíåííóþ ìåä.êàðòó ÷åëîâåêó íàïðîòèâ ñåáÿ&/medcard {arg_id}' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'recept' , description = 'Âûäà÷à èãðîêó ðåöåïòîâ' ,  text = 'Ñòîèìîñòü îäíîãî ðåöåïòà ñîñòàâëÿåò Ãðàæäàíàì îêðóãà? 3.000 ðóáëåé ?Ïðåäñòàâèòåëè Íåëåãàëüíûõ îðãàíèçàöèé? 5.000 ðóáëåé ?Ïðåäñòàâèòåëè Ñèëîâûõ ñòðóêòóð? 10.000 ðóáëåé ?Ïðåäñòàâèòåëè Ãðàæäàíñêèõ ñòðóêòóð? 7.000 ðóáëåé&Ñêàæèòå ñêîëüêî Âàì òðåáóåòñÿ ðåöåïòîâ, ïîñëå ÷åãî ìû ïðîäîëæèì.&/n Âíèìàíèå! Â òå÷åíèè ÷àñà âûäà¸òñÿ ìàêñèìóì 5 ðåöåïòîâ!&{show_recept_menu}&Õîðîøî, ñåé÷àñ ÿ âûäàì âàì ðåöåïòû.&/me äîñòà¸ò èç ñâîåãî ìåä.êåéñà áëàíê äëÿ îôîðìëåíèÿ ðåöåïòîâ è íà÷àåò åãî çàïîëíÿòü&/me ñòàâèò íà áëàíê ðåöåïòà ïå÷àòü {fraction_tag}&/do Áëàíê óñïåøíî çàïîëíåí.&/todo Âîò, äåðæèòå!*ïåðåäàâàÿ áëàíê  ðåöåïòà ÷åëîâåêó íàïðîòèâ&/recept {arg_id} {get_recepts}' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'osm' , description = 'Ïîëíûé ìåä.îñìîòð èãðîêà (ÐÏ)' ,  text = 'Õîðîøî, ñåé÷àñ ÿ ïðîâåäó âàì ìåä.îñìîòð.&Äàéòå ìíå âàøó ìåä.êàðòó äëÿ ïðîâåðêè.&/n @{get_nick({arg_id})}, ââåäèòå /showmc {my_id} ÷òîáû ïîêàçàòü ìíå ìåä.êàðòó.&{pause}&/me äîñòà¸ò èç ìåä.êåéñà ñòåðèëüíûå ïåð÷àòêè è íàäåâàåò èõ íà ðóêè&/do Ïåð÷àòêè íà ðóêàõ.&/todo Íà÷í¸ì ìåä.îñìîòð*óëûáàÿñü.&Ñåé÷àñ ÿ ïðîâåðþ âàøå ãîðëî, îòêðîéòå ðîò è âûñóíèòå ÿçûê.&/n Èñïîëüçóéòå /me îòêðûë(-à) ðîò ÷òîá ìû ïðîäîëæèëè&{pause}&/me äîñòà¸ò èç ìåä.êåéñà ôîíàðèê è âêëþ÷èâ åãî îñìàòðèâàåò ãîðëî ÷åëîâåêà íàïðîòèâ&Õîðîøî, ìîæåòå çàêðûâàòü ðîò, ñåé÷àñ ÿ ïðîâåðþ âàøè ãëàçà.&/me ïðîâåðÿåò ðåàêöèþ ÷åëîâåêà íà ñâåò, ïîñâåòèâ ôîíàðèê â ãëàçà&/do Çðà÷êè ãëàç îáñëåäóåìîãî ÷åëîâåêà ñóçèëèñü.&/todo Îòëè÷íî*âûêëþ÷àÿ ôîíàðèê è óáèðàÿ åãî â ìåä.êåéñ&Òàêñ, ñåé÷àñ ÿ ïðîâåðþ âàøå ñåðäöåáèåíèå, ïîýòîìó ïðèïîäíèìèòå âåðõíóþ îäåæäó!&/n @{get_nick({arg_id})}, ââåäèòå /showtatu ÷òîáû ñíÿòü îäåæäó ïî ÐÏ&{pause}&/me äîñòà¸ò èç ìåä.êåéñà ñòåòîñêîï è ïðèëîæèâ åãî ê ãðóäè ÷åëîâåêà ïðîâåðÿåò ñåðäöåáèåíèå&/do Ñåðäöåáèåíèå â ðàéîíå 65 óäàðîâ â ìèíóòó.&/todo Ñ ñåðäöåáèåíèåì ó âàñ âñå â ïîðÿäêå*óáèðàÿ ñòåòîñêîï îáðàòíî â ìåä.êåéñ&/me ñíèìàåò ñî ñâîèõ ðóê èñïîëüçîâàííûå ïåð÷àòêè è âûáðàñûâàåò èõ&Íó ÷òî-æ ÿ ìîãó âàì ñêàçàòü...&Ñî çäîðîâüåì ó âàñ âñå â ïîðÿäêå, âû ñâîáîäíû!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"} , 
					{cmd = 'gd' , description = 'Ýêñòðåííûé âûçîâ (/godeath)' ,  text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me ïðîñìàòðèâàåò èíôîðìàöèþ è âêëþ÷àåò íàâèãàòîð ê âûáðàííîìó ìåñòó ýêñòðåííîãî âûçîâà&/godeath {arg_id}' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'exp' , description = 'Âûãíàòü èãðîêà èç áîëüíèöû' ,  text = 'Âû áîëüøå íå ìîæåòå çäåñü íàõîäèòüñÿ, ÿ âûãîíÿþ âàñ èç áîëüíèöû!&/me ñõâàòèâ ÷åëîâåêà âåä¸ò ê âûõîäó èç áîëüíèöû è çàêðûâàåò çà íèì äâåðü&/expel {arg_id} Í.Ï.Á.' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
				},
				smi = {
					{cmd = 'zd', description = 'Ïðèâåñòâèå èãðîêà' , text = 'Çäðàâñòâóéòå {get_ru_nick({arg_id})}&ß {my_ru_nick} - {fraction_rank} {fraction_tag}&×åì ÿ ìîãó Âàì ïîìî÷ü?', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},	
					{cmd = 'fr', description = 'Ýôèð î ïîãîäå' , text = '/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « Ðàäèîñòàíöèè ã.Àðçàìàñà » :::...&/news Çäðàâñòâóéòå, äîðîãèå ðàäèîñëóøàòåëè&/news Ñ âàìè ÿ Êîððåñïîíäåíò ðàäèîñòàíöèè ã.Àðçàìàñà, {my_ru_nick}&/news È ñåãîäíÿ ó íàñ ýôèð î Ïîãîäå', arg = '' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},
					{cmd = 'offr', description = 'Êîíåö ýôèðà î ïîãîäå' , text = '/news À íà ýòîì ïðîãíîç ïîãîäû îêîí÷åí&/news Ñïàñèáî, ÷òî áûëè ñ íàìè&/news ...::: Ìóçûêàëüíàÿ çàñòàâêà « Ðàäèîñòàíöèè ã.Àðçàìàñà » :::...', arg = '' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},
					{cmd = 'vik', description = 'Íà÷àëî âèêòîðèíû' , text = '/news °°°° Ìóçûêàëüíàÿ çàñòàâêà « Ðàäèîñòàíöèè ã.Àðçàìàñà » °°°°&/news Çäðàâñòâóéòå, äîðîãèå ðàäèîñëóøàòåëè&/news Ñ âàìè ÿ Êîððåñïîíäåíò ðàäèîñòàíöèè ã.Àðçàìàñà, {my_ru_nick}&/news È ñåãîäíÿ ó íàñ âèêòîðèíà Ñòîëèöû&/news ß çàãàäûâàþ ñòîëèöû.&/news Íàïðèìåð: Ïåêèí, à Âû äîëæíû ñêàçàòü êàêîé ñòðàíû ýòà ñòîëèöà...&/news Êàæäàÿ óãàäàííàÿ ñòðàíà - 1 áàëë íà ñ÷åò îòâåòèâøåãî.&/news À èãðàåì ìû äî 3-åõ áàëëîâ.&/news Íî äëÿ íà÷àëà íàì íóæíû ñïîíñîðû.', arg = '' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},
					{cmd = 'offvik', description = 'Êîíåö âèêòîðèíû' , text = '/news Ó íàñ åñòü ïîáåäèòåëü, ïîçäðàâèì åãî.&/news ×òîáû çàáðàòü ïðèç - ïîçâîíèòå ìíå èëè îòîøëèòå ÑÌÑ íà (òóò áåç ñêîáîê ñâîé íîìåð òåëåôîíà)&/news À íà ýòîì ÿ çàêàí÷èâàþ âèêòîðèíó.&/news Ñïàñèáî, ÷òî áûëè ñ íàìè.&/news °°°° Ìóçûêàëüíàÿ çàñòàâêà « Ðàäèîñòàíöèè ã.Àðçàìàñà » °°°°', arg = '' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},			
				},
				fd = {
					{cmd = 'siren' , description = 'Âêë/âûêë ìèãàëîê â ò/ñ' , text = '{switchCarSiren}', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'zd' , description = 'Ïðèâåñòâèå èãðîêà' , text = 'Çäðàâñòâóéòå {get_ru_nick({arg_id})}&ß {my_ru_nick} - {fraction_rank} {fraction_tag}&×åì ÿ ìîãó Âàì ïîìî÷ü?', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},
				},
				lc = {
					{cmd = 'zd' , description = 'Ïðèâåñòâèå èãðîêà' , text = 'Çäðàâñòâóéòå, ÿ ÿâëÿþñü ñîòðóäíèêîì {fraction} {fraction_rank}&×åì ìîãó âàì ïîìî÷ü? Åñëè íóæíà ëèöåíçèÿ - ñêàæèòå òèï è ñðîê', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'gl' , description = 'Âûäà÷à ëèöåíçèè èãðîêó' , text = 'Ïðåäüÿâèòå ïàñïîðò.&{pause}&Õîðîøî, ñåé÷àñ îæèäàéòå ìèíóòó ïðèãîòîâëþ äîãîâîð î âûäà÷å.&/me Äîñòàë ãîòîâûé äîãîâîð è ïîñòàâèë åãî íà ñòîë.&/do Äîãîâîð íà ñòîëå.&/me Äîñòàë è îòäàë ðó÷êó ëåãêèì äâèæåíèåì ðóêè.&Ðàñïèøèòåñü âîò çäåñü&/b Ïî ÐÏ&/b /me Ðàñïèñàëñÿ&{pause}&/givelicense {arg_id}', arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'medka' , description = 'Çàïðîñèòü ìåäêàðòó äëÿ ïðîâåðêè' , text = '×òîáû ïîëó÷èòü ýòó ëèöåíçèþ, ïîêàæèòå ìíå âàøó ìåä.êàðòó&/n @{get_nick({arg_id})}, ââåäèòå êîìàíäó /showmc {my_id} ÷òîáû ïîêàçàòü ìíå ìåäêàðòó&{pause}&/me áåðåò îò ÷åëîâåêà íàïðîòèâ ìåäêàðòó è îñìàòðèâàåò å¸&/todo Õîðîøî, çàáèðàéòå*îòäàâàÿ ìåäêàðòó îáðàòíî âëàäåëüöó' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'gr' , description = 'Âûäà÷à ëèöåíçèè íà îðóæèå' , text = '/medka {arg_id}&Õîðîøî, ñåé÷àñ îæèäàéòå ìèíóòó ïðèãîòîâëþ äîãîâîð î âûäà÷å.&/me Äîñòàë ãîòîâûé äîãîâîð è ïîñòàâèë åãî íà ñòîë.&/do Äîãîâîð íà ñòîëå.&/me Äîñòàë è îòäàë ðó÷êó ëåãêèì äâèæåíèåì ðóêè.&Ðàñïèøèòåñü âîò çäåñü&/b Ïî ÐÏ&{pause}&/givelicense {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true}
				},
				ins = {
					{cmd = 'zd' , description = 'Ïðèâåñòâèå èãðîêà' , text = 'Çäðàâñòâóéòå, ÿ {my_ru_nick} - {fraction_rank} {fraction_tag}&×åì ÿ ìîãó Âàì ïîìî÷ü? Åñëè íóæíà ëèöåíçèÿ - ñêàæèòå òèï è ñðîê', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'go', description = 'Ïîçâàòü èãðîêà çà ñîáîé', text = 'Õîðîøî {get_ru_nick({arg_id})}, ñëåäóéòå çà ìíîé.', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
				},
				gov = {		
					{cmd = 'zd' , description = 'Ïðèâåñòâèå èãðîêà' , text = 'Çäðàâñòâóéòå, ìåíÿ çîâóò {my_ru_nick}, ÷åì ÿ ìîãó ïîìî÷ü?', arg = '{arg_id}' , enable = true , waiting = '2.5', in_fastmenu = true},
					{cmd = 'go' , description = 'Ïîçâàòü èãðîêà çà ñîáîé' , text = 'Õîðîøî {get_ru_nick({arg_id})}, ñëåäóéòå çà ìíîé.', arg = '{arg_id}' , enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'freely' , description = 'Ïðåäëîæèòü óñëóãè àäâîêàòà' ,  text = '/do Ïàïêà ñ äîêóìåíòàìè íàõîäèòñÿ â ëåâîé ðóêå.&/me îòêðûâ ïàïêó, âûòàùèë{sex} èç íå¸ áëàíê äëÿ îñâîáîæäåíèÿ çàêëþ÷¸ííîãî&/me äîñòàâ èç êàðìàíà ðó÷êó, çàïîëíèë{sex} äîêóìåíò è ïåðåäàë{sex} ÷åëîâåêó íàïðîòèâ&/todo Âïèøèòå ñþäà ñâîè äàííûå è ïîñòàâüòå ïîäïèñü ñíèçó*ïåðåäàâàÿ ëèñò ñ ðó÷êîé&/free {arg_id} {arg2}' , arg = '{arg_id} {arg2}' , enable = true, waiting = '2.5'},
					{cmd = 'wed' , description = 'Áðàã' , text = 'Äîðîãèå íîâîáðà÷íûå è óâàæàåìûå ãîñòè!&Ñåãîäíÿ  ñàìûé ñâåòëûé è ðàäîñòíûé äåíü â âàøåé æèçíè!&Ñîçäàíèå ñåìüè  ýòî íà÷àëî ïðåêðàñíîãî ïóòè äâóõ ëþáÿùèõ ñåðäåö.&Îòíûíå âû áóäåòå èäòè ðóêà îá ðóêó, äåëÿ ðàäîñòè è ïå÷àëè.&Âñòóïàÿ â áðàê, âû áåð¸òå íà ñåáÿ ñâÿùåííûé äîëã äðóã ïåðåä äðóãîì è ïåðåä áóäóùèì ïîêîëåíèåì.&Ïðîøó âàñ ïîäòâåðäèòü âàøå èñêðåííåå æåëàíèå âñòóïèòü â áðàê â ïðèñóòñòâèè ñâèäåòåëåé.&{pause}&Ñ âàøåãî îáîþäíîãî ñîãëàñèÿ âàø áðàê ðåãèñòðèðóåòñÿ!&Ïðîøó îáìåíÿòüñÿ îáðó÷àëüíûìè êîëüöàìè â çíàê âå÷íîé ëþáâè è âåðíîñòè.&/wedding {arg_id} {arg2}' , arg = '{arg_id} {arg2}' , enable = true, waiting = '2.5'},
					{cmd = 'frisk', description = 'Îáûñê (7+)', text = '/do Â êàðìàíå íàõîäÿòñÿ ñïåöèàëüíûå ëàòåêñíûå ïåð÷àòêè&/me äîñòàë ïåð÷àòêè è òùàòåëüíî íàäåë èõ&/do Ïåð÷àòêè íàäåòû ñîãëàñíî ïðîòîêîëó&/me ïðîâ¸ë òùàòåëüíûé îñìîòð, ñëåäóÿ ïðîòîêîëüíîé ïðîöåäóðå&/frisk {arg_id}&/me àêêóðàòíî ñíÿë ïåð÷àòêè è óáðàë èõ â ñïåöèàëüíûé êîíòåéíåð', arg = '{arg_id}', enable = false, waiting = '2.5' },
					{cmd = 'exp' , description = 'Âûãíàòü èãðîêà èç ïðàâèòåëüñòâà' ,  text = 'Ê ñîæàëåíèþ, âûíóæäåí ïîïðîñèòü âàñ ïîêèíóòü çäàíèå â ñâÿçè ñ íàðóøåíèåì ðåãëàìåíòà.&/me âåæëèâî, íî òâ¸ðäî âçÿë çà ëîêîòü&/me ñîïðîâîäèë ê âûõîäó&/me îòêðûë äâåðü è ïîìîã âûéòè íà óëèöó&/expel {arg_id} Íàðóøåíèå ïðàâèë ïîâåäåíèÿ â ãîñóäàðñòâåííîì ó÷ðåæäåíèè' , arg = '{arg_id}' , enable = true , waiting = '2.5', in_fastmenu = true},
					{cmd = 'pas' , description = 'Ïîêàç äîêóìåíòîâ' ,  text = '/do Â íàãðóäíîì êàðìàíå íàõîäÿòñÿ ñëóæåáíûå äîêóìåíòû&/me äîñòàë äîêóìåíòû, àêêóðàòíî ðàñêðûë èõ&/me ïåðåäàë äîêóìåíòû äëÿ îçíàêîìëåíèÿ&/do Ñîáåñåäíèê èçó÷àåò äîêóìåíòû&/pass {arg_id}' , arg = '{arg_id}' , enable = true , waiting = '2.5', in_fastmenu = true},
					
				},
				mafia = {
					{cmd = 'tie', description = 'Ñâÿçàòü æåðòâó', text = '/do Â êàðìàíå áðîíåæèëåòà ëåæèò øïàãàò.&/me ëåãêèì äâèæåíèåì ðóêè äîñòàë{sex} èç êàðìàíà øïàãàò&/me îáâÿçûâàåò ðóêè æåðòâû âåðåâêîé è ñòÿãèâàåò å¸&/tie {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'untie', description = 'Ðàçâÿçàòü æåðòâó', text = '/do Íà ïðàâîì áåäðå çàêðåïëåíî òàêòè÷åñêîå êðåïëåíèå äëÿ íîæà.&/me äâèæåíèåì ïðàâîé ðóêè îòêðåïèâ íîæ, áåð¸ò åãî â ðóêè&/do Â ïðàâîé ðóêå äåðæèò íîæ.&/me ïîäîéäÿ ê æåðòâå ñî ñïèíû, îòðåçàë{sex} âåð¸âêó&/untie {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'lead', description = 'Âåñòè æåðòâó çà ñîáîé', text = '/me äâèæåíèåì ðóêè ñõâàòèâ çà øêèðêó æåðòâû, âåä¸ò åãî çà ñîáîé&/lead {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'unlead', description = 'Ïðåêðàòèòü âåñòè æåðòâó', text = '/me ðàññëàáèâ ñõâàòêó, ïåðåñòà¸ò êîíòðîëèðîâàòü æåðòâó&/unlead {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'gag', description = 'Çàòêíóòü ðîò æåðòâå òðÿïêîé', text = '/do Íà ïîÿñå çàêðåïëåíà ñóìêà.&/me ïðàâîé ðóêîé îòñòåãíóâ ìîëíèþ, îòêðûâàåò ñóìêó&/do Âíóòðè ñóìêè ëåæèò òðÿïêà.&/me ïîäõîäÿ ê æåðòâå, ïîïóòíî äîñòàë{sex} èç ñóìêè òðÿïêó&/do Òðÿïêà â ðóêàõ â ðàçâ¸ðíóòîì âèäå.&/me îáåèìè ðóêàìè çàâåðíóâ òðÿïêó, çàïèõíóë{sex} â ðîò æåðòâû&/gag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}', in_fastmenu = true},
					{cmd = 'ungag', description = 'Âûòàùèòü òðÿïêó èçî ðòà æåðòâû', text = '/me ïîäîéäÿ áëèæå ê æåðòâå, äâèæåíèåì ïðàâîé ðóêè ïîòÿíóë{sex} çà òðÿïêó è çàáðàë{sex} ñåáå&/ungag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'bag', description = 'Íàäåòü ïàêåò íà ãîëîâó æåðòâû', text = '/do Â êàðìàíå êóðòêè ëåæèò ìóñîðíûé ïàêåò.&/me äîñòàë{sex} ìóñîðíûé ïàêåò èç êàðìàíà, ðàçâåðíóë{sex} åãî&/me íàäåâàåò ìóñîðíûé ïàêåò íà ãîëîâó æåðòâû, íå çàòÿãèâàÿ åãî&/bag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'unbag', description = 'Ñíÿòü ïàêåò ñ ãîëîâû æåðòâû', text = '/me ëåãêèì äâèæåíèåì ðóêè ñõâàòèâ çà ïàêåò, ïîòÿíóë{sex} åãî ââåðõ, òåì ñàìûì ñòÿíóâ ïàêåò ñ ãîëîâû æåðòâû&/unbag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}', in_fastmenu = true},
					{cmd = 'inñar', description = 'Çàòîëêàòü æåðòâó â ôóðãîí', text = '/me îòêðûâàåò äâåðè ôóðãîíà&/me áåðåò æåðòâó ïîä ðóêè è çàòàëêèâàåò âïåð¸ä ãîëîâîé â ôóðãîí&/me çàêðûâàåò äâåðè è ñàäèòñÿ â ôóðãîí&/incar {arg_id} 3', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}', in_fastmenu = true},
				},
				ghetto = {}
			},
			commands_manage = {
				my = {},
				goss = {
					{cmd = 'inv' , description = 'Ïðèíÿòèå èãðîêà â îðãàíèçàöèþ' , text = '/do Â êàðìàíå åñòü ñâÿçêà ñ êëþ÷àìè îò ðàçäåâàëêè.&/me äîñòà¸ò èç êàðìàíà îäèí êëþ÷ èç ñâÿçêè êëþ÷åé îò ðàçäåâàëêè&/todo Âîçüìèòå, ýòî êëþ÷ îò íàøåé ðàçäåâàëêè*ïåðåäàâàÿ êëþ÷ ÷åëîâåêó íàïðîòèâ&/invite {arg_id}&/r Ïî ïðèâåòñòâóåì íîâîãî ñîòðóäíèêà {get_rp_nick({arg_id})}' , arg = '{arg_id}', enable = true, waiting = '2.5'  , bind = "{}", in_fastmenu = true  },
					{cmd = 'gr' , description = 'Ïîâûøåíèå/ïîíèæåíèå cîòðóäíèêà' , text = '{show_rank_menu}&/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/giverank {arg_id} {get_rank}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ïîëó÷èë íîâóþ äîëæíîñòü!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },	
					{cmd = 'fmutes' , description = 'Âûäàòü ìóò ñîòðóäíèêó (10 min)' , text = '/fmutes {arg_id} Í.Ó.&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ëèøèëñÿ ïðàâà èñïîëüçîâàòü ðàöèþ íà 10 ìèíóò!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'funmute' , description = 'Ñíÿòü ìóò ñîòðóäíèêó' , text = '/funmute {arg_id}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} òåïåðü ìîæåò ïîëüçîâàòüñÿ ðàöèåé!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },
					{cmd = 'vig' , description = 'Âûäà÷à âûãîâîðà cîòðóäíèêó' , text = '/do ÊÏÊ â ðóêå.&/do Áàçà äàííûõ {fraction_tag} îòêðûòà.&/me Èçìåíèë èíôîðìàöèþ î ñîòðóäíèêå.&/fwarn {arg_id} {arg2}&/r Ñîòðóäíèêó {fraction_tag} {get_rp_nick({arg_id})} áûë âûäàí âûãîâîð çà:{arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'unvig' , description = 'Ñíÿòèå âûãîâîðà cîòðóäíèêó' , text = '/do ÊÏÊ â ðóêå.&/do Áàçà äàííûõ {fraction_tag} îòêðûòà.&/me Èçìåíèë èíôîðìàöèþ î ñîòðóäíèêå.&/fwarn {arg_id} {arg2}&/r Ñîòðóäíèêó {fraction_tag} {get_rp_nick({arg_id})} áûë ñíÿò âûãîâîð!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}" , in_fastmenu = true  },
					{cmd = 'unv' , description = 'Óâîëüíåíèå èãðîêà èç ôðàêöèè' , text = '/do ÊÏÊ â ðóêå.&/me Â áàçå äàííûõ {fraction_tag} áûëà óáðàíà èíôîðìàöèÿ î ñîòðóäíèêå.&/uninvite {arg_id} {arg2}&/r Ñîòðóäíèê {get_rp_nick({arg_id})} áûë óâîëåí, ïðè÷èíà:{arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'point' , description = 'Óñòàîâèòü ìåòêó äëÿ ñîòðóäíèêîâ' , text = '/r Ñðî÷íî âûäâèãàéòåñü êî ìíå, îòïðàâëÿþ âàì êîîðäèíàòû...&/point' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'govka' , description = 'Ñîáåñåäîâàíèå ïî ãîññ.âîëíå' , text = '/d [{fraction_tag}] - [Âñåì]: Çàíèìàþ ãîñóäàðñòâåííóþ âîëíó, ïðîñüáà íå ïåðåáèâàòü!&/gov [{fraction_tag}]: Äîáðîãî âðåìåíè ñóòîê, óâàæàåìûå æèòåëè íàøåãî øòàòà!&/gov [{fraction_tag}]: Ñåé÷àñ ïðîõîäèò ñîáåñåäîâàíèå â îðãàíèçàöèþ {fraction}}&/gov [{fraction_tag}]: Äëÿ âñòóïëåíèÿ âàì íóæíî èìåòü äîêóìåíòû è ïðèåõàòü ê íàì â õîëë.&/d [{fraction_tag}] - [Âñåì]: Îñâîáîæäàþ  ãîñóäàðñòâåííóþ âîëíó, ñïàñèáî ÷òî íå ïåðåáèâàëè.' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
				},
				police_gov = {
					{cmd = 'inv' , description = 'Ïðèíÿòèå èãðîêà â îðãàíèçàöèþ' , text = '/do Â êàðìàíå åñòü ñâÿçêà ñ êëþ÷àìè îò ðàçäåâàëêè.&/me äîñòà¸ò èç êàðìàíà îäèí êëþ÷ èç ñâÿçêè êëþ÷åé îò ðàçäåâàëêè&/todo Âîçüìèòå, ýòî êëþ÷ îò íàøåé ðàçäåâàëêè*ïåðåäàâàÿ êëþ÷ ÷åëîâåêó íàïðîòèâ&/invite {arg_id}&/n @{get_nick({arg_id})} , ïðèìèòå ïðåäëîæåíèå ÷òîáû ïîëó÷èòü èíâàéò!' , arg = '{arg_id}', enable = true, waiting = '2.5'  , bind = "{}", in_fastmenu = true  },
					{cmd = 'gr' , description = 'Ïîâûøåíèå/ïîíèæåíèå cîòðóäíèêà' , text = '{show_rank_menu}&/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/giverank {arg_id} {get_rank}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ïîëó÷èë íîâóþ äîëæíîñòü!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },	
					{cmd = 'fmutes' , description = 'Âûäàòü ìóò ñîòðóäíèêó (10 min)' , text = '/fmutes {arg_id} Í.Ó.&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ëèøèëñÿ ïðàâà èñïîëüçîâàòü ðàöèþ íà 10 ìèíóò!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'funmute' , description = 'Ñíÿòü ìóò ñîòðóäíèêó' , text = '/funmute {arg_id}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} òåïåðü ìîæåò ïîëüçîâàòüñÿ ðàöèåé!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },
					{cmd = 'vig' , description = 'Âûäà÷à âûãîâîðà cîòðóäíèêó' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/fwarn {arg_id} {arg2}&/r Ñîòðóäíèêó {get_ru_nick({arg_id})} âûäàí âûãîâîð! Ïðè÷èíà: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'unvig' , description = 'Ñíÿòèå âûãîâîðà cîòðóäíèêó' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/unfwarn {arg_id}&/r Ñîòðóäíèêó {get_ru_nick({arg_id})} áûë ñíÿò âûãîâîð!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}" , in_fastmenu = true  },
					{cmd = 'unv' , description = 'Óâîëüíåíèå èãðîêà èç ôðàêöèè' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò ñâîé òåëåôîí îáðàòíî â êàðìàí&/uninvite {arg_id} {arg2}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} áûë óâîëåí ïî ïðè÷èíå: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'point' , description = 'Óñòàîâèòü ìåòêó äëÿ ñîòðóäíèêîâ' , text = '/r Ñðî÷íî âûäâèãàéòåñü êî ìíå, îòïðàâëÿþ âàì êîîðäèíàòû...&/point' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'govka' , description = 'Ñîáåñåäîâàíèå ïî ãîññ.âîëíå' , text = '/d [{fraction_tag}] - [Âñåì] Çàíèìàþ ãîñ. âîëíó.&/gov [{fraction_tag}] Íà äàííûé ìîìåíò ïðîéäåò ñîáåñåäîâàíèå â {fraction}&/gov [{fraction_tag}] Ïðè ñåáå èìåòü: 3 ëåòíþþ ïðîïèñêó, ìåä.êàðòó, ëèöåíçèè è âîåííûé áèëåò&/gov [{fraction_tag}] Âñåõ æåëàþùèõ æäåì â Õîëëå Ïîëèöèè Àðçàìàñà.&/d [{fraction_tag}] - [Âñåì] Îñâîáîæäàþ ãîñ. âîëíó.' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
				},			
				hospital_gov = {
					{cmd = 'inv' , description = 'Ïðèíÿòèå èãðîêà â îðãàíèçàöèþ' , text = '/do Â êàðìàíå åñòü ñâÿçêà ñ êëþ÷àìè îò ðàçäåâàëêè.&/me äîñòà¸ò èç êàðìàíà îäèí êëþ÷ èç ñâÿçêè êëþ÷åé îò ðàçäåâàëêè&/todo Âîçüìèòå, ýòî êëþ÷ îò íàøåé ðàçäåâàëêè*ïåðåäàâàÿ êëþ÷ ÷åëîâåêó íàïðîòèâ&/invite {arg_id}&/n @{get_nick({arg_id})} , ïðèìèòå ïðåäëîæåíèå ÷òîáû ïîëó÷èòü èíâàéò!' , arg = '{arg_id}', enable = true, waiting = '2.5'  , bind = "{}", in_fastmenu = true  },
					{cmd = 'gr' , description = 'Ïîâûøåíèå/ïîíèæåíèå cîòðóäíèêà' , text = '{show_rank_menu}&/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/giverank {arg_id} {get_rank}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ïîëó÷èë íîâóþ äîëæíîñòü!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },	
					{cmd = 'fmutes' , description = 'Âûäàòü ìóò ñîòðóäíèêó (10 min)' , text = '/fmutes {arg_id} Í.Ó.&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ëèøèëñÿ ïðàâà èñïîëüçîâàòü ðàöèþ íà 10 ìèíóò!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'funmute' , description = 'Ñíÿòü ìóò ñîòðóäíèêó' , text = '/funmute {arg_id}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} òåïåðü ìîæåò ïîëüçîâàòüñÿ ðàöèåé!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },
					{cmd = 'vig' , description = 'Âûäà÷à âûãîâîðà cîòðóäíèêó' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/fwarn {arg_id} {arg2}&/r Ñîòðóäíèêó {get_ru_nick({arg_id})} âûäàí âûãîâîð! Ïðè÷èíà: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'unvig' , description = 'Ñíÿòèå âûãîâîðà cîòðóäíèêó' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/unfwarn {arg_id}&/r Ñîòðóäíèêó {get_ru_nick({arg_id})} áûë ñíÿò âûãîâîð!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}" , in_fastmenu = true  },
					{cmd = 'unv' , description = 'Óâîëüíåíèå èãðîêà èç ôðàêöèè' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò ñâîé òåëåôîí îáðàòíî â êàðìàí&/uninvite {arg_id} {arg2}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} áûë óâîëåí ïî ïðè÷èíå: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'point' , description = 'Óñòàîâèòü ìåòêó äëÿ ñîòðóäíèêîâ' , text = '/r Ñðî÷íî âûäâèãàéòåñü êî ìíå, îòïðàâëÿþ âàì êîîðäèíàòû...&/point' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'govka' , description = 'Ñîáåñåäîâàíèå ïî ãîññ.âîëíå' , text = '/d [{fraction_tag}] - [Âñå] Çàíèìàþ Ãîñóäàðñòâåííóþ âîëíó âåùàíèÿ.&/gov [{fraction_tag}] Óâàæàåìûå æèòåëè Âîñòî÷íîãî Îêðóãà, ìèíóòî÷êó âíèìàíèÿ.&/gov [{fraction_tag}] Ñîîáùàþ âàì, ÷òî ïðîõîäèò ñîáåñåäîâàíèå â {fraction_tag}!&/gov [{fraction_tag}] Ïðîñüáà ïðèáûòü â Õîëë Áîëüíèöû.&/d [{fraction_tag}] - [Âñå] Îñâîáîæäàþ Ãîñóäàðñòâåííóþ âîëíó âåùàíèÿ.' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
				},		
				smi_gov = {
					{cmd = 'inv' , description = 'Ïðèíÿòèå èãðîêà â îðãàíèçàöèþ' , text = '/do Â êàðìàíå åñòü ñâÿçêà ñ êëþ÷àìè îò ðàçäåâàëêè.&/me äîñòà¸ò èç êàðìàíà îäèí êëþ÷ èç ñâÿçêè êëþ÷åé îò ðàçäåâàëêè&/todo Âîçüìèòå, ýòî êëþ÷ îò íàøåé ðàçäåâàëêè*ïåðåäàâàÿ êëþ÷ ÷åëîâåêó íàïðîòèâ&/invite {arg_id}&/n @{get_nick({arg_id})} , ïðèìèòå ïðåäëîæåíèå ÷òîáû ïîëó÷èòü èíâàéò!' , arg = '{arg_id}', enable = true, waiting = '2.5'  , bind = "{}", in_fastmenu = true  },
					{cmd = 'gr' , description = 'Ïîâûøåíèå/ïîíèæåíèå cîòðóäíèêà' , text = '{show_rank_menu}&/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/giverank {arg_id} {get_rank}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ïîëó÷èë íîâóþ äîëæíîñòü!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },	
					{cmd = 'fmutes' , description = 'Âûäàòü ìóò ñîòðóäíèêó (10 min)' , text = '/fmutes {arg_id} Í.Ó.&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ëèøèëñÿ ïðàâà èñïîëüçîâàòü ðàöèþ íà 10 ìèíóò!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'funmute' , description = 'Ñíÿòü ìóò ñîòðóäíèêó' , text = '/funmute {arg_id}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} òåïåðü ìîæåò ïîëüçîâàòüñÿ ðàöèåé!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },
					{cmd = 'vig' , description = 'Âûäà÷à âûãîâîðà cîòðóäíèêó' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/fwarn {arg_id} {arg2}&/r Ñîòðóäíèêó {get_ru_nick({arg_id})} âûäàí âûãîâîð! Ïðè÷èíà: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'unvig' , description = 'Ñíÿòèå âûãîâîðà cîòðóäíèêó' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/unfwarn {arg_id}&/r Ñîòðóäíèêó {get_ru_nick({arg_id})} áûë ñíÿò âûãîâîð!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}" , in_fastmenu = true  },
					{cmd = 'unv' , description = 'Óâîëüíåíèå èãðîêà èç ôðàêöèè' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò ñâîé òåëåôîí îáðàòíî â êàðìàí&/uninvite {arg_id} {arg2}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} áûë óâîëåí ïî ïðè÷èíå: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'point' , description = 'Óñòàîâèòü ìåòêó äëÿ ñîòðóäíèêîâ' , text = '/r Ñðî÷íî âûäâèãàéòåñü êî ìíå, îòïðàâëÿþ âàì êîîðäèíàòû...&/point' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'govka' , description = 'Ñîáåñåäîâàíèå ïî ãîññ.âîëíå' , text = '/d [ÃÒÐÊ] - [Âñåì] Çàíèìàþ Ãîñóäàðñòâåííóþ âîëíó âåùàíèÿ.&/gov [ÃÒÐÊ] Óâàæàåìûå æèòåëè Âîñòî÷íîãî Îêðóãà, ìèíóòî÷êó âíèìàíèÿ.&/gov [ÃÒÐÊ] Ñîîáùàþ âàì, ÷òî ïðîõîäèò ñîáåñåäîâàíèå â Ðàäèîñòàíöèþ ã.Àðçàìàñ!&/gov [ÃÒÐÊ] Æäåì âñåõ!&/d [ÃÒÐÊ] - [Âñåì] Îñâîáîæäàþ Ãîñóäàðñòâåííóþ âîëíó âåùàíèÿ.' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
				},					
				goss_fcb = {
					{cmd = 'demoute' , description = 'Óâîëèòü ãîññëóæàùåãî' ,  text = '/do ÊÏÊ íàõîäèòüñÿ íà ïîÿñíîì äåðæàòåëå.&/me áåð¸ò â ðóêè ñâîé ÊÏÊ è âêëþ÷àåò åãî&/me çàõîäèò â áàçó äàííûõ {fraction_tag} è ïåðåõîäèò â ðàçäåë óïðàâëåíèå ñîòðóäíèêàìè äðóãèõ îðãàíèçàöèé&/me îòêðûâàåò äåëî íóæíîãî ñîòðóäíèêà è âíîñèò â íåãî èçìåíåíèÿ&/do Èçìåíåíèÿ óñïåøíî ñîõðàíåíû.&/demoute {arg_id} {arg2}&/me âûõîäèò ñ áàçû äàííûõ {fraction_tag} è âûêëþ÷èâ ÊÏÊ óáèðàåò åãî íà ïîÿñíîé äåðæàòåëü', arg = '{arg_id} {arg2}', enable = false, waiting = '2.5', bind = "{}"},
				},
				goss_prison = {
					{cmd = 'unpunish', description = 'Âûïóñê çàêëþ÷¸ííûõ èç ÒÑÐ', text = '/me ë¸ãêèìè äâèæåíèÿìè ðóê áåð¸ò äåëî çàêëþ÷¸ííîãî ñ ïîëêè, êëàä¸ò åãî íà ñòîë&/do Íà ñòîëå ëåæèò ðó÷êà è ïå÷àòü.&/me ë¸ãêèì äâèæåíèåì ïðàâîé ðóêè áåð¸ò ðó÷êó, çàïîëíÿåò ïîëå â äåëå çàêëþ÷¸ííîãî&/me ë¸ãêèìè äâèæåíèÿìè ðóê êëàä¸ò ðó÷êó íà ñòîë, áåð¸ò ïå÷àòü è ñòàâèò å¸ â äåëå&/me ë¸ãêèìè äâèæåíèÿìè ðóê ñòàâèò ïå÷àòü íà ñòîë, ïîñëå ÷åãî çàêðûâàåò äåëî&Âàø ñðîê óêîðî÷åí, âîçâðàùàéòåñü â êàìåðó è îæèäàéòå ...&... òðàíñïîðòèðîâêè äî áëèæàéøåãî íàñåë¸ííîãî ïóíêòà.&/unpunish {arg_id} {arg2}', arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'},
					{cmd = 'rjailreklama', description = 'Ðåêëàìà ÓÄÎ', text = '/rjail Äîáðîãî âðåìåíè ñóòîê çàêëþ÷åííûå.&/rjail Â äàííûé ìîìåíò Âû ìîæåòå ïîêèíóòü òþðüìó äîñðî÷íî, ÷åðåç êàáèíåò íà÷àëüñòâà òþðüìû.&/rjail Îáðàòèòå âíèìàíèå, ÓÄÎ (óñëîâíî äîðî÷íîå îñâîáîæåíèå) ïëàòíîå!&/rjail Ñïàñèáî çà âíèìàíèå.', arg = '', enable = true, waiting = '2.5'}
				},
				goss_gov = {
					{cmd = 'lic' , description = 'Âûäàòü ëèöåíçèþ àäâîêàòà' , text = '/do Áëàíê äëÿ âûäà÷è ëèöåíçèè íàõîäèòñÿ ïîä ñòîëîì.&/me çàñóíóâ ðóêó ïîä ñòîë, âçÿë{sex} áëàíê, ïîñëå ÷åãî çàïîëíèë{sex} åãî íóæíîé èíôîðìàöèåé&/todo Âïèøèòå ñþäà Âàøè äàííûå è ïîñòàâüòå ïîäïèñü ñíèçó*ïåðåäàâàÿ áëàíê è ðó÷êó&/givelicadvokat {arg_id}' , arg = '{arg_id}', enable = true, waiting = '2.5', },
					{cmd = 'demoute' , description = 'Óâîëèòü ãîññëóæàùåãî' ,  text = '/do ÊÏÊ íàõîäèòüñÿ íà ïîÿñíîì äåðæàòåëå.&/me áåð¸ò â ðóêè ñâîé ÊÏÊ è âêëþ÷àåò åãî&/me çàõîäèò â áàçó äàííûõ {fraction_tag} è ïåðåõîäèò â ðàçäåë óïðàâëåíèå ñîòðóäíèêàìè äðóãèõ îðãàíèçàöèé&/me îòêðûâàåò äåëî íóæíîãî ñîòðóäíèêà è âíîñèò â íåãî èçìåíåíèÿ&/do Èçìåíåíèÿ óñïåøíî ñîõðàíåíû.&/demoute {arg_id} {arg2}&/me âûõîäèò ñ áàçû äàííûõ {fraction_tag} è âûêëþ÷èâ ÊÏÊ óáèðàåò åãî íà ïîÿñíîé äåðæàòåëü', arg = '{arg_id} {arg2}', enable = false, waiting = '2.5', bind = "{}"},
					{cmd = 'inv' , description = 'Ïðèíÿòèå èãðîêà â îðãàíèçàöèþ' , text = '/do Â êàðìàíå åñòü ñâÿçêà ñ êëþ÷àìè îò ðàçäåâàëêè.&/me äîñòà¸ò èç êàðìàíà îäèí êëþ÷ èç ñâÿçêè êëþ÷åé îò ðàçäåâàëêè&/todo Âîçüìèòå, ýòî êëþ÷ îò íàøåé ðàçäåâàëêè*ïåðåäàâàÿ êëþ÷ ÷åëîâåêó íàïðîòèâ&/invite {arg_id}&/n @{get_nick({arg_id})} , ïðèìèòå ïðåäëîæåíèå ÷òîáû ïîëó÷èòü èíâàéò!' , arg = '{arg_id}', enable = true, waiting = '2.5'  , bind = "{}", in_fastmenu = true  },
					{cmd = 'gr' , description = 'Ïîâûøåíèå/ïîíèæåíèå cîòðóäíèêà' , text = '{show_rank_menu}&/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/giverank {arg_id} {get_rank}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ïîëó÷èë íîâóþ äîëæíîñòü!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },	
					{cmd = 'fmutes' , description = 'Âûäàòü ìóò ñîòðóäíèêó (10 min)' , text = '/fmutes {arg_id} Í.Ó.&/r Ñîòðóäíèê {get_ru_nick({arg_id})} ëèøèëñÿ ïðàâà èñïîëüçîâàòü ðàöèþ íà 10 ìèíóò!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'funmute' , description = 'Ñíÿòü ìóò ñîòðóäíèêó' , text = '/funmute {arg_id}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} òåïåðü ìîæåò ïîëüçîâàòüñÿ ðàöèåé!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },
					{cmd = 'vig' , description = 'Âûäà÷à âûãîâîðà cîòðóäíèêó' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/fwarn {arg_id} {arg2}&/r Ñîòðóäíèêó {get_ru_nick({arg_id})} âûäàí âûãîâîð! Ïðè÷èíà: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'unvig' , description = 'Ñíÿòèå âûãîâîðà cîòðóäíèêó' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò òåëåôîí îáðàòíî â êàðìàí&/unfwarn {arg_id}&/r Ñîòðóäíèêó {get_ru_nick({arg_id})} áûë ñíÿò âûãîâîð!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}" , in_fastmenu = true  },
					{cmd = 'unv' , description = 'Óâîëüíåíèå èãðîêà èç ôðàêöèè' , text = '/me äîñòà¸ò èç êàðìàíà ñâîé òåëåôîí è çàõîäèò â áàçó äàííûõ {fraction_tag}&/me èçìåíÿåò èíôîðìàöèþ î ñîòðóäíèêå {get_ru_nick({arg_id})} â áàçå äàííûõ {fraction_tag}&/me âûõîäèò ñ áàçû äàííûõ è óáèðàåò ñâîé òåëåôîí îáðàòíî â êàðìàí&/uninvite {arg_id} {arg2}&/r Ñîòðóäíèê {get_ru_nick({arg_id})} áûë óâîëåí ïî ïðè÷èíå: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'point' , description = 'Óñòàîâèòü ìåòêó äëÿ ñîòðóäíèêîâ' , text = '/r Ñðî÷íî âûäâèãàéòåñü êî ìíå, îòïðàâëÿþ âàì êîîðäèíàòû...&/point' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'govka' , description = 'Ñîáåñåäîâàíèå ïî ãîññ.âîëíå' , text = '' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
				},	
				mafia = {
					{cmd = 'inv' , description = 'Ïðèíÿòèå èãðîêà â îðãàíèçàöèþ' , text = '/do Â êàðìàíå åñòü ñâÿçêà ñ êëþ÷àìè îò ðàçäåâàëêè.&/me äîñòà¸ò èç êàðìàíà îäèí êëþ÷ èç ñâÿçêè êëþ÷åé îò ðàçäåâàëêè&/todo Âîçüìèòå, ýòî êëþ÷ îò íàøåé ðàçäåâàëêè*ïåðåäàâàÿ êëþ÷ ÷åëîâåêó íàïðîòèâ&/invite {arg_id}&/n @{get_nick({arg_id})} , ïðèìèòå ïðèíÿòü ÷òîáû ïîëó÷èòü èíâàéò!' , arg = '{arg_id}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'rp' , description = 'Âûäà÷à ñîòðóäíèêó /fractionrp' , text = '/fractionrp {arg_id}' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'gr' , description = 'Ïîâûøåíèå/ïîíèæåíèå cîòðóäíèêà' , text = '{show_rank_menu}&/todo Âîò òåáå íîâàÿ ôîðìà!*ïðîòÿãèâàÿ ôîðìó ÷åëîâåêó íàïðîòèâ &/giverank {arg_id} {get_rank}' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'fmutes' , description = 'Âûäàòü ìóò ñîòðóäíèêó (10 min)' , text = '/fmutes {arg_id} Ïîäóìàé î ñâî¸ì ïîâåäåíèè' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'funmute' , description = 'Ñíÿòü ìóò ñîòðóäíèêó' , text = '/funmute {arg_id}' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'vig' , description = 'Âûäà÷à âûãîâîðà' , text = '/f {get_ru_nick({arg_id})}, òû ïðîâèíèëñÿ(-ëàñü) â {arg2}!&/fwarn {arg_id} {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'unvig' , description = 'Ñíÿòèå âûãîâîðà cîòðóäíèêó' , text = '/f {get_ru_nick({arg_id})}, òû ïðîù¸í(-à)!&unfwarn {arg_id}' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'unv' , description = 'Óâîëüíåíèå èãðîêà èç ôðàêöèè' , text = '/me çàáèðàåò îðãàíèçàöèîííóþ ôîðìó ó ÷åëîâåêà&/uninvite {arg_id} {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'point' , description = 'Óñòàíîâèòü ìåòêó äëÿ ñîòðóäíèêîâ' , text = '/f Ñðî÷íî âûäâèãàéòåñü êî ìíå, îòïðàâëÿþ âàì êîîðäèíàòû...&/point' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
				},
				ghetto = {}
			}
		}
	},
	notes = {
		name = 'Çàìåòêè',
		path = configDirectory .. "/Notes.json",
		data = {
			{ note_name = 'Ãëàâà 1 (ÔÏ)', note_text = "Ãëàâà I. Îáùåå ïîëîæåíèå&&1.1. Çàïðåùåíî íàðóøàòü Çàêîíû Îêðóãà (Óãîëîâíûé êîäåêñ è ïðî÷èå ãðóáûå íàðóøåíèÿ, íå âõîäÿùèå â êîìïåòåíòíîñòü ñîòðóäíèêà) - Ïîíèæåíèå | Âûãîâîð | Óâîëüíåíèå&1.2. Çàïðåùåíî çàíèìàòüñÿ äåÿòåëüíîñòüþ, íå ñâÿçàííîé ñ èñïîëíåíèåì ñëóæåáíûõ îáÿçàííîñòåé, â òå÷åíèå ðàáî÷åãî äíÿ - Ïðåäóïðåæäåíèå | Âûãîâîð | Óâîëüíåíèå&1.3. Çàïðåùåíî èñïîëüçîâàòü ëè÷íûé òðàíñïîðò â ðàáî÷èõ öåëÿõ íàõîäÿñü ïðè èñïîëíåíèå - Ïðåäóïðåæäåíèå | Âûãîâîð&Èñêëþ÷åíèå: Ðàçðåøåíî òîëüêî åñëè òðàíñïîðò íàõîäèòñÿ â ðååñòðå.&1.4. Çàïðåùåíî áåçäåéñòâîâàòü ïðè ×ðåçâû÷àéíûõ Ñèòóàöèÿõ è Âîåííîì ïîëîæåíèå - Âûãîâîð | Óâîëüíåíèå&1.5. Çàïðåùåíî áåçäåéñòâèå èëè íåèñïîëíåíèå îáÿçàííîñòåé ñîòðóäíèêàìè âõîäÿùèõ â êîìïåòåíöèè ïî îêàçàíèþ ïîìîùè ëèöàì, íàõîäÿùèìñÿ â îïàñíîé äëÿ æèçíè ñèòóàöèè - Âûãîâîð | Ïîíèæåíèå&1.6. Çàïðåùåíî óïîòðåáëåíèå àëêîãîëÿ â ðàáî÷åå âðåìÿ  Âûãîâîð | Ïîíèæåíèå | Óâîëüíåíèå&1.7. Çàïðåùåíî íàìåðåííî íå ðåàãèðîâàòü íà ñîîáùåíèÿ, ïîñòóïàþùèå ïî ðàöèè äåïàðòàìåíòà, â ðàáî÷åå âðåìÿ - Âûãîâîð | Ïîíèæåíèå&Ïðèìå÷àíèå: Â íå ðàáî÷åå âðåìÿ, äàííàÿ ñòàòüÿ íå âìåíÿåòñÿ.&1.8. Çàïðåùåíî ñîòðóäíèêàì äðóãèõ îðãàíèçàöèé ó÷àñòâîâàòü â ñïåöîïåðàöèÿõ, ïðîâîäèìûõ ÔÑÁ, áåç ïðÿìîãî óêàçàíèÿ ÔÑÁ - Ïðåäóïðåæäåíèå | Âûãîâîð&1.9. Çàïðåùåíî íàðóøàòü ñóáîðäèíàöèþ ïðè îáùåíèè c ãðàæäàíñêèìè, è âûøå ïî äîëæíîñòÿì ëþäüìè - Âûãîâîð | Ïîíèæåíèå&1.10. Çàïðåùåíî ïðåäîñòàâëÿòü çàâåäîìî ëîæíóþ èíôîðìàöèþ ñîòðóäíèêàì ãîñóäàðñòâåííûõ îðãàíîâ èëè âûøåñòîÿùèì äîëæíîñòíûì ëèöàì - Âûãîâîð | Ïîíèæåíèå | Óâîëüíåíèå.&1.11. Çàïðåùåíî íàðóøàòü óñòàâ è ïðî÷èå ðåãëàìåíòû îðãàíèçàöèè - Âûãîâîð | Ïîíèæåíèå | Óâîëüíåíèå&1.12. Çàïðåùåíî ïðèìåíÿòü ôèçè÷åñêóþ ñèëó â ñòîðîíó ñîòðóäíèêîâ ÔÑÁ - Âûãîâîð | Óâîëüíåíèå&Ïðèìå÷àíèå: Çà èñêëþ÷åíèåì ñòàòüè 2.3 ÔÏ&"},		
			{ note_name = 'Ãëàâà 2 (ÔÏ)', note_text = "2.1. Âî ãëàâå âñåõ ãîñóäàðñòâåííûõ îðãàíèçàöèé ñòîèò Ãóáåðíàòîð, Âèöå-ãóáåðíàòîð, Äèðåêòîð ÔÑÁ, Çàì Äèðåêòîðà ÔÑÁ&2.2. Ðóêîâîäñòâî, à òàêæå ñîòðóäíèêè Ôåäåðàëüíîé Ñëóæáû Áåçîïàñíîñòè íàïðÿìóþ ïîä÷èíÿþòñÿ Ïðåçèäèóìó Âîñòî÷íîãî Îêðóãà. Âûãîâîð | Ïîíèæåíèå&2.3. Ñîòðóäíèêîâ Ïðàâèòåëüñòâà è ÔÑÁ äîïóñòèìî çàäåðæèâàòü ïðè íàëè÷èè îñîáûõ îñíîâàíèé - Âûãîâîð | Ïîíèæåíèå | Óâîëüíåíèå.&Ïðèìå÷àíèå: Îñîáûì îñíîâàíèÿì ÿâëÿåòñÿ ãîñ. èçìåíà èëè æå ïðÿìîå íàíåñåíèå âðåäà çäîðîâüþ è æèçíè îêðóæàþùèõ.&2.4. Çàïðåùåíî ïðîíèêàòü íà òåððèòîðèþ Ôåäåðàëüíîé Ñëóæáû Áåçîïàñíîñòè áåç ðàçðåøåíèÿ Ðóêîâîäñòâà ÔÑÁ - Ïðåäóïðåæäåíèå | Âûãîâîð | Ïîíèæåíèå&2.5. Çàïðåùåíî íå ïîÿâëÿòüñÿ íà ïîñòðîåíèÿ, êîíòðîëèðóåìûå Ðóêîâîäñòâîì (8+) Ïðàâèòåëüñòâî/ÔÑÁ - Âûãîâîð | Ïîíèæåíèå&2.6. Çàïðåùåíî âåñòè ñëåæêó çà ðóêîâîäñòâîì Ïðàâèòåëüñòâà è ÔÑÁ (8+) - Âûãîâîð | Ïîíèæåíèå | Óâîëüíåíèå&Ïðèìå÷àíèå: Ñ ðàçðåøåíèÿ Ïðåçèäèóìà (ÃÑ ÃÎÑ)&2.7. Ñîòðóäíèêè ÔÑÁ ìîãóò ñíÿòü íåïðèêîñíîâåííîñòü ñ ëþáîãî ëèöà íàõîäÿùåãîñÿ â Ôåäåðàëüíîì Ðîçûñêå.&2.8. Ãóáåðíàòîð èìååò ïðàâî ïðîõîäèòü íà îõðàíÿåìû îáúåêòû Îêðóãà ñ óâåäîìëåíèåì ðóêîâîäñòâà.&Ïðèìå÷àíèå: Â íåêîòîðûõ ñëó÷àÿõ îí ìîæåò ïîëó÷èòü îáîñíîâàííûé îòêàç.&2.9 Çàïðåùåíî íàðóøàòü çàêîí èìåÿ íåïðèêîñíîâåííîñòü. Ïîíèæåíèå | Óâîëüíåíèå"},	
			{ note_name = 'Ãëàâà I. (ÏÄÄ)', note_text = "1.1. Åçäà ïî âñòðå÷íîé. Øòðàô â ðàçìåðå 50.000 ðóáëåé.&1.2. Åçäà ïî âñòðå÷íîé íà ãðóçîâîì àâòî. Øòðàô â ðàçìåðå 100.000 ðóáëåé&"},		
			{ note_name = 'Ãëàâà II. (ÏÄÄ)', note_text = "2.1. Íàåçä íà ïåøåõîäà. Ïðèñóæäàåòñÿ 3 óðîâåíü ðîçûñêà è èçúÿòèå ïðàâ.&Åñëè ñìåðòåëüíîé òðàâìû íå ïðîèçîøëî, âìåñòî ðîçûñêà íàêëàäûâàåòñÿ øòðàô 200.000 ðóáëåé, êîòîðûé ïîäëåæèò âûïëàòå ïîñòðàäàâøåìó."},			
			{ note_name = 'Ãëàâà III. (ÏÄÄ)', note_text = "3.1. Ïàðêîâêà â íåïîëîæåííîì ìåñòå ëåãêîâûì òðàíñïîðòíûì ñðåäñòâîì. Øòðàô â ðàçìåðå 45.000 ðóáëåé / ýâàêóàöèÿ òðàíñïîðòà íà øòðàô ñòîÿíêó.&3.2. Ïàðêîâêà â íåïîëîæåííîì ìåñòå ãðóçîâûì àâòî. Øòðàô â ðàçìåðå 75.000 ðóáëåé. Èçúÿòèå âîä.ïðàâ.&3.3. Ïàðêîâêà â íåïîëîæåííîì ìåñòå âîçäóøíûì òðàíñïîðòíûì ñðåäñòâîì. Øòðàô â ðàçìåðå 150.000 ðóáëåé / èçúÿòèå ëèöåíçèè íà óïðàâëåíèå âîçäóøíûì Ò/Ñ."},		
			{ note_name = 'Ãëàâà IV. (ÏÄÄ)', note_text = "4.1. Óõîä ñ ìåñòà ÄÒÏ. Ïðèñóæäàåòñÿ 2 óðîâåíü ðîçûñêà, øòðàô: 60.000 ðóáëåé / èçúÿòèå ïðàâ.&4.2. Âèíîâíèê ÄÒÏ. Øòðàô â ðàçìåðå 50.000 ðóáëåé, âûïëàòà ìàòåðèàëüíîãî óùåðáà.&4.2. Òàðàí òðàíñïîðòíîãî ñðåäñòâà. Ïðèñóæäàåòñÿ 2 óðîâåíü ðîçûñêà / øòðàô 250.000 ðóá."},
			{ note_name = 'Ãëàâà V. (ÏÄÄ)', note_text = "5.1. Äâèæåíèå ïî îáî÷èíàì, òðîòóàðàì, æ/ä ïóòÿì, òðàìâàéíûì ðåëüñàì è ïîëÿì. Øòðàô â ðàçìåðå 50.000 ðóáëåé / èçúÿòèå ïðàâ.&5.2. Çà ïåðåõîä ïðîåçæåé ÷àñòè ïåøåõîäîì â íåïîëîæåííîì ìåñòå. Øòðàô â ðàçìåðå 45.000 ðóá."},			
			{ note_name = 'Ãëàâà VI. (ÏÄÄ)', note_text = "6.1. Çà èãíîðèðîâàíèå ñïåö. ñèðåí. Øòðàô â ðàçìåðå 100.000 ðóáëåé, èçúÿòèå ïðàâ.&6.2. Çà èãíîðèðîâàíèå ñïåö. ñèðåí, êîòîðûå âêëþ÷åíû ÷òîáû îñòàíîâèòü âàñ. Ïðèñóæäàåòñÿ 3 óðîâíÿ ðîçûñêà, èçúÿòèå ïðàâ."},			
			{ note_name = 'Ãëàâà VII. (ÏÄÄ)', note_text = "7.1. Çà íå âêëþ÷åííûå ïîâîðîòíèêè ïðè ñîâåðøåíèè ìàíåâðà. Øòðàô â ðàçìåðå 30.000 ðóáëåé.&7.2. Çà ñòîÿíêó ïîñðåäè äîðîãè áåç àâàðèéíûõ ñèãíàëîâ / ñîçäàíèå àâàðèéíîé ñèòóàöèè. Øòðàô â ðàçìåðå 50.000 ðóáëåé.&7.3. Çà âûêëþ÷åííûå ôàðû â íî÷íîå âðåìÿ ñóòîê: Øòðàô â ðàçìåðå 50.000 ðóáëåé&7.4. Åçäà ñ àâàðèéíûìè ñèãíàëàìè. Øòðàô â ðàçìåðå 35.000 ðóáëåé"},		
			{ note_name = 'Ãëàâà VIII. (ÏÄÄ)', note_text = "8.1. Ïðåâûøåíèå ñêîðîñòè â ãîðîäå áîëüøå 60 êì/÷. Øòðàô â ðàçìåðå 50.000 ðóáëåé.&8.2. Ïðåâûøåíèå ñêîðîñòè âíå ãîðîäà áîëüøå 120 êì/÷. Øòðàô â ðàçìåðå 100.000 ðóáëåé."},			
			{ note_name = 'Ãëàâà IX (ÏÄÄ)', note_text = "9.1. Çà äâèæåíèå íà íåèñïðàâíîì òðàíñïîðòíîì ñðåäñòâå (Äûì èç ïîä êàïîòà / ñèëüíûå ïîâðåæäåíèÿ ó àâòîìîáèëÿ: Øòðàô â ðàçìåðå 95.000 ðóáëåé.&9.2. Çà äâèæåíèå íà òðàíñïîðòíîì ñðåäñòâå ñ íåèñïðàâíîé èëè ñëîìàííîé ôàðîé: Øòðàô â ðàçìåðå 25.000 ðóáëåé.&9.3. Çà îòñóòñòâèå íîìåðíûõ çíàêîâ íà òðàíñïîðòíîì ñðåäñòâå: Ìàøèíà èçûìàåòñÿ íà øòðàô.ñòîÿíêó è øòðàô â ðàçìåðå 50.000 ðóáëåé."},
			{ note_name = 'Ãëàâà X. (ÏÄÄ)', note_text = "10.1. Çà ïðîåçä íà æåëòûé ñèãíàë ñâåòîôîðà. Øòðàô â ðàçìåðå 30.000 ðóáëåé&10.2. Çà ïðîåçä íà êðàñíûé ñèãíàë ñâåòîôîðà. Íàêëàäûâàåòñÿ ñèñòåìíûé øòðàô, çà íåãî ñòðîãî çàïðåùåíî&íàêëàäûâàòü øòðàô."},
			{ note_name = 'Èíôîðìàöèÿ ñêðèïòà', note_text = "Ïðèâåòñòâóþ, óâàæàåìûå ïîëüçîâàòåëè Rodina Helper!&Åñëè âû âèäèòå äàííîå ñîîáùåíèå  çíà÷èò, ó ìåíÿ âñ¸ ïîëó÷èëîñü: ñêðèïò îôèöèàëüíî îäîáðåí ñàìèì Äàíèëîì Ëèìàíñêèì (ÃÀ) íà Âîñòî÷íîì ñåðâåðå.&Åñëè âñ¸ ïîéä¸ò äàëüøå, ñêðèïò ïîÿâèòñÿ è íà äðóãèõ îêðóãàõ íàøåãî ïðåêðàñíîãî ïðîåêòà. Îæèäàéòå äàëüíåéøèõ îáíîâëåíèé!&Ìû ñòàðàåìñÿ ñäåëàòü âñ¸ äëÿ êîìôîðòíîãî èñïîëüçîâàíèÿ ñêðèïòà è âàøåé çàùèòû. Òîò æå ñàìûé «Ïîëèñ Õåëïåð» óñòóïàåò ìåñòî äàííîìó ñêðèïòó.&Äàëåå áóäåò ñîçäàí ñàéò è óñòàíîâùèê äëÿ ýòîãî õåëïåðà. Âñþ èíôîðìàöèþ âû ìîæåòå óâèäåòü â Telegram-êàíàëå (â íàñòðîéêàõ ñêðèïòà). Òàì æå ìîæíî çàäàòü âîïðîñû ïî ñêðèïòó è ñîîáùèòü î ïðîáëåìàõ.&ß òàêæå ÿâëÿþñü òåõíè÷åñêèì ìîäåðàòîðîì Áàðêèíà. Åñëè ñêðèïò ñòàíåò îôèöèàëüíûì, îí áóäåò âûïóñêàòüñÿ â ñáîðêàõ ó Áàðêèíà.&Ñïàñèáî, ÷òî âû ñî ìíîé! Óäà÷íîãî èñïîëüçîâàíèÿ ñêðèïòà!"},
		}
	},
	rpgun = {
		name = 'RP îðóæèå',
		path = configDirectory .. "/Guns.json",
		data = {
            rp_guns = {
                {id = 0, name = 'êóëàêè', enable = true, rpTake = 2},
				{id = 1, name = 'êàñòåòû', enable = false, rpTake = 2},
				{id = 2, name = 'êëþøêó äëÿ ãîëüôà', enable = false, rpTake = 1},
				{id = 3, name = 'äóáèíêó', enable = true, rpTake = 3},
				{id = 4, name = 'îñòðûé íîæ', enable = false, rpTake = 3},
				{id = 5, name = 'áèòó', enable = false, rpTake = 1},
				{id = 6, name = 'ëîïàòó', enable = true, rpTake = 1},
				{id = 7, name = 'êèé', enable = false, rpTake = 1},
				{id = 8, name = 'êàòàíó', enable = false, rpTake = 1},
				{id = 9, name = 'áåíçîïèëó', enable = false, rpTake = 1},
				{id = 10, name = 'èãðóøêó', enable = false, rpTake = 2},
				{id = 11, name = 'áîëüøóþ èãðóøêó', enable = false, rpTake = 2},
				{id = 12, name = 'ìîòîðíóþ èãðóøêó', enable = false, rpTake = 2},
				{id = 13, name = 'áîëüøóþ èãðóøêó', enable = false, rpTake = 2},
				{id = 14, name = 'áóêåò öâåòîâ', enable = true, rpTake = 1},
				{id = 15, name = 'òðîñòü', enable = false, rpTake = 1},
				{id = 16, name = 'îñêîëî÷íóþ ãðàíàòó', enable = false, rpTake = 3},
				{id = 17, name = 'äûìîâóþ ãðàíàòó', enable = true, rpTake = 3},
				{id = 18, name = 'êîêòåéëü Ìîëîòîâà', enable = true, rpTake = 3},
				{id = 22, name = 'ïèñòîëåò Colt45', enable = false, rpTake = 4},
				{id = 23, name = "ýëåêòðîøîêåð Taser X26P", enable = true, rpTake = 4},
				{id = 24, name = 'ïèñòîëåò Desert Eagle', enable = true, rpTake = 4},
				{id = 25, name = 'äðîáîâèê', enable = true, rpTake = 1},
				{id = 26, name = 'îáðåç', enable = true, rpTake = 4},
				{id = 27, name = 'óëó÷øåííûé îáðåç', enable = false, rpTake = 1},
				{id = 28, name = 'ÏÏ Micro Uzi', enable = true, rpTake = 3},
				{id = 29, name = 'ÏÏ MP5', enable = true, rpTake = 4},
				{id = 30, name = 'àâòîìàò AK47', enable = true, rpTake = 1},
				{id = 31, name = 'àâòîìàò M4', enable = true, rpTake = 1},
				{id = 32, name = 'ÏÏ Tec9', enable = true, rpTake = 4},
				{id = 33, name = 'âèíòîâêó Rifle', enable = true, rpTake = 1},
				{id = 34, name = 'ñíàéïåðñêóþ âèíòîâêó', enable = true, rpTake = 1},
				{id = 35, name = 'ÐÏÃ', enable = false, rpTake = 1},
				{id = 36, name = 'ÏÒÓÐ', enable = false, rpTake = 1},
				{id = 37, name = 'îãíåì¸ò', enable = false, rpTake = 1},
				{id = 38, name = 'ìèíèãàí', enable = false, rpTake = 1},
				{id = 39, name = 'äèíàìèò', enable = false, rpTake = 3},
				{id = 40, name = 'äåòîíàòîð', enable = false, rpTake = 3},
				{id = 41, name = 'ïåðöîâûé áàëîí÷èê', enable = true, rpTake = 2},
				{id = 42, name = 'îãíåòóøèòåëü', enable = true, rpTake = 1},
				{id = 43, name = 'ôîòîàïàðàò', enable = true, rpTake = 2},
				{id = 44, name = 'ÏÍÂ', enable = false, rpTake = 3},
				{id = 45, name = 'òåïëîâèçîð', enable = false, rpTake = 3},
				{id = 46, name = 'ïàðàøóò', enable = true, rpTake = 1},
				-- gta sa damage reason
				{id = 49, name = 'ò/ñ', enable = false, rpTake = 1},
				{id = 50, name = 'ëîïàñòè âåðòîë¸òà', enable = false, rpTake = 1},
				{id = 51, name = 'ãðàíàòó', enable = false, rpTake = 1},
				{id = 54, name = 'êîëëèçèþ/òþíèíã', enable = false, rpTake = 1},
				-- ARZ CUSTOM GUN
				{id = 71, name = 'ïèñòîëåò Desert Eagle Steel', enable = true, rpTake = 4},
				{id = 72, name = 'ïèñòîëåò Desert Eagle Gold', enable = true, rpTake = 4},
				{id = 73, name = 'ïèñòîëåò Glock Gradient', enable = true, rpTake = 4},
				{id = 74, name = 'ïèñòîëåò Desert Eagle Flame', enable = true, rpTake = 4},
				{id = 75, name = 'ïèñòîëåò Python Royal', enable = true, rpTake = 4},
				{id = 76, name = 'ïèñòîëåò Python Silver', enable = true, rpTake = 4},
				{id = 77, name = 'àâòîìàò AK-47 Roses', enable = true, rpTake = 1},
				{id = 78, name = 'àâòîìàò AK-47 Gold', enable = true, rpTake = 1},
				{id = 79, name = 'ïóëåì¸ò M249 Graffiti', enable = true, rpTake = 1},
				{id = 80, name = 'çîëîòóþ Ñàéãó', enable = true, rpTake = 1},
				{id = 81, name = 'ÏÏ Standart', enable = true, rpTake = 4},
				{id = 82, name = 'ïóëåì¸ò M249', enable = true, rpTake = 1},
				{id = 83, name = 'ÏÏ Skorp', enable = true, rpTake = 4},
				{id = 84, name = 'àâòîìàò AKS74 êàìóôëÿæíûé', enable = true, rpTake = 1},
				{id = 85, name = 'àâòîìàò AK47 êàìóôëÿæíûé', enable = true, rpTake = 1},
				{id = 86, name = 'äðîáîâèê Rebecca', enable = true, rpTake = 1},
				{id = 87, name = 'ïîðòàëüíóþ ïóøêó', enable = true, rpTake = 1},
				{id = 88, name = 'ëåäÿíîé ìå÷', enable = true, rpTake = 1},
				{id = 89, name = 'ïîðòàëüíóþ ïóøêó', enable = true, rpTake = 4},
				{id = 90, name = 'îãëóøàþùóþ ãðàíàòó', enable = true, rpTake = 3},
				{id = 91, name = 'îñëåïëÿþùóþ ãðàíàòó', enable = true, rpTake = 3},
				{id = 92, name = 'ñíàéïåðñêóþ âèíòîâêó TAC50', enable = true, rpTake = 1},
				{id = 93, name = 'îãëóøàþùèé ïèñòîëåò', enable = true, rpTake = 4},
				{id = 94, name = 'ñíåæíóþ ïóøêó', enable = true, rpTake = 1},
				{id = 95, name = 'ïèêñåëüíûé áëàñòåð', enable = true, rpTake = 3},
				{id = 96, name = 'àâòîìàò M4 Gold', enable = true, rpTake = 1},
				{id = 97, name = 'áàíäèòñêèé äðîáîâèê', enable = true, rpTake = 1},
				{id = 98, name = 'ÏÏ Uzi Graffiti', enable = true, rpTake = 4},
				{id = 99, name = 'çîëîòóþ ìîíòèðîâêó', enable = true, rpTake = 1},
				{id = 100, name = 'áèòó Compton', enable = true, rpTake = 1},
				{id = 101, name = 'ïèñòîëåò SciFi Deagle', enable = true, rpTake = 4},
				{id = 102, name = 'àâòîìàò SciFi AK47', enable = true, rpTake = 1},
				{id = 103, name = 'äðîáîâèê SciFi', enable = true, rpTake = 1},
				{id = 104, name = 'íîæ SciFi', enable = true, rpTake = 3},
				{id = 105, name = 'ñêàíåð', enable = false, rpTake = 4},
				{id = 106, name = 'çîëîòîé íîæ', enable = true, rpTake = 3},
				{id = 107, name = 'êàòàíó Íèð', enable = true, rpTake = 1},
            },
            rpTakeNames = {
				{"èç-çà ñïèíû", "çà ñïèíó"},
				{"èç êàðìàíà", "â êàðìàí"},
				{"èç ïîÿñà", "íà ïîÿñ"},
				{"èç êîáóðû", "â êîáóðó"}
			},
            gunActions = {
                on = {},
                off = {},
                partOn = {},
                partOff = {}
            },
            oldGun = nil,
            nowGun = 0
        }
	},
    smart_uk = {
		name = 'Óìíûé Ðîçûñê',
		path = configDirectory .. "/SmartUK.json",
		data = {}
	},
    smart_pdd = {
		name = 'Óìíûå Øòðàôû',
		path = configDirectory .. "/SmartPDD.json",
		data = {}
	},
    smart_rptp = {
		name = 'Óìíûé Ñðîê',
		path = configDirectory .. "/SmartRPTP.json",
		data = {}
	},
	arz_veh = {
		name = 'Òðàíñïîðò',
		path = configDirectory .. "/Vehicles.json",
		data = {},
		cache = {}
	},
	ads_history = {
		name = 'Èñòîðèÿ Îáúÿâëåíèé',
		path = configDirectory .. "/ADS.json",
		data = {}
	}
}
function load_module(key)
    local obj = modules[key]
	if not obj then
		print('Îøèáêà: íåèçâåñòíûé ìîäóëü "' .. key .. '"!')
	else
		if doesFileExist(obj.path) then
			local file, errstr = io.open(obj.path, 'r')
			if file then
				local contents = file:read('*a')
				file:close()
				if #contents == 0 then
					print('Íå óäàëîñü îòêðûòü ìîäóëü "' .. obj.name .. '". Ïðè÷èíà: ôàéë ïóñòîé')
				else
					local result, loaded = pcall(decodeJson, contents)
					if result then
						obj.data = loaded
						print('Ìîäóëü "' .. obj.name .. '" èíèöèàëèçèðîâàí! (åñòü âàøè êàñòîìíûå äàííûå)')
					else
						print('Íå óäàëîñü îòêðûòü ìîäóëü "' .. obj.name .. '". Îøèáêà: decode json')
					end
				end
			else
				print('Íå óäàëîñü îòêðûòü ìîäóëü "' .. obj.name .. '". Îøèáêà: ' .. tostring(errstr or "íåèçâåñòíàÿ"))
			end
		else
			print('Ìîäóëü "' .. obj.name .. '" èíèöèàëèçèðîâàí!')
		end
	end
end
function save_module(key)
    local obj = modules[key]
	if not obj then
		print('Îøèáêà: íåèçâåñòíûé ìîäóëü "' .. key .. '"!')
	else
		local file, errstr = io.open(obj.path, 'w')
		if file then
			local function looklike(array)
				local dkok, dkjson = pcall(require, "dkjson")
				if dkok then
					local ok, encoded = pcall(dkjson.encode, array, {indent = true})
					if ok then return encoded end
				else
					local ok, encoded = pcall(encodeJson, array)
					if ok then return encoded end
				end
			end
			local content = looklike(obj.data)
			if content then
				file:write(content)
				print('Ìîäóëü "' .. obj.name .. '" ñîõðàí¸í!')
			else
				print('Íå óäàëîñü ñîõðàíèòü ìîäóëü "' .. obj.name .. '" - îøèáêà êîäèðîâêè json!')
			end
			file:close()
		else
			print('Íå óäàëîñü ñîõðàíèòü ìîäóëü "' .. obj.name .. '", îøèáêà: ' .. tostring(errstr or "íåèçâåñòíàÿ"))
		end
	end
end
------------------------------------------- GUI & MODULES ----------------------------------------
local MODULE = {
	Initial = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
		slider = imgui.new.int(0),
		step = 0,
		fraction_type_selector = 0,
		fraction_type_selector_text = 'Áåç îðãàíèçàöèè',
		fraction_type_icon = nil,
		step2_result = 0,
		fraction_selector = 0,
		fraction_selector_text = '',
	},
	Main = {
		Window = imgui.new.bool(),
		theme = imgui.new.int(tonumber(settings.general.helper_theme)),
		slider = imgui.new.int(),
		slider_dpi = imgui.new.float(tonumber(settings.general.custom_dpi)),
		input = imgui.new.char[256](),
		checkbox = {
			accent_enable = imgui.new.bool(settings.player_info.accent_enable),
			mobile_stop_button = imgui.new.bool(settings.general.mobile_stop_button),
			mobile_fastmenu_button = imgui.new.bool(settings.general.mobile_fastmenu_button),
			dep_anti_skobki = imgui.new.bool(settings.departament.anti_skobki),
			-- payday_notify = imgui.new.bool(settings.general.payday_notify or false),
			-- auto_accept_docs = imgui.new.bool(settings.general.auto_accept_docs or false),
			-- auto_update_members = imgui.new.bool(settings.general.auto_update_members or false),
			-- auto_mask = imgui.new.bool(settings.general.auto_mask or false),
			
			-- MJ 
			mobile_taser_button = imgui.new.bool(settings.mj.mobile_taser_button or false),
			mobile_meg_button = imgui.new.bool(settings.mj.mobile_meg_button or false),
			-- auto_change_code_siren = imgui.new.bool(settings.mj.auto_change_code_siren or false),
			-- auto_doklad_patrool = imgui.new.bool(settings.mj.auto_doklad_patrool or false),
			-- auto_doklad_damage = imgui.new.bool(settings.mj.auto_doklad_damage or false),
			-- auto_doklad_arrest = imgui.new.bool(settings.mj.auto_doklad_arrest or false),
			-- auto_time = imgui.new.bool(settings.mj.auto_time or false),
			-- auto_update_wanteds = imgui.new.bool(settings.mj.auto_update_wanteds or false),
			-- auto_case_documentation = imgui.new.bool(settings.mj.auto_case_documentation or false),
			-- awanted = imgui.new.bool(settings.mj.awanted or false),

			-- auto_clicker_situation = imgui.new.bool((isMode('police') or isMode('fcb')) and settings.mj.auto_clicker_situation or settings.mh.auto_clicker_situation)
			-- MD
			-- auto_doklad_patrool = imgui.new.bool(settings.md.auto_doklad_patrool or false),
			-- auto_doklad_damage = imgui.new.bool(settings.md.auto_doklad_damage or false),
		},
		mmcolor = imgui.new.float[3](),
		msgcolor = imgui.new.float[3](),
	},
	Binder = {
		Window = imgui.new.bool(),
		waiting_slider = imgui.new.float(0),
		ComboTags = imgui.new.int(),
		input_cmd = imgui.new.char[256](),
		input_description = imgui.new.char[256](),
		input_text = imgui.new.char[8192](),
		item_list = {
			u8('Áåç àðãóìåíòîâ'),
			u8('{arg} Ëþáîå çíà÷åíèå'),
			u8('{arg_id} ID èãðîêà | Ïðèìåð /cure 429'),
			u8('{arg_id} ID {arg2} ëþáîå çíà÷åíèå | Ïðèìåð /vig 429 Áåç áåéäæèêà'),
			u8('{arg_id} ID {arg2} ÷èñëî {arg3} ëþáîå | Ïðèìåð /su 429 2 Íåïîä÷èíåíèå'),
			u8('{arg_id} ID {arg2} ÷èñëî {arg3} ëþáîå {arg4} ëþáîå | Ïðèìåð /carcer 429 1 5 Í.Ï.Ò')
		},
		ImItems = imgui.new['const char*'][6]({
			u8('Áåç àðãóìåíòîâ'),
			u8('{arg} Ëþáîå çíà÷åíèå'),
			u8('{arg_id} ID èãðîêà | Ïðèìåð /cure 429'),
			u8('{arg_id} ID {arg2} ëþáîå çíà÷åíèå | Ïðèìåð /vig 429 Áåç áåéäæèêà'),
			u8('{arg_id} ID {arg2} ÷èñëî {arg3} ëþáîå | Ïðèìåð /su 429 2 Íåïîä÷èíåíèå'),
			u8('{arg_id} ID {arg2} ÷èñëî {arg3} ëþáîå {arg4} ëþáîå | Ïðèìåð /carcer 429 1 5 Í.Ï.Ò')
		}),
		data = {
			change_waiting = nil,
			change_cmd = nil,
			change_text = nil,
			change_arg = nil,
			change_bind = nil,
			change_in_fastmenu = false,
			create_command_9_10 = false,
			input_description = nil
		},
		state = {
			isActive = false,
			isStop = false,
			isPause = false
		},
		tags = {},
		tags_text = ''
	},
	Note = {
		Window = imgui.new.bool(),
		input_text = imgui.new.char[1048576](),
		input_name = imgui.new.char[256](),
		show_note_name = '',
		show_note_text = '',
	},
	Members = {
		Window = imgui.new.bool(),
		all = {},
		new = {},
		upd = {},
		info = {fraction = '', check = false},
	},
	RPWeapon = {
		Window = imgui.new.bool(),
		ComboTags = imgui.new.int(),
		item_list = {u8'Ñïèíà', u8'Êàðìàí', u8'Ïîÿñ', u8'Êîáóðà'},
		ImItems = imgui.new['const char*'][4]({u8'Ñïèíà', u8'Êàðìàí', u8'Ïîÿñ', u8'Êîáóðà'}),
		input_search = imgui.new.char[256]('')
	},
	CruiseControl = {
		enable = imgui.new.bool(settings.general.cruise_control),
		active = false,
		wait_point = false,
		point = {x = 0, y = 0, z = 0}
	},
	-- goss
	Departament = {
		Window = imgui.new.bool(),
		text = imgui.new.char[256](),
		fm = imgui.new.char[32](u8(settings.departament.dep_fm)),
		tag1 = imgui.new.char[32](u8(settings.departament.dep_tag1)),
		tag2 = imgui.new.char[32](u8(settings.departament.dep_tag2)),
		new_tag = imgui.new.char[32]()
	},
	Post = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
		name = '',
		code = 'CODE 4',
		active = false,
		start_time = 0,
		current_time = 0,
		time = 0,
		process_doklad = false,
		ComboCode = imgui.new.int(5),
		combo_code_list = {'CODE 0', 'CODE 1', 'CODE 2', 'CODE 2 HIGHT', 'CODE 3', 'CODE 4', 'CODE 4 ADAM', 'CODE 5', 'CODE 6', 'CODE 7', 'CODE 30', 'CODE 30 RINGER', 'CODE 37', 'CODE TOM'},
		ImItemsCode = imgui.new['const char*'][14]({'CODE 0', 'CODE 1', 'CODE 2', 'CODE 2 HIGHT', 'CODE 3', 'CODE 4', 'CODE 4 ADAM', 'CODE 5', 'CODE 6', 'CODE 7', 'CODE 30', 'CODE 30 RINGER', 'CODE 37', 'CODE TOM'})
	},
	-- mj
	Wanted = {
		Window = imgui.new.bool(),
		updwanteds = {},
		wanted = {},
		wanted_new = {},
		check_wanted = false,
	},
	Megafon = {
		Window = imgui.new.bool()
	},
	Taser = {
		Window = imgui.new.bool()
	},
	Patrool = {
		Window = imgui.new.bool(),
		active = false,
		start_time = 0,
		current_time = 0,
		time = 0,
		process_doklad = false,
		code = 'CODE 4',
		mark = 'ADAM',
		ComboMark = imgui.new.int(1),
		combo_mark_list = {'ADAM', 'LINCOLN', 'MARY', 'HENRY', 'AIR', 'ASD', 'CHARLIE', 'ROBERT', 'SUPERVISOR', 'DAVID', 'EDWARD', 'NORA'},
		ImItemsMark = imgui.new['const char*'][12]({'ADAM', 'LINCOLN', 'MARY', 'HENRY', 'AIR', 'ASD', 'CHARLIE', 'ROBERT', 'SUPERVISOR', 'DAVID', 'EDWARD', 'NORA'}),
		ComboCode = imgui.new.int(5),
		combo_code_list = {'CODE 0', 'CODE 1', 'CODE 2', 'CODE 2 HIGHT', 'CODE 3', 'CODE 4', 'CODE 4 ADAM', 'CODE 5', 'CODE 6', 'CODE 7', 'CODE 30', 'CODE 30 RINGER', 'CODE 37', 'CODE TOM'},
		ImItemsCode = imgui.new['const char*'][14]({'CODE 0', 'CODE 1', 'CODE 2', 'CODE 2 HIGHT', 'CODE 3', 'CODE 4', 'CODE 4 ADAM', 'CODE 5', 'CODE 6', 'CODE 7', 'CODE 30', 'CODE 30 RINGER', 'CODE 37', 'CODE TOM'})
	},
	SumMenu = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
		form_su = '',
	},
	TsmMenu = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
	},
	-- prison
	PumMenu = {
		Window = imgui.new.bool(),
		input = imgui.new.char[256](),
	},
	-- hospital
	MedCard = {
		Window = imgui.new.bool(),
		days = imgui.new.int(3),
		status = imgui.new.int(3)
	},
	Recept = {
		Window = imgui.new.bool(),
		recepts = imgui.new.int(1)
	},
	Antibiotik = {
		Window = imgui.new.bool(),
		ants = imgui.new.int(1)
	},
	HealChat = {
		Window = imgui.new.bool(),
		bool = false,
		player_id = nil,
		worlds = {'âûëå÷è', 'ëå÷è', 'õèë', 'ëåê', 'heal', 'hil', 'lek', 'òàáë', 'áîëèò', 'ãîëîâà', 'ëåêíè' , 'ktr', 'ktxb', 'ujkjdf'},
		healme = false
	},
	GoDeath = {
		player_id = nil,
		locate = '',
		city = ''
	},
	MedicalPrice = {
		heal         = imgui.new.char[12](u8(settings.mh.price.heal)),
		heal_vc      = imgui.new.char[12](u8(settings.mh.price.heal_vc)),
		healactor_vc = imgui.new.char[12](u8(settings.mh.price.healactor_vc)),		
		medosm       = imgui.new.char[12](u8(settings.mh.price.medosm)),
		mticket      = imgui.new.char[12](u8(settings.mh.price.mticket)),		
		recept       = imgui.new.char[12](u8(settings.mh.price.recept)),
		ant          = imgui.new.char[12](u8(settings.mh.price.ant)),
		med7         = imgui.new.char[12](u8(settings.mh.price.med7)),
		med14        = imgui.new.char[12](u8(settings.mh.price.med14)),
		med30        = imgui.new.char[12](u8(settings.mh.price.med30)),
		med60        = imgui.new.char[12](u8(settings.mh.price.med60)),	
	},	
	-- SMI
	SmiEdit = {
		Window = imgui.new.bool(),
		input_edit_text = imgui.new.char[256](),
		input_ads_search = imgui.new.char[256](),
		ad_message = '',
		ad_from = '',
		ad_dialog_id = '',
		adshistory_orig = '',
		adshistory_input_text = imgui.new.char[512](),
		skip_dialogd = false,
		ad_repeat_count = 0,
		last_ad_text = "",
	},
	-- AS
	LicensePrice = {
		avto1 = imgui.new.char[12](u8(settings.lc.price.avto1)),
		avto2 = imgui.new.char[12](u8(settings.lc.price.avto2)),
		avto3 = imgui.new.char[12](u8(settings.lc.price.avto3)),
		moto1 = imgui.new.char[12](u8(settings.lc.price.moto1)),
		moto2 = imgui.new.char[12](u8(settings.lc.price.moto2)),
		moto3 = imgui.new.char[12](u8(settings.lc.price.moto3)),
		fish1 = imgui.new.char[12](u8(settings.lc.price.fish1)),
		fish2 = imgui.new.char[12](u8(settings.lc.price.fish2)),
		fish3 = imgui.new.char[12](u8(settings.lc.price.fish3)),
		swim1 = imgui.new.char[12](u8(settings.lc.price.swim1)),
		swim2 = imgui.new.char[12](u8(settings.lc.price.swim2)),
		swim3 = imgui.new.char[12](u8(settings.lc.price.swim3)),
		gun1 = imgui.new.char[12](u8(settings.lc.price.gun1)),
		gun2 = imgui.new.char[12](u8(settings.lc.price.gun2)),
		gun3 = imgui.new.char[12](u8(settings.lc.price.gun3)),
		hunt1 = imgui.new.char[12](u8(settings.lc.price.hunt1)),
		hunt2 = imgui.new.char[12](u8(settings.lc.price.hunt2)),
		hunt3 = imgui.new.char[12](u8(settings.lc.price.hunt3)),
		klad1 = imgui.new.char[12](u8(settings.lc.price.klad1)),
		klad2 = imgui.new.char[12](u8(settings.lc.price.klad2)),
		klad3 = imgui.new.char[12](u8(settings.lc.price.klad3)),
		taxi1 = imgui.new.char[12](u8(settings.lc.price.taxi1)),
		taxi2 = imgui.new.char[12](u8(settings.lc.price.taxi2)),
		taxi3 = imgui.new.char[12](u8(settings.lc.price.taxi3)),
		mexa1 = imgui.new.char[12](u8(settings.lc.price.mexa1)),
		mexa2 = imgui.new.char[12](u8(settings.lc.price.mexa2)),
		mexa3 = imgui.new.char[12](u8(settings.lc.price.mexa3)),
		fly1 = imgui.new.char[12](u8(settings.lc.price.fly1)),
		fly2 = imgui.new.char[12](u8(settings.lc.price.fly2)),
		fly3 = imgui.new.char[12](u8(settings.lc.price.fly3))
	},
	-- 9/10
	GiveRank = {
		Window = imgui.new.bool(),
		number = imgui.new.int(5)
	},
	Sobes = {
		Window = imgui.new.bool()
	},
	LeadTools = {
		vc_vize = {
			bool = false,
			player_id = nil
		},
		auto_uninvite = {
			checker = false,
			msg1 = '',
			msg2 = '',
			msg3 = ''
		},
		spawncar = false,
		platoon = {
			check = false,
			player_id = nil
		}
	},
	-- others
	Update = {
		Window = imgui.new.bool(),
		is_need_update = false,
		version = "",
		url = "",
		info = "",
		download_file = ""
	},
	CommandStop = {
		Window = imgui.new.bool()
	},
	CommandPause = {
		Window = imgui.new.bool()
	},
	LeaderFastMenu = {
		Window = imgui.new.bool()
	},
	FastMenu = {
		Window = imgui.new.bool()
	},
	FastPieMenu = {
		Window = imgui.new.bool()
	},
	FastMenuButton = {
		Window = imgui.new.bool()
	},
	FastMenuPlayers = {
		Window = imgui.new.bool()
	},
	InfraredVision = false,
	NightVision = false,
	FONT = nil,
	DEBUG = false
}
MODULE.Binder.tags = {
	my_id = function()
		if isMonetLoader() then
			local nick = settings.player_info.nick or ReverseTranslateNick(settings.player_info.name_surname)
			return sampGetPlayerIdByNickname(nick)
		else
			return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
		end
	end,
    my_nick = function()
		if isMonetLoader() then
			return settings.player_info.nick or ReverseTranslateNick(settings.player_info.name_surname)
		else
			return sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
		end
	end,
	my_ru_nick = function() return settings.player_info.name_surname end,
    my_rp_nick = function()
		if isMonetLoader() then
			local nick = settings.player_info.nick or ReverseTranslateNick(settings.player_info.name_surname)
			return nick:gsub('_', ' ')
		else
			return sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))):gsub('_',' ') 
		end
	end,
    my_doklad_nick = function()
		local nick
		if isMonetLoader() then
			nick = settings.player_info.nick or ReverseTranslateNick(settings.player_info.name_surname)
		else
			nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
		end
		if nick:find('(.+)%_(.+)') then
			local name, surname = nick:match('(.+)%_(.+)')
			return name:sub(1, 1)  .. '.' .. surname
		else
			return nick
		end
    end,
	fraction_rank_number = function() return settings.player_info.fraction_rank_number end,
	fraction_rank = function() return settings.player_info.fraction_rank end,
	fraction_tag = function() return settings.player_info.fraction_tag end,
	fraction = function() return settings.player_info.fraction end,
	sex = function() 
		return (settings.player_info.sex == 'Æåíùèíà') and 'a' or ''
	end,
	get_time = function()
		return os.date("%H:%M:%S")
	end,
	get_date = function()
		return os.date("%H:%M:%S")
	end,
	get_rank = function()
		return MODULE.GiveRank.number[0]
	end,
	get_square = function()
		local KV = {
			[1] = "À",
			[2] = "Á",
			[3] = "Â",
			[4] = "Ã",
			[5] = "Ä",
			[6] = "Æ",
			[7] = "Ç",
			[8] = "È",
			[9] = "Ê",
			[10] = "Ë",
			[11] = "Ì",
			[12] = "Í",
			[13] = "Î",
			[14] = "Ï",
			[15] = "Ð",
			[16] = "Ñ",
			[17] = "Ò",
			[18] = "Ó",
			[19] = "Ô",
			[20] = "Õ",
			[21] = "Ö",
			[22] = "×",
			[23] = "Ø",
			[24] = "ß",
		}
		local X, Y, Z = getCharCoordinates(playerPed)
		X = math.ceil((X + 3000) / 250)
		Y = math.ceil((Y * - 1 + 3000) / 250)
		Y = KV[Y]
		if Y ~= nil then
			local KVX = (Y.."-"..X)
			return KVX
		else
			return X
		end
	end,
	get_area = function()
		local x,y,z = getCharCoordinates(PLAYER_PED)
		return getAreaRu(x,y,z)
	end,
	get_city = function()
		local city = {
			[0] = "Âíå ãîðîäà",
			[1] = "Ëîñ Ñàíòîñ",
			[2] = "Ñàí Ôèåððî",
			[3] = "Ëàñ Âåíòóðàñ"
		}
		return city[getCityPlayerIsIn(PLAYER_PED)]
	end,
	get_drived_car = function()
		local closest_car = nil
		local closest_distance = 50
		local my_pos = {getCharCoordinates(PLAYER_PED)}
		local my_car
		if isCharInAnyCar(PLAYER_PED) then
			my_car = storeCarCharIsInNoSave(PLAYER_PED)
		end
		for _, vehicle in ipairs(getAllVehicles()) do
			if doesCharExist(getDriverOfCar(vehicle)) and vehicle ~= my_car then
				local vehicle_pos = {getCarCoordinates(vehicle)}
				local distance = getDistanceBetweenCoords3d(my_pos[1], my_pos[2], my_pos[3], vehicle_pos[1], vehicle_pos[2], vehicle_pos[3])
				if distance < closest_distance then
					closest_distance = distance
					closest_car = vehicle
				end
			end
		end
		if closest_car then
			local colorNames = {
				[0] = "÷¸ðíîãî",
				[1] = "áåëîãî",
				[2] = "áèðþçîâîãî",
				[3] = "áîðäîâîãî",
				[4] = "õâîéíîãî",
				[5] = "ïóðïóðíîãî",
				[6] = "æ¸ëòîãî",
				[7] = "ãîëóáîãî",
				[8] = "ñåðîãî",
				[9] = "îëèâêîâîãî",
				[10] = "ñèíåãî",
				[11] = "ñåðîãî",
				[12] = "ãîëóáîãî",
				[13] = "ãðàôèòîâîãî",
				[14] = "ñâåòëîãî",
				[15] = "ñâåòëîãî",
				[16] = "õâîéíîãî",
				[17] = "áîðäîâîãî",
				[18] = "áîðäîâîãî",
				[19] = "ñåðîãî",
				[20] = "ñèíåãî",
				[21] = "áîðäîâîãî",
				[22] = "áîðäîâîãî",
				[23] = "ñåðîãî",
				[24] = "ãðàôèòîâîãî",
				[25] = "ñåðîãî",
				[26] = "ñâåòëîãî",
				[27] = "òóñêëîãî",
				[28] = "ñèíåãî",
				[29] = "ñâåòëîãî",
				[30] = "áîðäîâîãî",
				[31] = "áîðäîâîãî",
				[32] = "ãîëóáîâàòîãî",
				[33] = "ñåðîãî",
				[34] = "òóñêëîãî",
				[35] = "êîðè÷íåâîãî",
				[36] = "ñèíåãî",
				[37] = "õâîéíîãî",
				[38] = "ñåðîãî",
				[39] = "ñèíåãî",
				[40] = "ò¸ìíîãî",
				[41] = "êîðè÷íåâîãî",
				[42] = "êîðè÷íåâîãî",
				[43] = "áîðäîâîãî",
				[44] = "õâîéíîãî",
				[45] = "áîðäîâîãî",
				[46] = "áåæåâîãî",
				[47] = "îëèâêîâîãî",
				[48] = "îëèâêîâîãî",
				[49] = "ñåðîãî",
				[50] = "ñåðåáðèñòîãî",
				[51] = "õâîéíîãî",
				[52] = "ñèíåãî",
				[53] = "ñèíåãî",
				[54] = "ñèíåãî",
				[55] = "êîðè÷íåâîãî",
				[56] = "ãîëóáîãî",
				[57] = "îëèâêîâîãî",
				[58] = "ò¸ìíîêðàñíîãî",
				[59] = "ñèíåãî",
				[60] = "ñâåòëîãî",
				[61] = "îðàíæåâîãî",
				[62] = "ò¸ìíîêðàñíîãî",
				[63] = "ñåðåáðèñòîãî",
				[64] = "ñâåòëîãî",
				[65] = "îëèâêîâîãî",
				[66] = "êîðè÷íåâîãî",
				[67] = "àñôàëüòîâîãî",
				[68] = "îëèâêîâîãî",
				[69] = "êâàðöåâîãî",
				[70] = "ò¸ìíîêðàñíîãî",
				[71] = "ñâåòëîãî",
				[72] = "ò¸ìíîñåðîãî",
				[73] = "îëèâêîâîãî",
				[74] = "áîðäîâîãî",
				[75] = "ñèíåãî",
				[76] = "îëèâêîâîãî",
				[77] = "îðàíæåâîãî",
				[78] = "áîðäîâîãî",
				[79] = "ñèíåãî",
				[80] = "ðîçîâîãî",
				[81] = "îëèâêîâîãî",
				[82] = "ò¸ìíîêðàñíîãî",
				[83] = "áèðþçîâîãî",
				[84] = "êîðè÷íåâîãî",
				[85] = "ðîçîâîãî",
				[86] = "õâîéíîãî",
				[87] = "ñèíåãî",
				[88] = "âèííîãî",
				[89] = "îëèâêîâîãî",
				[90] = "ñâåòëîãî",
				[91] = "ò¸ìíîñèíåãî",
				[92] = "ò¸ìíîñåðîãî",
				[93] = "ãîëóáîâàòîãî",
				[94] = "ñèíåãî",
				[95] = "ñèíåãî",
				[96] = "ñâåòëîãî",
				[97] = "àñôàëüòîâîãî",
				[98] = "ãîëóáîâàòîãî",
				[99] = "êîðè÷íåâîãî",
				[100] = "áðèëëèàíòîâîãî",
				[101] = "êîáàëüòîâîãî",
				[102] = "êîðè÷íåâîãî",
				[103] = "ñèíåãî",
				[104] = "êîðè÷íåâîãî",
				[105] = "ñåðîãî",
				[106] = "ñèíåãî",
				[107] = "îëèâêîâîãî",
				[108] = "áðèëëèàíòîâîãî",
				[109] = "ñåðîãî",
				[110] = "îëèâêîâîãî",
				[111] = "ñåðîãî",
				[112] = "ñåðîãî",
				[113] = "êîðè÷íåâîãî",
				[114] = "çåë¸íîãî",
				[115] = "ò¸ìíîêðàñíîãî",
				[116] = "ñèíåãî",
				[117] = "áîðäîâîãî",
				[118] = "ãîëóáîãî",
				[119] = "êîðè÷íåâîãî",
				[120] = "îëèâêîâîãî",
				[121] = "áîðäîâîãî",
				[122] = "ò¸ìíîñåðîãî",
				[123] = "êîðè÷íåâîãî",
				[124] = "ò¸ìíîêðàñíîãî",
				[125] = "ñèíåãî",
				[126] = "ðîçîâîãî",
				[127] = "÷¸ðíîãî",
				[128] = "çåë¸íîãî",
				[129] = "áîðäîâîãî",
				[130] = "ñèíåãî",
				[131] = "êîðè÷íåâîãî",
				[132] = "ò¸ìíîêðàñíîãî",
				[133] = "÷¸ðíîãî",
				[134] = "ôèîëåòîâîãî",
				[135] = "ÿðêîñèíåãî",
				[136] = "àìåòèñòîâîãî",
				[137] = "çåë¸íîãî",
				[138] = "ñåðîãî",
				[139] = "ïóðïóðíîãî",
				[140] = "ñâåòëîãî",
				[141] = "ò¸ìíîñåðîãî",
				[142] = "îëèâêîâîãî",
				[143] = "ôèîëåòîâîãî",
				[144] = "ôèîëåòîâîãî",
				[145] = "çåë¸íîãî",
				[146] = "ïóðïóðíîãî",
				[147] = "ôèîëåòîâîãî",
				[148] = "îëèâêîâîãî",
				[149] = "ò¸ìíîãî",
				[150] = "ò¸ìíîçåë¸íîãî",
				[151] = "çåëåíîãî",
				[152] = "ñèíåãî",
				[153] = "çåë¸íîãî",
				[154] = "ñàëàòîâîãî",
				[155] = "áèðþçîâîãî",
				[156] = "êîðè÷íåâîãî",
				[157] = "ñâåòëîãî",
				[158] = "îðàíæåâîãî",
				[159] = "êîðè÷íåâîãî",
				[160] = "ò¸ìíîçåë¸íîãî",
				[161] = "âèííîãî",
				[162] = "ñèíåãî",
				[163] = "ãðàôèòîâîãî",
				[164] = "÷¸ðíîãî",
				[165] = "áèðþçîâîãî",
				[166] = "áèðþçîâîãî",
				[167] = "ôèîëåòîâîãî",
				[168] = "áîðäîâîãî",
				[169] = "ôèîëåòîâîãî",
				[170] = "ôèîëåòîâîãî",
				[171] = "ôèîëåòîâîãî",
				[172] = "õâîéíîãî",
				[173] = "êîðè÷íåâîãî",
				[174] = "êîðè÷íåâîãî",
				[175] = "êîðè÷íåâîãî",
				[176] = "ïóðïóðíîãî",
				[177] = "ïóðïóðíîãî",
				[178] = "ïóðïóðíîãî",
				[179] = "ôèîëåòîâîãî",
				[180] = "êîðè÷íåâîãî",
				[181] = "êðàñíîãî",
				[182] = "îðàíæåâîãî",
				[183] = "îëèâêîâîãî",
				[184] = "ãîëóáîãî",
				[185] = "÷¸ðíîãî",
				[186] = "÷¸ðíîãî",
				[187] = "çåë¸íîãî",
				[188] = "çåë¸íîãî",
				[189] = "çåë¸íîãî",
				[190] = "ïóðïóðíîãî",
				[191] = "ñàëàòîâîãî",
				[192] = "ñâåòëîãî",
				[193] = "ñâåòëîãî",
				[194] = "îëèâêîâîãî",
				[195] = "îëèâêîâîãî",
				[196] = "ñåðîãî",
				[197] = "îëèâêîâîãî",
				[198] = "ñèíåãî",
				[199] = "îëèâêîâîãî",
				[200] = "ñòðàííîãî",
				[201] = "ñèíåãî",
				[202] = "çåë¸íîãî",
				[203] = "ñèíåãî",
				[204] = "ãîëóáîãî",
				[205] = "ñèíåãî",
				[206] = "ò¸ìíîñèíåãî",
				[207] = "ãîëóáîãî",
				[208] = "ñèíåãî",
				[209] = "ñèíåãî",
				[210] = "ñèíåãî",
				[211] = "ôèîëåòîâîãî",
				[212] = "îðàíæåâîãî",
				[213] = "ñâåòëîãî",
				[214] = "îëèâêîâîãî",
				[215] = "÷¸ðíîãî",
				[216] = "îðàíæåâîãî",
				[217] = "áèðþçîâîãî",
				[218] = "áëåäíî-ðîçîâîãî",
				[219] = "îðàíæåâîãî",
				[220] = "ðîçîâîãî",
				[221] = "îëèâêîâîãî",
				[222] = "îðàíæåâîãî",
				[223] = "ñèíåãî",
				[224] = "áîðäîâîãî",
				[225] = "õâîéíîãî",
				[226] = "ñàëàòîâîãî",
				[227] = "çåë¸íîãî",
				[228] = "áëåäíîãî",
				[229] = "ñàëàòîâîãî",
				[230] = "áîðäîâîãî",
				[231] = "êîðè÷íåâîãî",
				[232] = "ðîçîâîãî",
				[233] = "ïóðïóðíîãî",
				[234] = "ò¸ìíîçåë¸íîãî",
				[235] = "îëèâêîâîãî",
				[236] = "õâîéíîãî",
				[237] = "ïóðïóðíîãî",
				[238] = "îðàíæåâîãî",
				[239] = "êîðè÷íåâîãî",
				[240] = "ãîëóáîãî",
				[241] = "çåëåíîãî",
				[242] = "ôèîëåòîâîãî",
				[243] = "çåë¸íîãî",
				[244] = "êîðè÷íåâîãî",
				[245] = "õâîéíîãî",
				[246] = "ãîëóáîãî",
				[247] = "ñèíåãî",
				[248] = "áîðäîâîãî",
				[249] = "áîðäîâîãî",
				[250] = "ñåðîãî",
				[251] = "ñåðîãî",
				[252] = "÷¸ðíîãî",
				[253] = "ñåðîãî",
				[254] = "êîðè÷íåâîãî",
				[255] = "ñèíåãî"
			}
			local clr1, clr2 = getCarColours(closest_car)
			local CarColorName = " " .. colorNames[clr1] .. " öâåòà"
			local function getVehPlateNumberByCarHandle(car)
				for i, plate in pairs(modules.arz_veh.cache) do
					result, veh = sampGetCarHandleBySampVehicleId(plate.carID)
					if result and veh == car then
						return ' c íîìåðàìè ' .. plate.number
					end
				end
				return ''
			end
			return (getNameOfARZVehicleModel(getCarModel(closest_car)) .. CarColorName .. getVehPlateNumberByCarHandle(closest_car))
		else
			--sampAddChatMessage("[Rodina Helper] {ffffff}Íå óäàëîñü ïîëó÷èòü ìîäåëü áëèæàéøåãî ò/c ñ âîäèòåëåì!", 0x009EFF)
			return 'òðàíñïîðòíîãî ñðåäñòâà'
		end
	end,
	get_nearest_car = function()
		local closest_car = nil
		local closest_distance = 50
		local my_pos = {getCharCoordinates(PLAYER_PED)}
		local my_car
		if isCharInAnyCar(PLAYER_PED) then
			my_car = storeCarCharIsInNoSave(PLAYER_PED)
		end
		for _, vehicle in ipairs(getAllVehicles()) do
			if vehicle ~= my_car then
				local vehicle_pos = {getCarCoordinates(vehicle)}
				local distance = getDistanceBetweenCoords3d(my_pos[1], my_pos[2], my_pos[3], vehicle_pos[1], vehicle_pos[2], vehicle_pos[3])
				if distance < closest_distance then
					closest_distance = distance
					closest_car = vehicle
				end
			end
		end
		if closest_car then
			local colorNames = {
				[0] = "÷¸ðíîãî",
				[1] = "áåëîãî",
				[2] = "áèðþçîâîãî",
				[3] = "áîðäîâîãî",
				[4] = "õâîéíîãî",
				[5] = "ïóðïóðíîãî",
				[6] = "æ¸ëòîãî",
				[7] = "ãîëóáîãî",
				[8] = "ñåðîãî",
				[9] = "îëèâêîâîãî",
				[10] = "ñèíåãî",
				[11] = "ñåðîãî",
				[12] = "ãîëóáîãî",
				[13] = "ãðàôèòîâîãî",
				[14] = "ñâåòëîãî",
				[15] = "ñâåòëîãî",
				[16] = "õâîéíîãî",
				[17] = "áîðäîâîãî",
				[18] = "áîðäîâîãî",
				[19] = "ñåðîãî",
				[20] = "ñèíåãî",
				[21] = "áîðäîâîãî",
				[22] = "áîðäîâîãî",
				[23] = "ñåðîãî",
				[24] = "ãðàôèòîâîãî",
				[25] = "ñåðîãî",
				[26] = "ñâåòëîãî",
				[27] = "òóñêëîãî",
				[28] = "ñèíåãî",
				[29] = "ñâåòëîãî",
				[30] = "áîðäîâîãî",
				[31] = "áîðäîâîãî",
				[32] = "ãîëóáîâàòîãî",
				[33] = "ñåðîãî",
				[34] = "òóñêëîãî",
				[35] = "êîðè÷íåâîãî",
				[36] = "ñèíåãî",
				[37] = "õâîéíîãî",
				[38] = "ñåðîãî",
				[39] = "ñèíåãî",
				[40] = "ò¸ìíîãî",
				[41] = "êîðè÷íåâîãî",
				[42] = "êîðè÷íåâîãî",
				[43] = "áîðäîâîãî",
				[44] = "õâîéíîãî",
				[45] = "áîðäîâîãî",
				[46] = "áåæåâîãî",
				[47] = "îëèâêîâîãî",
				[48] = "îëèâêîâîãî",
				[49] = "ñåðîãî",
				[50] = "ñåðåáðèñòîãî",
				[51] = "õâîéíîãî",
				[52] = "ñèíåãî",
				[53] = "ñèíåãî",
				[54] = "ñèíåãî",
				[55] = "êîðè÷íåâîãî",
				[56] = "ãîëóáîãî",
				[57] = "îëèâêîâîãî",
				[58] = "ò¸ìíîêðàñíîãî",
				[59] = "ñèíåãî",
				[60] = "ñâåòëîãî",
				[61] = "îðàíæåâîãî",
				[62] = "ò¸ìíîêðàñíîãî",
				[63] = "ñåðåáðèñòîãî",
				[64] = "ñâåòëîãî",
				[65] = "îëèâêîâîãî",
				[66] = "êîðè÷íåâîãî",
				[67] = "àñôàëüòîâîãî",
				[68] = "îëèâêîâîãî",
				[69] = "êâàðöåâîãî",
				[70] = "ò¸ìíîêðàñíîãî",
				[71] = "ñâåòëîãî",
				[72] = "ò¸ìíîñåðîãî",
				[73] = "îëèâêîâîãî",
				[74] = "áîðäîâîãî",
				[75] = "ñèíåãî",
				[76] = "îëèâêîâîãî",
				[77] = "îðàíæåâîãî",
				[78] = "áîðäîâîãî",
				[79] = "ñèíåãî",
				[80] = "ðîçîâîãî",
				[81] = "îëèâêîâîãî",
				[82] = "ò¸ìíîêðàñíîãî",
				[83] = "áèðþçîâîãî",
				[84] = "êîðè÷íåâîãî",
				[85] = "ðîçîâîãî",
				[86] = "õâîéíîãî",
				[87] = "ñèíåãî",
				[88] = "âèííîãî",
				[89] = "îëèâêîâîãî",
				[90] = "ñâåòëîãî",
				[91] = "ò¸ìíîñèíåãî",
				[92] = "ò¸ìíîñåðîãî",
				[93] = "ãîëóáîâàòîãî",
				[94] = "ñèíåãî",
				[95] = "ñèíåãî",
				[96] = "ñâåòëîãî",
				[97] = "àñôàëüòîâîãî",
				[98] = "ãîëóáîâàòîãî",
				[99] = "êîðè÷íåâîãî",
				[100] = "áðèëëèàíòîâîãî",
				[101] = "êîáàëüòîâîãî",
				[102] = "êîðè÷íåâîãî",
				[103] = "ñèíåãî",
				[104] = "êîðè÷íåâîãî",
				[105] = "ñåðîãî",
				[106] = "ñèíåãî",
				[107] = "îëèâêîâîãî",
				[108] = "áðèëëèàíòîâîãî",
				[109] = "ñåðîãî",
				[110] = "îëèâêîâîãî",
				[111] = "ñåðîãî",
				[112] = "ñåðîãî",
				[113] = "êîðè÷íåâîãî",
				[114] = "çåë¸íîãî",
				[115] = "ò¸ìíîêðàñíîãî",
				[116] = "ñèíåãî",
				[117] = "áîðäîâîãî",
				[118] = "ãîëóáîãî",
				[119] = "êîðè÷íåâîãî",
				[120] = "îëèâêîâîãî",
				[121] = "áîðäîâîãî",
				[122] = "ò¸ìíîñåðîãî",
				[123] = "êîðè÷íåâîãî",
				[124] = "ò¸ìíîêðàñíîãî",
				[125] = "ñèíåãî",
				[126] = "ðîçîâîãî",
				[127] = "÷¸ðíîãî",
				[128] = "çåë¸íîãî",
				[129] = "áîðäîâîãî",
				[130] = "ñèíåãî",
				[131] = "êîðè÷íåâîãî",
				[132] = "ò¸ìíîêðàñíîãî",
				[133] = "÷¸ðíîãî",
				[134] = "ôèîëåòîâîãî",
				[135] = "ÿðêîñèíåãî",
				[136] = "àìåòèñòîâîãî",
				[137] = "çåë¸íîãî",
				[138] = "ñåðîãî",
				[139] = "ïóðïóðíîãî",
				[140] = "ñâåòëîãî",
				[141] = "ò¸ìíîñåðîãî",
				[142] = "îëèâêîâîãî",
				[143] = "ôèîëåòîâîãî",
				[144] = "ôèîëåòîâîãî",
				[145] = "çåë¸íîãî",
				[146] = "ïóðïóðíîãî",
				[147] = "ôèîëåòîâîãî",
				[148] = "îëèâêîâîãî",
				[149] = "ò¸ìíîãî",
				[150] = "ò¸ìíîçåë¸íîãî",
				[151] = "çåëåíîãî",
				[152] = "ñèíåãî",
				[153] = "çåë¸íîãî",
				[154] = "ñàëàòîâîãî",
				[155] = "áèðþçîâîãî",
				[156] = "êîðè÷íåâîãî",
				[157] = "ñâåòëîãî",
				[158] = "îðàíæåâîãî",
				[159] = "êîðè÷íåâîãî",
				[160] = "ò¸ìíîçåë¸íîãî",
				[161] = "âèííîãî",
				[162] = "ñèíåãî",
				[163] = "ãðàôèòîâîãî",
				[164] = "÷¸ðíîãî",
				[165] = "áèðþçîâîãî",
				[166] = "áèðþçîâîãî",
				[167] = "ôèîëåòîâîãî",
				[168] = "áîðäîâîãî",
				[169] = "ôèîëåòîâîãî",
				[170] = "ôèîëåòîâîãî",
				[171] = "ôèîëåòîâîãî",
				[172] = "õâîéíîãî",
				[173] = "êîðè÷íåâîãî",
				[174] = "êîðè÷íåâîãî",
				[175] = "êîðè÷íåâîãî",
				[176] = "ïóðïóðíîãî",
				[177] = "ïóðïóðíîãî",
				[178] = "ïóðïóðíîãî",
				[179] = "ôèîëåòîâîãî",
				[180] = "êîðè÷íåâîãî",
				[181] = "êðàñíîãî",
				[182] = "îðàíæåâîãî",
				[183] = "îëèâêîâîãî",
				[184] = "ãîëóáîãî",
				[185] = "÷¸ðíîãî",
				[186] = "÷¸ðíîãî",
				[187] = "çåë¸íîãî",
				[188] = "çåë¸íîãî",
				[189] = "çåë¸íîãî",
				[190] = "ïóðïóðíîãî",
				[191] = "ñàëàòîâîãî",
				[192] = "ñâåòëîãî",
				[193] = "ñâåòëîãî",
				[194] = "îëèâêîâîãî",
				[195] = "îëèâêîâîãî",
				[196] = "ñåðîãî",
				[197] = "îëèâêîâîãî",
				[198] = "ñèíåãî",
				[199] = "îëèâêîâîãî",
				[200] = "ñòðàííîãî",
				[201] = "ñèíåãî",
				[202] = "çåë¸íîãî",
				[203] = "ñèíåãî",
				[204] = "ãîëóáîãî",
				[205] = "ñèíåãî",
				[206] = "ò¸ìíîñèíåãî",
				[207] = "ãîëóáîãî",
				[208] = "ñèíåãî",
				[209] = "ñèíåãî",
				[210] = "ñèíåãî",
				[211] = "ôèîëåòîâîãî",
				[212] = "îðàíæåâîãî",
				[213] = "ñâåòëîãî",
				[214] = "îëèâêîâîãî",
				[215] = "÷¸ðíîãî",
				[216] = "îðàíæåâîãî",
				[217] = "áèðþçîâîãî",
				[218] = "áëåäíî-ðîçîâîãî",
				[219] = "îðàíæåâîãî",
				[220] = "ðîçîâîãî",
				[221] = "îëèâêîâîãî",
				[222] = "îðàíæåâîãî",
				[223] = "ñèíåãî",
				[224] = "áîðäîâîãî",
				[225] = "õâîéíîãî",
				[226] = "ñàëàòîâîãî",
				[227] = "çåë¸íîãî",
				[228] = "áëåäíîãî",
				[229] = "ñàëàòîâîãî",
				[230] = "áîðäîâîãî",
				[231] = "êîðè÷íåâîãî",
				[232] = "ðîçîâîãî",
				[233] = "ïóðïóðíîãî",
				[234] = "ò¸ìíîçåë¸íîãî",
				[235] = "îëèâêîâîãî",
				[236] = "õâîéíîãî",
				[237] = "ïóðïóðíîãî",
				[238] = "îðàíæåâîãî",
				[239] = "êîðè÷íåâîãî",
				[240] = "ãîëóáîãî",
				[241] = "çåëåíîãî",
				[242] = "ôèîëåòîâîãî",
				[243] = "çåë¸íîãî",
				[244] = "êîðè÷íåâîãî",
				[245] = "õâîéíîãî",
				[246] = "ãîëóáîãî",
				[247] = "ñèíåãî",
				[248] = "áîðäîâîãî",
				[249] = "áîðäîâîãî",
				[250] = "ñåðîãî",
				[251] = "ñåðîãî",
				[252] = "÷¸ðíîãî",
				[253] = "ñåðîãî",
				[254] = "êîðè÷íåâîãî",
				[255] = "ñèíåãî"
			}
			local clr1, clr2 = getCarColours(closest_car)
			local CarColorName = " " .. colorNames[clr1] .. " öâåòà"
			local function getVehPlateNumberByCarHandle(car)
				for i, plate in pairs(modules.arz_veh.cache) do
					result, veh = sampGetCarHandleBySampVehicleId(plate.carID)
					if result and veh == car then
						return ' c íîìåðàìè ' .. plate.number
					end
				end
				return ''
			end
			return (getNameOfARZVehicleModel(getCarModel(closest_car)) .. CarColorName .. getVehPlateNumberByCarHandle(closest_car))
		else
			return 'òðàíñïîðòíîãî ñðåäñòâà'
		end
	end,
	get_form_su = function()
		return MODULE.SumMenu.form_su
	end,
	get_patrool_format_time = function()
		local hours = math.floor(MODULE.Patrool.time / 3600)
		local minutes = math.floor((MODULE.Patrool.time % 3600) / 60)
		local secs = MODULE.Patrool.time % 60
		if hours > 0 then
			return string.format("%d ÷àñîâ %d ìèíóò %d ñåêóíä", hours, minutes, secs)
		elseif minutes > 0 then
			return string.format("%d ìèíóò %d ñåêóíä", minutes, secs)
		else
			return string.format("%d ñåêóíä(-û)", secs)
		end
	end,
	get_patrool_time = function()
		local hours = math.floor(MODULE.Patrool.time / 3600)
		local minutes = math.floor(( MODULE.Patrool.time % 3600) / 60)
		local secs = MODULE.Patrool.time % 60
		if hours > 0 then
			return string.format("%02d:%02d:%02d", hours, minutes, secs)
		else
			return string.format("%02d:%02d", minutes, secs)
		end
	end,
	get_patrool_code = function()
		return MODULE.Patrool.code
	end,
	get_patrool_mark = function()
		return MODULE.Patrool.mark .. '-' .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
	end,
	get_post_format_time = function()
		local hours = math.floor(MODULE.Post.time / 3600)
		local minutes = math.floor((MODULE.Post.time % 3600) / 60)
		local secs = MODULE.Post.time % 60
		if hours > 0 then
			return string.format("%d ÷àñîâ %d ìèíóò %d ñåêóíä", hours, minutes, secs)
		elseif minutes > 0 then
			return string.format("%d ìèíóò %d ñåêóíä", minutes, secs)
		else
			return string.format("%d ñåêóíä(-û)", secs)
		end
	end,
	get_post_time = function()
		local hours = math.floor(MODULE.Post.time / 3600)
		local minutes = math.floor(( MODULE.Post.time % 3600) / 60)
		local secs = MODULE.Post.time % 60
		if hours > 0 then
			return string.format("%02d:%02d:%02d", hours, minutes, secs)
		else
			return string.format("%02d:%02d", minutes, secs)
		end
	end,
	get_post_code = function()
		return MODULE.Post.code
	end,
	get_post_name = function()
		return MODULE.Post.name
	end,
	get_car_units = function()
		if isCharInAnyCar(PLAYER_PED) then
			local car = storeCarCharIsInNoSave(PLAYER_PED)
			local success, passengers = getNumberOfPassengers(car)
			if isMonetLoader() and success and passengers == nil then
				passengers = success
			end
			if success and passengers and tonumber(passengers) > 0 then
				local my_passengers = {}
				for k, v in ipairs(getAllChars()) do
					local res, id = sampGetPlayerIdByCharHandle(v)
					if res and id ~= select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
						if isCharInAnyCar(v) then
							if car == storeCarCharIsInNoSave(v) then
								table.insert(my_passengers, id)
							end
						end
					end
				end
				if #my_passengers ~= 0 then
					local units = ''
					for k, idd in ipairs(my_passengers) do
						local nickname = sampGetPlayerNickname(idd)
						local first_letter = nickname:sub(1, 1)
						local last_name = nickname:match(".*_(.*)")
						if last_name then
							units = units .. first_letter .. "." .. last_name .. ' '
						else
							units = units .. nickname .. ' '
						end
					end
					return units
				else
					--sampAddChatMessage('[Rodina Helper] Â âàøåì àâòî íåòó âàøèõ íàïàðíèêîâ!', -1)
					return 'Íåòó'
				end
			else
				return 'Íåòó'
			end
		else
			--sampAddChatMessage('[Rodina Helper] Âû íå íàõîäèòåñü â àâòî, íåâîçìîæíî ïîëó÷èòü âàøèõ íàïàðíèêîâ!', -1)
			return 'Íåòó'
		end
	end,
	switchCarSiren = function()
		if isCharInAnyCar(PLAYER_PED) then
			local car = storeCarCharIsInNoSave(PLAYER_PED)
			if getDriverOfCar(car) == PLAYER_PED then
				switchCarSiren(car, not isCarSirenOn(car))
				return '/me ' .. (isCarSirenOn(car) and 'âêëþ÷àåò' or 'âûêëþ÷àåò') .. ' ìèãàëêè â ñâî¸ì òðàíñïîðòíîì ñðåäñòâå'
			else
				--sampAddChatMessage('[Rodina Helper] {ffffff}Âû íå çà ðóë¸ì!', 0x009EFF)
				return (isCarSirenOn(car) and 'Âûêëþ÷è' or 'Âðóáàé') .. ' ìèãàëêè!'
			end
		else
			--sampAddChatMessage('[Rodina Helper] {ffffff}Âû íå â àâòîìîáèëå!', 0x009EFF)
			return "Êõì"
		end
	end,
	-- LC
	get_price_avto1 = function() return settings.lc.price.avto1 end,
	get_price_avto2 = function() return settings.lc.price.avto2 end,
	get_price_avto3 = function() return settings.lc.price.avto3 end,
	get_price_moto1 = function() return settings.lc.price.moto1 end,
	get_price_moto2 = function() return settings.lc.price.moto2 end,
	get_price_moto3 = function() return settings.lc.price.moto3 end,
	get_price_fish1 = function() return settings.lc.price.fish1 end,
	get_price_fish2 = function() return settings.lc.price.fish2 end,
	get_price_fish3 = function() return settings.lc.price.fish3 end,
	get_price_swim1 = function() return settings.lc.price.swim1 end,
	get_price_swim2 = function() return settings.lc.price.swim2 end,
	get_price_swim3 = function() return settings.lc.price.swim3 end,
	get_price_gun1 = function() return settings.lc.price.gun1 end,
	get_price_gun2 = function() return settings.lc.price.gun2 end,
	get_price_gun3 = function() return settings.lc.price.gun3 end,
	get_price_hunt1 = function() return settings.lc.price.hunt1 end,
	get_price_hunt2 = function() return settings.lc.price.hunt2 end,
	get_price_hunt3 = function() return settings.lc.price.hunt3 end,
	get_price_klad1 = function() return settings.lc.price.klad1 end,
	get_price_klad2 = function() return settings.lc.price.klad2 end,
	get_price_klad3 = function() return settings.lc.price.klad3 end,
	get_price_taxi1 = function() return settings.lc.price.taxi1 end,
	get_price_taxi2 = function() return settings.lc.price.taxi2 end,
	get_price_taxi3 = function() return settings.lc.price.taxi3 end,
	get_price_mexa1 = function() return settings.lc.price.mexa1 end,
	get_price_mexa2 = function() return settings.lc.price.mexa2 end,
	get_price_mexa3 = function() return settings.lc.price.mexa3 end,
	get_price_fly1 = function() return settings.lc.price.fly1 end,
	get_price_fly2 = function() return settings.lc.price.fly2 end,
	get_price_fly3 = function() return settings.lc.price.fly3 end,
	-- MH
	get_price_heal = function()
		if sampGetCurrentServerName():find("Vice City") then
			return settings.mh.price.heal_vc
		else
			return settings.mh.price.heal
		end
	end,
	get_price_actorheal = function()
		if u8(sampGetCurrentServerName()):find("Vice City") then
			return settings.mh.price.healactor_vc
		else
			return settings.mh.price.healactor
		end
	end,
	get_price_medosm = function() return settings.mh.price.medosm end,
	get_price_mticket = function() return settings.mh.price.mticket end,
	get_price_head = function() return settings.mh.price.head end,	
	get_price_ant = function() return settings.mh.price.ant end,
	get_price_recept = function() return settings.mh.price.recept end,
	get_price_med7 = function() return settings.mh.price.med7 end,
	get_price_med14 = function() return settings.mh.price.med14 end,
	get_price_med30 = function() return settings.mh.price.med30 end,
	get_price_med60 = function() return settings.mh.price.med60 end,	
	get_medcard_days = function() 
		return MODULE.MedCard.days[0]
	end,
	get_medcard_status = function() 
		return MODULE.MedCard.status[0]
	end,
	get_recepts = function()
		return MODULE.Recept.recepts[0]
	end,
	get_ants = function()
		return MODULE.Antibiotik.ants[0]
	end,
	get_medcard_price = function()
		if MODULE.MedCard.days[0] == 0 then
			return settings.mh.price.med7
		elseif MODULE.MedCard.days[0] == 1 then
			return settings.mh.price.med14
		elseif MODULE.MedCard.days[0] == 2 then
			return settings.mh.price.med30
		elseif MODULE.MedCard.days[0] == 3 then
			return settings.mh.price.med60
		elseif MODULE.MedCard.days[0] == 3 then	
		else
			return 1000
		end
	end,
}
-- âðåìåííî, ïîçæå âîîáùå ñèñòåìó òåãîâ ïîìåíÿþ
local binder_tags_text = [[
{my_id} - Âàø ID
{my_nick} - Âàø Íèêíåéì 
{my_rp_nick} - Âàø Íèêíåéì áåç _
{my_ru_nick} - Âàøå Èìÿ è Ôàìèëèÿ
{my_doklad_nick} - Ïåðâàÿ áóêâà âàøåãî èìåíè è ôàìèëèÿ

{fraction} - Âàøà ôðàêöèÿ
{fraction_rank} - Âàøà ôðàêöèîííàÿ äîëæíîñòü
{fraction_tag} - Òåã âàøåé ôðàêöèè

{sex} - Äîáàâëÿåò áóêâó "à" åñëè â õåëïåðå óêàçàí æåíñêèé ïîë

{get_time} - Ïîëó÷èòü òåêóùåå âðåìÿ
{get_city} - Ïîëó÷èòü òåêóùèé ãîðîä
{get_square} - Ïîëó÷èòü òåêóùèé êâàäðàò
{get_area} - Ïîëó÷èòü òåêóùèé ðàéîí
{get_nearest_car} - Ïîëó÷èòü ìîäåëü áëèæàéøåãî ê âàì àâòî
{get_drived_car} - Ïîëó÷èòü ìîäåëü áëèæàéøåãî ê âàì àâòî ñ âîäèòåëåì

{get_nick({arg_id})} - ïîëó÷èòü Íèêíåéì èç àðãóìåíòà ID èãðîêà
{get_rp_nick({arg_id})} - ïîëó÷èòü Íèêíåéì áåç ñèìâîëà _ èç àðãóìåíòà ID èãðîêà
{get_ru_nick({arg_id})} - ïîëó÷èòü Íèêíåéì íà êèðèëèöå èç àðãóìåíòà ID èãðîêà 

{get_price_heal} - Öåíà ëå÷åíèÿ ïàöèåíòîâ
{get_price_head} - Öåíà ëå÷åíèÿ îò íàðêîçàâèñèìîñòè
{get_price_actorheal} - Öåíà ëå÷åíèÿ îõðàííèêîâ
{get_price_medosm} - Öåíà ìåä.îñìîòðà äëÿ ïèëîòà
{get_price_mticket} - Öåíà îáñëåäîâàíèÿ âîåííîãî áèëåòà
{get_price_ant} - Öåíà àíòèáèîòèêà   
{get_price_recept} - Öåíà ðåöåïòà
{get_price_med7} - Öåíà ìåäêêàðòû íà 7 äíåé   
{get_price_med14} - Öåíà ìåäêêàðòû íà 14 äíåé
{get_price_med30} - Öåíà ìåäêêàðòû íà 30 äíåé   
{get_price_med60} - Öåíà ìåäêêàðòû íà 60 äíåé

{show_medcard_menu} - Îòêðûòü ìåíþ ìåä.êàðòû
{get_medcard_days} - Ïîëó÷èòü íîìåð âûáðàííîãî êîë-âà äíåé
{get_medcard_status} - Ïîëó÷èòü íîìåð âûáðàííîãî ñòàòóñà
{get_medcard_price} - Ïîëó÷èòü öåíó ìåä.êàðòû èñõîäÿ èç äíåé
{show_recept_menu} - Îòêðûòü ìåíþ âûäà÷è ðåöåïòîâ
{get_recepts} - Ïîëó÷èòü êîë-âî âûáðàííûõ ðåöåïòîâ
{show_ant_menu} - Îòêðûòü ìåíþ âûäà÷è àíòèáèîòèêîâ 
{get_ants} - Ïîëó÷èòü êîë-âî âûáðàííûõ àíòèáèîòèêîâ
{lmenu_vc_vize} - Àâòî-âûäà÷à âèçû Vice City
{give_platoon} - Íàçíà÷èòü âçâîä èãðîêó
{show_rank_menu} - Îòêðûòü ìåíþ âûäà÷è ðàíãîâ
{get_rank} - Ïîëó÷èòü âûáðàííûé ðàíã

{pause} - Ïîñòàâèòü îòûãðîâêó êîìàíäû íà ïàóçó è îæèäàòü äåéñòâèÿ
]]
----------------------------------------- MoonMonet & Colors -------------------------------------
function rgbToHex(rgb)
	local r = bit.band(bit.rshift(rgb, 16), 0xFF)
	local g = bit.band(bit.rshift(rgb, 8), 0xFF)
	local b = bit.band(rgb, 0xFF)
	local hex = string.format("%02X%02X%02X", r, g, b)
	return hex
end
function color_to_float3(u32color)
    local temp = imgui.ColorConvertU32ToFloat4(u32color)
    return temp.z, temp.y, temp.x
end
if settings.general.helper_theme == 0 and monet_no_errors then
	message_color = settings.general.moonmonet_theme_color
	message_color_hex = '{' ..  rgbToHex(settings.general.moonmonet_theme_color) .. '}'
	MODULE.Main.msgcolor[0], MODULE.Main.msgcolor[1], MODULE.Main.msgcolor[2] = color_to_float3(settings.general.moonmonet_theme_color)
	MODULE.Main.mmcolor[0], MODULE.Main.mmcolor[1], MODULE.Main.mmcolor[2] = color_to_float3(settings.general.moonmonet_theme_color)
else
	print('Áèáëèîòåêà MoonMonet îòñóñòâóåò! Ñòàâëþ Dark Theme ïî äåôîëòó')
	message_color = settings.general.message_color
	message_color_hex = '{' ..  rgbToHex(settings.general.message_color) .. '}'
	MODULE.Main.msgcolor[0], MODULE.Main.msgcolor[1], MODULE.Main.msgcolor[2] = color_to_float3(settings.general.message_color)
	settings.general.helper_theme = 1
	MODULE.Main.theme[0] = 1
	save_settings()
end
------------------------------------------- Mimgui PieMenu ---------------------------------------
if ((not pie_no_errors) and (not isMonetLoader())) then 
	local path = getWorkingDirectory():gsub('\\','/') .. "/lib/mimgui_piemenu.lua"
	if not doesFileExist(path) then
		local file, errstr = io.open(getWorkingDirectory():gsub('\\','/') .. "/lib/mimgui_piemenu.lua", 'w')
		if file then
			file:write([[		
local imgui = require 'mimgui'
local ImVec2 = imgui.ImVec2
local ImVec4 = imgui.ImVec4

local function ImRectAdd(rect, rhs)
local Min, Max = rect.Min, rect.Max
if Min.x > rhs.x then Min.x = rhs.x end
if Min.y > rhs.y then Min.y = rhs.y end
if Max.x < rhs.x then Max.x = rhs.x end
if Max.y < rhs.y then Max.y = rhs.y end
end

local function NewPieMenu(context)
	local obj = {
		m_iCurrentIndex = 0,
		m_fMaxItemSqrDiameter = 0,
		m_fLastMaxItemSqrDiameter = 0,
		m_iHoveredItem = 0,
		m_iLastHoveredItem = 0,
		m_iClickedItem = 0,
		m_oItemIsSubMenu = {}, -- [c_iMaxPieItemCount]
		m_oItemNames = {}, -- [c_iMaxPieItemCount]
		m_oItemSizes = {}, -- [c_iMaxPieItemCount]
	}
	return obj
end

local function NewPieMenuContext(MaxPieMenuStack, MaxPieItemCount, RadiusEmpty, RadiusMin, MinItemCount, MinItemCountPerLevel)
	local obj = {
		c_iMaxPieMenuStack = MaxPieMenuStack or 8,
		c_iMaxPieItemCount = MaxPieItemCount or 12,
		c_iRadiusEmpty = RadiusEmpty or 30,
		c_iRadiusMin = RadiusMin or 30,
		c_iMinItemCount = MinItemCount or 3,
		c_iMinItemCountPerLevel = MinItemCountPerLevel or 3,

		m_oPieMenuStack = {},
		m_iCurrentIndex = -1,
		m_iLastFrame = 0,
		m_iMaxIndex = 0,
		m_oCenter = ImVec2(0, 0),
		m_iMouseButton = 0,
		m_bClose = false,
	}
	for i = 0, obj.c_iMaxPieMenuStack - 1 do
		obj.m_oPieMenuStack[i] = NewPieMenu(obj)
	end
	return obj
end

local function BeginPieMenuEx(menuCtx)
	assert(menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieMenuStack)
	menuCtx.m_iCurrentIndex = menuCtx.m_iCurrentIndex + 1
	menuCtx.m_iMaxIndex = menuCtx.m_iMaxIndex + 1
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	oPieMenu.m_iCurrentIndex = 0
	oPieMenu.m_fMaxItemSqrDiameter = 0
	if not imgui.IsMouseReleased( menuCtx.m_iMouseButton ) then
		oPieMenu.m_iHoveredItem = -1
	end
	if menuCtx.m_iCurrentIndex > 0 then
		oPieMenu.m_fMaxItemSqrDiameter = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex - 1].m_fMaxItemSqrDiameter
	end
	end

	local function EndPieMenuEx(menuCtx)
	assert(menuCtx.m_iCurrentIndex >= 0)
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	menuCtx.m_iCurrentIndex = menuCtx.m_iCurrentIndex - 1
	end

	local function BeginPiePopup(menuCtx, pName, iMouseButton)
	iMouseButton = iMouseButton or 0
	if imgui.IsPopupOpen(pName) then
		imgui.PushStyleColor(imgui.Col.WindowBg, ImVec4(0, 0, 0, 0))
		imgui.PushStyleColor(imgui.Col.Border, ImVec4(0, 0, 0, 0))
		imgui.PushStyleVarFloat(imgui.StyleVar.WindowRounding, 0.0)
		imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, 1.0)
		menuCtx.m_iMouseButton = iMouseButton
		menuCtx.m_bClose = false
		imgui.SetNextWindowPos( ImVec2( -100, -100 ), imgui.Cond.Appearing )
		imgui.SetNextWindowSize(ImVec2(0, 0), imgui.Cond.Always)
		local bOpened = imgui.BeginPopup(pName)
		if bOpened then
			local iCurrentFrame = imgui.GetFrameCount()
			if menuCtx.m_iLastFrame < (iCurrentFrame - 1) then
				menuCtx.m_oCenter = ImVec2(imgui.GetIO().MousePos)
			end
			menuCtx.m_iLastFrame = iCurrentFrame
			menuCtx.m_iMaxIndex = -1
			BeginPieMenuEx(menuCtx)
			return true
		else
			imgui.End()
			imgui.PopStyleColor(2)
			imgui.PopStyleVar(2)
		end
	end
	return false
end

local function EndPiePopup(menuCtx)
	EndPieMenuEx(menuCtx)
	local oStyle = imgui.GetStyle()
	local pDrawList = imgui.GetWindowDrawList()
	pDrawList:PushClipRectFullScreen()
	local oMousePos = imgui.GetIO().MousePos
	local oDragDelta = ImVec2(oMousePos.x - menuCtx.m_oCenter.x, oMousePos.y - menuCtx.m_oCenter.y)
	local fDragDistSqr = oDragDelta.x*oDragDelta.x + oDragDelta.y*oDragDelta.y
	local fCurrentRadius = menuCtx.c_iRadiusEmpty
	-- ImRect
	local oArea = {Min = ImVec2(menuCtx.m_oCenter), Max = ImVec2(menuCtx.m_oCenter)}
	local bItemHovered = false
	local c_fDefaultRotate = -math.pi / 2
	local fLastRotate = c_fDefaultRotate
	for iIndex = 0, menuCtx.m_iMaxIndex do
		local oPieMenu = menuCtx.m_oPieMenuStack[iIndex]
		local fMenuHeight = math.sqrt(oPieMenu.m_fMaxItemSqrDiameter)
		local fMinRadius = fCurrentRadius
		local fMaxRadius = fMinRadius + (fMenuHeight * oPieMenu.m_iCurrentIndex) / 2
		local item_arc_span = 2 * math.pi / math.max(menuCtx.c_iMinItemCount + menuCtx.c_iMinItemCountPerLevel * iIndex, oPieMenu.m_iCurrentIndex)
		local drag_angle = math.atan2(oDragDelta.y, oDragDelta.x)
		local fRotate = fLastRotate - item_arc_span * ( oPieMenu.m_iCurrentIndex - 1 ) / 2
		local item_hovered = -1
		for item_n = 0, oPieMenu.m_iCurrentIndex - 1 do
			local item_label = oPieMenu.m_oItemNames[ item_n ]
			local inner_spacing = oStyle.ItemInnerSpacing.x / fMinRadius / 2
			local fMinInnerSpacing = oStyle.ItemInnerSpacing.x / ( fMinRadius * 2 )
			local fMaxInnerSpacing = oStyle.ItemInnerSpacing.x / ( fMaxRadius * 2 )
			local item_inner_ang_min = item_arc_span * ( item_n - 0.5 + fMinInnerSpacing ) + fRotate
			local item_inner_ang_max = item_arc_span * ( item_n + 0.5 - fMinInnerSpacing ) + fRotate
			local item_outer_ang_min = item_arc_span * ( item_n - 0.5 + fMaxInnerSpacing ) + fRotate
			local item_outer_ang_max = item_arc_span * ( item_n + 0.5 - fMaxInnerSpacing ) + fRotate
			local hovered = false
			if fDragDistSqr >= fMinRadius * fMinRadius and fDragDistSqr < fMaxRadius * fMaxRadius  then
				while (drag_angle - item_inner_ang_min) < 0 do
					drag_angle = drag_angle + (2 * math.pi)
				end
				while (drag_angle - item_inner_ang_min) > 2 * math.pi do
					drag_angle = drag_angle - (2 * math.pi)
				end
				if drag_angle >= item_inner_ang_min and drag_angle < item_inner_ang_max  then
					hovered = true
					bItemHovered = not oPieMenu.m_oItemIsSubMenu[ item_n ]
				end
			end
			-- draw segments
			local arc_segments = math.floor(( 32 * item_arc_span / ( 2 * math.pi ) ) + 1)
			local iColor = imgui.GetColorU32( hovered and imgui.Col.ButtonHovered or imgui.Col.Button )
			local fAngleStepInner = (item_inner_ang_max - item_inner_ang_min) / arc_segments
			local fAngleStepOuter = ( item_outer_ang_max - item_outer_ang_min ) / arc_segments
			pDrawList:PrimReserve(arc_segments * 6, (arc_segments + 1) * 2)
			for iSeg = 0, arc_segments do
				local fCosInner = math.cos(item_inner_ang_min + fAngleStepInner * iSeg)
				local fSinInner = math.sin(item_inner_ang_min + fAngleStepInner * iSeg)
				local fCosOuter = math.cos(item_outer_ang_min + fAngleStepOuter * iSeg)
				local fSinOuter = math.sin(item_outer_ang_min + fAngleStepOuter * iSeg)

				if iSeg < arc_segments then
					local VtxCurrentIdx = pDrawList._VtxCurrentIdx
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 0)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 2)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 1)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 3)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 2)
					pDrawList:PrimWriteIdx(VtxCurrentIdx + 1)
				end
				local pos = ImVec2(menuCtx.m_oCenter.x + fCosInner * (fMinRadius + oStyle.ItemInnerSpacing.x), menuCtx.m_oCenter.y + fSinInner * (fMinRadius + oStyle.ItemInnerSpacing.x))
				local pos2 = ImVec2(menuCtx.m_oCenter.x + fCosOuter * (fMaxRadius - oStyle.ItemInnerSpacing.x), menuCtx.m_oCenter.y + fSinOuter * (fMaxRadius - oStyle.ItemInnerSpacing.x))
				pDrawList:PrimWriteVtx(pos, ImVec2(0, 0), iColor)
				pDrawList:PrimWriteVtx(pos2, ImVec2(0, 0), iColor)
			end

			local fRadCenter = ( item_arc_span * item_n ) + fRotate
			local oOuterCenter = ImVec2( menuCtx.m_oCenter.x + math.cos( fRadCenter ) * fMaxRadius, menuCtx.m_oCenter.y + math.sin( fRadCenter ) * fMaxRadius )
			ImRectAdd(oArea, oOuterCenter)
			if oPieMenu.m_oItemIsSubMenu[item_n] then
				local oTrianglePos = {ImVec2(), ImVec2(), ImVec2()}
				local fRadLeft = fRadCenter - 5 / fMaxRadius
				local fRadRight = fRadCenter + 5 / fMaxRadius
				oTrianglePos[ 0+1 ].x = menuCtx.m_oCenter.x + math.cos( fRadCenter ) * ( fMaxRadius - 5 )
				oTrianglePos[ 0+1 ].y = menuCtx.m_oCenter.y + math.sin( fRadCenter ) * ( fMaxRadius - 5 )
				oTrianglePos[ 1+1 ].x = menuCtx.m_oCenter.x + math.cos( fRadLeft ) * ( fMaxRadius - 10 )
				oTrianglePos[ 1+1 ].y = menuCtx.m_oCenter.y + math.sin( fRadLeft ) * ( fMaxRadius - 10 )
				oTrianglePos[ 2+1 ].x = menuCtx.m_oCenter.x + math.cos( fRadRight ) * ( fMaxRadius - 10 )
				oTrianglePos[ 2+1 ].y = menuCtx.m_oCenter.y + math.sin( fRadRight ) * ( fMaxRadius - 10 )
				pDrawList:AddTriangleFilled(oTrianglePos[1], oTrianglePos[2], oTrianglePos[3], 0xFFFFFFFF)
			end
			local text_size = ImVec2(oPieMenu.m_oItemSizes[item_n])
			local text_pos = ImVec2(
				menuCtx.m_oCenter.x + math.cos((item_inner_ang_min + item_inner_ang_max) * 0.5) * (fMinRadius + fMaxRadius) * 0.5 - text_size.x * 0.5,
				menuCtx.m_oCenter.y + math.sin((item_inner_ang_min + item_inner_ang_max) * 0.5) * (fMinRadius + fMaxRadius) * 0.5 - text_size.y * 0.5)
			pDrawList:AddText(text_pos, imgui.GetColorU32(imgui.Col.Text), item_label)
			if hovered then
				item_hovered = item_n
			end
		end
		fCurrentRadius = fMaxRadius
		oPieMenu.m_fLastMaxItemSqrDiameter = oPieMenu.m_fMaxItemSqrDiameter
		oPieMenu.m_iHoveredItem = item_hovered
		if fDragDistSqr >= fMaxRadius * fMaxRadius then
			item_hovered = oPieMenu.m_iLastHoveredItem
		end
		oPieMenu.m_iLastHoveredItem = item_hovered
		fLastRotate = item_arc_span * oPieMenu.m_iLastHoveredItem + fRotate
		if item_hovered == -1 or not oPieMenu.m_oItemIsSubMenu[item_hovered] then
			break
		end
	end
	pDrawList:PopClipRect()
	if oArea.Min.x < 0  then
		menuCtx.m_oCenter.x = ( menuCtx.m_oCenter.x - oArea.Min.x )
	end
	if oArea.Min.y < 0  then
		menuCtx.m_oCenter.y = ( menuCtx.m_oCenter.y - oArea.Min.y )
	end
	local oDisplaySize = imgui.GetIO().DisplaySize
	if oArea.Max.x > oDisplaySize.x  then
		menuCtx.m_oCenter.x = ( menuCtx.m_oCenter.x - oArea.Max.x ) + oDisplaySize.x
	end
	if oArea.Max.y > oDisplaySize.y  then
		menuCtx.m_oCenter.y = ( menuCtx.m_oCenter.y - oArea.Max.y ) + oDisplaySize.y
	end
	if menuCtx.m_bClose or ( not bItemHovered and imgui.IsMouseReleased( menuCtx.m_iMouseButton ) ) then
		imgui.CloseCurrentPopup()
	end
	imgui.EndPopup()
	imgui.PopStyleColor(2)
	imgui.PopStyleVar(2)
end

local function BeginPieMenu(menuCtx, pName, bEnabled)
	assert(menuCtx.m_iCurrentIndex >= 0 and menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieItemCount)
	bEnabled = bEnabled or true
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	local oTextSize = imgui.CalcTextSize(pName)
	oPieMenu.m_oItemSizes[oPieMenu.m_iCurrentIndex] = oTextSize
	local fSqrDiameter = (oTextSize.x * oTextSize.x / 2) + (oTextSize.y * oTextSize.y / 2)
	if fSqrDiameter > oPieMenu.m_fMaxItemSqrDiameter then
		oPieMenu.m_fMaxItemSqrDiameter = fSqrDiameter
	end
	oPieMenu.m_oItemIsSubMenu[oPieMenu.m_iCurrentIndex] = true
	oPieMenu.m_oItemNames[oPieMenu.m_iCurrentIndex] = pName
	if oPieMenu.m_iLastHoveredItem == oPieMenu.m_iCurrentIndex then
		oPieMenu.m_iCurrentIndex = oPieMenu.m_iCurrentIndex + 1
		BeginPieMenuEx(menuCtx)
		return true
	end
	oPieMenu.m_iCurrentIndex = oPieMenu.m_iCurrentIndex + 1
	return false
end

local function EndPieMenu(menuCtx)
	assert(menuCtx.m_iCurrentIndex >= 0 and menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieItemCount)
	menuCtx.m_iCurrentIndex = menuCtx.m_iCurrentIndex - 1
end

local function PieMenuItem(menuCtx, pName, bEnabled)
	assert(menuCtx.m_iCurrentIndex >= 0 and menuCtx.m_iCurrentIndex < menuCtx.c_iMaxPieItemCount)
	bEnabled = bEnabled or true
	local oPieMenu = menuCtx.m_oPieMenuStack[menuCtx.m_iCurrentIndex]
	local oTextSize = imgui.CalcTextSize(pName)
	oPieMenu.m_oItemSizes[oPieMenu.m_iCurrentIndex] = oTextSize
	local fSqrDiameter = (oTextSize.x * oTextSize.x / 3) + (oTextSize.y * oTextSize.y / 3)
	if fSqrDiameter > oPieMenu.m_fMaxItemSqrDiameter then
		oPieMenu.m_fMaxItemSqrDiameter = fSqrDiameter
	end
	oPieMenu.m_oItemIsSubMenu[oPieMenu.m_iCurrentIndex] = false
	oPieMenu.m_oItemNames[oPieMenu.m_iCurrentIndex] = pName
	local bActive = oPieMenu.m_iCurrentIndex == oPieMenu.m_iHoveredItem
	oPieMenu.m_iCurrentIndex = oPieMenu.m_iCurrentIndex + 1
	if bActive then
		menuCtx.m_bClose = true
	end
	return bActive
end

local function New(...)
	local menuContext = NewPieMenuContext(...)
	return {
		_VERSION = '1.0',
		BeginPiePopup = function(name, mouseButton)
			return BeginPiePopup(menuContext, name, mouseButton)
		end,
		EndPiePopup = function()
			return EndPiePopup(menuContext)
		end,
		PieMenuItem = function(name, enabled)
			return PieMenuItem(menuContext, name, enabled)
		end,
		BeginPieMenu = function(name, enabled)
			return BeginPieMenu(menuContext, name, enabled)
		end,
		EndPieMenu = function()
			return EndPieMenu(menuContext)
		end
	}
end

local defaultPieMenu = New()
defaultPieMenu.New = New
return defaultPieMenu
			]])
			file:close()
			pie = require('mimgui_piemenu')
			pie_no_errors = true
		end
	end
end
if pie_no_errors then
	if settings.general.piemenu then
		MODULE.FastPieMenu.Window[0] = true
	end
end
------------------------------------------- Mimgui Hotkey ----------------------------------------
local hotkeys = {}
if ((not isMonetLoader()) and (hotkey_no_errors) and (not isMode(''))) then
	hotkey.Text.NoKey = u8'< click and select keys >'
	hotkey.Text.WaitForKey = u8'< wait keys >'
	function getNameKeysFrom(keys)
		local keys = decodeJson(keys)
		local keysStr = {}
		for _, keyId in ipairs(keys) do
			local keyName = require('vkeys').id_to_name(keyId) or ''
			table.insert(keysStr, keyName)
		end
		return tostring(table.concat(keysStr, ' + ')) or ''
	end
	function loadHotkeys()
		MainMenuHotKey = hotkey.RegisterHotKey('Open MainMenu', false, decodeJson(settings.general.bind_mainmenu), function()
			if not MODULE.Main.Window[0] then
				MODULE.Main.Window[0] = true
			end
		end)
		CommandStopHotKey = hotkey.RegisterHotKey('Stop Command', false, decodeJson(settings.general.bind_command_stop), function() 
			sampProcessChatInput('/stop')
		end)
		FastMenuHotKey = hotkey.RegisterHotKey('Open FastMenu', false, decodeJson(settings.general.bind_fastmenu), function() 
			local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
			if valid and doesCharExist(ped) then
				local result, id = sampGetPlayerIdByCharHandle(ped)
				if result and id ~= -1 and not MODULE.LeaderFastMenu.Window[0] then
					show_fast_menu(id)
				end
			end
		end)
		LeaderFastMenuHotKey = hotkey.RegisterHotKey('Open LeaderFastMenu', false, decodeJson(settings.general.bind_leader_fastmenu), function() 
			if settings.player_info.fraction_rank_number >= 9 then 
				local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
				if valid and doesCharExist(ped) then
					local result, id = sampGetPlayerIdByCharHandle(ped)
					if result and id ~= -1 and not MODULE.FastMenu.Window[0] then
						show_leader_fast_menu(id)
					end
				end
			end
		end)
		ActionHotKey = hotkey.RegisterHotKey('Action Key', false, decodeJson(settings.general.bind_action), function()
			if ((settings.player_info.fraction_rank_number >= 9) and (MODULE.GiveRank.Window[0])) then
				give_rank()
			elseif ((isMode('hospital')) and (MODULE.HealChat.bool)) then
				if (MODULE.HealChat.player_id ~= nil and not sampIsDialogActive() and not sampIsChatInputActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive()) then
					find_and_use_command("/heal {arg_id}", MODULE.HealChat.player_id)
					MODULE.HealChat.bool = false
					MODULE.HealChat.player_id = nil
				end
			elseif ((isMode('smi')) and (MODULE.SmiEdit.Window[0])) then
				send_ad()
			end
		end)
		for _, command in ipairs(modules.commands.data.commands.my) do
			createHotkeyForCommand(command)
		end
		for _, command in ipairs(modules.commands.data.commands_manage.my) do
			createHotkeyForCommand(command)
		end
	end
	function createHotkeyForCommand(command)
		local hotkeyName = command.cmd .. "HotKey"
		if hotkeys[hotkeyName] then
			hotkey.RemoveHotKey(hotkeyName)
		end
		if command.arg == "" and command.bind ~= nil and command.bind ~= '{}' and command.bind ~= '[]' then
			hotkeys[hotkeyName] = hotkey.RegisterHotKey(hotkeyName, false, decodeJson(command.bind), function()
				if (not (sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive())) then
					sampProcessChatInput('/' .. command.cmd)
				end
			end)
			print('Ñîçäàí õîòêåé äëÿ êîìàíäû /' .. command.cmd .. ' íà êëàâèøó ' .. getNameKeysFrom(command.bind))
			sampAddChatMessage('[Rodina Helper] {ffffff}Ñîçäàí õîòêåé äëÿ êîìàíäû ' .. message_color_hex .. '/' .. command.cmd .. ' {ffffff}íà êëàâèøó '  .. message_color_hex .. getNameKeysFrom(command.bind), message_color)
		end
	end
	addEventHandler('onWindowMessage', function(msg, key, lparam)
		if msg == 641 or msg == 642 or lparam == -1073741809 then hotkey.ActiveKeys = {} end
		if msg == 0x0005 then hotkey.ActiveKeys = {} end
	end)
end
-------------------------------------------- RP GUNS INIT ----------------------------------------
function initialize_guns()
    for i, weapon in pairs(modules.rpgun.data.rp_guns) do
        local rpTakeType = modules.rpgun.data.rpTakeNames[weapon.rpTake]
		local id = weapon.id
        modules.rpgun.data.gunActions.partOn[id] = rpTakeType[1]
        modules.rpgun.data.gunActions.partOff[id] = rpTakeType[2]
        if id == 3 or (id > 15 and id < 19) or (id == 90 or id == 91) then
            modules.rpgun.data.gunActions.on[id] = (settings.player_info.sex == "Æåíùèíà") and "ñíÿëà" or "ñíÿë"
        else
            modules.rpgun.data.gunActions.on[id] = (settings.player_info.sex == "Æåíùèíà") and "äîñòàëà" or "äîñòàë"
        end
        if id == 3 or (id > 15 and id < 19) or (id > 38 and id < 41) or (id == 90 or id == 91) then
            modules.rpgun.data.gunActions.off[id] = (settings.player_info.sex == "Æåíùèíà") and "ïîâåñèëà" or "ïîâåñèë"
        else
            modules.rpgun.data.gunActions.off[id] = (settings.player_info.sex == "Æåíùèíà") and "óáðàëà" or "óáðàë"
        end
    end
end
function get_name_weapon(id) 
    for _, weapon in ipairs(modules.rpgun.data.rp_guns) do
        if weapon.id == id then
            return weapon.name
        end
    end
    return "îðóæèå"
end
function isExistsWeapon(id) 
    for _, weapon in ipairs(modules.rpgun.data.rp_guns) do
        if weapon.id == id then
            return true
        end
    end
    return false
end
function isEnableWeapon(id) 
    for _, weapon in ipairs(modules.rpgun.data.rp_guns) do
        if weapon.id == id then
            return weapon.enable
        end
    end
    return false
end
function handleNewWeapon(weaponId)
    sampAddChatMessage('[Rodina Helper] {ffffff}Îáíàðóæåíî íîâîå îðóæèå ñ ID ' .. message_color_hex .. weaponId .. '{ffffff}, äàþ åìó èìÿ "îðóæèå" è ðàñïîëîæåíèå "ñïèíà".', message_color)
    sampAddChatMessage('[Rodina Helper] {ffffff}Èçìåíèòü èìÿ èëè ðàñïîëîæåíèå îðóæèÿ âû ìîæåòå â /helper - Ãëàâíîå ìåíþ - Ðåæèì RP îòûãðîâêè îðóæèÿ - Íàñòðîèòü', message_color)
    table.insert(modules.rpgun.data.rp_guns, {id = weaponId, name = "îðóæèå", enable = true, rpTake = 1})
	save_module('rpgun')
    initialize_guns()
end
function processWeaponChange(oldGun, nowGun)
    if not modules.rpgun.data.gunActions.off[oldGun] or not modules.rpgun.data.gunActions.on[nowGun] then
        sampAddChatMessage('[Rodina Helper | Àññèñòåíò] {ffffff}Èíèöèàëèçàöèÿ îðóæèÿ...', message_color)
		initialize_guns()
		return
    end
    local actions = modules.rpgun.data.gunActions
    if oldGun == 0 and nowGun == 0 then
        return
    elseif oldGun == 0 and not isEnableWeapon(nowGun) then
        return
    elseif nowGun == 0 and not isEnableWeapon(oldGun) then
        return
    elseif not isEnableWeapon(oldGun) and isEnableWeapon(nowGun) then
        sampSendChat(string.format("/me %s %s %s",
            actions.on[nowGun],
            get_name_weapon(nowGun),
            actions.partOn[nowGun]
        ))
    elseif isEnableWeapon(oldGun) and not isEnableWeapon(nowGun) then
        sampSendChat(string.format("/me %s %s %s",
            actions.off[oldGun],
           	get_name_weapon(oldGun),
            actions.partOff[oldGun]
        ))
    elseif oldGun == 0 then
        sampSendChat(string.format("/me %s %s %s",
            actions.on[nowGun],
            get_name_weapon(nowGun),
            actions.partOn[nowGun]
        ))
    elseif nowGun == 0 then
        sampSendChat(string.format("/me %s %s %s",
            actions.off[oldGun],
            get_name_weapon(oldGun),
            actions.partOff[oldGun]
        ))
    else
		if isEnableWeapon(oldGun) and isEnableWeapon(nowGun) then
			sampSendChat(string.format("/me %s %s %s, ïîñëå ÷åãî %s %s %s",
				actions.off[oldGun],
				get_name_weapon(oldGun),
				actions.partOff[oldGun],
				actions.on[nowGun],
				get_name_weapon(nowGun),
				actions.partOn[nowGun]
			))
		end
        
    end
end
-------------------------------------------- Variables ------------------------------------------
local PlayerID = nil
local player_id = nil
local clicked = false
------------------------------------------- Functions --------------------------------------------
function main()

	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(0) end

	check_resourses()

	if settings.general.fraction_mode == '' then
		import_data_from_old_helpers()
		repeat wait(0) until sampIsLocalPlayerSpawned()
		MODULE.Initial.Window[0] = true
		return
	end
	
	load_modules()
	
	if settings.general.rp_guns then initialize_guns() end
	
	initialize_commands()

	if ((not isMonetLoader()) and hotkey_no_errors) then loadHotkeys() end

	welcome_message()
	
	check_update()

	while true do
		wait(0)

		if (isMonetLoader() and settings.general.mobile_fastmenu_button) then
			if tonumber(#get_players()) > 0 and not MODULE.FastMenu.Window[0] and not MODULE.FastMenuPlayers.Window[0] then
				MODULE.FastMenuButton.Window[0] = true
			else
				MODULE.FastMenuButton.Window[0] = false
			end
		end

		if MODULE.Post.active then
			MODULE.Post.time = os.difftime(os.time(), MODULE.Post.start_time)
		end

		if (isMode('police') or isMode('fcb')) then
			if MODULE.Patrool.active then
				MODULE.Patrool.time = os.difftime(os.time(), MODULE.Patrool.start_time)
			end
			if MODULE.Patrool.active and isCharInAnyCar(PLAYER_PED) and settings.mj.auto_change_code_siren then
				local currentSirenState = isCarSirenOn(storeCarCharIsInNoSave(PLAYER_PED))
				if firstCheck then
					lastSirenState = currentSirenState
					firstCheck = false
				end
				if currentSirenState ~= lastSirenState then
					lastSirenState = currentSirenState
					if currentSirenState then
						sampAddChatMessage("[Rodina Helper | Àññèñòåíò] {ffffff}Â âàøåì ò/ñ áûëà âêëþ÷åíà ñèðåíà, èçìåíÿþ ñèòóàöèîííûé êîä íà CODE 3!", message_color)
						MODULE.Patrool.ComboCode[0] = 4
						MODULE.Patrool.code = MODULE.Patrool.combo_code_list[MODULE.Patrool.ComboCode[0] + 1]
					else
						sampAddChatMessage("[Rodina Helper | Àññèñòåíò] {ffffff}Â âàøåì ò/ñ áûëà îòêëþ÷åíà ñèðåíà, èçìåíÿþ ñèòóàöèîííûé êîä íà CODE 4.", message_color)
						MODULE.Patrool.ComboCode[0] = 5
						MODULE.Patrool.code = MODULE.Patrool.combo_code_list[MODULE.Patrool.ComboCode[0] + 1]
					end
				end
			end
		end

		if (settings.general.rp_guns) and (modules.rpgun.data.nowGun ~= getCurrentCharWeapon(PLAYER_PED)) then
            modules.rpgun.data.oldGun = modules.rpgun.data.nowGun
            modules.rpgun.data.nowGun = getCurrentCharWeapon(PLAYER_PED)
            if not isExistsWeapon(modules.rpgun.data.oldGun) then
                handleNewWeapon(modules.rpgun.data.oldGun)
            elseif not isExistsWeapon(modules.rpgun.data.nowGun) then
                handleNewWeapon(modules.rpgun.data.nowGun)
            end
            processWeaponChange(modules.rpgun.data.oldGun, modules.rpgun.data.nowGun)
        end

		if (settings.general.payday_notify) then
			local currentMinute = os.date("%M", os.time())
			local currentSecond = os.date("%S", os.time())
			if ((currentMinute == "55" or currentMinute == "25") and currentSecond == "00") then
				if sampGetPlayerColor(MODULE.Binder.tags.my_id()) == 368966908 then
					sampAddChatMessage('[Rodina Helper] {ffffff}×åðåç 5 ìèíóò áóäåò PAYDAY. Íàäåíüòå ôîðìó ÷òîáû íå ïðîïóñòèòü çàðïëàòó!', message_color)
					playNotifySound()
					wait(1000)
				end
			end
		end
		
		if (settings.general.cruise_control) then
			if (MODULE.CruiseControl.wait_point) then
				local bool, x, y, z = getTargetBlipCoordinates()
				if bool then
					MODULE.CruiseControl.point = {x = x, y = y, z = z}
					MODULE.CruiseControl.wait_point = false
					sampAddChatMessage('[Rodina Helper] {ffffff}Êîîðäèíàòû ìåñòà íàçíà÷åíèÿ óñïåøíî ïîëó÷åíû!', message_color)
					while (isGamePaused() or isPauseMenuActive()) do wait(0) end
					lua_thread.create(function()
						sampSendChat('/me âêëþ÷àåò â ñâî¸ì òñ àäàïòèâíûé CRUISE CONTROL è íàñòðàèâàåò GPS íàâèãàòîð')
						wait(1500)
						sampSendChat('/do Íà ýêðàíå çàãîðàåòñÿ íàäïèñü "GPS ìàðøðóò óñïåøíî ïðîëîæåí, ìîæíî åõàòü".')
						MODULE.CruiseControl.active = true 
						wait(2000)
						sampSendChat('/do ' .. MODULE.Binder.tags.my_ru_nick() .. ' äåðæèò ðóêè íà ðóëå, CRUISE CONTROL ïîääåðæèâàåò ñêîðîñòü òñ.')
					end)
				end
			end
			if (MODULE.CruiseControl.active) then
				local function stop()
					MODULE.CruiseControl.active = false
					clearCharTasks(PLAYER_PED)
					if isCharInAnyCar(PLAYER_PED) then
						taskWarpCharIntoCarAsDriver(PLAYER_PED, storeCarCharIsInNoSave(PLAYER_PED))
					end
				end
				if not isCharInAnyCar(PLAYER_PED) then
					sampAddChatMessage('[Rodina Helper] {ffffff}Âû äîëæíû íàõîäèòüñÿ â òðàíñïîðòíîì ñðåäñòâå!', message_color)
					stop()
				elseif not (isCarEngineOn(storeCarCharIsInNoSave(PLAYER_PED))) then
					sampAddChatMessage('[Rodina Helper] {ffffff}Äâèãàòåëü âàøåãî òðàíñïîðòíîãî ñðåäñòâà çàãëîõ!', message_color)
					stop()
				elseif locateCharInCar2d(PLAYER_PED, MODULE.CruiseControl.point.x, MODULE.CruiseControl.point.y, 15, 15, false) then
					sampSendChat('/me ïðèåõàâ ê ïóíêòó íàçíà÷åíèÿ îòêëþ÷àåò â òñ àäàïòèâíûé CRUISE CONTROL')
					stop()
				else
					taskCarDriveToCoord(PLAYER_PED, storeCarCharIsInNoSave(PLAYER_PED), MODULE.CruiseControl.point.x, MODULE.CruiseControl.point.y, MODULE.CruiseControl.point.z, 28, 0, 0, 2)
				end
				
			end
		end

	end

end
function load_modules()
	load_module('commands')
	load_module('notes')
	load_module('rpgun')
	load_module('arz_veh')

	if isMode('police') or isMode('fcb') then
		load_module('smart_uk')
		load_module('smart_pdd')
		if (isMonetLoader()) then
			if (settings.mj.mobile_taser_button) then
				MODULE.Taser.Window[0] = true
			end
			if (settings.mj.mobile_meg_button) then
				MODULE.Megafon.Window[0] = true
			end
		end
	elseif isMode('prison') then
		load_module('smart_rptp')
		if ((isMonetLoader()) and (settings.md.mobile_taser_button)) then
			MODULE.Taser.Window[0] = true
		end	
	elseif isMode('smi') then
		load_module('ads_history')
	end
end
function welcome_message()
	if not sampIsLocalPlayerSpawned() then 
		sampAddChatMessage('[Rodina Helper] {ffffff}Èíèöèàëèçàöèÿ õåëïåðà ïðîøëà óñïåøíî!',message_color)
		sampAddChatMessage('[Rodina Helper] {ffffff}Äëÿ ïîëíîé çàãðóçêè õåëïåðà ñíà÷àëî çàñïàâíèòåñü (âîéäèòå íà ñåðâåð)',message_color)
		repeat wait(0) until sampIsLocalPlayerSpawned()
	end

	sampAddChatMessage('[Rodina Helper] {ffffff}Çàãðóçêà õåëïåðà ïðîøëà óñïåøíî!', message_color)
	sampAddChatMessage('[Rodina Helper] {ffffff}Ïðèâåñòâóåì âàñ â íàøåì õåëïåðå ÷òîá çíàòü âñþ èíôîðìàöèþ ïîäïèøèòåñü íà ÒÃ êàíàë ñïàñèáî)', message_color)
	show_arz_notify('info', 'Rodina Helper', "Çàãðóçêà õåëïåðà ïðîøëà óñïåøíî!", 3000)
	print('Ïîëíàÿ çàãðóçêà õåëïåðà ïðîøëà óñïåøíî!')

	if isMonetLoader() or settings.general.bind_mainmenu == nil then	
		sampAddChatMessage('[Rodina Helper] {ffffff}×òîá îòêðûòü ìåíþ õåëïåðà ââåäèòå êîìàíäó ' .. message_color_hex .. '/helper', message_color)
	elseif hotkey_no_errors and settings.general.bind_mainmenu then
		sampAddChatMessage('[Rodina Helper] {ffffff}×òîá îòêðûòü ìåíþ õåëïåðà íàæìèòå ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_mainmenu) .. ' {ffffff}èëè ââåäèòå êîìàíäó ' .. message_color_hex .. '/helper', message_color)
	else
		sampAddChatMessage('[Rodina Helper] {ffffff}×òîá îòêðûòü ìåíþ õåëïåðà ââåäèòå êîìàíäó ' .. message_color_hex .. '/helper', message_color)
	end
end
function registerCommandsFrom(array)
	for _, command in ipairs(array) do
		if command.enable then
			register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
		end
	end
end
function register_command(chat_cmd, cmd_arg, cmd_text, cmd_waiting)
	sampRegisterChatCommand(chat_cmd, function(arg)
		if not MODULE.Binder.state.isActive then
			if MODULE.Binder.state.isStop then
				MODULE.Binder.state.isStop = false
			end
			local arg_check = false
			local modifiedText = cmd_text
			if cmd_arg == '{arg}' then
				if arg and arg ~= '' then
					modifiedText = modifiedText:gsub('{arg}', arg or "")
					arg_check = true
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/' .. chat_cmd .. ' [àðãóìåíò]', message_color)
					playNotifySound()
				end
			elseif cmd_arg == '{arg_id}' then
				if isParamSampID(arg) then
					arg = tonumber(arg)
					modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg) or "")
					modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg):gsub('_',' ') or "")
					modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}', TranslateNick(sampGetPlayerNickname(arg)) or "")
					modifiedText = modifiedText:gsub('%{arg_id%}', arg or "")
					arg_check = true
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID èãðîêà]', message_color)
					playNotifySound()
				end
			elseif cmd_arg == '{arg_id} {arg2}' then
				if arg and arg ~= '' then
					local arg_id, arg2 = arg:match('(%d+) (.+)')
					if isParamSampID(arg_id) and arg2 then
						arg_id = tonumber(arg_id)
						modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id) or "")
						modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id):gsub('_',' ') or "")
						modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}', TranslateNick(sampGetPlayerNickname(arg_id)) or "")
						modifiedText = modifiedText:gsub('%{arg_id%}', arg_id or "")
						modifiedText = modifiedText:gsub('%{arg2%}', arg2 or "")
						arg_check = true
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID èãðîêà] [àðãóìåíò]', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID èãðîêà] [àðãóìåíò]', message_color)
					playNotifySound()
				end
            elseif cmd_arg == '{arg_id} {arg2} {arg3}' then
				if arg and arg ~= '' then
					local arg_id, arg2, arg3 = arg:match('(%d+) (%d) (.+)')
					if isParamSampID(arg_id) and arg2 and arg3 then
						arg_id = tonumber(arg_id)
						modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id) or "")
						modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id):gsub('_',' ') or "")
						modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}', TranslateNick(sampGetPlayerNickname(arg_id)) or "")
						modifiedText = modifiedText:gsub('%{arg_id%}', arg_id or "")
						modifiedText = modifiedText:gsub('%{arg2%}', arg2 or "")
                        modifiedText = modifiedText:gsub('%{arg3%}', arg3 or "")
						arg_check = true
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID èãðîêà] [÷èñëî] [àðãóìåíò]', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID èãðîêà] [÷èñëî] [àðãóìåíò]', message_color)
					playNotifySound()
				end
			elseif cmd_arg == '{arg_id} {arg2} {arg3} {arg4}' then
				if arg and arg ~= '' then
					local arg_id, arg2, arg3, arg4 = arg:match('(%d+) (%d) (.+) (.+)')
					if isParamSampID(arg_id) and arg2 and arg3 and arg4 then
						arg_id = tonumber(arg_id)
						modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id) or "")
						modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id):gsub('_',' ') or "")
						modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}', TranslateNick(sampGetPlayerNickname(arg_id)) or "")
						modifiedText = modifiedText:gsub('%{arg_id%}', arg_id or "")
						modifiedText = modifiedText:gsub('%{arg2%}', arg2 or "")
                        modifiedText = modifiedText:gsub('%{arg3%}', arg3 or "")
						modifiedText = modifiedText:gsub('%{arg4%}', arg4 or "")
						arg_check = true
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID èãðîêà] [÷èñëî] [àðãóìåíò] [àðãóìåíò]', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID èãðîêà] [÷èñëî] [àðãóìåíò] [àðãóìåíò]', message_color)
					playNotifySound()
				end
			elseif cmd_arg == '' then
				arg_check = true
			end
			if arg_check then
				lua_thread.create(function()
					MODULE.Binder.state.isActive = true
					MODULE.Binder.state.isPause = false
					if modifiedText:find('&.+&') then
						info_stop_command()
					end
					local lines = {}
					for line in string.gmatch(modifiedText, "[^&]+") do
						table.insert(lines, line)
					end
					for line_index, line in ipairs(lines) do
						if MODULE.Binder.state.isStop then 
							MODULE.Binder.state.isStop = false 
							MODULE.Binder.state.isActive = false
							if isMonetLoader() and settings.general.mobile_stop_button then
								MODULE.CommandStop.Window[0] = false
							end
							sampAddChatMessage('[Rodina Helper] {ffffff}Îòûãðîâêà êîìàíäû /' .. chat_cmd .. " óñïåøíî îñòàíîâëåíà!", message_color) 
							break
						else
							if line == '{show_medcard_menu}' then
								if cmd_arg == '{arg_id}' then
									player_id = arg
								elseif cmd_arg == '{arg_id} {arg2}' then
									local arg_id, arg2 = arg:match('(%d+) (.+)')
									if arg_id and arg2 and isParamSampID(arg_id) then
										player_id = tonumber(arg_id)
									end
								end
								MODULE.MedCard.Window[0] = true
								break
							elseif line == '{show_recept_menu}' then
								if cmd_arg == '{arg_id}' then
									player_id = arg
								elseif cmd_arg == '{arg_id} {arg2}' then
									local arg_id, arg2 = arg:match('(%d+) (.+)')
									if arg_id and arg2 and isParamSampID(arg_id) then
										player_id = tonumber(arg_id)
									end
								end
								MODULE.Recept.Window[0] = true
								break
							elseif line == '{show_ant_menu}' then
								if cmd_arg == '{arg_id}' then
									player_id = arg
								elseif cmd_arg == '{arg_id} {arg2}' then
									local arg_id, arg2 = arg:match('(%d+) (.+)')
									if arg_id and arg2 and isParamSampID(arg_id) then
										player_id = tonumber(arg_id)
									end
								end
								MODULE.Antibiotik.Window[0] = true
								break
							elseif line == '{lmenu_vc_vize}' then
								if cmd_arg == '{arg_id}' then
									MODULE.LeadTools.vc_vize.player_id = arg
								elseif cmd_arg == '{arg_id} {arg2}' then
									local arg_id, arg2 = arg:match('(%d+) (.+)')
									if arg_id and arg2 and isParamSampID(arg_id) then
										MODULE.LeadTools.vc_vize.player_id = tonumber(arg_id)
									end
								end
								MODULE.LeadTools.vc_vize.bool = true
								sampSendChat("/lmenu")
								break
							elseif line == '{give_platoon}' then
								if cmd_arg == '{arg_id}' then
									MODULE.LeadTools.platoon.player_id = arg
								elseif cmd_arg == '{arg_id} {arg2}' then
									local arg_id, arg2 = arg:match('(%d+) (.+)')
									if arg_id and arg2 and isParamSampID(arg_id) then
										MODULE.LeadTools.platoon.player_id = arg_id
									end
								end
								MODULE.LeadTools.platoon.check = true
								sampSendChat("/platoon")
								break
							elseif line == '{show_rank_menu}' then
								if cmd_arg == '{arg_id}' then
									player_id = arg
								elseif cmd_arg == '{arg_id} {arg2}' then
									local arg_id, arg2 = arg:match('(%d+) (.+)')
									if arg_id and arg2 and isParamSampID(arg_id) then
										player_id = arg_id
									end
								end
								MODULE.GiveRank.Window[0] = true
								break
							elseif line == "{pause}" then
								sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà /' .. chat_cmd .. ' ïîñòàâëåíà íà ïàóçó!', message_color)
								MODULE.Binder.state.isPause = true
								MODULE.CommandPause.Window[0] = true
								while MODULE.Binder.state.isPause do
									wait(0)
								end
								if not MODULE.Binder.state.isStop then
									sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîäîëæàþ îòûãðîâêó êîìàíäû /' .. chat_cmd, message_color)	
								end			
							elseif line:find('{wait%[(%d+)%]}') then
								wait(tonumber(string.match(line, '{wait%[(%d+)%]}')))
							else
								if not MODULE.Binder.state.isStop then
									if line_index ~= 1 then wait(cmd_waiting * 1000) end
									if not MODULE.Binder.state.isStop then 
										for tag, replacement in pairs(MODULE.Binder.tags) do
											if line:find("{" .. tag .. "}") then
												local success, result = pcall(string.gsub, line, "{" .. tag .. "}", function() return replacement() end)
												if success then
													line = result
												end
											end
										end
										sampSendChat(line)
									end
								else
									MODULE.Binder.state.isStop = false 
									MODULE.Binder.state.isActive = false
									if isMonetLoader() and settings.general.mobile_stop_button then
										MODULE.CommandStop.Window[0] = false
									end
									sampAddChatMessage('[Rodina Helper] {ffffff}Îòûãðîâêà êîìàíäû /' .. chat_cmd .. " óñïåøíî îñòàíîâëåíà!", message_color) 	
									break
								end
							end
						end
					end
					MODULE.Binder.state.isActive = false
					if isMonetLoader() and settings.general.mobile_stop_button then
						MODULE.CommandStop.Window[0] = false
					end
				end)
			end
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
			playNotifySound()
		end
	end)
end
function info_stop_command()
	if isMonetLoader() and settings.general.mobile_stop_button then
		sampAddChatMessage('[Rodina Helper] {ffffff}×òîáû îñòàíîâèòü îòûãðîâêó êîìàíäû èñïîëüçóéòå ' .. message_color_hex .. '/stop {ffffff}èëè íàæìèòå êíîïêó âíèçó ýêðàíà', message_color)
		MODULE.CommandStop.Window[0] = true
	elseif not isMonetLoader() and hotkey_no_errors and settings.general.bind_command_stop then
		sampAddChatMessage('[Rodina Helper] {ffffff}×òîáû îñòàíîâèòü îòûãðîâêó êîìàíäû èñïîëüçóéòå ' .. message_color_hex .. '/stop {ffffff}èëè íàæìèòå ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_command_stop), message_color)
	else
		sampAddChatMessage('[Rodina Helper] {ffffff}×òîáû îñòàíîâèòü îòûãðîâêó êîìàíäû èñïîëüçóéòå ' .. message_color_hex .. '/stop', message_color)
	end
end
function find_and_use_command(cmd, cmd_arg)
	for _, command in ipairs(modules.commands.data.commands.my) do
		if command.enable and command.text:find(cmd) then
			sampProcessChatInput("/" .. command.cmd .. " " .. cmd_arg)
			return
		end
	end
	for _, command in ipairs(modules.commands.data.commands_manage.my) do
		if command.enable and command.text:find(cmd) then
			sampProcessChatInput("/" .. command.cmd .. " " .. cmd_arg)
			return
		end
	end
	sampAddChatMessage('[Rodina Helper] {ffffff}Íå ìîãó íàéòè áèíä ýòîé êîìàíäû! Ïîïðîáóéòå ñáðîñèòü íàñòðîéêè', message_color)
	playNotifySound()
end
function initialize_commands()
	sampRegisterChatCommand("helper", function() 
		MODULE.Main.Window[0] = not MODULE.Main.Window[0] 
	end)
	sampRegisterChatCommand("hm", show_fast_menu)
	sampRegisterChatCommand("stop", function() 
		if MODULE.Binder.state.isActive then 
			MODULE.Binder.state.isStop = true
		else 
			sampAddChatMessage('[Rodina Helper] {ffffff}Â äàííûé ìîìåíò íåòó íèêàêîé àêòèâíîé êîìàíäû/îòûãðîâêè!', message_color) 
		end
	end)
	sampRegisterChatCommand("fixsize", function()
		settings.general.custom_dpi = 1.0
		settings.general.autofind_dpi = false
		sampAddChatMessage('[Rodina Helper] {ffffff}Ðàçìåð ìåíþøåê õåëïåðà ñáðîøåí ê ñòàíäàðòíûì! Ïåðåçàïóñê...', message_color)
		save_settings()
		reload_script = true
		thisScript():reload()
	end)
	sampRegisterChatCommand("rpguns", function()
		MODULE.RPWeapon.Window[0] = not MODULE.RPWeapon.Window[0] 
	end)
	sampRegisterChatCommand("pnv", function()
		if not MODULE.Binder.state.isActive then
			MODULE.NightVision = not MODULE.NightVision
			setNightVision(MODULE.NightVision)
			MODULE.InfraredVision = false
			setInfraredVision(MODULE.InfraredVision)
			if MODULE.NightVision then
				sampSendChat('/me äîñòà¸ò èç êàðìàíà î÷êè íî÷íîãî âèäåíèÿ è íàäåâàåò èõ')
			else
				sampSendChat('/me ñíèìàåò ñ ñåáÿ î÷êè íî÷íîãî âèäåíèÿ è óáèðàåò èõ â êàðìàí')
			end	
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
			playNotifySound()
		end
	end)
	sampRegisterChatCommand("irv", function()
		if not MODULE.Binder.state.isActive then
			MODULE.InfraredVision = not MODULE.InfraredVision
			setInfraredVision(MODULE.InfraredVision)
			MODULE.NightVision = false
			setNightVision(MODULE.NightVision)	
			if MODULE.InfraredVision then
				sampSendChat('/me äîñòà¸ò èç êàðìàíà èíôðàêðàñíûå î÷êè è íàäåâàåò èõ')
			else
				sampSendChat('/me ñíèìàåò ñ ñåáÿ èíôðàêðàñíûå î÷êè è óáèðàåò èõ â êàðìàí')
			end
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
			playNotifySound()
		end
	end)
	sampRegisterChatCommand("cruise", function()
		if not MODULE.Binder.state.isActive then
			if settings.general.cruise_control then
				if MODULE.CruiseControl.active then
					MODULE.CruiseControl.active = false
					if isCharInAnyCar(PLAYER_PED) then
						taskWarpCharIntoCarAsDriver(PLAYER_PED, storeCarCharIsInNoSave(PLAYER_PED))
					end
					sampAddChatMessage('[Rodina Helper] {ffffff} Ðåæèì "CRUISE CONTROL" îòêëþ÷åí!', message_color)
				else
					if not isCharInAnyCar(PLAYER_PED) then
						sampAddChatMessage('[Rodina Helper] {ffffff}Âû äîëæíû íàõîäèòüñÿ â òðàíñïîðòíîì ñðåäñòâå!', message_color)
						return
					end
					local car = storeCarCharIsInNoSave(PLAYER_PED)
					if not (isCarEngineOn(car)) then
						sampAddChatMessage('[Rodina Helper] {ffffff}Çàâåäèòå äâèãàòåëü âàøåãî òðàíñïîðòíîãî ñðåäñòâà!', message_color)
						return
					end

					local driver = getDriverOfCar(car)
					if driver ~= PLAYER_PED then
						sampAddChatMessage('[Rodina Helper] {ffffff}Âû äîëæíû áûòü âîäèòåëåì òðàíñïîðòíîãî ñðåäñòâà!', message_color)
						return
					end

					local bool, x, y, z = getTargetBlipCoordinates()
					if bool then
						sampAddChatMessage('[Rodina Helper] {ffffff}Óäàëèòå ñâîþ ñòàðóþ ìåòêó ñ êàðòû!', message_color)
						return
					end

					MODULE.CruiseControl.point = {x = 0, y = 0, z = 0}
					MODULE.CruiseControl.wait_point = true
					sampAddChatMessage('[Rodina Helper] {ffffff}Âûáåðèòå ïóíêò íàçíàíåíèÿ (ïîñòàâüòå ìåòêó íà êàðòå)', message_color)
				end
			else
				sampAddChatMessage('[Rodina Helper] {ffffff} Äàííàÿ ôóíêöèÿ îòêëþ÷åíà â íàñòðîéêàõ õåëïåðà!', message_color)
			end
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
			playNotifySound()
		end
	end)
	sampRegisterChatCommand("debug", function() 
		MODULE.DEBUG = not MODULE.DEBUG 
		sampAddChatMessage('[Rodina Helper] {ffffff}Îòñëåæèâàíèå äàííûõ ñ ñåðâåðà ' .. (MODULE.DEBUG and 'âêëþ÷åíî!' or 'âûêëþ÷åíî!'), message_color) 
	end)

	if not isMode('none') then
		sampRegisterChatCommand("mb", function(arg)
			if not MODULE.Binder.state.isActive then
				if MODULE.Members.Window[0] then
					MODULE.Members.Window[0] = false
					MODULE.Members.upd.check = false
					sampAddChatMessage('[Rodina Helper] {ffffff}Ìåíþ ñïèñêà ñîòðóäíèêîâ çàêðûòî!', message_color)
				else
					MODULE.Members.new = {} 
					MODULE.Members.info.check = true 
					sampSendChat("/members")
				end
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("dep", function(arg)
			if not MODULE.Binder.state.isActive then
				MODULE.Departament.Window[0] = not MODULE.Departament.Window[0]
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("sob", function(arg)
			if not MODULE.Binder.state.isActive then
				if isParamSampID(arg) then
					player_id = tonumber(arg)
					MODULE.Sobes.Window[0] = not MODULE.Sobes.Window[0]
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/sob [ID èãðîêà]', message_color)
					playNotifySound()
				end	
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
	end

	if isMode('police') or isMode('fcb') then
		sampRegisterChatCommand("sum", function(arg) 
			if not MODULE.Binder.state.isActive then
				if isParamSampID(arg) then
					if #modules.smart_uk.data ~= 0 then
						player_id = tonumber(arg)
						MODULE.SumMenu.Window[0] = true 
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}Ñíà÷àëî çàãðóçèòå/çàïîëíèòå ñèñòåìó óìíîãî ðîçûñêà â /helper - Ôóíêöèè îðãè', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/sum [ID èãðîêà]', message_color)
					playNotifySound()
				end	
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("tsm", function(arg) 
			if not MODULE.Binder.state.isActive then
				if isParamSampID(arg) then
					if #modules.smart_pdd.data ~= 0 then
						player_id = tonumber(arg)
						MODULE.TsmMenu.Window[0] = true
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}Ñíà÷àëî çàãðóçèòå/çàïîëíèòå ñèñòåìó óìíûõ øòðàôîâ â /helper - Ôóíêöèè îðãè', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/tsm [ID èãðîêà]', message_color)
					playNotifySound()
				end	
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("meg", function()
			MODULE.Megafon.Window[0] = not MODULE.Megafon.Window[0]
		end)
		sampRegisterChatCommand("afind", function(arg)
		end)
		sampRegisterChatCommand("wanted", function(arg)
			sampSendChat('/wanted ' .. arg)
			sampAddChatMessage('[Rodina Helper] {ffffff}Ëó÷øå èñïîëüçóéòå /wanteds äëÿ àâòîñêàíèðîâàíèÿ âñåãî âàíòåäà!', message_color)
		end)
		sampRegisterChatCommand("wanteds", function(arg)
			if MODULE.Wanted.Window[0] or MODULE.Wanted.updwanteds.stop then
				MODULE.Wanted.Window[0] = false
				MODULE.Wanted.check_wanted = false
				MODULE.Wanted.updwanteds.check = false
				sampAddChatMessage('[Rodina Helper] {ffffff}Ìåíþ ñïèñêà ïðåñòóïíèêîâ çàêðûòî!', message_color)
			elseif not MODULE.Binder.state.isActive then
				lua_thread.create(function()
					local max_lvl = isMode('fcb') and 7 or 6
					sampAddChatMessage('[Rodina Helper] {ffffff}Ñêàíèðîâàíèå /wanted, îæèäàéòå ' .. message_color_hex .. max_lvl .. ' {ffffff}ñåêóíä...', message_color)
					show_arz_notify('info', 'Rodina Helper', "Ñêàíèðîâàíèå /wanted...", 2500)
					MODULE.Wanted.wanted_new = {}
					MODULE.Wanted.check_wanted = true
					for i = max_lvl, 1, -1 do
						printStringNow("CHECK WANTED " .. i, 1000)
						sampSendChat('/wanted ' .. i)
						wait(1000)
					end
					MODULE.Wanted.check_wanted = false
					if #MODULE.Wanted.wanted_new == 0 then
						sampAddChatMessage('[Rodina Helper] {ffffff}Ñåé÷àñ íà ñåðâåðå íåòó èãðîêîâ ñ ðîçûñêîì!', message_color)
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}Ñêàíèðîâàíèå /wanted îêîí÷åíî! Íàéäåíî ïðåñòóïíèêîâ: ' .. #MODULE.Wanted.wanted_new, message_color)
						MODULE.Wanted.wanted = MODULE.Wanted.wanted_new
						MODULE.Wanted.updwanteds.stop = false
						MODULE.Wanted.updwanteds.time = 0
						MODULE.Wanted.updwanteds.last_time = os.time()
						MODULE.Wanted.updwanteds.check = true
						MODULE.Wanted.Window[0] = true
					end
				end)
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("patrool", function(arg)
			if not MODULE.Binder.state.isActive then
				if isCharInAnyCar(PLAYER_PED) or MODULE.Patrool.Window[0] then
					MODULE.Patrool.Window[0] = not MODULE.Patrool.Window[0]
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Íåëüçÿ íà÷àòü ïàòðóëü, âû äîëæíû áûòü â ò/ñ!', message_color)
				end
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
	end

	if not (isMode('ghetto') or isMode('mafia') or isMode('judge')) then
		sampRegisterChatCommand("post", function(arg)
			if not MODULE.Binder.state.isActive then
				MODULE.Post.Window[0] = not MODULE.Post.Window[0]
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
	end
	
	if not (isMode('ghetto') or isMode('mafia') or isMode('judge')) then
		sampRegisterChatCommand("post", function(arg)
			if not MODULE.Binder.state.isActive then
				MODULE.lekser.Window[0] = not MODULE.lekser.Window[0]
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
	end	

	if isMode('prison') then
		sampRegisterChatCommand("pum", function(arg) 
			if not MODULE.Binder.state.isActive then
				if isParamSampID(arg) then
					if #modules.smart_rptp.data ~= 0 then
						player_id = tonumber(arg)
						MODULE.PumMenu.Window[0] = true 
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}Ñíà÷àëî çàãðóçèòå/çàïîëíèòå ñèñòåìó óìíîãî ñðîêà â /helper - Ôóíêöèè îðãè', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/pum [ID èãðîêà]', message_color)
					playNotifySound()
				end	
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
				playNotifySound()
			end
		end)
	end

	registerCommandsFrom(modules.commands.data.commands.my)

	if settings.player_info.fraction_rank_number >= 9 then
		sampRegisterChatCommand("lm", show_leader_fast_menu)
		sampRegisterChatCommand("spcar", function()
			if not MODULE.Binder.state.isActive then
				lua_thread.create(function()
					MODULE.Binder.state.isActive = true
					info_stop_command()
					sampSendChat("/rb Âíèìàíèå! ×åðåç 15 ñåêóíä áóäåò ñïàâí òðàíñïîðòà îðãàíèçàöèè.")
					wait(1500)
					if MODULE.Binder.state.isStop then 
						MODULE.Binder.state.isStop = false 
						MODULE.Binder.state.isActive = false
						if isMonetLoader() and settings.general.mobile_stop_button then
							MODULE.CommandStop.Window[0] = false
						end
						sampAddChatMessage('[Rodina Helper] {ffffff}Îòûãðîâêà êîìàíäû /spcar óñïåøíî îñòàíîâëåíà!', message_color) 
						return
					end
					sampSendChat("/rb Çàéìèòå òðàíñïîðò, èíà÷å îí áóäåò çàñïàâíåí.")
					wait(13500)	
					if MODULE.Binder.state.isStop then 
						MODULE.Binder.state.isStop = false 
						MODULE.Binder.state.isActive = false
						if isMonetLoader() and settings.general.mobile_stop_button then
							MODULE.CommandStop.Window[0] = false
						end
						sampAddChatMessage('[Rodina Helper] {ffffff}Îòûãðîâêà êîìàíäû /spcar óñïåøíî îñòàíîâëåíà!', message_color) 
						return
					end
					MODULE.LeadTools.spawncar = true
					sampSendChat("/lmenu")
					MODULE.Binder.state.isActive = false
					if isMonetLoader() and settings.general.mobile_stop_button then
						MODULE.CommandStop.Window[0] = false
					end
				end)
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äîæäèòåñü çàâåðøåíèÿ îòûãðîâêè ïðåäûäóùåé êîìàíäû!', message_color)
			end
		end)
		registerCommandsFrom(modules.commands.data.commands_manage.my)
	end
end
function get_fraction_cmds(selected, is_manage)
    local cmds = {}
    local function append_commands(from_table)
        if from_table then
            for _, cmd in ipairs(from_table) do
                table.insert(cmds, cmd)
            end
        end
    end
	if is_manage then
		if selected == 'mafia' then
			append_commands(modules.commands.data.commands_manage.mafia)
		elseif selected == 'ghetto' then
			append_commands(modules.commands.data.commands_manage.ghetto)
		else
			if selected == 'fcb' then
				append_commands(modules.commands.data.commands_manage.goss_fcb)
			elseif selected == 'prison' then
				append_commands(modules.commands.data.commands_manage.goss_prison)
			elseif selected == 'gov' then
				append_commands(modules.commands.data.commands_manage.goss_gov)
			elseif selected == 'police' then
				append_commands(modules.commands.data.commands_manage.police_gov)
			elseif selected == 'hospital' then
				append_commands(modules.commands.data.commands_manage.hospital_gov)		
			elseif selected == 'smi' then
				append_commads(modules.commands.data.commands_manage.smi_gov)
			end
		end
	else
		if selected == 'police' then
			append_commands(modules.commands.data.commands.police)
		elseif selected == 'fcb' then
			append_commands(modules.commands.data.commands.police)
			append_commands(modules.commands.data.commands.fcb)
		elseif selected == 'hospital' then
			append_commands(modules.commands.data.commands.hospital)
		elseif selected == 'smi' then
			append_commands(modules.commands.data.commands.smi)
		elseif selected == 'army' then
			append_commands(modules.commands.data.commands.army)
		elseif selected == 'prison' then
			append_commands(modules.commands.data.commands.prison)
			append_commands(modules.commands.data.commands.army)
		elseif selected == 'lc' then
			append_commands(modules.commands.data.commands.lc)
		elseif selected == 'gov' then
			append_commands(modules.commands.data.commands.gov)
		elseif selected == 'ins' then
			append_commands(modules.commands.data.commands.ins)
		elseif selected == 'fd' then
			append_commands(modules.commands.data.commands.fd)
		elseif selected == 'mafia' then
			append_commands(modules.commands.data.commands.mafia)
		elseif selected == 'ghetto' then
			append_commands(modules.commands.data.commands.ghetto)
		end
	end
    return cmds
end
function delete_default_fraction_cmds(my_cmds, default_cmds)
	for i = #my_cmds, 1, -1 do
		for _, def in ipairs(default_cmds) do
			if my_cmds[i].cmd == def.cmd then
				table.remove(my_cmds, i)
				break
			end
		end
	end
end
function add_notes(module)
	local function add_unique(tbl, note)
		for _, v in ipairs(tbl) do
			if v.note_text == note.note_text then
				return
			end
		end
		table.insert(tbl, note)
	end

	local situate_codes = {note_name = 'Ñèòóàöèîííûå êîäû', note_text = 'CODE 0 - Îôèöåð ðàíåí.&CODE 1 - Îôèöåð â áåäñòâåííîì ïîëîæåíèè, íóæíà ïîìîùü âñåõ þíèòîâ.&CODE 2 - Îáû÷íûé âûçîâ [áåç ñèðåí/ñòðîáîñêîïîâ/ñîáëþäåíèå ÏÄÄ].&CODE 2 HIGHT - Ïðèîðèòåòíûé âûçîâ [áåç ñèðåí/ñòðîáîñêîïîâ/ñîáëþäåíèå ÏÄÄ].&CODE 3 - Ñðî÷íûé âûçîâ [ñèðåíû, ñòðîáîñêîïû, èãíîðèðîâàíèÿ ÏÄÄ].&CODE 4 - Ñòàáèëüíî, ïîìîùü íå òðåáóåòñÿ.&Code 4 ADAM - Ïîìîùü íå òðåáóåòñÿ, íî îôèöåðû ïîáëèçîñòè äîëæíû áûòü ãîòîâû îêàçàòü ïîìîùü.&CODE 5 - Îôèöåðàì äåðæàòüñÿ ïîäàëüøå îò îïàñíîãî ìåñòà.&CODE 6 - Çàäåðæèâàþñü íà ìåñòå [âêëþ÷àÿ ëîêàöèþ è ïðè÷èíó,íàïðèìåð, 911].&CODE 7 - Ïåðåðûâ íà îáåä.&CODE 30 - Ñðàáàòûâàíèå "òèõîé" ñèãíàëèçàöèè íà ìåñòå ïðîèñøåñòâèÿ.&CODE 30 RINGER - Ñðàáàòûâàíèå "ãðîìêîé ñèãíàëèçàöèè íà ìåñòå ïðîèñøåñòâèÿ.&CODE 37 - Îáíàðóæåíèå óãíàííîãî ò/c.&Ñode TOM - Îôèöåðó òðåáóåòñÿ Òàéçåð.' }
	local teen_codes = { note_name = 'Òåí-êîäû', note_text = '10-1 - Ñáîð âñåõ îôèöåðîâ íà äåæóðñòâå.&10-2 - Âûøåë â ïàòðóëü.&10-2R - Çàêîí÷èë ïàòðóëü.&10-3 - Ðàäèîìîë÷àíèå.&10-4 - Ïðèíÿòî.&10-5 - Ïîâòîðèòå.&10-6 - Íå ïðèíÿòî/íåâåðíî/íåò.&10-7 - Îæèäàéòå.&10-8 - Íå äîñòóïåí/çàíÿò.&10-14 - Çàïðîñ òðàíñïîðòèðîâêè.&10-15 - Ïîäîçðåâàåìûå àðåñòîâàíû.&10-18 - Òðåáóåòñÿ ïîääåðæêà äîïîëíèòåëüíûõ þíèòîâ.&10-20 - Ëîêàöèÿ.&10-21 - Ñòàòóñ è ìåñòîíàõîæäåíèå.&10-22 - Âûäâèãàéòåñü ê ëîêàöèè.&10-27 - Ìåíÿþ ìàðêèðîâêó ïàòðóëÿ.&10-30 - Äîðîæíî-òðàíñïîðòíîå ïðîèñøåñòâèå.&10-40 - Áîëüøîå ñêîïëåíèå ëþäåé (áîëåå 4).&10-41 - Íåëåãàëüíàÿ àêòèâíîñòü.&10-46 - Ïðîâîæó îáûñê.&10-55 - Òðàôôèê ñòîï.&10-57 VICTOR - Ïîãîíÿ çà àâòîìîáèëåì.&10-57 FOXTROT - Ïåøàÿ ïîãîíÿ.&10-66 - Òðàôôèê ñòîï ïîâûøåííîãî ðèñêà.&10-70 - Çàïðîñ ïîääåðæêè.&10-71 - Çàïðîñ ìåäèöèíñêîé ïîääåðæêè.&10-88 - Òåðàêò/×Ñ.&10-99 - Ñèòóàöèÿ óðåãóëèðîâàíà.&10-100 Âðåìåííî íåäîñòóïåí äëÿ âûçîâîâ.' }
	add_unique(modules.notes.data, situate_codes)
	add_unique(modules.notes.data, teen_codes)

	if module ~= 'prison' then
		local markup_patrool = { note_name = 'Ìàðêèðîâêè ïàòðóëÿ', note_text = 'Îñíîâíûå:&ADAM [A] - Ïàòðóëü èç 2/3 îôèöåðîâ íà êðóçåðå.&LINCOLN [L] - Îäèíî÷íûé ïàòðóëü íà êðóçåðå.&MARY [M] - Îäèíî÷íûé ïàòðóëü íà ìîòîöèêëå.&HENRY [H] - Âûñîêîñêîðîñòîé ïàòðóëü.&AIR [AIR] - Âîçäóøíûé ïàòðóëü.&Air Support Division [ASD] - Âîçäóøíàÿ ïîääåðæêà.&&Äîïîëíèòåëüíûå:&CHARLIE [C] - Ãðóïïà çàõâàòà.&ROBERT [R] - Îòäåë Äåòåêòèâîâ.&SUPERVISOR [SV] - Ðóêîâîäÿùèé ñîñòàâ.&DAVID [D] - Cïåöèàëüíûé îòäåë SWAT.&EDWARD [E] - Ýâàêóàòîð ïîëèöèè.&NORA [N] - íåìàðêèðîâàííàÿ åäèíèöà ïàòðóëÿ.'}
		add_unique(modules.notes.data, markup_patrool)
	end

	save_module('notes')
end
local russian_characters = {
    [168] = '¨', [184] = '¸', [192] = 'À', [193] = 'Á', [194] = 'Â', [195] = 'Ã', [196] = 'Ä', [197] = 'Å', [198] = 'Æ', [199] = 'Ç', [200] = 'È', [201] = 'É', [202] = 'Ê', [203] = 'Ë', [204] = 'Ì', [205] = 'Í', [206] = 'Î', [207] = 'Ï', [208] = 'Ð', [209] = 'Ñ', [210] = 'Ò', [211] = 'Ó', [212] = 'Ô', [213] = 'Õ', [214] = 'Ö', [215] = '×', [216] = 'Ø', [217] = 'Ù', [218] = 'Ú', [219] = 'Û', [220] = 'Ü', [221] = 'Ý', [222] = 'Þ', [223] = 'ß', [224] = 'à', [225] = 'á', [226] = 'â', [227] = 'ã', [228] = 'ä', [229] = 'å', [230] = 'æ', [231] = 'ç', [232] = 'è', [233] = 'é', [234] = 'ê', [235] = 'ë', [236] = 'ì', [237] = 'í', [238] = 'î', [239] = 'ï', [240] = 'ð', [241] = 'ñ', [242] = 'ò', [243] = 'ó', [244] = 'ô', [245] = 'õ', [246] = 'ö', [247] = '÷', [248] = 'ø', [249] = 'ù', [250] = 'ú', [251] = 'û', [252] = 'ü', [253] = 'ý', [254] = 'þ', [255] = 'ÿ',
}
function string.rlower(s)
    s = s:lower()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:lower()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 192 and ch <= 223 then -- upper russian characters
            output = output .. russian_characters[ch + 32]
        elseif ch == 168 then -- ¨
            output = output .. russian_characters[184]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end
function string.rupper(s)
    s = s:upper()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:upper()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 224 and ch <= 255 then -- lower russian characters
            output = output .. russian_characters[ch - 32]
        elseif ch == 184 then -- ¸
            output = output .. russian_characters[168]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end
function TranslateNick(name)
	if name:match('%a+') then
        for k, v in pairs({['ph'] = 'ô',['Ph'] = 'Ô',['Ch'] = '×',['ch'] = '÷',['Th'] = 'Ò',['th'] = 'ò',['Sh'] = 'Ø',['sh'] = 'ø' ,['Ae'] = 'Ý',['ae'] = 'ý',['size'] = 'ñàéç',['Jj'] = 'Äæåéäæåé',['Whi'] = 'Âàé',['lack'] = 'ëýê',['whi'] = 'âàé',['Ck'] = 'Ê',['ck'] = 'ê',['Kh'] = 'Õ',['kh'] = 'õ',['hn'] = 'í',['Hen'] = 'Ãåí',['Zh'] = 'Æ',['zh'] = 'æ',['Yu'] = 'Þ',['yu'] = 'þ',['Yo'] = '¨',['yo'] = '¸',['Cz'] = 'Ö',['cz'] = 'ö', ['ia'] = 'ÿ', ['ea'] = 'è',['Ya'] = 'ß', ['ya'] = 'ÿ', ['ove'] = 'àâ',['ay'] = 'ýé', ['rise'] = 'ðàéç',['oo'] = 'ó', ['Oo'] = 'Ó', ['Ee'] = 'È', ['ee'] = 'è', ['Un'] = 'Àí', ['un'] = 'àí', ['Ci'] = 'Öè', ['ci'] = 'öè', ['yse'] = 'óç', ['cate'] = 'êåéò', ['eow'] = 'ÿó', ['rown'] = 'ðàóí', ['yev'] = 'óåâ', ['Babe'] = 'Áýéáè', ['Jason'] = 'Äæåéñîí', ['Alexei'] = 'Àëåêñåé', ['Alex'] = 'Àëåêñ', ['liy'] = 'ëèé', ['ane'] = 'åéí', ['ame'] = 'åéì'}) do
            name = name:gsub(k, v) 
        end
		for k, v in pairs({['B'] = 'Á',['Z'] = 'Ç',['T'] = 'Ò',['Y'] = 'É',['P'] = 'Ï',['J'] = 'Äæ',['X'] = 'Êñ',['G'] = 'Ã',['V'] = 'Â',['H'] = 'Õ',['N'] = 'Í',['E'] = 'Å',['I'] = 'È',['D'] = 'Ä',['O'] = 'Î',['K'] = 'Ê',['F'] = 'Ô',['y`'] = 'û',['e`'] = 'ý',['A'] = 'À',['C'] = 'Ê',['L'] = 'Ë',['M'] = 'Ì',['W'] = 'Â',['Q'] = 'Ê',['U'] = 'À',['R'] = 'Ð',['S'] = 'Ñ',['zm'] = 'çüì',['h'] = 'õ',['q'] = 'ê',['y'] = 'è',['a'] = 'à',['w'] = 'â',['b'] = 'á',['v'] = 'â',['g'] = 'ã',['d'] = 'ä',['e'] = 'å',['z'] = 'ç',['i'] = 'è',['j'] = 'æ',['k'] = 'ê',['l'] = 'ë',['m'] = 'ì',['n'] = 'í',['o'] = 'î',['p'] = 'ï',['r'] = 'ð',['s'] = 'ñ',['t'] = 'ò',['u'] = 'ó',['f'] = 'ô',['x'] = 'x',['c'] = 'ê',['``'] = 'ú',['`'] = 'ü',['_'] = ' '}) do
            name = name:gsub(k, v) 
        end
        return name
    end
	return name
end
function ReverseTranslateNick(name)
    local translit_table = {
        ['ô'] = 'f', ['Ô'] = 'F', ['÷'] = 'ch', ['×'] = 'Ch',
        ['ò'] = 't', ['Ò'] = 'T', ['ø'] = 'sh', ['Ø'] = 'Sh',
        ['è'] = 'i', ['Ý'] = 'E', ['ý'] = 'e', ['ñ'] = 's',
        ['æ'] = 'zh', ['Æ'] = 'Zh', ['þ'] = 'yu', ['Þ'] = 'Yu',
        ['¸'] = 'yo', ['¨'] = 'Yo', ['ö'] = 'ts', ['Ö'] = 'Ts',
        ['ÿ'] = 'ya', ['ß'] = 'Ya', ['àâ'] = 'ov', ['ýé'] = 'ey',
        ['ó'] = 'u', ['Ó'] = 'U', ['È'] = 'I', ['àí'] = 'an',
        ['öè'] = 'tsi', ['óç'] = 'uz', ['êåéò'] = 'kate', ['ÿó'] = 'yau',
        ['ðàóí'] = 'rown', ['óåâ'] = 'uev', ['Áýéáè'] = 'Baby',
        ['Äæåéñîí'] = 'Jason', ['Àëåêñåé'] = 'Alexei', ['Àëåêñ'] = 'Alex', ['ëèé'] = 'liy', ['åéí'] = 'ein', ['åéì'] = 'ame'
    } 
    for k, v in pairs(translit_table) do
        name = name:gsub(k, v)
    end 
    local char_table = {
        ['À'] = 'A', ['Á'] = 'B', ['Â'] = 'V', ['Ã'] = 'G', ['Ä'] = 'D',
        ['Å'] = 'E', ['¨'] = 'Yo', ['Æ'] = 'Zh', ['Ç'] = 'Z', ['È'] = 'I',
        ['É'] = 'Y', ['Ê'] = 'K', ['Ë'] = 'L', ['Ì'] = 'M', ['Í'] = 'N',
        ['Î'] = 'O', ['Ï'] = 'P', ['Ð'] = 'R', ['Ñ'] = 'S', ['Ò'] = 'T',
        ['Ó'] = 'U', ['Ô'] = 'F', ['Õ'] = 'H', ['Ö'] = 'Ts', ['×'] = 'Ch',
        ['Ø'] = 'Sh', ['Ù'] = 'Sch', ['Ú'] = '', ['Û'] = 'Y', ['Ü'] = '',
        ['Ý'] = 'E', ['Þ'] = 'Yu', ['ß'] = 'Ya',
        ['à'] = 'a', ['á'] = 'b', ['â'] = 'v', ['ã'] = 'g', ['ä'] = 'd',
        ['å'] = 'e', ['¸'] = 'yo', ['æ'] = 'zh', ['ç'] = 'z', ['è'] = 'i',
        ['é'] = 'y', ['ê'] = 'k', ['ë'] = 'l', ['ì'] = 'm', ['í'] = 'n',
        ['î'] = 'o', ['ï'] = 'p', ['ð'] = 'r', ['ñ'] = 's', ['ò'] = 't',
        ['ó'] = 'u', ['ô'] = 'f', ['õ'] = 'h', ['ö'] = 'ts', ['÷'] = 'ch',
        ['ø'] = 'sh', ['ù'] = 'sch', ['ú'] = '', ['û'] = 'y', ['ü'] = '',
        ['ý'] = 'e', ['þ'] = 'yu', ['ÿ'] = 'ya', [' '] = '_'
    }
    for k, v in pairs(char_table) do
        name = name:gsub(k, v)
    end
    return name
end
function isParamSampID(id)
	id = tonumber(id)
	if id ~= nil and tostring(id):find('%d') and not tostring(id):find('%D') and string.len(id) >= 1 and string.len(id) <= 3 then
		if id == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
			return true
		elseif sampIsPlayerConnected(id) then
			return true
		end
	end
	return false
end
function playNotifySound()
	local path_audio = configDirectory .. "/Resourse/notify.mp3"
	if doesFileExist(path_audio) then
		local audio = loadAudioStream(path_audio)
		setAudioStreamState(audio, 1)
	end
end
function show_fast_menu(id)
	if isParamSampID(id) then 
		player_id = tonumber(id)
		MODULE.FastMenu.Window[0] = true
	else
		if isMonetLoader() or settings.general.bind_fastmenu == nil then
			if not MODULE.FastMenuPlayers.Window[0] then
				sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/hm [ID]', message_color)
			end
		elseif settings.general.bind_fastmenu and hotkey_no_errors then
			sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/hm [ID] {ffffff}èëè íàâåäèòåñü íà èãðîêà ÷åðåç ' .. message_color_hex .. 'ÏÊÌ + ' .. getNameKeysFrom(settings.general.bind_fastmenu), message_color) 
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/hm [ID]', message_color)
		end 
		playNotifySound()
	end 
end
function show_leader_fast_menu(id)
	if isParamSampID(id) then
		player_id = tonumber(id)
		MODULE.LeaderFastMenu.Window[0] = true
	else
		if isMonetLoader() or settings.general.bind_leader_fastmenu == nil then
			sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/lm [ID]', message_color)
		elseif settings.general.bind_leader_fastmenu and hotkey_no_errors then
			sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/lm [ID] {ffffff}èëè íàâåäèòåñü íà èãðîêà ÷åðåç ' .. message_color_hex .. 'ÏÊÌ + ' .. getNameKeysFrom(settings.general.bind_leader_fastmenu), message_color) 
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/lm [ID]', message_color)
		end 
		playNotifySound()
	end
end
function get_players()
	local myPlayerId = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myX, myY, myZ = getCharCoordinates(PLAYER_PED)
	local playersInRange = {}
	for temp1, h in pairs(getAllChars()) do
		temp2, id = sampGetPlayerIdByCharHandle(h)
		temp3, m = sampGetPlayerIdByCharHandle(PLAYER_PED)
		id = tonumber(id)
		if id ~= -1 and id ~= m and doesCharExist(h) then
			local x, y, z = getCharCoordinates(h)
			local mx, my, mz = getCharCoordinates(PLAYER_PED)
			local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
			if dist <= 5 then
				table.insert(playersInRange, id)
			end
		end
	end
	return playersInRange
end
function openLink(link)
	if isMonetLoader() then
		ffi.cdef[[ void _Z12AND_OpenLinkPKc(const char* link); ]]
		ffi.load('GTASA')._Z12AND_OpenLinkPKc(link)
	else
		os.execute("explorer " .. link)
	end
end
local servers = {
	{name = 'Unknown server', number = '00'},
	-- Arizona
	{name = 'Phoenix', number = '01'},
	{name = 'Tucson', number = '02'},
	{name = 'Scottdale', number = '03'},
	{name = 'Chandler', number = '04'},
	{name = 'Brainburg', number = '05'},
	{name = 'SaintRose', number = '06'},
	{name = 'Mesa', number = '07'},
	{name = 'Red Rock', number = '08'},
	{name = 'Yuma', number = '09'},
	{name = 'Surprise', number = '10'},
	{name = 'Prescott', number = '11'},
	{name = 'Glendale', number = '12'},
	{name = 'Kingman', number = '13'},
	{name = 'Winslow', number = '14'},
	{name = 'Payson', number = '15'},
	{name = 'Gilbert', number = '16'},
	{name = 'Show Low', number = '17'},
	{name = 'Casa Grande', number = '18'},
	{name = 'Page', number = '19'},
	{name = 'Sun City', number = '20'},
	{name = 'Queen Creek', number = '21'},
	{name = 'Sedona', number = '22'},
	{name = 'Holiday', number = '23'},
	{name = 'Wednesday', number = '24'},
	{name = 'Yava', number = '25'},
	{name = 'Faraway', number = '26'},
	{name = 'Bumble Bee', number = '27'},
	{name = 'Christmas', number = '28'},
	{name = 'Mirage', number = '29'},
	{name = 'Love', number = '30'},
	{name = 'Drake', number = '31'},
	{name = 'Space', number = '32'},
	-- Arizona Mobile
	{name = 'Mobile III', number = '103'},
	{name = 'Mobile II', number = '102'},
	{name = 'Mobile I', number = '101'},
	-- Arizona VC
	{name = 'Vice City'	, number = '200'},
	-- Rodina
	{name = 'Öåíòðàëüíûé îêðóã'	, number = '301'},
	{name = 'Þæíûé îêðóã', number = '302'},
	{name = 'Ñåâåðíûé îêðóã', number = '303'},
	{name = 'Âîñòî÷íûé îêðóã', number = '304'},
	{name = 'Çàïàäíûé îêðóã', number = '305'},
	{name = 'Ïðèìîðñêèé îêðóã', number = '306'},
	{name = 'Ôåäåðàëüíûé îêðóã', number = '307'},
	-- Rodina Mobile
	{name = 'Ìîñêâà', number = '401'},
}
function getServerNumber()
	local server = "00"
	for _, s in ipairs(servers) do
		if sampGetCurrentServerName():gsub('%-', ' '):find(s.name) then
			server = s.number
			break
		end
	end
	return server
end
function getServerName(number)
	local server = ''
	for _, s in ipairs(servers) do
		if tostring(number) == tostring(s.number) then
			server = s.name
			break
		end
	end
	return server
end
function sampGetPlayerIdByNickname(nick)
	local id = -1

	if not isMonetLoader() then
		local myid = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
		if sampGetPlayerNickname(myid) == (nick) then return myid end
	end

	for i = 0, 999 do
	    if sampIsPlayerConnected(i) and sampGetPlayerNickname(i):find(nick) then
		   id = i
		   break
	    end
	end
	return id
end
function getNameOfARZVehicleModel(id)
	local need_download_arzveh = false
	if doesFileExist(modules.arz_veh.path) and modules.arz_veh.data and #modules.arz_veh.data ~= 0 then
		local check = false
		for _, vehicle in ipairs(modules.arz_veh.data) do
			if vehicle.model_id == id then
				check = true
				--sampAddChatMessage("[Rodina Helper] {ffffff}Ñàìûé áëèæàéøèé òðàíñïîðò ê âàì ýòî " .. vehicle.name ..  " [ID " .. id .. "].", message_color)
				return vehicle.name
			end
		end
		if not check then
			need_download_arzveh = true
		end
	else
		need_download_arzveh = true
	end
	if need_download_arzveh then
		sampAddChatMessage('[Rodina Helper] {ffffff}Íåò íàçâàíèÿ ìîäåëè ò/c ñ ID ' .. id .. ", òàê êàê îòñóñòâóåò ôàéë Vehicles.json", message_color)
		sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóþ ïðîñòî "òðàíñïîðòíîãî ñðåäñòâà", è ïûòàþñü ñêà÷àòü ôàéë...', message_color)
		download_file = 'arz_veh'
		if tonumber(getServerNumber()) > 300 then
			downloadFileFromUrlToPath('https://Fil.github.io/arizona-helper/SmartVEH/VehiclesRodina.json', modules.arz_veh.path)
		else
			downloadFileFromUrlToPath('https://Fil.github.io/arizona-helper/SmartVEH/Vehicles.json', modules.arz_veh.path)
		end
		return 'òðàíñïîðòíîãî ñðåäñòâà'
	end
end
function getAreaRu(x, y, z)
	local streets = {
		{"Ãîëüô-êëóá Àâèñïà", -2667.810, -302.135, -28.831, -2646.400, -262.320, 71.169},
		{"Àýðîïîðò ÑÔ", -1315.420, -405.388, 15.406, -1264.400, -209.543, 25.406},
		{"Ãîëüô-êëóá Àâèñïà", -2550.040, -355.493, 0.000, -2470.040, -318.493, 39.700},
		{"Àýðîïîðò ÑÔ", -1490.330, -209.543, 15.406, -1264.400, -148.388, 25.406},
		{"Ãàðñèÿ", -2395.140, -222.589, -5.3, -2354.090, -204.792, 200.000},
		{"Òåíèñòûå ðó÷üè", -1632.830, -2263.440, -3.0, -1601.330, -2231.790, 200.000},
		{"Âîñòî÷íûé ËÑ", 2381.680, -1494.030, -89.084, 2421.030, -1454.350, 110.916},
		{"Ãðóçîâîé ñêëàä ËÂ", 1236.630, 1163.410, -89.084, 1277.050, 1203.280, 110.916},
		{"Áëýêôèëäñêèé ïåðåêð¸ñòîê", 1277.050, 1044.690, -89.084, 1315.350, 1087.630, 110.916},
		{"Ãîëüô-êëóá Àâèñïà", -2470.040, -355.493, 0.000, -2270.040, -318.493, 46.100},
		{"Òåìïë äðàéâ", 1252.330, -926.999, -89.084, 1357.000, -910.170, 110.916},
		{"Âîêçàë ËÑ", 1692.620, -1971.800, -20.492, 1812.620, -1932.800, 79.508},
		{"Ãðóçîâîé ñêëàä ËÂ", 1315.350, 1044.690, -89.084, 1375.600, 1087.630, 110.916},
		{"Ëîñ-Ôëîðåñ", 2581.730, -1454.350, -89.084, 2632.830, -1393.420, 110.916},
		{"Àçàðòíûé ðàéîí", 2437.390, 1858.100, -39.084, 2495.090, 1970.850, 60.916},
		{"Èñòåðáýéñêèé õèìçàâîä", -1132.820, -787.391, 0.000, -956.476, -768.027, 200.000},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", 1370.850, -1170.870, -89.084, 1463.900, -1130.850, 110.916},
		{"Âîñòî÷íàÿ Ýñïàëàíäà", -1620.300, 1176.520, -4.5, -1580.010, 1274.260, 200.000},
		{"Ñòàíöèÿ Ìàðêåò", 787.461, -1410.930, -34.126, 866.009, -1310.210, 65.874},
		{"Âîêçàë ËÂ", 2811.250, 1229.590, -39.594, 2861.250, 1407.590, 60.406},
		{"Ïåðåêð¸ñòîê Ìîíòãîìåðè", 1582.440, 347.457, 0.000, 1664.620, 401.750, 200.000},
		{"Ìîñò Ôðåäåðèê", 2759.250, 296.501, 0.000, 2774.250, 594.757, 200.000},
		{"Ñòàíöèÿ Éåëëîó-Áåëë", 1377.480, 2600.430, -21.926, 1492.450, 2687.360, 78.074},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", 1507.510, -1385.210, 110.916, 1582.550, -1325.310, 335.916},
		{"Îòåëü Íî÷íûå âîëêè", 2185.330, -1210.740, -89.084, 2281.450, -1154.590, 110.916},
		{"Ãîðà Âàéíâóä", 1318.130, -910.170, -89.084, 1357.000, -768.027, 110.916},
		{"Ãîëüô-êëóá Àâèñïà", -2361.510, -417.199, 0.000, -2270.040, -355.493, 200.000},
		{"Áîëüíèöà Äæåôôåðñîí", 1996.910, -1449.670, -89.084, 2056.860, -1350.720, 110.916},
		{"Çàïàäàíîå øîññå", 1236.630, 2142.860, -89.084, 1297.470, 2243.230, 110.916},
		{"Äæåôôåðñîí", 2124.660, -1494.030, -89.084, 2266.210, -1449.670, 110.916},
		{"Ñåâåðíîå øîññå ËÂ", 1848.400, 2478.490, -89.084, 1938.800, 2553.490, 110.916},
		{"Ðîäåî äðàéâ", 422.680, -1570.200, -89.084, 466.223, -1406.050, 110.916},
		{"Âîêçàë ÑÔ", -2007.830, 56.306, 0.000, -1922.000, 224.782, 100.000},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", 1391.050, -1026.330, -89.084, 1463.900, -926.999, 110.916},
		{"Çàïàäíûé Ðåäñàíäñ", 1704.590, 2243.230, -89.084, 1777.390, 2342.830, 110.916},
		{"Ìàëåíüêàÿ Ìåêñèêà", 1758.900, -1722.260, -89.084, 1812.620, -1577.590, 110.916},
		{"Áëýêôèëäñêèé ïåðåêð¸ñòîê", 1375.600, 823.228, -89.084, 1457.390, 919.447, 110.916},
		{"Àýðîïîðò ËÑ", 1974.630, -2394.330, -39.084, 2089.000, -2256.590, 60.916},
		{"Áåêîí-Õèëë", -399.633, -1075.520, -1.489, -319.033, -977.516, 198.511},
		{"Ðîäåî äðàéâ", 334.503, -1501.950, -89.084, 422.680, -1406.050, 110.916},
		{"Ãîðà Âàéíâóä", 225.165, -1369.620, -89.084, 334.503, -1292.070, 110.916},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", 1724.760, -1250.900, -89.084, 1812.620, -1150.870, 110.916},
		{"Ñòðèï", 2027.400, 1703.230, -89.084, 2137.400, 1783.230, 110.916},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", 1378.330, -1130.850, -89.084, 1463.900, -1026.330, 110.916},
		{"Áëýêôèëäñêèé ïåðåêð¸ñòîê", 1197.390, 1044.690, -89.084, 1277.050, 1163.390, 110.916},
		{"Àâòîâîêçàë", 1073.220, -1842.270, -89.084, 1323.900, -1804.210, 110.916},
		{"Ìîíòãîìåðè", 1451.400, 347.457, -6.1, 1582.440, 420.802, 200.000},
		{"Ôîñòåðñêàÿ äîëèíà", -2270.040, -430.276, -1.2, -2178.690, -324.114, 200.000},
		{"Áëýêôèëä", 1325.600, 596.349, -89.084, 1375.600, 795.010, 110.916},
		{"Àýðîïîðò ËÑ", 2051.630, -2597.260, -39.084, 2152.450, -2394.330, 60.916},
		{"Ãîðà Âàéíâóä", 1096.470, -910.170, -89.084, 1169.130, -768.027, 110.916},
		{"Ãîëüô-êîðò Éåëëîóáåëë", 1457.460, 2723.230, -89.084, 1534.560, 2863.230, 110.916},
		{"Ñòðèï", 2027.400, 1783.230, -89.084, 2162.390, 1863.230, 110.916},
		{"Äæåôôåðñîí", 2056.860, -1210.740, -89.084, 2185.330, -1126.320, 110.916},
		{"Ãîðà Âàéíâóä", 952.604, -937.184, -89.084, 1096.470, -860.619, 110.916},
		{"Ýëü-Êåáðàäîñ", -1372.140, 2498.520, 0.000, -1277.590, 2615.350, 200.000},
		{"Ëàñ-Êîëèíàñ", 2126.860, -1126.320, -89.084, 2185.330, -934.489, 110.916},
		{"Ëàñ-Êîëèíàñ", 1994.330, -1100.820, -89.084, 2056.860, -920.815, 110.916},
		{"Ãîðà Âàéíâóä", 647.557, -954.662, -89.084, 768.694, -860.619, 110.916},
		{"Ãðóçîâîé ñêëàä ËÂ", 1277.050, 1087.630, -89.084, 1375.600, 1203.280, 110.916},
		{"Ñåâåðíîå øîññå ËÂ", 1377.390, 2433.230, -89.084, 1534.560, 2507.230, 110.916},
		{"Óèëëîóôèëä", 2201.820, -2095.000, -89.084, 2324.000, -1989.900, 110.916},
		{"Ñåâåðíîå øîññå ËÂ", 1704.590, 2342.830, -89.084, 1848.400, 2433.230, 110.916},
		{"Òåìïë äðàéâ", 1252.330, -1130.850, -89.084, 1378.330, -1026.330, 110.916},
		{"Ìàëåíüêàÿ Ìåêñèêà", 1701.900, -1842.270, -89.084, 1812.620, -1722.260, 110.916},
		{"Êâèíñ", -2411.220, 373.539, 0.000, -2253.540, 458.411, 200.000},
		{"Àýðîïîðò ËÂ", 1515.810, 1586.400, -12.500, 1729.950, 1714.560, 87.500},
		{"Ãîðà Âàéíâóä", 225.165, -1292.070, -89.084, 466.223, -1235.070, 110.916},
		{"Òåìïë äðàéâ", 1252.330, -1026.330, -89.084, 1391.050, -926.999, 110.916},
		{"Âîñòî÷íûé ËÑ", 2266.260, -1494.030, -89.084, 2381.680, -1372.040, 110.916},
		{"Âîñòî÷íîå øîññå ËÂ", 2623.180, 943.235, -89.084, 2749.900, 1055.960, 110.916},
		{"Óèëëîóôèëä", 2541.700, -1941.400, -89.084, 2703.580, -1852.870, 110.916},
		{"Ëàñ-Êîëèíàñ", 2056.860, -1126.320, -89.084, 2126.860, -920.815, 110.916},
		{"Âîñòî÷íîå øîññå ËÂ", 2625.160, 2202.760, -89.084, 2685.160, 2442.550, 110.916},
		{"Ðîäåî äðàéâ", 225.165, -1501.950, -89.084, 334.503, -1369.620, 110.916},
		{"Ïóñòûííûé îêðóã", -365.167, 2123.010, -3.0, -208.570, 2217.680, 200.000},
		{"Âîñòî÷íîå øîññå ËÂ", 2536.430, 2442.550, -89.084, 2685.160, 2542.550, 110.916},
		{"Ðîäåî äðàéâ", 334.503, -1406.050, -89.084, 466.223, -1292.070, 110.916},
		{"Âàéíâóä", 647.557, -1227.280, -89.084, 787.461, -1118.280, 110.916},
		{"Ðîäåî äðàéâ", 422.680, -1684.650, -89.084, 558.099, -1570.200, 110.916},
		{"Ñåâåðíîå øîññå ËÂ", 2498.210, 2542.550, -89.084, 2685.160, 2626.550, 110.916},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", 1724.760, -1430.870, -89.084, 1812.620, -1250.900, 110.916},
		{"Ðîäåî äðàéâ", 225.165, -1684.650, -89.084, 312.803, -1501.950, 110.916},
		{"Äæåôôåðñîí", 2056.860, -1449.670, -89.084, 2266.210, -1372.040, 110.916},
		{"Òóìàííûé îêðóã", 603.035, 264.312, 0.000, 761.994, 366.572, 200.000},
		{"Òåìïë äðàéâ", 1096.470, -1130.840, -89.084, 1252.330, -1026.330, 110.916},
		{"Êðàñíûé æ/ä ìîñò", -1087.930, 855.370, -89.084, -961.950, 986.281, 110.916},
		{"Ïëÿæ Âåðîíà", 1046.150, -1722.260, -89.084, 1161.520, -1577.590, 110.916},
		{"Öåíòðàëüíûé áàíê ËÑ", 1323.900, -1722.260, -89.084, 1440.900, -1577.590, 110.916},
		{"Ãîðà Âàéíâóä", 1357.000, -926.999, -89.084, 1463.900, -768.027, 110.916},
		{"Ðîäåî äðàéâ", 466.223, -1570.200, -89.084, 558.099, -1385.070, 110.916},
		{"Ãîðà Âàéíâóä", 911.802, -860.619, -89.084, 1096.470, -768.027, 110.916},
		{"Ãîðà Âàéíâóä", 768.694, -954.662, -89.084, 952.604, -860.619, 110.916},
		{"Þæíîå øîññå ËÂ", 2377.390, 788.894, -89.084, 2537.390, 897.901, 110.916},
		{"Àéäëâóä", 1812.620, -1852.870, -89.084, 1971.660, -1742.310, 110.916},
		{"Ïîðò ËÑ", 2089.000, -2394.330, -89.084, 2201.820, -2235.840, 110.916},
		{"Êîììåð÷åñêèé ðàéîí", 1370.850, -1577.590, -89.084, 1463.900, -1384.950, 110.916},
		{"Ñåâåðíîå øîññå ËÂ", 2121.400, 2508.230, -89.084, 2237.400, 2663.170, 110.916},
		{"Òåìïë äðàéâ", 1096.470, -1026.330, -89.084, 1252.330, -910.170, 110.916},
		{"Ãëåí Ïàðê", 1812.620, -1449.670, -89.084, 1996.910, -1350.720, 110.916},
		{"Àýðîïîðò ËÂ", -1242.980, -50.096, 0.000, -1213.910, 578.396, 200.000},
		{"Ìîñò Ìàðòèíà", -222.179, 293.324, 0.000, -122.126, 476.465, 200.000},
		{"Ñòðèï", 2106.700, 1863.230, -89.084, 2162.390, 2202.760, 110.916},
		{"Óèëëîóôèëä", 2541.700, -2059.230, -89.084, 2703.580, -1941.400, 110.916},
		{"Êàíàë Ìàðèíà", 807.922, -1577.590, -89.084, 926.922, -1416.250, 110.916},
		{"Àýðîïîðò ËÂ", 1457.370, 1143.210, -89.084, 1777.400, 1203.280, 110.916},
		{"Àéäëâóä", 1812.620, -1742.310, -89.084, 1951.660, -1602.310, 110.916},
		{"Âîñòî÷íàÿ Ýñïàëàíäà", -1580.010, 1025.980, -6.1, -1499.890, 1274.260, 200.000},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", 1370.850, -1384.950, -89.084, 1463.900, -1170.870, 110.916},
		{"Ìîñò Ìàêî", 1664.620, 401.750, 0.000, 1785.140, 567.203, 200.000},
		{"Ðîäåî äðàéâ", 312.803, -1684.650, -89.084, 422.680, -1501.950, 110.916},
		{"Ïëîùàäü Ïåðøèíã", 1440.900, -1722.260, -89.084, 1583.500, -1577.590, 110.916},
		{"Ãîðà Âàéíâóä", 687.802, -860.619, -89.084, 911.802, -768.027, 110.916},
		{"Ìîñò Ãàíò", -2741.070, 1490.470, -6.1, -2616.400, 1659.680, 200.000},
		{"Ëàñ-Êîëèíàñ", 2185.330, -1154.590, -89.084, 2281.450, -934.489, 110.916},
		{"Ãîðà Âàéíâóä", 1169.130, -910.170, -89.084, 1318.130, -768.027, 110.916},
		{"Ñåâåðíîå øîññå ËÂ", 1938.800, 2508.230, -89.084, 2121.400, 2624.230, 110.916},
		{"Êîììåð÷åñêèé ðàéîí", 1667.960, -1577.590, -89.084, 1812.620, -1430.870, 110.916},
		{"ÊÏÏ ËÑ-ÑÔ", 72.648, -1544.170, -89.084, 225.165, -1404.970, 110.916},
		{"Ðîêà Ýñêàëàíòå", 2536.430, 2202.760, -89.084, 2625.160, 2442.550, 110.916},
		{"ÊÏÏ ËÑ-ÑÔ", 72.648, -1684.650, -89.084, 225.165, -1544.170, 110.916},
		{"Öåíòðàëüíûé Ðûíîê", 952.663, -1310.210, -89.084, 1072.660, -1130.850, 110.916},
		{"Ëàñ-Êîëèíàñ", 2632.740, -1135.040, -89.084, 2747.740, -945.035, 110.916},
		{"Ãîðà Âàéíâóä", 861.085, -674.885, -89.084, 1156.550, -600.896, 110.916},
		{"Êèíãñ", -2253.540, 373.539, -9.1, -1993.280, 458.411, 200.000},
		{"Âîñòî÷íûé Ðåäñàíäñ", 1848.400, 2342.830, -89.084, 2011.940, 2478.490, 110.916},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", -1580.010, 744.267, -6.1, -1499.890, 1025.980, 200.000},
		{"Àâòîâîêçàë", 1046.150, -1804.210, -89.084, 1323.900, -1722.260, 110.916},
		{"Ãîðà Âàéíâóä", 647.557, -1118.280, -89.084, 787.461, -954.662, 110.916},
		{"Îêåàíñêîå ïîáåðåæüå", -2994.490, 277.411, -9.1, -2867.850, 458.411, 200.000},
		{"Ãðèíãëàññêèé êîëëåäæ", 964.391, 930.890, -89.084, 1166.530, 1044.690, 110.916},
		{"Ãëåí Ïàðê", 1812.620, -1100.820, -89.084, 1994.330, -973.380, 110.916},
		{"Ãðóçîâîé ñêëàä ËÂ", 1375.600, 919.447, -89.084, 1457.370, 1203.280, 110.916},
		{"Ïóñòûííûé îêðóã", -405.770, 1712.860, -3.0, -276.719, 1892.750, 200.000},
		{"Ïëÿæ Âåðîíà", 1161.520, -1722.260, -89.084, 1323.900, -1577.590, 110.916},
		{"Âîñòî÷íûé ËÑ", 2281.450, -1372.040, -89.084, 2381.680, -1135.040, 110.916},
		{"Äâîðåö Êàëèãóëû", 2137.400, 1703.230, -89.084, 2437.390, 1783.230, 110.916},
		{"Àéäëâóä", 1951.660, -1742.310, -89.084, 2124.660, -1602.310, 110.916},
		{"Ïèëèãðèì", 2624.400, 1383.230, -89.084, 2685.160, 1783.230, 110.916},
		{"Àéäëâóä", 2124.660, -1742.310, -89.084, 2222.560, -1494.030, 110.916},
		{"Êâèíñ", -2533.040, 458.411, 0.000, -2329.310, 578.396, 200.000},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", -1871.720, 1176.420, -4.5, -1620.300, 1274.260, 200.000},
		{"Êîììåð÷åñêèé ðàéîí", 1583.500, -1722.260, -89.084, 1758.900, -1577.590, 110.916},
		{"Âîñòî÷íûé ËÑ", 2381.680, -1454.350, -89.084, 2462.130, -1135.040, 110.916},
		{"Êàíàë Ìàðèíà", 647.712, -1577.590, -89.084, 807.922, -1416.250, 110.916},
		{"Ãîðà Âàéíâóä", 72.648, -1404.970, -89.084, 225.165, -1235.070, 110.916},
		{"Âàéíâóä", 647.712, -1416.250, -89.084, 787.461, -1227.280, 110.916},
		{"Âîñòî÷íûé ËÑ", 2222.560, -1628.530, -89.084, 2421.030, -1494.030, 110.916},
		{"Ðîäåî äðàéâ", 558.099, -1684.650, -89.084, 647.522, -1384.930, 110.916},
		{"Èñòåðñêèé Òîííåëü", -1709.710, -833.034, -1.5, -1446.010, -730.118, 200.000},
		{"Ðîäåî äðàéâ", 466.223, -1385.070, -89.084, 647.522, -1235.070, 110.916},
		{"Âîñòî÷íûé Ðåäñàíäñ", 1817.390, 2202.760, -89.084, 2011.940, 2342.830, 110.916},
		{"Àçàðòíûé ðàéîí", 2162.390, 1783.230, -89.084, 2437.390, 1883.230, 110.916},
		{"ÁÊ Ðèôà", 1971.660, -1852.870, -89.084, 2222.560, -1742.310, 110.916},
		{"Ïåðåêð¸ñòîê Ìîíòãîìåðè", 1546.650, 208.164, 0.000, 1745.830, 347.457, 200.000},
		{"Óèëëîóôèëä", 2089.000, -2235.840, -89.084, 2201.820, -1989.900, 110.916},
		{"Òåìïë äðàéâ", 952.663, -1130.840, -89.084, 1096.470, -937.184, 110.916},
		{"Ïðèêë Ïàéí", 1848.400, 2553.490, -89.084, 1938.800, 2863.230, 110.916},
		{"Àýðîïîðò ËÑ", 1400.970, -2669.260, -39.084, 2189.820, -2597.260, 60.916},
		{"Áåëûé ìîñò", -1213.910, 950.022, -89.084, -1087.930, 1178.930, 110.916},
		{"Áåëûé ìîñò", -1339.890, 828.129, -89.084, -1213.910, 1057.040, 110.916},
		{"Êðàñíûé æ/ä ìîñò", -1339.890, 599.218, -89.084, -1213.910, 828.129, 110.916},
		{"Êðàñíûé æ/ä ìîñò", -1213.910, 721.111, -89.084, -1087.930, 950.022, 110.916},
		{"Ïëÿæ Âåðîíà", 930.221, -2006.780, -89.084, 1073.220, -1804.210, 110.916},
		{"Çåë¸íûé óò¸ñ", 1073.220, -2006.780, -89.084, 1249.620, -1842.270, 110.916},
		{"Ãîðà Âàéíâóä", 787.461, -1130.840, -89.084, 952.604, -954.662, 110.916},
		{"Ãîðà Âàéíâóä", 787.461, -1310.210, -89.084, 952.663, -1130.840, 110.916},
		{"Êîììåð÷åñêèé ðàéîí", 1463.900, -1577.590, -89.084, 1667.960, -1430.870, 110.916},
		{"Öåíòðàëüíûé Ðûíîê", 787.461, -1416.250, -89.084, 1072.660, -1310.210, 110.916},
		{"Çàïàäíûé Ðîêøîð", 2377.390, 596.349, -89.084, 2537.390, 788.894, 110.916},
		{"Ñåâåðíîå øîññå ËÂ", 2237.400, 2542.550, -89.084, 2498.210, 2663.170, 110.916},
		{"Âîñòî÷íûé ïëÿæ ËÑ", 2632.830, -1668.130, -89.084, 2747.740, -1393.420, 110.916},
		{"Ìîñò Ôàëëîó", 434.341, 366.572, 0.000, 603.035, 555.680, 200.000},
		{"Óèëëîóôèëä", 2089.000, -1989.900, -89.084, 2324.000, -1852.870, 110.916},
		{"×àéíàòàóí", -2274.170, 578.396, -7.6, -2078.670, 744.170, 200.000},
		{"Ñêàëèñòûé ìàññèâ ËÂ", -208.570, 2337.180, 0.000, 8.430, 2487.180, 200.000},
		{"ÁÊ Àöòåêè", 2324.000, -2145.100, -89.084, 2703.580, -2059.230, 110.916},
		{"Èñòåðáýéñêèé õèìçàâîä", -1132.820, -768.027, 0.000, -956.476, -578.118, 200.000},
		{"Êàçèíî Âèñàäæ", 1817.390, 1703.230, -89.084, 2027.400, 1863.230, 110.916},
		{"Îêåàíñêîå ïîáåðåæüå", -2994.490, -430.276, -1.2, -2831.890, -222.589, 200.000},
		{"Ãîðà Âàéíâóä", 321.356, -860.619, -89.084, 687.802, -768.027, 110.916},
		{"Íåôòÿíîé êîìïëåêñ", 176.581, 1305.450, -3.0, 338.658, 1520.720, 200.000},
		{"Ãîðà Âàéíâóä", 321.356, -768.027, -89.084, 700.794, -674.885, 110.916},
		{"Ïèëèãðèì", 2162.390, 1883.230, -89.084, 2437.390, 2012.180, 110.916},
		{"ÁÊ Âàãîñ", 2747.740, -1668.130, -89.084, 2959.350, -1498.620, 110.916},
		{"Äæåôôåðñîí", 2056.860, -1372.040, -89.084, 2281.450, -1210.740, 110.916},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", 1463.900, -1290.870, -89.084, 1724.760, -1150.870, 110.916},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", 1463.900, -1430.870, -89.084, 1724.760, -1290.870, 110.916},
		{"Áåëûé ìîñò", -1499.890, 696.442, -179.615, -1339.890, 925.353, 20.385},
		{"Þæíîå øîññå ËÂ", 1457.390, 823.228, -89.084, 2377.390, 863.229, 110.916},
		{"Âîñòî÷íûé ËÑ", 2421.030, -1628.530, -89.084, 2632.830, -1454.350, 110.916},
		{"Ãðèíãëàññêèé êîëëåäæ", 964.391, 1044.690, -89.084, 1197.390, 1203.220, 110.916},
		{"Ëàñ-Êîëèíàñ", 2747.740, -1120.040, -89.084, 2959.350, -945.035, 110.916},
		{"Ãîðà Âàéíâóä", 737.573, -768.027, -89.084, 1142.290, -674.885, 110.916},
		{"Ïîðò ËÑ", 2201.820, -2730.880, -89.084, 2324.000, -2418.330, 110.916},
		{"Âîñòî÷íûé ËÑ", 2462.130, -1454.350, -89.084, 2581.730, -1135.040, 110.916},
		{"Ãðóâ", 2222.560, -1722.330, -89.084, 2632.830, -1628.530, 110.916},
		{"Ãîëüô-êëóá Àâèñïà", -2831.890, -430.276, -6.1, -2646.400, -222.589, 200.000},
		{"Óèëëîóôèëä", 1970.620, -2179.250, -89.084, 2089.000, -1852.870, 110.916},
		{"Ñåâåðíàÿ Ýñïëàíàäà", -1982.320, 1274.260, -4.5, -1524.240, 1358.900, 200.000},
		{"Êàçèíî Øóëåð", 1817.390, 1283.230, -89.084, 2027.390, 1469.230, 110.916},
		{"Ïîðò ËÑ", 2201.820, -2418.330, -89.084, 2324.000, -2095.000, 110.916},
		{"Ìîòåëü Ïîñëåäíèé ãðîø", 1823.080, 596.349, -89.084, 1997.220, 823.228, 110.916},
		{"Áýéñàéíä-Ìàðèíà", -2353.170, 2275.790, 0.000, -2153.170, 2475.790, 200.000},
		{"Êèíãñ", -2329.310, 458.411, -7.6, -1993.280, 578.396, 200.000},
		{"Ýëü-Êîðîíà", 1692.620, -2179.250, -89.084, 1812.620, -1842.270, 110.916},
		{"Áëýêôèëäñêàÿ ÷àñîâíÿ", 1375.600, 596.349, -89.084, 1558.090, 823.228, 110.916},
		{"Êàçèíî Ðîçîâûé êëþâ", 1817.390, 1083.230, -89.084, 2027.390, 1283.230, 110.916},
		{"Çàïàäíîå øîññå", 1197.390, 1163.390, -89.084, 1236.630, 2243.230, 110.916},
		{"Ëîñ-Ôëîðåñ", 2581.730, -1393.420, -89.084, 2747.740, -1135.040, 110.916},
		{"Êàçèíî Âèñàäæ", 1817.390, 1863.230, -89.084, 2106.700, 2011.830, 110.916},
		{"Ïðèêë Ïàéí", 1938.800, 2624.230, -89.084, 2121.400, 2861.550, 110.916},
		{"Ïëÿæ Âåðîíà", 851.449, -1804.210, -89.084, 1046.150, -1577.590, 110.916},
		{"Ïåðåêð¸ñòîê Ðîáàäà", -1119.010, 1178.930, -89.084, -862.025, 1351.450, 110.916},
		{"Ëèíäåí-Ñàéä", 2749.900, 943.235, -89.084, 2923.390, 1198.990, 110.916},
		{"Ïîðò ËÑ", 2703.580, -2302.330, -89.084, 2959.350, -2126.900, 110.916},
		{"Óèëëîóôèëä", 2324.000, -2059.230, -89.084, 2541.700, -1852.870, 110.916},
		{"Êèíãñ", -2411.220, 265.243, -9.1, -1993.280, 373.539, 200.000},
		{"Êîììåð÷åñêèé ðàéîí", 1323.900, -1842.270, -89.084, 1701.900, -1722.260, 110.916},
		{"Ãîðà Âàéíâóä", 1269.130, -768.027, -89.084, 1414.070, -452.425, 110.916},
		{"Êàíàë Ìàðèíà", 647.712, -1804.210, -89.084, 851.449, -1577.590, 110.916},
		{"Áýòòåðè Ïîéíò", -2741.070, 1268.410, -4.5, -2533.040, 1490.470, 200.000},
		{"Êàçèíî 4 Äðàêîíà", 1817.390, 863.232, -89.084, 2027.390, 1083.230, 110.916},
		{"Áëýêôèëä", 964.391, 1203.220, -89.084, 1197.390, 1403.220, 110.916},
		{"Ñåâåðíîå øîññå ËÂ", 1534.560, 2433.230, -89.084, 1848.400, 2583.230, 110.916},
		{"Ãîëüô-êîðò Éåëëîóáåëë", 1117.400, 2723.230, -89.084, 1457.460, 2863.230, 110.916},
		{"Àéäëâóä", 1812.620, -1602.310, -89.084, 2124.660, -1449.670, 110.916},
		{"Çàïàäíûé Ðåäñàíäñ", 1297.470, 2142.860, -89.084, 1777.390, 2243.230, 110.916},
		{"Àâòîøêîëà", -2270.040, -324.114, -1.2, -1794.920, -222.589, 200.000},
		{"Âûñîêîãîðíàÿ ëåñîïèëêà", 967.383, -450.390, -3.0, 1176.780, -217.900, 200.000},
		{"Ëàñ-Áàððàíêàñ", -926.130, 1398.730, -3.0, -719.234, 1634.690, 200.000},
		{"Êàçèíî Ïèðàòû", 1817.390, 1469.230, -89.084, 2027.400, 1703.230, 110.916},
		{"Çàë ñóäà", -2867.850, 277.411, -9.1, -2593.440, 458.411, 200.000},
		{"Ãîëüô-êëóá Àâèñïà", -2646.400, -355.493, 0.000, -2270.040, -222.589, 200.000},
		{"Ñòðèï", 2027.400, 863.229, -89.084, 2087.390, 1703.230, 110.916},
		{"Õàøáåðè", -2593.440, -222.589, -1.0, -2411.220, 54.722, 200.000},
		{"Àðåíäà àâèàòðàíñïîðòà ËÑ", 1852.000, -2394.330, -89.084, 2089.000, -2179.250, 110.916},
		{"Êîìïëåêñ Óàéòâóä", 1098.310, 1726.220, -89.084, 1197.390, 2243.230, 110.916},
		{"Âîäîõðàíèëèùå ËÂ", -789.737, 1659.680, -89.084, -599.505, 1929.410, 110.916},
		{"Ýëü-Êîðîíà", 1812.620, -2179.250, -89.084, 1970.620, -1852.870, 110.916},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", -1700.010, 744.267, -6.1, -1580.010, 1176.520, 200.000},
		{"Ôîñòåðñêàÿ äîëèíà", -2178.690, -1250.970, 0.000, -1794.920, -1115.580, 200.000},
		{"Ëàñ-Ïàéàñàäàñ", -354.332, 2580.360, 2.0, -133.625, 2816.820, 200.000},
		{"Âàëëå Îêóëòàäî", -936.668, 2611.440, 2.0, -715.961, 2847.900, 200.000},
		{"Áëýêôèëäñêèé ïåðåêð¸ñòîê", 1166.530, 795.010, -89.084, 1375.600, 1044.690, 110.916},
		{"Ãýíòîí", 2222.560, -1852.870, -89.084, 2632.830, -1722.330, 110.916},
		{"ÀýðîÂîêçàë ÑÔ ÑÔ", -1213.910, -730.118, 0.000, -1132.820, -50.096, 200.000},
		{"Âîñòî÷íûé Ðåäñàíäñ", 1817.390, 2011.830, -89.084, 2106.700, 2202.760, 110.916},
		{"Âîñòî÷íàÿ Ýñïàëàíäà", -1499.890, 578.396, -79.615, -1339.890, 1274.260, 20.385},
		{"Äâîðåö Êàëèãóëû", 2087.390, 1543.230, -89.084, 2437.390, 1703.230, 110.916},
		{"Êàçèíî Ðîÿëü", 2087.390, 1383.230, -89.084, 2437.390, 1543.230, 110.916},
		{"Ãîðà Âàéíâóä", 72.648, -1235.070, -89.084, 321.356, -1008.150, 110.916},
		{"Àçàðòíûé ðàéîí", 2437.390, 1783.230, -89.084, 2685.160, 2012.180, 110.916},
		{"Ãîðà Âàéíâóä", 1281.130, -452.425, -89.084, 1641.130, -290.913, 110.916},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", -1982.320, 744.170, -6.1, -1871.720, 1274.260, 200.000},
		{"Õýíêèïýíêè ïîèíò", 2576.920, 62.158, 0.000, 2759.250, 385.503, 200.000},
		{"Âîåííûé ñêëàä ÃÑÌ", 2498.210, 2626.550, -89.084, 2749.900, 2861.550, 110.916},
		{"Øîññå Ãàððè-Ãîëä", 1777.390, 863.232, -89.084, 1817.390, 2342.830, 110.916},
		{"Òîííåëü Áýéñàéä", -2290.190, 2548.290, -89.084, -1950.190, 2723.290, 110.916},
		{"Ïîðò ËÑ", 2324.000, -2302.330, -89.084, 2703.580, -2145.100, 110.916},
		{"Ãîðà Âàéíâóä", 321.356, -1044.070, -89.084, 647.557, -860.619, 110.916},
		{"Ïðîìñêëàä Ðýíäîëüôà", 1558.090, 596.349, -89.084, 1823.080, 823.235, 110.916},
		{"Âîñòî÷íûé ïëÿæ ËÑ", 2632.830, -1852.870, -89.084, 2959.350, -1668.130, 110.916},
		{"Ïðîëèâ Ôëèíò-Óîòåð", -314.426, -753.874, -89.084, -106.339, -463.073, 110.916},
		{"Áëóáåððè", 19.607, -404.136, 3.8, 349.607, -220.137, 200.000},
		{"Âîêçàë ËÂ", 2749.900, 1198.990, -89.084, 2923.390, 1548.990, 110.916},
		{"Ãëåí Ïàðê", 1812.620, -1350.720, -89.084, 2056.860, -1100.820, 110.916},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", -1993.280, 265.243, -9.1, -1794.920, 578.396, 200.000},
		{"Çàïàäíûé Ðåäñàíäñ", 1377.390, 2243.230, -89.084, 1704.590, 2433.230, 110.916},
		{"Ãîðà Âàéíâóä", 321.356, -1235.070, -89.084, 647.522, -1044.070, 110.916},
		{"Ìîñò Ãàíò", -2741.450, 1659.680, -6.1, -2616.400, 2175.150, 200.000},
		{"Áîëüøîé êðàòåð ËÂ", -90.218, 1286.850, -3.0, 153.859, 1554.120, 200.000},
		{"Ïåðåñå÷åíèå Ôëèíò", -187.700, -1596.760, -89.084, 17.063, -1276.600, 110.916},
		{"Ëàñ-Êîëèíàñ", 2281.450, -1135.040, -89.084, 2632.740, -945.035, 110.916},
		{"Æ/Ä äåïî ËÂ", 2749.900, 1548.990, -89.084, 2923.390, 1937.250, 110.916},
		{"Êàçèíî Èçóìðóäíûé îñòðîâ", 2011.940, 2202.760, -89.084, 2237.400, 2508.230, 110.916},
		{"Ñêàëèñòûé ìàññèâ ËÂ", -208.570, 2123.010, -7.6, 114.033, 2337.180, 200.000},
		{"Ñàíòà-Ôëîðà", -2741.070, 458.411, -7.6, -2533.040, 793.411, 200.000},
		{"Ñåâèëëüñêèé áóëüâàð", 2703.580, -2126.900, -89.084, 2959.350, -1852.870, 110.916},
		{"Öåíòðàëüíûé Ðûíîê", 926.922, -1577.590, -89.084, 1370.850, -1416.250, 110.916},
		{"Êâèíñ", -2593.440, 54.722, 0.000, -2411.220, 458.411, 200.000},
		{"Ïåðåñå÷åíèå Ïèëñîí", 1098.390, 2243.230, -89.084, 1377.390, 2507.230, 110.916},
		{"Ñïàëüíûé ðàéîí ËÂ", 2121.400, 2663.170, -89.084, 2498.210, 2861.550, 110.916},
		{"Ïèëèãðèì", 2437.390, 1383.230, -89.084, 2624.400, 1783.230, 110.916},
		{"Áëýêôèëä", 964.391, 1403.220, -89.084, 1197.390, 1726.220, 110.916},
		{"Ðàäèîòåëåñêîï", -410.020, 1403.340, -3.0, -137.969, 1681.230, 200.000},
		{"Äèëëèìîð", 580.794, -674.885, -9.5, 861.085, -404.790, 200.000},
		{"Ýëü-Êåáðàäîñ", -1645.230, 2498.520, 0.000, -1372.140, 2777.850, 200.000},
		{"Ñåâåðíàÿ Ýñïëàíàäà", -2533.040, 1358.900, -4.5, -1996.660, 1501.210, 200.000},
		{"Àýðîïîðò ÑÔ", -1499.890, -50.096, -1.0, -1242.980, 249.904, 200.000},
		{"Èçóìðóäíàÿ äåðåâíÿ", 1916.990, -233.323, -100.000, 2131.720, 13.800, 200.000},
		{"ÊÏÏ ËÑ-ËÂ", 1414.070, -768.027, -89.084, 1667.610, -452.425, 110.916},
		{"Âîñòî÷íûé ïëÿæ ËÑ", 2747.740, -1498.620, -89.084, 2959.350, -1120.040, 110.916},
		{"Ïðîëèâ Ñàí-Àíäðåàñ", 2450.390, 385.503, -100.000, 2759.250, 562.349, 200.000},
		{"Òåíèñòûå ðó÷üè", -2030.120, -2174.890, -6.1, -1820.640, -1771.660, 200.000},
		{"Áîëüíèöà ËÑ", 1072.660, -1416.250, -89.084, 1370.850, -1130.850, 110.916},
		{"Çàïàäíûé Ðîêøîð", 1997.220, 596.349, -89.084, 2377.390, 823.228, 110.916},
		{"Ïðèêë Ïàéí", 1534.560, 2583.230, -89.084, 1848.400, 2863.230, 110.916},
		{"Ïîðò Èñòåð Áåéçèí", -1794.920, -50.096, -1.04, -1499.890, 249.904, 200.000},
		{"Êîíîïëÿíàÿ äîëèíà", -1166.970, -1856.030, 0.000, -815.624, -1602.070, 200.000},
		{"Ãðóçîâîé ñêëàä ËÂ", 1457.390, 863.229, -89.084, 1777.400, 1143.210, 110.916},
		{"Ïðèêë Ïàéí", 1117.400, 2507.230, -89.084, 1534.560, 2723.230, 110.916},
		{"Áëóáåððè", 104.534, -220.137, 2.3, 349.607, 152.236, 200.000},
		{"Ñêàëèñòûé ìàññèâ ËÂ", -464.515, 2217.680, 0.000, -208.570, 2580.360, 200.000},
		{"Öåíòðàëüíûé ðàéîí ÑÔ", -2078.670, 578.396, -7.6, -1499.890, 744.267, 200.000},
		{"Âîñòî÷íûé Ðîêøîð", 2537.390, 676.549, -89.084, 2902.350, 943.235, 110.916},
		{"Çàëèâ ÑÔ", -2616.400, 1501.210, -3.0, -1996.660, 1659.680, 200.000},
		{"Ïàðàäèçî", -2741.070, 793.411, -6.1, -2533.040, 1268.410, 200.000},
		{"Àçàðòíûé ðàéîí", 2087.390, 1203.230, -89.084, 2640.400, 1383.230, 110.916},
		{"Ñòðèï-êëóá ËÂ", 2162.390, 2012.180, -89.084, 2685.160, 2202.760, 110.916},
		{"Äæàíèïåð Õèëë", -2533.040, 578.396, -7.6, -2274.170, 968.369, 200.000},
		{"Äæàíèïåð Õîëëîó", -2533.040, 968.369, -6.1, -2274.170, 1358.900, 200.000},
		{"Áàíêîâñêîå îòäåëåíèå ËÂ", 2237.400, 2202.760, -89.084, 2536.430, 2542.550, 110.916},
		{"Âîñòî÷íîå øîññå ËÂ", 2685.160, 1055.960, -89.084, 2749.900, 2626.550, 110.916},
		{"Ïëÿæ Âåðîíà", 647.712, -2173.290, -89.084, 930.221, -1804.210, 110.916},
		{"Ôîñòåðñêàÿ äîëèíà", -2178.690, -599.884, -1.2, -1794.920, -324.114, 200.000},
		{"Àðêî-äåëü-îåñòå", -901.129, 2221.860, 0.000, -592.090, 2571.970, 200.000},
		{"Àâòîñàëîí ËÑ", -792.254, -698.555, -5.3, -452.404, -380.043, 200.000},
		{"Çëîâåùèé äâîðåö", -1209.670, -1317.100, 114.981, -908.161, -787.391, 251.981},
		{"Äàìáà Øåðìàíà", -968.772, 1929.410, -3.0, -481.126, 2155.260, 200.000},
		{"Ñåâåðíàÿ Ýñïëàíàäà", -1996.660, 1358.900, -4.5, -1524.240, 1592.510, 200.000},
		{"Ôèíàíñîâûé ðàéîí", -1871.720, 744.170, -6.1, -1701.300, 1176.420, 300.000},
		{"Ãàðñèÿ", -2411.220, -222.589, -1.14, 2173.040, 265.243, 200.000},
		{"Ìîíòãîìåðè", 1119.510, 119.526, -3.0, 1451.400, 493.323, 200.000},
		{"Ò/Ö Ðó÷åé", 2749.900, 1937.250, -89.084, 2921.620, 2669.790, 110.916},
		{"Àýðîïîðò ËÑ", 1249.620, -2394.330, -89.084, 1852.000, -2179.250, 110.916},
		{"Ïëÿæ Ñàíòà-Ìàðèÿ", 72.648, -2173.290, -89.084, 342.648, -1684.650, 110.916},
		{"ÊÏÏ ËÑ-ËÂ", 1463.900, -1150.870, -89.084, 1812.620, -768.027, 110.916},
		{"Ýéíäæåë-Ïàéí", -2324.940, -2584.290, -6.1, -1964.220, -2212.110, 200.000},
		{"Çàáðîøåííûé àýðîäðîì", 37.032, 2337.180, -3.0, 435.988, 2677.900, 200.000},
		{"Îêòàí-Ñïðèíãñ", 338.658, 1228.510, 0.000, 664.308, 1655.050, 200.000},
		{"Ïèëèãðèì Êàì-ý-Ëîò", 2087.390, 943.235, -89.084, 2623.180, 1203.230, 110.916},
		{"Çàïàäíûé Ðåäñàíäñ", 1236.630, 1883.110, -89.084, 1777.390, 2142.860, 110.916},
		{"Ïëÿæ Ñàíòà-Ìàðèÿ", 342.648, -2173.290, -89.084, 647.712, -1684.650, 110.916},
		{"Çåë¸íûé óò¸ñ", 1249.620, -2179.250, -89.084, 1692.620, -1842.270, 110.916},
		{"Àýðîïîðò ËÂ", 1236.630, 1203.280, -89.084, 1457.370, 1883.110, 110.916},
		{"Îêðóã Ôëèíò", -594.191, -1648.550, 0.000, -187.700, -1276.600, 200.000},
		{"Çåë¸íûé óò¸ñ", 930.221, -2488.420, -89.084, 1249.620, -2006.780, 110.916},
		{"Ïàëîìèíî Êðèê", 2160.220, -149.004, 0.000, 2576.920, 228.322, 200.000},
		{"Âîåííàÿ áàçà ËÑ", 2373.770, -2697.090, -89.084, 2809.220, -2330.460, 110.916},
		{"Àýðîïîðò ÑÔ", -1213.910, -50.096, -4.5, -947.980, 578.396, 200.000},
		{"Êîìïëåêñ Óàéòâóä", 883.308, 1726.220, -89.084, 1098.310, 2507.230, 110.916},
		{"Êàëòîí Õåéòñ", -2274.170, 744.170, -6.1, -1982.320, 1358.900, 200.000},
		{"Âîåííàÿ áàçà ÑÔ", -1794.920, 249.904, -9.1, -1242.980, 578.396, 200.000},
		{"Çàëèâ ËÑ", -321.744, -2224.430, -89.084, 44.615, -1724.430, 110.916},
		{"Äîýðòè", 2173.040, -222.589, -1.0, -1794.920, 265.243, 200.000},
		{"Ãîðà ×èëèàä", -2178.690, -2189.910, -47.917, -2030.120, -1771.660, 576.083},
		{"Ôîðò-Êàðñîí", -376.233, 826.326, -3.0, 123.717, 1220.440, 200.000},
		{"Àâòîáàçàð", -2178.690, -1115.580, 0.000, -1794.920, -599.884, 200.000},
		{"Îêåàíñêîå ïîáåðåæüå", -2994.490, -222.589, -1.0, -2593.440, 277.411, 200.000},
		{"Ôåðí-Ðèäæ", 508.189, -139.259, 0.000, 1306.660, 119.526, 200.000},
		{"Áýéñàéä", -2741.070, 2175.150, 0.000, -2353.170, 2722.790, 200.000},
		{"Àýðîïîðò ËÂ", 1457.370, 1203.280, -89.084, 1777.390, 1883.110, 110.916},
		{"Ôåðìà Áëóáåððè", -319.676, -220.137, 0.000, 104.534, 293.324, 200.000},
		{"Ïàëèñàäû", -2994.490, 458.411, -6.1, -2741.070, 1339.610, 200.000},
		{"Ñêàëà Íîðñòàð", 2285.370, -768.027, 0.000, 2770.590, -269.740, 200.000},
		{"Êàðüåð Õàíòåð", 337.244, 710.840, -115.239, 860.554, 1031.710, 203.761},
		{"Àýðîïîðò ËÑ", 1382.730, -2730.880, -89.084, 2201.820, -2394.330, 110.916},
		{"Ïîêëîííàÿ ãîðà", -2994.490, -811.276, 0.000, -2178.690, -430.276, 200.000},
		{"Çàëèâ ÑÔ", -2616.400, 1659.680, -3.0, -1996.660, 2175.150, 200.000},
		{"Òþðüìà ñòðîãîãî ðåæèìà", -91.586, 1655.050, -50.000, 421.234, 2123.010, 250.000},
		{"Ãîðà ×èëèàä", -2997.470, -1115.580, -47.917, -2178.690, -971.913, 576.083},
		{"Ãîðà ×èëèàä", -2178.690, -1771.660, -47.917, -1936.120, -1250.970, 576.083},
		{"Àýðîïîðò ÑÔ", -1794.920, -730.118, -3.0, -1213.910, -50.096, 200.000},
		{"Ïàíîïòèêóì", -947.980, -304.320, -1.1, -319.676, 327.071, 200.000},
		{"Òåíèñòûå ðó÷üè", -1820.640, -2643.680, -8.0, -1226.780, -1771.660, 200.000},
		{"Áýê-î-Áåéîíä", -1166.970, -2641.190, 0.000, -321.744, -1856.030, 200.000},
		{"Ãîðà ×èëèàä", -2994.490, -2189.910, -47.917, -2178.690, -1115.580, 576.083},
		{"Òüåððà Ðîáàäà", -1213.910, 596.349, -242.990, -480.539, 1659.680, 900.000},
		{"Îêðóã Ôëèíò", -1213.910, -2892.970, -242.990, 44.615, -768.027, 900.000},
		{"Ãîðà ×èëëèàä", -2997.470, -2892.970, -242.990, -1213.910, -1115.580, 900.000},
		{"Ïóñòûííûé îêðóã", -480.539, 596.349, -242.990, 869.461, 2993.870, 900.000},
		{"Òüåððà Ðîáàäà", -2997.470, 1659.680, -242.990, -480.539, 2993.870, 900.000},
		{"Îêðóæíîñòü ÑÔ", -2997.470, -1115.580, -242.990, -1213.910, 1659.680, 900.000},
		{"Îêðóæíîñòü ËÂ", 869.461, 596.349, -242.990, 2997.060, 2993.870, 900.000},
		{"Òóìàííûé îêðóã", -1213.910, -768.027, -242.990, 2997.060, 596.349, 900.000},
		{"Îêðóæíîñòü ËÑ", 44.615, -2892.970, -242.990, 2997.060, -768.027, 900.000}
	}
    for i, v in ipairs(streets) do
        if (x >= v[2]) and (y >= v[3]) and (z >= v[4]) and (x <= v[5]) and (y <= v[6]) and (z <= v[7]) then
            return v[1]
        end
    end
    return 'Íåèçâåñòíî'
end
function split_text_into_lines(text, max_length)
	local lines = {}
	local current_line = ""
	for word in text:gmatch("%S+") do
		local new_line = current_line .. (current_line == "" and "" or " ") .. word
		if #new_line > max_length then
			table.insert(lines, current_line)
			current_line = word
		else
			current_line = new_line
		end
	end
	if current_line ~= "" then
		table.insert(lines, current_line)
	end
	return table.concat(lines, "\n")
end
function count_lines_in_text(text, max_length)
	local lines = {}
	local current_line = ""
	for word in text:gmatch("%S+") do
		local new_line = current_line .. (current_line == "" and "" or " ") .. word
		if #new_line > max_length then
			table.insert(lines, current_line)
			current_line = word
		else
			current_line = new_line
		end
	end
	if current_line ~= "" then
		table.insert(lines, current_line)
	end
	return tonumber(#lines)
end
function getDeviceID() 
	if isMonetLoader() then
		local success, id = pcall(function()
			local envu = require("android.jnienv-util")
			envu.LooperPrepare()
			local activity = require("android.jni-raw").activity
			local contentResolver = envu.CallObjectMethod(
				activity,
				"getContentResolver",
				"()Landroid/content/ContentResolver;"
			)
			local ANDROID_ID = envu.GetStaticObjectField(
				"android/provider/Settings$Secure",
				"ANDROID_ID",
				"Ljava/lang/String;"
			)
			local jstr = envu.CallStaticObjectMethod(
				"android/provider/Settings$Secure",
				"getString",
				"(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;",
				contentResolver,
				ANDROID_ID
			)
			local android_id = envu.FromJString(jstr)
			local model = envu.FromJString(envu.GetStaticObjectField("android/os/Build", "MODEL", "Ljava/lang/String;"))
			return android_id .. " (" .. model .. ")"
		end)
		if success and id then
			return id
		end
	else
		local success, id = pcall(function()
			ffi.cdef[[
				int __stdcall GetVolumeInformationA(
						const char* lpRootPathName,
						char* lpVolumeNameBuffer,
						uint32_t nVolumeNameSize,
						uint32_t* lpVolumeSerialNumber,
						uint32_t* lpMaximumComponentLength,
						uint32_t* lpFileSystemFlags,
						char* lpFileSystemNameBuffer,
						uint32_t nFileSystemNameSize
				);
				]]
			local serial = ffi.new("unsigned long[1]", 0)
			ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
			return serial[0]
		end)
		if success and id then 
			return string.format("%08X", id)
		end
	end
	return 'Unknown'
end
function downloadFileFromUrlToPath(url, path)
	print('Íà÷èíàþ ñêà÷èâàíèå ôàéëà â ' .. path)
	local function on_finish_download()
		if download_file == 'update' then
			local function readJsonFile(filePath)
				if not doesFileExist(filePath) then
					print('Îøèáêà: Ôàéë "' .. filePath .. ' íå ñóùåñòâóåò')
					return nil
				end
				local file, err = io.open(filePath, "r")
				if not file then
					print('Îøèáêà: Íå óäàëîñü îòêðûòü ôàéë "' .. filePath .. '": ' .. tostring(err))
					return nil
				end
				local content = file:read("*a")
				file:close()
				local jsonData = decodeJson(content)
				if not jsonData then
					print('Îøèáêà: Íåâåðíûé ôîðìàò JSON â ôàéëå ' .. filePath)
					return nil
				end
				return jsonData
			end
			local ok, updateInfo = pcall(readJsonFile, path)
			if updateInfo then
				local isVip = thisScript().version:find('VIP')
				local uVer = isVip and updateInfo.vip_current_version or updateInfo.current_version
				local uText = isVip and updateInfo.vip_update_info or updateInfo.update_info
				local uUrl = isVip and '' or updateInfo.update_url
				
				print('Òåêóùàÿ óñòàíîâëåííàÿ âåðñèÿ:', thisScript().version)
				print('Òåêóùàÿ âåðñèÿ â îáëàêå:', uVer)
				if uVer and thisScript().version ~= uVer then
					print('Äîñòóïíî îáíîâëåíèå!')
					sampAddChatMessage('[Rodina Helper] {ffffff}Äîñòóïíî îáíîâëåíèå!', message_color)
					MODULE.Update.is_need_update = true
					MODULE.Update.url = uUrl
					MODULE.Update.version = uVer
					MODULE.Update.info = uText
					MODULE.Update.Window[0] = true
				else
					print('Îáíîâëåíèå íå íóæíî!')
					sampAddChatMessage('[Rodina Helper] {ffffff}Îáíîâëåíèå íå íóæíî, ó âàñ àêòóàëüíàÿ âåðñèÿ!', message_color)
				end
			end
		elseif download_file == 'helper' then
			sampAddChatMessage('[Rodina Helper] {ffffff}Çàãðóçêà íîâîé âåðñèè õåëïåðà óñïåøíî çàâåðøåíà! Ïåðåçàãðóçêà..',  message_color)
			-- óäàëåíèå ôàéëà õåëïåðà îò äèñêîðäà ñ _ â íàçâàíèè, èìÿ ôàéëà òîëüêî ñ ïðîáåëîì
			os.remove(getWorkingDirectory():gsub('\\','/') .. "Rodina_Helper.lua")
			reload_script = true
			thisScript():unload()
		elseif download_file == 'smart_uk' then
			sampAddChatMessage('[Rodina Helper] {ffffff}Çàãðóçêà ñèñòåìû óìíîé âûäà÷è ðîçûñêà äëÿ ñåðâåðà ' .. message_color_hex .. getServerName(getServerNumber()) .. ' [' .. getServerNumber() ..  '] {ffffff}çàâåðøåíà óñïåøíî!',  message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}Òåïåðü âû ìîæåòå èñïîëüçîâàòü êîìàíäó ' .. message_color_hex .. '/sum [ID èãðîêà]', message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}Íî ñïåðâà ïåðåçàãðóçèòå ñêðèïò Ctrl + R ', message_color)			
			MODULE.Main.Window[0] = false
			load_module('smart_uk')
		elseif download_file == 'smart_pdd' then
			sampAddChatMessage('[Rodina Helper] {ffffff}Çàãðóçêà ñèñòåìû óìíîé âûäà÷è øòðàôîâ äëÿ ñåðâåðà ' .. message_color_hex .. getServerName(getServerNumber()) .. ' [' .. getServerNumber() ..  '] {ffffff}çàâåðøåíà óñïåøíî!',  message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}Òåïåðü âû ìîæåòå èñïîëüçîâàòü êîìàíäó ' .. message_color_hex .. '/tsm [ID èãðîêà]', message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}Íî ñïåðâà ïåðåçàãðóçèòå ñêðèïò Ctrl + R ', message_color)
			MODULE.Main.Window[0] = false
			load_module('smart_pdd')
		elseif download_file == 'notify' then
			if doesFileExist(configDirectory .. "/Resourse/notify.mp3") then
				print('Çâóê îïîâåùåíèé óñïåøíî çàãðóæåí!')
			end
		end
		download_file = ''
	end
	if isMonetLoader() then
		local function downloadToFile(url, path)
			local http = require("socket.http")
			local ltn12 = require("ltn12")

			local f, ferr = io.open(path, "wb")
			if not f then
				return false, "Íå óäàëîñü ñîçäàòü ôàéë: " .. tostring(ferr)
			end

			local ok, code, headers, status = http.request{
				method = "GET",
				url = url,
				sink = ltn12.sink.file(f)
			}

			if not ok then
				return false, "Îøèáêà çàïðîñà: " .. tostring(code)
			end

			if tonumber(code) ~= 200 then
				return false, "HTTP êîä: " .. tostring(code)
			end

			return true
		end
		local ok, err = downloadToFile(url, path)
		if ok then
			on_finish_download()
		else
			sampAddChatMessage("[Rodina Helper] {ffffff}Îøèáêà çàãðóçêè ôàéëà: " .. tostring(err), message_color)
		end
	else
		downloadUrlToFile(url, path, function(id, status)
			if status == 6 then
				on_finish_download()
			end
		end)
	end
end
function check_update()
	print('Ïðîâåðêà íà íàëè÷èå îáíîâëåíèé...')
	sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîâåðêà íà íàëè÷èå îáíîâëåíèé...', message_color)
	download_file = 'update'
	-- https://komarova140784-web.github.io/Rodina-Helper-/Update.json
	downloadFileFromUrlToPath('https://komarova140784-web.github.io/Rodina-Helper-/Update.json', configDirectory .. "/Update.json")
end
function check_resourses()
	if not doesDirectoryExist(configDirectory .. '/Resourse') then
		createDirectory(configDirectory .. '/Resourse')
	end
	if not doesFileExist(configDirectory .. '/Resourse/logo.png') then
		sampAddChatMessage('Ïîäãðóæàþ ëîãîòèï õåëïåðà...', message_color)
		downloadFileFromUrlToPath('https://github.com/komarova140784-web/Rodina-Helper-/raw/main/Resourse/logo.png', configDirectory .. '/Resourse/logo.png')
		-- https://github.com/komarova140784-web/Rodina-Helper-/raw/main/Resourse/logo.png
	end
	if not doesFileExist(configDirectory .. "/Resourse/notify.mp3") then
		sampAddChatMessage('Ïîäãðóæàþ çâóê äëÿ îïîâåùåíèé õåëïåðà...', message_color)
		downloadFileFromUrlToPath('https://github.com/komarova140784-web/Rodina-Helper-/raw/main/Resourse/notify.mp3', configDirectory .. "/Resourse/notify.mp3")
	end
	if not doesFileExist(configDirectory .. "contrafk.lua") then
		sampAddChatMessage('Ïîäãðóæàþ êîíòðîëåð àôê...', message_color)
		downloadFileFromUrlToPath('https://github.com/komarova140784-web/Rodina-Helper-/raw/main/contrafk.lua', configDirectory .. "contrafk.lua")
	end	
end
function import_data_from_old_helpers()
	local path = getWorkingDirectory():gsub('\\','/')
	if doesFileExist(path .. "/SMI Helper/Ads.json") then
		os.rename(path .. "/SMI Helper/Ads.json", modules.ads_history.path)
	end
	-- justice, hospital, smi, as, fd, gov, government, mafia, prison
end
function deleteOldHelpers()
	local path = getWorkingDirectory():gsub('\\','/')
	local helpers = {"Justice", "Hospital", "SMI", "AS", "FD", "GOV", "Government", "Mafia", "Prison"}
	for index, name in ipairs(helpers) do
		if doesFileExist(path .. "/" .. name .. " Helper.lua") then
			os.remove(path .. "/" .. name .. " Helper.lua")
		elseif doesFileExist(path .. "/" .. name .. "_Helper.lua") then
			os.remove(path .. "/" .. name .. "_Helper.lua")
		end
	end
end
function deleteHelperData(checker)
	os.remove(configDirectory .. "/Settings.json")
	os.remove(configDirectory .. "/Commands.json")
	os.remove(configDirectory .. "/Notes.json")
	os.remove(configDirectory .. "/Vehicles.json")
	os.remove(configDirectory .. "/Guns.json")
	os.remove(configDirectory .. "/Ads.json")
	os.remove(configDirectory .. "/Update.json")
	os.remove(configDirectory .. "/SmartUK.json")
	os.remove(configDirectory .. "/SmartPDD.json")
	os.remove(configDirectory .. "/SmartRPTP.json")
	if checker then
		os.remove(configDirectory .. "/Resourse/notify.mp3")
		os.remove(configDirectory .. "/Resourse/logo.png")
		os.remove(thisScript().path)
		sampAddChatMessage('[Rodina Helper] {ffffff}Õåëïåð ïîëíîñòüþ óäàë¸í èç âàøåãî óñòðîéñòâà!', message_color)
		reload_script = true
		thisScript():unload()
	else
		sampAddChatMessage('[Rodina Helper] {ffffff}Ïåðåçàãðóçêà õåëïåðà...', message_color)
		reload_script = true
		thisScript():reload()
	end
end
if isMode('police') or isMode('fcb') then
	function form_su(name, playerID, message)
		local lvl, id, reason = message:match('Ïðîøó îáüÿâèòü â ðîçûñê (%d) ñòåïåíè äåëî N(%d+)%. Ïðè÷èíà%: (.+)')
		MODULE.SumMenu.form_su = id .. ' ' .. lvl .. ' ' .. reason
		sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. '/givefsu ' .. playerID .. '{ffffff} ÷òîáû âûäàòü ðîçûñê ïî çàïðîñó îôèöåðà ' .. message_color_hex .. name, message_color)
		playNotifySound()
	end
end
if isMode('hospital') then
	function heal_handler(nick, id, message)
		if (nick and id and message and tonumber(id) ~= select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) then
			local function check_end_time()
				lua_thread.create(function()
					wait(5000)
					if MODULE.HealChat.bool then
						MODULE.HealChat.Window[0] = false
						MODULE.HealChat.bool = false
						sampAddChatMessage('[Rodina Helper] {ffffff}Âû íå óñïåëè âûëå÷èòü èãðîêà ')
					end
				end)
			end
			for hello_bro, keyword in ipairs(MODULE.HealChat.worlds) do
				if (message:rupper():find(keyword:rupper())) then
					if isMonetLoader() then
						sampAddChatMessage('[Rodina Helper] {ffffff}×òîá âûëå÷èòü èãðîêà ' .. sampGetPlayerNickname(id) .. ', â òå÷åíèè 5-òè ñåêóíä íàæìèòå êíîïêó',message_color)
						MODULE.HealChat.player_id = id
						MODULE.HealChat.bool = true
						MODULE.HealChat.Window[0] = true
						check_end_time()
					elseif hotkey_no_errors then
						sampAddChatMessage('[Rodina Helper] {ffffff}×òîáû âûëå÷èòü èãðîêà ' .. sampGetPlayerNickname(id) .. ' íàæìèòå ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_action) .. ' {ffffff}â òå÷åíèè 5-òè ñåêóíä!',message_color)
						show_arz_notify('info', 'Rodina Helper', 'Íàæìèòå ' .. getNameKeysFrom(settings.general.bind_action) .. ' ÷òîáû áûñòðî âûëå÷èòü èãðîêà', 5000)
						MODULE.HealChat.player_id = id
						MODULE.HealChat.bool = true
						check_end_time()
					end
					return
				end
			end
		end
	end
end
if isMode('smi') then
	function send_ad()
		local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text))
		if text ~= '' then
			local exists = false
			for _, ad in ipairs(modules.ads_history.data) do
				if ad and ad.text and ad.text == MODULE.SmiEdit.ad_message then
					exists = true
					break
				end
			end
			if not exists then
				table.insert(modules.ads_history.data, 1, {text = MODULE.SmiEdit.ad_message, my_text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text))})
				save_module('ads_history')
			end

			if text == MODULE.SmiEdit.last_ad_text then
				MODULE.SmiEdit.ad_repeat_count = MODULE.SmiEdit.ad_repeat_count + 1
			else
				MODULE.SmiEdit.ad_repeat_count = 0
				MODULE.SmiEdit.last_ad_text = text
			end
			if MODULE.SmiEdit.ad_repeat_count >= 51 then
				sampAddChatMessage('[Rodina Helper] {ffffff}Íå óäàëîñü îòïðàâèòü îáüÿâó, ó âàñ ñëèøêîì ìíîãî ñïåö.ñèìâîëîâ (öèôðû/òî÷êè/êàâû÷êè)!', message_color)
				MODULE.SmiEdit.last_ad_text = ''
				MODULE.SmiEdit.ad_repeat_count = 0
				for index, ad in ipairs(modules.ads_history.data) do
					if ad and ad.text and ad.text == MODULE.SmiEdit.ad_message then
						sampAddChatMessage('[Rodina Helper] {ffffff}Ñòðîêà ðåäàêòèðîâàíèÿ îáüÿâëåíèÿ î÷èùåíà, íî âàøå îáüÿâëåíèå ñîõðàíåíî â èñòîðèè îáüÿâëåíèé.', message_color)
						ad.text = ad.my_text
						save_module('ads_history')
						break
					end
				end
				return
			else
				sampSendDialogResponse(MODULE.SmiEdit.ad_dialog_id, 1, 0, text)
			end
			imgui.StrCopy(MODULE.SmiEdit.input_edit_text, '')
			MODULE.SmiEdit.Window[0] = false
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}Íåëüçÿ îòïðàâèòü ïóñòóþ îáüÿâó!', message_color)
		end
	end
end
if (settings.player_info.fraction_rank_number >= 9) then
	function give_rank()
		local command_find = false
		for _, command in ipairs(modules.commands.data.commands_manage.my) do
			if command.enable and command.text:find('/giverank {arg_id}') then
				command_find = true
				local modifiedText = command.text
				local wait_tag = false
				local arg_id = player_id
				modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id) or "")
				modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id):gsub('_',' ') or "")
				modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}', TranslateNick(sampGetPlayerNickname(arg_id)) or "")
				modifiedText = modifiedText:gsub('%{arg_id%}', arg_id or "")
				lua_thread.create(function()
					MODULE.Binder.state.isActive = true
					info_stop_command()
					local lines = {}
					for line in string.gmatch(modifiedText, "[^&]+") do
						table.insert(lines, line)
					end
					for _, line in ipairs(lines) do 
						if MODULE.Binder.state.isStop then 
							MODULE.Binder.state.isStop = false 
							MODULE.Binder.state.isActive = false
							if isMonetLoader() and settings.general.mobile_stop_button then
								MODULE.CommandStop.Window[0] = false
							end
							sampAddChatMessage('[Rodina Helper] {ffffff}Îòûãðîâêà êîìàíäû /' .. command.cmd .. " óñïåøíî îñòàíîâëåíà!", message_color) 
							return 
						end
						if wait_tag then
							for tag, replacement in pairs(MODULE.Binder.tags) do
								if line:find("{" .. tag .. "}") then
									local success, result = pcall(string.gsub, line, "{" .. tag .. "}", replacement())
									if success then
										line = result
									end
								end
							end
							sampSendChat(line)
							wait(1500)	
						end
						if not wait_tag then
							if line == '{show_rank_menu}' then
								wait_tag = true
							end
						end
					end
					MODULE.Binder.state.isActive = false
					if isMonetLoader() and settings.general.mobile_stop_button then
						MODULE.CommandStop.Window[0] = false
					end
				end)
			end
		end
		if not command_find then
			sampAddChatMessage('[Rodina Helper] {ffffff}Áèíä äëÿ èçìåíåíèÿ ðàíãà îòñóòñòâóåò ëèáî îòêëþ÷¸í!', message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}Ïîïðîáóéòå ñáðîñèòü íàñòðîéêè õåëïåðà!', message_color)
			sampSendChat('/giverank ' .. player_id .. " " .. MODULE.GiveRank.number[0])
		end
	end
end
function emulationCEF(str)
	-- by wojciech?
	local bs = raknetNewBitStream()
	raknetBitStreamWriteInt8(bs, 220)
	raknetBitStreamWriteInt8(bs, 18)
	raknetBitStreamWriteInt16(bs, #str)
	raknetBitStreamWriteString(bs, str)
	raknetBitStreamWriteInt32(bs, 0)
	raknetSendBitStream(bs)
	raknetDeleteBitStream(bs)
end
function visualCEF(str, is_encoded)
	-- by wojciech?
	local bs = raknetNewBitStream()
	raknetBitStreamWriteInt8(bs, 17)
	raknetBitStreamWriteInt32(bs, 0)
	raknetBitStreamWriteInt16(bs, #str)
	raknetBitStreamWriteInt8(bs, is_encoded and 1 or 0)
	if is_encoded then
		raknetBitStreamEncodeString(bs, str)
	else
		raknetBitStreamWriteString(bs, str)
	end
	raknetEmulPacketReceiveBitStream(220, bs)
	raknetDeleteBitStream(bs)
end
function show_arz_notify(type, title, text, time)
	if isMonetLoader() then
		--[[
		if type == 'info' then
			type = 3
		elseif type == 'error' then
			type = 2
		elseif type == 'success' then
			type = 1
		end
		local bs = raknetNewBitStream()
		raknetBitStreamWriteInt8(bs, 62)
		raknetBitStreamWriteInt8(bs, 6)
		raknetBitStreamWriteBool(bs, true)
		raknetEmulPacketReceiveBitStream(220, bs)
		raknetDeleteBitStream(bs)
		local json = encodeJson({
			styleInt = type,
			title = title,
			text = text,
			duration = time
		})
		local interfaceid = 6
		local subid = 0
		local bs = raknetNewBitStream()
		raknetBitStreamWriteInt8(bs, 84)
		raknetBitStreamWriteInt8(bs, interfaceid)
		raknetBitStreamWriteInt8(bs, subid)
		raknetBitStreamWriteInt32(bs, #json)
		raknetBitStreamWriteString(bs, json)
		raknetEmulPacketReceiveBitStream(220, bs)
		raknetDeleteBitStream(bs)
		]]
	else
		local function escape_js(s)
			return s:gsub("\\", "\\\\"):gsub('"', '\\"')
		end
		local safe_type = escape_js(type)
		local safe_title = escape_js(title)
		local safe_text = escape_js(text)
		local safe_time = tostring(time)
		local str = ('window.executeEvent("event.notify.initialize", "[\\"%s\\", \\"%s\\", \\"%s\\", \\"%s\\"]");'):format(safe_type, safe_title, safe_text, safe_time)
		visualCEF(str, true)
	end
end
--------------------------------------------- Events ---------------------------------------------
function sampev.onShowTextDraw(id, data)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[ShowTextDraw] {ffffff}ID ' .. id .. " | Text " .. data.text .. ' | ModelID ' .. data.modelId .. " |", message_color)
		print("[ShowTextDraw] ID " .. id .. " | Text " .. data.text .. ' | ModelID ' .. data.modelId .. " |")
	end
	if data.text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~r~Sport!') then
		sampAddChatMessage('[Rodina Helper] {ffffff}Àêòèâèðîâàí ðåæèì åçäû Sport!', message_color)
		return false
	end
	if data.text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~g~Comfort!') then
		sampAddChatMessage('[Rodina Helper] {ffffff}Àêòèâèðîâàí ðåæèì åçäû Comfort!', message_color)
		return false
	end
end
function sampev.onSendClickTextDraw(textdrawId)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[ClickTextDraw] {ffffff}ID ' .. textdrawId, message_color)
		print('[ClickTextDraw] ID ' .. textdrawId)
	end
end
function sampev.onDisplayGameText(style,time,text)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[GameText] {ffffff}Style ' .. style .. " | Time " .. time .. " | Text " .. text, message_color)
		print('[GameText] Style ' .. style .. " | Time " .. time .. " | Text " .. text)
	end
	if text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~r~Sport!') then
		sampAddChatMessage('[Rodina Helper] {ffffff}Àêòèâèðîâàí ðåæèì åçäû Sport!', message_color)
		return false
	end
	if text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~g~Comfort!') then
		sampAddChatMessage('[Rodina Helper] {ffffff}Àêòèâèðîâàí ðåæèì åçäû Comfort!', message_color)
		return false
	end
end
function sampev.onSendTakeDamage(playerId,damage,weapon)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[TakeDamage] {ffffff}ID ' .. playerId .. " | Damage " .. damage .. " | Weapon " .. weapon, message_color)
		print('[TakeDamage] ID ' .. playerId .. " | Damage " .. damage .. " | Weapon " .. weapon)
	end
	if playerId ~= 65535 then
		playerId2 = playerId1
		playerId1 = playerId
		if isParamSampID(playerId) and playerId1 ~= playerId2 and tonumber(playerId) ~= 0 and weapon then
			local weapon_name = get_name_weapon(weapon)
			if weapon_name then
				sampAddChatMessage('[Rodina Helper] {ffffff}Èãðîê ' .. sampGetPlayerNickname(playerId) .. '[' .. playerId .. '] íàïàë íà âàñ èñïîëüçóÿ ' .. weapon_name .. '['.. weapon .. ']!', message_color)
				if isMode('police') or isMode('fcb') or isMode('army') or isMode('prison') then
					if ((MODULE.Patrool.Window[0]) and (MODULE.Patrool.ComboCode[0] ~= 1)) then
						sampAddChatMessage('[Rodina Helper | Àññèñòåíò] {ffffff}Âàø ñèòóàöèîííûé êîä èçìåí¸í íà CODE 0.', message_color)
						MODULE.Patrool.ComboCode[0] = 1
						MODULE.Patrool.code = MODULE.Patrool.combo_code_list[MODULE.Patrool.ComboCode[0] + 1]
					end
					if ((MODULE.Post.Window[0]) and (MODULE.Post.ComboCode[0] ~= 1)) then
						sampAddChatMessage('[Rodina Helper | Àññèñòåíò] {ffffff}Âàø ñèòóàöèîííûé êîä èçìåí¸í íà CODE 0.', message_color)
						MODULE.Post.ComboCode[0] = 1
						MODULE.Post.code = MODULE.Post.combo_code_list[MODULE.Post.ComboCode[0] + 1]
					end
					if (settings.mj.auto_doklad_damage or settings.md.auto_doklad_damage) then
						lua_thread.create(function()
							sampSendChat('/r ' .. MODULE.Binder.tags.my_doklad_nick() .. ' íà CONTROL. ' .. (weapon ~= 0 and 'Íàõîæóñü ïîä îãí¸ì' or 'Íà ìåíÿ íàïàëè') .. ' â ðàéîíå ' .. MODULE.Binder.tags.get_area() .. ' (' .. MODULE.Binder.tags.get_square() .. '), ñîñòîÿíèå CODE 0!')
							wait(1500)
							sampSendChat('/rb Íàïàäàþùèé: ' .. sampGetPlayerNickname(playerId) .. '[' .. playerId .. '], îí(-à) èñïîëüçóåò ' .. weapon_name .. '!')
						end)
					end
				end
			end
		end
	end
end
function sampev.onSendGiveDamage(playerId, damage, weapon, bodypart)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[GiveDamage] {ffffff}ID ' .. playerId .. " | Damage " .. damage .. " | Weapon " .. weapon .. " | Body " .. bodypart, message_color)
		print('[GiveDamage] ID ' .. playerId .. " | Damage " .. damage .. " | Weapon " .. weapon .. " | Body " .. bodypart)
	end
	if playerId ~= 65535 then
		if (sampGetPlayerNickname(playerId) == 'Andrey_Fil' and getServerNumber() == '20') or sampGetPlayerNickname(playerId):find('%[20%]Andrey_Fil') then
			sampAddChatMessage('[Rodina Helper] {ffffff}Andrey_Fil - ýòî ðàçðàáîò÷èê Rodina Helper!', message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}Íå íóæíî íàíîñèòü óðîí ðàçðàáîò÷èêó õåëïåðà, ÀÑÒÀÍÀÂÈÒÅÑÜ :sob: :sob: :sob:', message_color)
			playNotifySound()
		end
	end
end
function sampev.onServerMessage(color, text)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[ServerMessage] {ffffff}Color ' .. color .. " | Text " .. text, message_color)
		print('[ServerMessage] Color ' .. color .. " | Text " .. text)
	end

	if (text:find("^1%.{......} 111 %- {......}Ïðîâåðèòü áàëàíñ òåëåôîíà")) or
		text:find("^2%.{......} 060 %- {......}Ñëóæáà òî÷íîãî âðåìåíè") or
		text:find("^3%.{......} 911 %- {......}Ïîëèöåéñêèé ó÷àñòîê") or
		text:find("^4%.{......} 912 %- {......}Ñêîðàÿ ïîìîùü") or
		text:find("^5%.{......} 914 %- {......}Òàêñè") or
		text:find("^5%.{......} 914 %- {......}Ìåõàíèê") or
		text:find("^6%.{......} 8828 %- {......}Ñïðàâî÷íàÿ öåíòðàëüíîãî áàíêà") or
		text:find("^7%.{......} 997 %- {......}Ñëóæáà ïî âîïðîñàì æèëîé íåäâèæèìîñòè %(óçíàòü âëàäåëüöà äîìà%)") then
		return false
	end
	if (text:find("^%[Ïîäñêàçêà%] {......}Íîìåðà òåëåôîíîâ ãîñóäàðñòâåííûõ ñëóæá:")) then
		sampAddChatMessage('[Rodina Helper] {ffffff}Íîìåðà òåëåôîíîâ ãîñóäàðñòâåííûõ ñëóæá:', message_color)
		sampAddChatMessage('[Rodina Helper] {ffffff}111 Áàëàíñ | 60 Âðåìÿ | 911 ÌÞ | 912 ÌÇ | 913 Òàêñè | 914 Ìåõè | 8828 Áàíê | 997 Äîìà', message_color)
		return false
	end

	if ((settings.general.ping) and (not isMonetLoader()) and (text:find('@' .. MODULE.Binder.tags.my_nick()) or text:find('@' .. MODULE.Binder.tags.my_id() .. ' '))) then
		sampAddChatMessage('[Rodina Helper] {ffffff}Êòî-òî óïîìÿíóë âàñ â ÷àòå!', message_color)
		playNotifySound()
	end

	if ((settings.general.auto_uninvite) and (settings.player_info.fraction_rank_number >= 9)) then
		local function auto_uninvite_handler(name, playerID, message)
			if not message:find(" îòïðàâüòå (.+) +++ ÷òîáû óâîëèòñÿ ÏÑÆ!") and not message:find("Ñîòðóäíèê (.+) áûë óâîëåí ïî ïðè÷èíå(.+)") and message:rupper():find("ÏÑÆ") or message:rupper():find("ÓÂÎËÜÒÅ") or message:rupper():find("ÓÂÀË") then
				MODULE.LeadTools.msg3 = MODULE.LeadTools.msg2
				MODULE.LeadTools.msg2 = MODULE.LeadTools.msg1
				MODULE.LeadTools.msg1 = text
				PlayerID = playerID
				if MODULE.LeadTools.msg3 == text then
					MODULE.LeadTools.checker = true
					sampSendChat('/fmute ' .. playerID .. ' 1 [AutoUval]')
				elseif tag == "R" then
					sampSendChat("/rb "..name.."["..playerID.."], îòïðàâüòå /rb +++ ÷òîáû óâîëèòñÿ ÏÑÆ!")
				elseif tag == "F" then
					sampSendChat("/fb "..name.."["..playerID.."], îòïðàâüòå /fb +++ ÷òîáû óâîëèòñÿ ÏÑÆ!")
				end
			elseif ((message == "(( +++ ))" or  message == "(( +++. ))") and (PlayerID == playerID)) then
				MODULE.LeadTools.checker = true
				sampSendChat('/fmute ' .. playerID .. ' 1 [AutoUval]')
			end
		end
		if text:find("^%[(.-)%] (.-) (.-)%[(.-)%]: (.+)") and color == 766526463 then -- /f /fb /r /rb áåç òåãà 
			local tag, rank, name, playerID, message = string.match(text, "%[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
			auto_uninvite_handler(name, playerID, message)
		elseif text:find("^%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)") and color == 766526463 then -- /r /f ñ òåãîì
			local tag, tag2, rank, name, playerID, message = string.match(text, "%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
			auto_uninvite_handler(name, playerID, message)
		elseif text:find("(.+) çàãëóøèë%(à%) èãðîêà (.+) íà 1 ìèíóò. Ïðè÷èíà: %[AutoUval%]") and MODULE.LeadTools.checker then
			local text2 = text:gsub('{......}', '')
			local DATA = text2:match("(.+) çàãëóøèë")
			local Name = DATA:match(" ([A-Za-z0-9_]+)%[")
			local MyName = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
			if Name == MyName then
				sampAddChatMessage('[Rodina Helper] {ffffff}Óâîëüíÿþ èãðîêà ' .. sampGetPlayerNickname(PlayerID) .. '!', message_color)
				MODULE.LeadTools.checker = false
				temp = PlayerID .. ' ÏÑÆ'
				find_and_use_command("/uninvite {arg_id} {arg2}", temp)
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äðóãîé çàìåñòèòåëü/ëèäåð óæå óâîëüíÿåò èãðîêà ' .. sampGetPlayerNickname(PlayerID) .. '!', message_color)
				MODULE.LeadTools.checker = false
			end
		end
	end

	if (isMode('police') or isMode('fcb')) then
		if (settings.player_info.fraction_rank_number >= (isMode('fcb') and 4 or 5)) then
			if ((text:find("^%[(.-)%] (.-) (.-)%[(.-)%]: Ïðîøó îáüÿâèòü â ðîçûñê (%d) ñòåïåíè äåëî N(%d+)%. Ïðè÷èíà%: (.+)")) and (color == 766526463)) then -- /f /fb /r /rb áåç òåãà 
				local tag, rank, name, playerID, message = string.match(text, "%[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
				form_su(name, playerID, message)
			elseif ((text:find("^%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: Ïðîøó îáüÿâèòü â ðîçûñê (%d) ñòåïåíè äåëî N(%d+)%. Ïðè÷èíà%: (.+)")) and (color == 766526463)) then -- /r /f ñ òåãîì
				local tag, tag2, rank, name, playerID, message = string.match(text, "%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
				form_su(name, playerID, message)
			end
		end
		if (text:find('^Ìåñòîïîëîæåíèå (.+) îòìå÷åíî íà êàðòå êðàñíûì ìàðêåðîì')) then
			printStringNow(MODULE.Wanted.afind and 'AUTO FIND' or 'FIND', 500)
			return false
		end
		if ((MODULE.Wanted.check_wanted) and (text:find('^%[Îøèáêà%] %{FFFFFF%}Èñïîëüçóé: %/wanted %[óðîâåíü ðîçûñêà 1%-6%]') or text:find('^%[Îøèáêà%] %{FFFFFF%}Èñïîëüçóéòå: %/wanted %[óðîâåíü ðîçûñêà 1%-6%]'))) then
			return false
		end
		if ((MODULE.Wanted.check_wanted) and (text:find('^%[Îøèáêà%].+Èãðîêîâ ñ òàêèì óðîâíåì ðîçûñêà íåòó'))) then 
			return false 
		end
		if ((MODULE.Patrool.active) and (text:find('^Íà ýòîì àâòîìîáèëå óæå óñòàíîâëåíà ìàðêèðîâêà.'))) then
			sampAddChatMessage('[Rodina Helper] {ffffff}Ìåíÿþ ìàêðèðîâêó â òðàíñïîðòå...', message_color)
			sampSendChat('/delvdesc')
			lua_thread.create(function()
				wait(5000)
				sampSendChat('/vdesc ' .. MODULE.Binder.tags.get_patrool_mark())
			end)		
		end
		if (text:find('^%[Èíôîðìàöèÿ%] {ffffff}Âû ïîäîáðàëè îáëîìîê, òåïåðü âàì íóæíî îòíåñòè åãî è {ff0000}ïîëîæèòü â îáùóþ êó÷ó')) then
			sampAddChatMessage('[Rodina Helper] {ffffff}Âû ïîäîáðàëè çàâàë, òåïåðü âàì íóæíî îòíåñòè åãî â îáùóþ êó÷ó!', message_color)
			return false
		end
		if (text:find('^%[Èíôîðìàöèÿ%] {ffffff}Âû ïîëîæèëè îáëîìîê â îáùóþ êó÷ó, îòïðàâëÿéòåñü ê ñëåäóþùåìó çàâàëó.')) then
			sampAddChatMessage('[Rodina Helper] {ffffff}Âû ïîëîæèëè çàâàë â îáùóþ êó÷ó, òåïåðü îòïðàâëÿéòåñü ê ñëåäóþùåìó çàâàëó.', message_color)
			return false
		end
	end
 	
	if isMode('hospital') then
		if (text:find('^Î÷åâèäåö ñîîáùàåò î ïîñòðàäàâøåì ÷åëîâåêå â ðàéîíå (.+) %((.+)%).')) then
			MODULE.GoDeath.locate, MODULE.GoDeath.city = text:match('Î÷åâèäåö ñîîáùàåò î ïîñòðàäàâøåì ÷åëîâåêå â ðàéîíå (.+) %((.+)%).')
			return false
		elseif (text:find('^Î÷åâèäåö ñîîáùàåò î ïîñòðàäàâøåì ÷åëîâåêå%, ãåîëîêàöèÿ%: (.+)')) then -- rodina
			MODULE.GoDeath.locate, MODULE.GoDeath.city = "íåèçâåñòíîì", text:match('ãåîëîêàöèÿ%: (.+)')
			return false
		end
		if (text:find('^%(%( ×òîáû ïðèíÿòü âûçîâ, ââåäèòå /godeath (%d+). Îïëàòà çà âûçîâ (.+) %)%)')) then
			local price_godeath = ''
			MODULE.GoDeath.player_id, price_godeath = text:match('%(%( ×òîáû ïðèíÿòü âûçîâ, ââåäèòå /godeath (%d+). Îïëàòà çà âûçîâ (.+) %)%)')
			MODULE.GoDeath.player_id = tonumber(MODULE.GoDeath.player_id)
			local cmd = '/godeath'
			for _, command in ipairs(modules.commands.data.commands.my) do
				if command.enable and command.text:find('/godeath {arg_id}') then
					cmd =  '/' .. command.cmd
				end
			end
			if MODULE.GoDeath.locate == 'íåèçâåñòíîì' then
				sampAddChatMessage('[Rodina Helper] {ffffff}Èç ãîðîäà ' .. message_color_hex .. MODULE.GoDeath.city .. ' {ffffff}ïîñòóïèë âûçîâ î ïîñòðàäàâøåì ' .. message_color_hex .. sampGetPlayerNickname(MODULE.GoDeath.player_id), message_color)
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Èç ãîðîäà ' .. message_color_hex .. MODULE.GoDeath.city .. ' (' .. MODULE.GoDeath.locate .. ') {ffffff}ïîñòóïèë âûçîâ î ïîñòðàäàâøåì ' .. message_color_hex .. sampGetPlayerNickname(MODULE.GoDeath.player_id), message_color)
			end
			sampAddChatMessage('[Rodina Helper] {ffffff}Âûëå÷èâ åãî âû ïîëó÷èòå ' .. price_godeath .. '! ×òîáû ïðèíÿòü âûçîâ, èñïîëüçóéòå êîìàíäó ' .. message_color_hex .. cmd .. ' ' .. MODULE.GoDeath.player_id, message_color)
			return false
		end
		if (text:find("^Ïàöèåíò (.+) âûçûâàåò âðà÷åé .+õîëë.+ýòàæ")) then
			sampAddChatMessage('[Rodina Helper] {ffffff}Ïàöèåíò ' .. text:match("Ïàöèåíò (.+) âûçûâàåò") .. ' âûçûâàåò âðà÷à â õîëë áîëüíèöû!', message_color)
			return false
		end
		if (text:find('$hme')) then
			find_and_use_command("/heal {my_id}", "")
			return false
		end
		if ((MODULE.HealChat.healme) and (text:find('^%[Ïðåäëîæåíèå%]') or text:find('^%[Íîâîå ïðåäëîæåíèå%]'))) then
			return false
		end
		if (MODULE.HealChat.healme and text:find('^%[Èíôîðìàöèÿ%] {FFFFFF}Âû îòïðàâèëè ïðåäëîæåíèå î ëå÷åíèè.')) then
			sampSendChat('/offer')
			return false
		end
		if ((MODULE.HealChat.healme) and (text:find('^%[Èíôîðìàöèÿ%] {FFFFFF}Âàñ âûëå÷èë ìåäèê ' .. MODULE.Binder.tags.my_nick()))) then
			MODULE.HealChat.healme = false
			return false
		end
		if ((settings.mh.heal_in_chat.enable) and not MODULE.HealChat.bool and not MODULE.Binder.state.isActive) then	
			if (text:find('^(.+)%[(%d+)%] ãîâîðèò:{B7AFAF} (.+)')) then
				local nick, id, message = text:match('^(.+)%[(%d+)%] ãîâîðèò:{B7AFAF} (.+)')
				heal_handler(nick, id, message)
			elseif (text:find('^(.+)%[(%d+)%] êðè÷èò: (.+)')) then
				local nick, id, message = text:match('^(.+)%[(%d+)%] êðè÷èò: (.+)')
				heal_handler(nick, id, message)
			end
		end
	end	

	if isMode('lc') then
		if text:find('^Âû îòðåìîíòèðîâàëè äîðîæíûé çíàê: (.+) Âàøà çàðïëàòà%: (.+)') then
			local money = text:match('Âàøà çàðïëàòà%: (.+)')
			sampAddChatMessage('[Rodina Helper] {ffffff}Çà ðåìîíò äîðîæíîãî çíàêà âû çàðàáîòàëè ' .. money, message_color)
			return false
		end
		if text:find('^Âû óñòàíîâèëè äîðîæíûé çíàê: (.+) Âàøà çàðïëàòà%: (.+)') then
			local money = text:match('Âàøà çàðïëàòà%: (.+)')
			sampAddChatMessage('[Rodina Helper] {ffffff}Çà óñòàíîâêó äîðîæíîãî çíàêà âû çàðàáîòàëè ' .. money, message_color)
			return false
		end
		if text:find('^Âû âçÿëè èíñòðóìåíòû äëÿ ðåìîíòà äîðîæíîãî çíàêà.') then
			sampAddChatMessage('[Rodina Helper] {ffffff}Âû âçÿëè èíñòðóìåíòû äëÿ ðåìîíòà äîðîæíîãî çíàêà.', message_color)
			return false
		end
		if text:find('^%[Îøèáêà%](.+)Ó èãðîêà óæå åñòü òàêàÿ ëèöåíçèÿ ñðîêîì áîëåå ÷åì (.+)') then
			local days = text:match('ñðîêîì áîëåå ÷åì (.+)')
			sampAddChatMessage('[Rodina Helper] {ffffff}Ó èãðîêà óæå åñòü òàêàÿ ëèöåíçèÿ ñðîêîì áîëåå ÷åì ' .. days, message_color)
			sampSendChat('Ó âàñ óæå åñòü òàêàÿ ëèöåíçèÿ ñðîêîì áîëåå ÷åì ' .. days)
			return false
		end
		if (text:find('^%[Îøèáêà%](.+)Âû íå ìîæåòå ïðîäàâàòü ëèöåíçèè íà òàêîé ñðîê')) then
			sampAddChatMessage('[Rodina Helper] {ffffff}Âàø ðàíã íèæå, ÷åì òðåáóåòñÿ äëÿ âûäà÷è äàííîé ëèöåíçèè!', message_color)
			sampSendChat('Èçâèíèòå, ÿ íå ìîãó âûäàòü äàííóþ ëèöåíçèþ èç-çà íèçêîé äîëæíîñòè.')
			return false
		end
	end	

	if isMode('smi') then
		if text:find('^Íà îáðàáîòêó îáúÿâëåíèé ïðèøëî VIP ñîîáùåíèå îò: (.+){FFA500}%(Àâòîìàòè÷åñêè%)') then
			local nick = text:match('Íà îáðàáîòêó îáúÿâëåíèé ïðèøëî VIP ñîîáùåíèå îò: (.+){FFA500}%(Àâòîìàòè÷åñêè%)')
			if nick == nil then
				nick = ''
			end
			if sampGetPlayerIdByNickname(nick) == -1 then
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå VIP àâòî-îáüÿâëåíèå îò èãðîêà ' .. message_color_hex .. nick, message_color)
			else
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå VIP àâòî-îáüÿâëåíèå îò èãðîêà ' .. message_color_hex .. nick .. '[' .. sampGetPlayerIdByNickname(nick) .. ']', message_color)
			end
			return false
		elseif text:find('^Íà îáðàáîòêó îáúÿâëåíèé ïðèøëî ñîîáùåíèå îò: (.+){FFA500}%(Àâòîìàòè÷åñêè%)') then
			local nick = text:match('Íà îáðàáîòêó îáúÿâëåíèé ïðèøëî ñîîáùåíèå îò: (.+){FFA500}%(Àâòîìàòè÷åñêè%)')
			if nick == nil then
				nick = ''
			end
			if sampGetPlayerIdByNickname(nick) == -1 then
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå àâòî-îáüÿâëåíèå îò èãðîêà ' .. message_color_hex .. nick, message_color)
			else
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå àâòî-îáüÿâëåíèå îò èãðîêà ' .. message_color_hex .. nick .. '[' .. sampGetPlayerIdByNickname(nick) .. ']', message_color)
			end
			return false
		elseif text:find('^Íà îáðàáîòêó îáúÿâëåíèé ïðèøëî ñîîáùåíèå îò%: (.+)') then
			local nick = text:match('ïðèøëî ñîîáùåíèå îò%: (.+)')
			if nick == nil then
				nick = ''
			end
			if sampGetPlayerIdByNickname(nick) == -1 then
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå îáüÿâëåíèå îò èãðîêà ' .. message_color_hex .. nick, message_color)
			else
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå îáüÿâëåíèå îò èãðîêà ' .. message_color_hex .. nick .. '[' .. sampGetPlayerIdByNickname(nick) .. ']', message_color)
			end
			return false
		elseif text:find('^Íà îáðàáîòêó îáúÿâëåíèé ïðèøëî VIP ñîîáùåíèå îò%: (.+)') then
			local nick = text:match('ïðèøëî VIP ñîîáùåíèå îò%: (.+)')
			if nick == nil then
				nick = ''
			end
			if sampGetPlayerIdByNickname(nick) == -1 then
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå VIP îáüÿâëåíèå îò èãðîêà ' .. message_color_hex .. nick, message_color)
			else
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå VIP îáüÿâëåíèå îò èãðîêà ' .. message_color_hex .. nick .. '[' .. sampGetPlayerIdByNickname(nick) .. ']', message_color)
			end
			return false
		elseif text:find('^Íà îáðàáîòêó îáúÿâëåíèé ïðèøëî ñîîáùåíèå î ðåêëàìå áèçíåñà îò%: (.+)') then
			local nick = text:match('ïðèøëî ñîîáùåíèå î ðåêëàìå áèçíåñà îò%: (.+)')
			if nick == nil then
				nick = ''
			end
			if sampGetPlayerIdByNickname(nick) == -1 then
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå îáüÿâëåíèå îò ìàðêåòîëîãà ' .. message_color_hex .. nick, message_color)
			else
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå îáüÿâëåíèå îò ìàðêåòîëîãà ' .. message_color_hex .. nick .. '[' .. sampGetPlayerIdByNickname(nick) .. ']', message_color)
			end
			return false
		elseif text:find('^{C17C2D}Íà îáðàáîòêó îáúÿâëåíèé ïðèøëî ñîîáùåíèå îò ðóêîâîäñòâà ñòðàõîâîé êîìïàíèè%: (.+)') then
			local nick = text:match('Íà îáðàáîòêó îáúÿâëåíèé ïðèøëî ñîîáùåíèå îò ðóêîâîäñòâà ñòðàõîâîé êîìïàíèè%: (.+)')
			if nick == nil then
				nick = ''
			end
			if sampGetPlayerIdByNickname(nick) == -1 then
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå îáüÿâëåíèå îò ðóêîâîäñòâà ÑÒÊ, à èìåííî èãðîê ' .. message_color_hex .. nick, message_color)
			else
				sampAddChatMessage('[Rodina Helper]{ffffff} Ïîñòóïèëî íîâîå îáüÿâëåíèå îò ðóêîâîäñòâà ÑÒÊ, à èìåííî èãðîê ' .. message_color_hex .. nick .. '[' .. sampGetPlayerIdByNickname(nick) .. ']', message_color)
			end
			return false
		elseif text:find('^%[Îøèáêà%] %{ffffff%}Ýòî îáúÿâëåíèå óæå ðåäàêòèðóåò (.+).') then
			local nick = text:match('ðåäàêòèðóåò (.+).')
			sampAddChatMessage('[Rodina Helper] {ffffff}Ýòî îáüÿâëåíèå óæå ðåäàêòèðóåò èãðîê ' .. message_color_hex  .. nick, message_color)
			return false
		end
	end

	if (text:find('Andrey_Fil') and getServerNumber() == '20') or text:find('%[20%]Andrey_Fil') then
		local lastColor = text:match("(.+){%x+}$")
   		if not lastColor then
			lastColor = "{" .. rgba_to_hex(color) .. "}"
		end
		if text:find('%[VIP ADV%]') or text:find('%[FOREVER%]') then
			lastColor = "{FFFFFF}"
		end
		if text:find('%[20%]Andrey_Fil%[%d+%]') then
			local id = text:match('%[20%]Andrey_Fil%[(%d+)%]') or ''
			text = string.gsub(text, '%[20%]Andrey_Fil%[%d+%]', message_color_hex .. '[20]Fil[' .. id .. ']' .. lastColor)
		elseif text:find('%[20%]Andrey_Fil') then
			text = string.gsub(text, '%[20%]Andrey_Fil', message_color_hex .. '[20]Fil' .. lastColor)
		elseif text:find('Andrey_Fil%[%d+%]') then
			local id = text:match('Andrey_Fil%[(%d+)%]') or ''
			text = string.gsub(text, 'Andrey_Fil%[%d+%]', message_color_hex .. 'Fil[' .. id .. ']' .. lastColor)
		elseif text:find('Andrey_Fil') then
			text = string.gsub(text, 'Andrey_Fil', message_color_hex .. 'Fil' .. lastColor)
		end
		return {color,text}
	end
end
function sampev.onSendChat(text)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[SendChat] {ffffff}Text ' .. text, message_color)
		print('[SendChat] ' .. text)
	end
	local ignore = {
		[")"] = true,
		["))"] = true,
		["("] = true,
		["(("] = true,
		["q"] = true,
		["<3"] = true,
	}
	if ignore[text] then
		return {text}
	end
	if settings.player_info.rp_chat then
		text = text:sub(1, 1):rupper()..text:sub(2, #text) 
		if not text:find('(.+)%.') and not text:find('(.+)%!') and not text:find('(.+)%?') then
			text = text .. '.'
		end
	end
	if settings.player_info.accent_enable then
		text = settings.player_info.accent .. ' ' .. text 
	end
	return {text}
end
function sampev.onSendCommand(text)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[SendCommand] {ffffff}CMD ' .. text, message_color)
		print('[SendCommand] CMD ' .. text)
	end
	if isMode('hospital') and text == "/me äîñòà¸ò èç ñâîåãî ìåä.êåéñà ëåêàðñòâî è ïðèíèìàåò åãî" then
		MODULE.HealChat.healme = true
	end
	if settings.player_info.rp_chat then
		local chats =  { '/vr', '/fam', '/al', '/s', '/b', '/n', '/r', '/rb', '/f', '/fb', '/j', '/jb', '/m', '/do'} 
		for _, cmd in ipairs(chats) do
			if text:find('^'.. cmd .. ' ') then
				local cmd_text = text:match('^'.. cmd .. ' (.+)')
				if cmd_text ~= nil then
					cmd_text = cmd_text:sub(1, 1):rupper()..cmd_text:sub(2, #cmd_text)
					text = cmd .. ' ' .. cmd_text
					if not text:find('(.+)%.') and not text:find('(.+)%!') and not text:find('(.+)%?') then
						text = text .. '.'
					end
				end
			end
		end
	end
	return {text}
end
function sampev.onShowDialog(dialogid, style, title, button1, button2, text)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[ShowDialog] {ffffff}ID ' .. dialogid .. ' | Style ' .. style .. ' | Title ' .. title .. ' | Btn1 ' .. button1 .. ' | Btn2 ' .. button2 .. ' | Text ' .. text, message_color)
		print('[ShowDialog] ID ' .. dialogid .. ' | Style ' .. style .. ' | Title ' .. title .. ' | Btn1 ' .. button1 .. ' | Btn2 ' .. button2 .. ' | Text ' .. text)
	end

	if ((check_stats) and (title:find('Îñíîâíàÿ ñòàòèñòèêà') or title:find('Ñòàòèñòèêà èãðîêà'))) then
		-- Arizona & Rodina Stats
		if text:find("Èìÿ") then
			settings.player_info.nick = text:match("{FFFFFF}Èìÿ: {B83434}%[(.-)]") or text:match("{ffffff}Èìÿ %(en%.%):%s+{BE433D}([^\n\r]+)")
			settings.player_info.name_surname = text:match("{ffffff}Èìÿ %(ðóñ%.%):%s+{BE433D}([^\n\r]+)") or TranslateNick(settings.player_info.nick)
			sampAddChatMessage('[Rodina Helper] {ffffff}Âàøå èìÿ è ôàìèëèÿ îáíàðóæåíû: ' .. settings.player_info.name_surname, message_color)
        end
		if text:find("Ïîë:") then
			settings.player_info.sex = text:match("{FFFFFF}Ïîë: {B83434}%[(.-)]") or text:match("{ffffff}Ïîë:%s+{BE433D}([^\n\r]+)")
			sampAddChatMessage('[Rodina Helper] {ffffff}Âàø ïîë îáíàðóæåí: ' .. settings.player_info.sex, message_color)
		end
		if text:find("Îðãàíèçàöèÿ:") then
			settings.player_info.fraction = text:match("{FFFFFF}Îðãàíèçàöèÿ: {B83434}%[(.-)]") or text:match("{ffffff}Îðãàíèçàöèÿ:%s+{BE433D}([^\n\r]+)")
			if settings.player_info.fraction == 'Íå èìååòñÿ' then
				sampAddChatMessage('[Rodina Helper] {ffffff}Âû íå ñîñòîèòå â îðãàíèçàöèè!', message_color)
				settings.player_info.fraction_tag = "none"
				settings.general.fraction_mode = "none"
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Âàøà îðãàíèçàöèÿ îáíàðóæåíà, ýòî: '..settings.player_info.fraction, message_color)
				local fraction_data = {
					-- Rodina
					['ÔÑÁ'] = {'ÔÑÁ', 'fbi'},
					['Àðìèÿ'] = {'Àðìèÿ', 'army'},
					['Òþðüìà Ñòðîãîãî Ðåæèìà'] = {'ÔÑÈÍ', 'prison'},
					['Ãîðîäñêàÿ ïîëèöèÿ'] = {'ÃÈÁÄÄ', 'police'},
					['Ïîëèöèÿ îêðóãà'] = {'ÃÓÂÄ', 'police'},
					['Áîëüíèöà îêðóãà'] = {'ÎÊÁ', 'hospital'},
					['Ãîðîäñêàÿ áîëüíèöà'] = {'ÃÊÁ', 'hospital'},
					['Öåíòð Ëèöåíçèðîâàíèÿ'] = {'ÌÐÝÎ', 'lc'},
					['Ïðàâèòåëüñòâî'] = {'Ïðà-âî', 'gov'},
					['Ðàäèîöåíòð'] = {'ÃÒÐÊ', 'smi'},
				}
				local data = fraction_data[settings.player_info.fraction]
				if data then
					local old_fraction_mode = settings.general.fraction_mode 
					settings.player_info.fraction_tag = data[1]
					settings.general.fraction_mode = data[2]
					settings.departament.dep_tag1 = '[' .. settings.player_info.fraction_tag .. ']'
					sampAddChatMessage('[Rodina Helper] {ffffff}Âàøåé îðãàíèçàöèè ïðèñâîåí òåã '..settings.player_info.fraction_tag .. ". Íî âû ìîæåòå èçìåíèòü åãî.", message_color)

					if old_fraction_mode ~= '' and old_fraction_mode ~= settings.general.fraction_mode then
						sampAddChatMessage('[Rodina Helper] {ffffff}Âû òåïåðü â äðóãîé ôðàêöèè, ïîýòîìó óäàëÿþ ñòàíäàðòíûå RP êîìàíäû ' .. old_fraction_mode, message_color)
						delete_default_fraction_cmds(modules.commands.data.commands.my, get_fraction_cmds(old_fraction_mode, false))
						delete_default_fraction_cmds(modules.commands.data.commands_manage.my, get_fraction_cmds(old_fraction_mode, true))
					end

					local function add_unique(tbl, cmds)
						for _, cmd in ipairs(cmds) do
							local exists = false
							for _, v in ipairs(tbl) do
								if v.cmd == cmd.cmd then exists = true break end
							end
							if not exists then table.insert(tbl, cmd) end
						end
					end
					add_unique(modules.commands.data.commands.my, get_fraction_cmds(settings.general.fraction_mode, false))
					add_unique(modules.commands.data.commands_manage.my, get_fraction_cmds(settings.general.fraction_mode, true))

					save_module('commands')
					
					if settings.general.fraction_mode == 'police' or settings.general.fraction_mode == 'fcb' then
						add_notes()
					elseif settings.general.fraction_mode == 'prison' then
						add_notes('prison')
					end
				else
					settings.general.fraction_mode = 'none'
					settings.player_info.fraction_rank = "none"
					settings.player_info.fraction_rank_number = 0
					sampAddChatMessage('[Rodina Helper] {ffffff}Âàøà îðãàíèçàöèÿ ïîêà ÷òî íå ïîääåðæèâàåòñÿ â õåëïåðå!', message_color)
					sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîéäèòå ðó÷íóþ íàñòðîéêó õåëïåðà äëÿ èíèöèàëèçàöèè...', message_color)
				end
				if text:find("Äîëæíîñòü:") then
					local rank, rank_number = text:match("{FFFFFF}Äîëæíîñòü: {B83434}(.+)%((%d+)%)(.+)Óðîâåíü ðîçûñêà")
					if not rank or not rank_number then
						rank, rank_number = text:match("{ffffff}Äîëæíîñòü:%s+{BE433D}([^(]+)%((%d+)%)")
					end
					settings.player_info.fraction_rank = rank
					settings.player_info.fraction_rank_number = tonumber(rank_number)
					sampAddChatMessage('[Rodina Helper] {ffffff}Âàøà äîëæíîñòü îáíàðóæåíà, ýòî: ' .. settings.player_info.fraction_rank .. " (" .. settings.player_info.fraction_rank_number .. ")", message_color)
					if settings.player_info.fraction_rank_number >= 9 then
						settings.general.auto_uninvite = true
					end
				else
					settings.player_info.fraction_rank = "none"
					settings.player_info.fraction_rank_number = 0
					sampAddChatMessage('[Rodina Helper] {ffffff}Íå ìîãó ïîëó÷èòü âàø ðàíã!',message_color)
				end
			end
		end
		save_settings()
		sampSendDialogResponse(dialogid, 0, 0, 0)
		reload_script = true
		thisScript():reload()
		return false
	end

	if ((MODULE.Members.info.check) and (title:find('(.+)%(Â ñåòè: (%d+)%)') or title:find('Â ñåòè âñåãî .+ ÷ëåíîâ'))) then
        local count = 0
        local next_page = false
        local next_page_i = 0
		MODULE.Members.info.fraction = string.match(title, '(.+)%(Â ñåòè')
		if MODULE.Members.info.fraction then
			MODULE.Members.info.fraction = string.gsub(MODULE.Members.info.fraction, '{(.+)}', '')
		else
			MODULE.Members.info.fraction = settings.player_info.fraction -- rodina
		end
        for line in text:gmatch('[^\r\n]+') do
            count = count + 1
            if not line:find('ñòðàíèöà') and (not line:find('Íèê') or not line:find('Èìÿ')) then

				local optional_info = ''
				if line:find('{FFA500}%(Âû%)') then
					line = line:gsub("{FFA500}%(Âû%)", "")
					optional_info = '(Âû)'
				end
				if line:find(' %/ Â äåìîðãàíå') then
					line = line:gsub(" %/ Â äåìîðãàíå", "")
					optional_info = optional_info .. ' (JAIL)'
				end
				if line:find(' %/ MUTED') then
					line = line:gsub(" %/ MUTED", "")
					optional_info = optional_info .. ' (MUTE)'
				end
				if optional_info == '' then
					optional_info = '-'
				end

				

				if line:find('{FFA500}%(%d+.+%)') then
					local color, nickname, id, rank, rank_number, color2, rank_time, warns, afk = string.match(line, "{(%x%x%x%x%x%x)}([%w_]+)%((%d+)%)%s*([^%(]+)%((%d+)%)%s*{(%x%x%x%x%x%x)}%(([^%)]+)%)%s*{FFFFFF}(%d+)%s*%[%d+%]%s*/%s*(%d+)%s*%d+ øò")
					if color ~= nil and nickname ~= nil and id ~= nil and rank ~= nil and rank_number ~= nil and warns ~= nil and afk ~= nil then
						local working = false
						if color:find('90EE90') then
							working = true
						end
						if rank_time then
							rank_number = rank_number .. ') (' .. rank_time
						end
						table.insert(MODULE.Members.new, { nick = nickname, id = id, rank = rank, rank_number = rank_number, warns = warns, afk = afk, working = working, info = optional_info})
					end
				else
					local color, nickname, id, rank, rank_number, rank_time, warns, afk = string.match(line, "{(%x%x%x%x%x%x)}%s*([^%(]+)%((%d+)%)%s*([^%(]+)%((%d+)%)%s*([^{}]+){FFFFFF}%s*(%d+)%s*%[%d+%]%s*/%s*(%d+)%s*%d+ øò")
					if color ~= nil and nickname ~= nil and id ~= nil and rank ~= nil and rank_number ~= nil and warns ~= nil and afk ~= nil then
						local working = false
						if color:find('90EE90') then
							working = true
						end
						table.insert(MODULE.Members.new, { nick = nickname, id = id, rank = rank, rank_number = rank_number, warns = warns, afk = afk, working = working, info = optional_info})
					end
				end

				-- rodina
				if not rank or not nickname then
					local nickname, id, rank, rank_number, warns = line:match("(.+)%((%d+)%)%s+(.+)%((%d+)%).+(%d) / 3")
					if nickname and id and rank and rank_number and warns then
						table.insert(MODULE.Members.new, { nick = nickname, id = id, rank = rank, rank_number = rank_number, warns = warns, afk = 0, working = true, info = optional_info})
					end
				end
            end
            if line:match('Ñëåäóþùàÿ ñòðàíèöà') then
                next_page = true
                next_page_i = count - 2
            end
        end
        if next_page then
            sampSendDialogResponse(dialogid, 1, next_page_i, 0)
            next_page = false
            next_pagei = 0
		elseif #MODULE.Members.new ~= 0 then
            sampSendDialogResponse(dialogid, 0, 0, 0)
			MODULE.Members.all = MODULE.Members.new
			MODULE.Members.info.check = false
			MODULE.Members.Window[0] = true
		else
			sampSendDialogResponse(dialogid, 0, 0, 0)
			sampAddChatMessage('[Rodina Helper]{ffffff} Ñïèñîê ñîòðóäíèêîâ ïóñò!', message_color)
			MODULE.Members.info.check = false
        end
        return false
    end

	if settings.player_info.fraction_rank_number >= 9 then
		if title:find('Âûáåðèòå ðàíã äëÿ (.+)') and text:find('âàêàíñèé') then -- invite
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
		if MODULE.LeadTools.spawncar and title:find('$') and text:find('Ñïàâí òðàíñïîðòà') then -- ñïàâí òðàíñïîðòà 
			local count = 0
			for line in text:gmatch('[^\r\n]+') do
				if line:find('Ñïàâí òðàíñïîðòà') then
					sampSendDialogResponse(dialogid, 1, count, 0)
					MODULE.LeadTools.spawncar = false
					return false
				else
					count = count + 1
				end
			end
		end
		if MODULE.LeadTools.vc_vize.bool then -- âèçà äëÿ ÂÑ
			if text:find('Óïðàâëåíèå ðàçðåøåíèÿìè íà êîìàíäèðîâêó â Vice City') then
				local count = 0
				for line in text:gmatch('[^\r\n]+') do
					if line:find('Óïðàâëåíèå ðàçðåøåíèÿìè íà êîìàíäèðîâêó â Vice City') then
						sampSendDialogResponse(dialogid, 1, count, 0)
						return false 
					else
						count = count + 1
					end
				end
			end
			if title:find('Âûäà÷à ðàçðåøåíèé íà ïîåçäêè Vice City') then
				MODULE.LeadTools.vc_vize.bool = false
				sampSendChat("/r Ñîòðóäíèêó "..TranslateNick(sampGetPlayerNickname(tonumber(MODULE.LeadTools.vc_vize.player_id))).." âûäàíà âèçà Vice City!")
				sampSendDialogResponse(dialogid, 1, 0, tostring(MODULE.LeadTools.vc_vize.player_id))
				return false 
			end	
			if title:find('Çàáðàòü ðàçðåøåíèå íà ïîåçäêè Vice City') then
				MODULE.LeadTools.vc_vize.bool = false
				sampSendChat("/r Ó ñîòðóäíèêà "..TranslateNick(sampGetPlayerNickname(tonumber(MODULE.LeadTools.vc_vize.player_id))).." áûëà èçüÿòà âèçà Vice City!")
				sampSendDialogResponse(dialogid, 1, 0, tostring(sampGetPlayerNickname(MODULE.LeadTools.vc_vize.player_id)))
				return false 
			end
		end
		if (MODULE.LeadTools.platoon.check) then
			if text:find('Íàçíà÷èòü âçâîä èãðîêó') and text:find('Ó÷àñòíèêè âçâîäà') then
				sampSendDialogResponse(dialogid, 1, 3, 0)
				return false 
			end
			if text:find('{FFFFFF}Ââåäèòå {FB8654}ID{FFFFFF} èãðîêà, êîòîðîãî õîòèòå íàçíà÷èòü') then
				sampSendDialogResponse(dialogid, 1, 0, MODULE.LeadTools.platoon.player_id)
				MODULE.LeadTools.platoon.check = false
				return false 
			end
		end
	end

	if title:find('Ñóùíîñòè ðÿäîì') then -- arz fastmenu
		sampSendDialogResponse(dialogid, 0, 2, 0)
		return false 
	end

	if settings.gov.anti_trivoga and text:find('Âû äåéñòâèòåëüíî õîòèòå âûçâàòü ñîòðóäíèêîâ ïîëèöèè?')  then -- àíòè òðåâîæíàÿ êíîïêà
		sampSendDialogResponse(dialogid, 0, 0, 0)
		return false
	end
	
	if isMode('police') or isMode('fcb') then
		if text:find('Íèê') and text:find('Óðîâåíü ðîçûñêà') and text:find('Ðàññòîÿíèå') and MODULE.Wanted.check_wanted then
			local text = string.gsub(text, '%{......}', '')
			text = string.gsub(text, 'Íèê%s+Óðîâåíü ðîçûñêà%s+Ðàññòîÿíèå\n', '')
			for line in string.gmatch(text, '[^\n]+') do
				local nick, id, lvl, dist = string.match(line, '(%w+_%w+)%((%d+)%)%s+(%d) óðîâåíü%s+%[(.+)%]')
				if nick and id and lvl and dist then
					if dist:find('â èíòåðüåðå') then
						dist = 'Â èíòå'
					end
					table.insert(MODULE.Wanted.wanted_new, {nick = nick, id = id, lvl = lvl, dist = dist})
				end
			end
			sampSendDialogResponse(dialogid, 0, 0, 0)
			return false
		end
	end
	
	if (isMode('hospital')) then	
		if (MODULE.HealChat.healme) then
			if title:find('Àêòèâíûå ïðåäëîæåíèÿ') and text:find('Ëå÷åíèå') and text:find('Êîãäà') and text:find(MODULE.Binder.tags.my_nick()) then
				sampSendDialogResponse(dialogid, 1, 0, 0)
				return false
			end
			if title:find('Àêòèâíûå ïðåäëîæåíèÿ') and text:find('Ëå÷åíèå') and not text:find('Êîãäà') and text:find(MODULE.Binder.tags.my_nick()) then
				sampSendDialogResponse(dialogid, 1, 2, 0)
				return false
			end
			if title:find('Ïîäòâåðæäåíèå äåéñòâèÿ') and text:find('Ëå÷åíèå') and text:find(MODULE.Binder.tags.my_nick()) then
				sampSendDialogResponse(dialogid, 1, 2, 0)
				return false
			end
		end
		if (text:find('{FFFFFF}Ìåäèê {DAD540}(.+){FFFFFF} õî÷åò âûëå÷èòü âàñ çà {DAD540}') and text:find(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))):gsub('%[%d+%]',''))) then -- /hme
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
		if text:find("Ïðîâåðüòå è ïîäòâåðäèòå äàííûå ïåðåä âûäà÷åé ìåä êàðòû") and text:find("Ïîëíîñòüþ çäîðîâ") then  -- àâòîâûäà÷à ìåä.êàðòû
			sampAddChatMessage('[Rodina Helper] {ffffff}Îæèäàéòå ïîêà èãðîê ïîäòâåðäèò ïîëó÷åíèå ìåä. êàðòû', message_color)
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
	end

	if (isMode('smi')) then
		if MODULE.SmiEdit.skip_dialog then
			sampSendDialogResponse(dialogid, 0, 0, 0)
			MODULE.SmiEdit.skip_dialog = false
			sampSendChat('/newsredak')
			return false
		end
		if title:find('Ðåäàêòèðîâàíèå') and text:find('Îáúÿâëåíèå îò') and text:find('Ñîîáùåíèå') then
			MODULE.SmiEdit.ad_dialog_id = dialogid
			for line in text:gmatch("[^\n]+") do
				if line:find('^{FFFFFF}Îáúÿâëåíèå îò {FFD700}ìàðêåòîëîãà (.+) %(áèçíåñ') then
					MODULE.SmiEdit.ad_from = line:match('{FFFFFF}Îáúÿâëåíèå îò {FFD700}ìàðêåòîëîãà (.+) %(áèçíåñ')
				elseif line:find('^{FFFFFF}Îáúÿâëåíèå îò {FFD700}ðóêîâîäñòâà ñòðàõîâîé êîìïàíèè (.+),') then
					MODULE.SmiEdit.ad_from = line:match('{FFFFFF}Îáúÿâëåíèå îò {FFD700}ðóêîâîäñòâà ñòðàõîâîé êîìïàíèè (.+),')
				elseif line:find('^{FFFFFF}Îáúÿâëåíèå îò {FFD700}(.+),') then
					MODULE.SmiEdit.ad_from = line:match('{FFFFFF}Îáúÿâëåíèå îò {FFD700}(.+),')
				end
				if line:find('{FFFFFF}Ñîîáùåíèå:%s+{33AA33}(.+)') then
					MODULE.SmiEdit.ad_message = line:match('{FFFFFF}Ñîîáùåíèå:%s+{33AA33}(.+)')
				end
			end
			local exits = false
			-- VIP
			
			if not exits then
				MODULE.SmiEdit.Window[0] = true
			end
			return false
		end
		if (title:find('Ðåäàêòèðîâàíèå') and text:find('îáû÷íûõ') and text:find('àâòîìàòè÷åñêèõ') and settings.player_info.fraction_rank_number < 9) then
			sampSendDialogResponse(dialogid, 1,0,0)
			return false
		end
		if title:find('Ðåäàêöèÿ') then
			if text:find('Íà äàííûé ìîìåíò ñîîáùåíèé íåò') then
				sampSendDialogResponse(dialogid, 1,0,0)
				sampAddChatMessage('[Rodina Helper] {ffffff}Íà äàííûé ìîìåíò íåòó îáüÿâëåíèé äëÿ ðåäàêòèðîâàíèÿ!', message_color)
				return false
			end
		end 
	end
	
	if (isMode('lc')) then
		if title:find("Äîðîæíûå çíàêè") and (title:find("Los Santos") or title:find("San Fierro") or title:find("Las Venturas") or title:find("Lav Venturas")) and settings.lc.auto_find_clorest_repair_znak then
			-- çà îñíîâó âçÿòî https://www.blast.hk/threads/231943/ by áåçëèêèé
			local count = 0
			local znaks = {}
			for line in text:gmatch('[^\r\n]+') do
				count = count + 1
				if not line:find('Íàçâàíèå çíàêà') and not line:find('Óñòàíîâëåí') then
					line = string.gsub(line, "%%", "")
					line = string.gsub(line, "{[0-9a-fA-F]+}", "")
					local num, name, dist, damage, status = string.match(line, '%[(%d+)%] ([^\t]+)\t([0-9%.]+)..ì\t(%d*)\t(.*)')
					if name == nil then
						num, name, dist, status = string.match(line, '%[(%d+)%] ([^\t]+)\t([0-9%.]+)..ì\t.*\t(.*)')
						damage = 100
					end
					table.insert(znaks, {number = num, name = name, distance = dist, health = damage, status = status})
				end
			end
			local min_dist = 999999
			local nearest = nil
			for i, znak in ipairs(znaks) do
				local dist = tonumber(znak.distance)
				if dist and dist < min_dist then
					min_dist = dist
					nearest = znak
				end
			end
			if not nearest then
				sampAddChatMessage("[Rodina Helper | Àññèñòåíò] {ffffff}Â äàííîì ãîðîäå âñå äîðîæíûå çíàêè â íîðìå!", message_color)
				sampSendDialogResponse(dialogid, 0, 0, "")
			else
				sampAddChatMessage("[Rodina Helper | Àññèñòåíò] {ffffff}Áëèæàéøèé ê âàì çíàê " .. message_color_hex .. "¹" .. nearest.number .. " {ffffff}(äèñòàíöèÿ " .. message_color_hex .. nearest.distance .. "ì{ffffff}, ñòàòóñ " .. message_color_hex .. nearest.status .. "{ffffff})", message_color)
				sampSendDialogResponse(dialogid, 1, nearest.number-1, "")
			end
			return false
		end
	end

end
function sampev.onCreate3DText(id, color, position, distance, testLOS, attachedPlayerId, attachedVehicleId, text_3d)
   	if (MODULE.DEBUG) then
		
	end
	if settings.gov.anti_trivoga and text_3d and text_3d:find('Òðåâîæíàÿ êíîïêà') then
		return false
	end
end
function sampev.onPlayerChatBubble(player_id, color, distance, duration, message)
	if (MODULE.DEBUG) then
		sampAddChatMessage('[ChatBubble] {ffffff}ID ' .. player_id .. ' | Color ' .. color .. ' | Dist ' .. distance .. ' | Duration ' .. duration .. ' | MSG ' .. message, message_color)
		print('[ChatBubble] {ffffff}ID ' .. player_id .. ' | Color ' .. color .. ' | Dist ' .. distance .. ' | Duration ' .. duration .. ' | MSG ' .. message)
	end
	if isMode('police') or isMode('fcb') then
		if message:find(" (.+) äîñòàë ñêðåïêè äëÿ âçëîìà íàðó÷íèêîâ") then
			local nick = message:match(' (.+) äîñòàë ñêðåïêè äëÿ âçëîìà íàðó÷íèêîâ')
			local id = sampGetPlayerIdByNickname(nick)
			local result, handle = sampGetCharHandleBySampPlayerId(id)
			if result then
				sampAddChatMessage('[Rodina Helper] {ffffff}Âíèìàíèå! ' .. nick .. '[' .. id .. '] èñïîëüçóåò ñêðåïêè è íà÷èíàåò âçëàìûâàòü íàðó÷íèêè!', message_color)
			end
		end
	end
end
addEventHandler('onSendPacket', function(id, bs, priority, reliability, orderingChannel)
	if id == 220 then
		local id = raknetBitStreamReadInt8(bs)
		local packettype = raknetBitStreamReadInt8(bs)
		if isMonetLoader() then
			local strlen = raknetBitStreamReadInt8(bs)
			if (MODULE.DEBUG) then
				local str = raknetBitStreamReadString(bs, strlen)
				sampAddChatMessage('[SendPacket] {ffffff}' .. str, message_color)
				print("[SendPacket] " .. str)
			end
		else
			local strlen = raknetBitStreamReadInt16(bs)
			local str = raknetBitStreamReadString(bs, strlen)
			if packettype ~= 0 and packettype ~= 1 and #str > 2 then
				if (MODULE.DEBUG) then
					sampAddChatMessage('[SendPacket] {ffffff}' .. str, message_color)
					print("[SendPacket] " .. str)
				end
			end
		end
	end
end)
addEventHandler('onReceivePacket', function(id, bs)
	if id == 220 then
		local id = raknetBitStreamReadInt8(bs)
        local cmd = raknetBitStreamReadInt8(bs)
		local function dumpFullBitStream(bs)
			local bitsLeft = raknetBitStreamGetNumberOfUnreadBits(bs)
			if not bitsLeft then
				print("dumpFullBitStream: raknetBitStreamGetNumberOfUnreadBits îøèáêà!")
				return
			end
			local bytesLeft = math.floor(bitsLeft / 8)
			if bytesLeft == 0 then
				print("dumpFullBitStream: íåòó äîñòóïíûõ áàéòîâ äëÿ ÷òåíèÿ")
				return
			end
			local bytes = {}
			for i = 1, bytesLeft do
				bytes[i] = raknetBitStreamReadInt8(bs)
			end
			local hexStrParts = {}
			for i, b in ipairs(bytes) do
				hexStrParts[i] = string.format("%02X", b)
			end
			return(table.concat(hexStrParts, " "))
		end
		-- if (MODULE.DEBUG) then
		-- 	local dump = dumpFullBitStream(bs)
		-- 	sampAddChatMessage('[ReceivePacket] {ffffff}' .. dump, message_color)
		-- 	print("[ReceivePacket] " .. dump)
		-- end
		if cmd == 153 then
            local carId = raknetBitStreamReadInt16(bs)
            raknetBitStreamIgnoreBits(bs, 8)
            local numberlen = raknetBitStreamReadInt8(bs)
            local plate_number = raknetBitStreamReadString(bs, numberlen)
            local typelen = raknetBitStreamReadInt8(bs)
            local numType = raknetBitStreamReadString(bs, typelen)
            modules.arz_veh.cache[carId] = {
                carID = carId or 0,
                number = plate_number or "",
                region = numType or "",
            }
        end
		if isMonetLoader() then 
			if cmd == 84 then
				local unk1 = raknetBitStreamReadInt8(bs)
				local unk2 = raknetBitStreamReadInt8(bs)
				local len = raknetBitStreamReadInt16(bs)
				local encoded = raknetBitStreamReadInt8(bs)
				local string = encoded == 0 and raknetBitStreamReadString(bs, len) or raknetBitStreamDecodeString(bs, len + encoded)
				if (MODULE.DEBUG) then
					sampAddChatMessage('[ReceivePacket] {ffffff}' .. string, message_color)
					print("[ReceivePacket] " .. string)
				end
			end
		else
			if cmd == 17 then
				raknetBitStreamIgnoreBits(bs, 32)
				local length = raknetBitStreamReadInt16(bs)
				local encoded = raknetBitStreamReadInt8(bs)
				local cmd = (encoded ~= 0) and raknetBitStreamDecodeString(bs, length + encoded) or raknetBitStreamReadString(bs, length)
				if (MODULE.DEBUG) then
					sampAddChatMessage('[ReceivePacket] {ffffff}' .. cmd, message_color)
					print("[ReceivePacket] " .. cmd)
				end
				if cmd:find('"Ïðîâåðêà äîêóìåíòîâ","Íàéäèòå') then
					local find = cmd:match('%[.+%[(.+)%]%]')
					sampAddChatMessage("[Rodina Helper | Àññèñòåíò] {ffffff}Ïðàâèëüíûå êîíâåðòû: " .. find:gsub(',', ' '), message_color)
					sampShowDialog(897124, 'Rodina Helper - Àññèñòåíò', "Ïðàâèëüíûå êîíâåðòû: " .. find:gsub(',', ' '), '{009EFF}Çàêðûòü', '', 0)
				end
			end
		end
	end
end)
addEventHandler('onReceiveRpc', function(id, bs)
	if id == 123 then
        local carId = raknetBitStreamReadInt16(bs)
        local numLen = raknetBitStreamReadInt8(bs)
		local plate_number = raknetBitStreamReadString(bs, numLen)
		modules.arz_veh.cache[carId] = {
			carID = carId or 0,
			number = plate_number or "",
			type = "ARZ"
		}
	end
end)
--------------------------------------------- INIT GUI --------------------------------------------
imgui.OnInitialize(function()
	imgui.GetIO().IniFilename = nil
	imgui.GetIO().Fonts:Clear()

	local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
	if isMonetLoader() then
		MODULE.FONT = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory():gsub('\\','/') .. '/lib/mimgui/trebucbd.ttf', 14 * settings.general.custom_dpi, _, glyph_ranges)
	else
		MODULE.FONT = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14)..'\\trebucbd.ttf', 14 * settings.general.custom_dpi, _, glyph_ranges)
	end

	fa.Init(14 * settings.general.custom_dpi)

	if settings.general.helper_theme == 0 and monet_no_errors then
		apply_moonmonet_theme()
	elseif settings.general.helper_theme == 1 then
		apply_dark_theme()
	elseif settings.general.helper_theme == 2 then
		apply_white_theme()
	end

	imgui.GetIO().ConfigFlags = imgui.ConfigFlags.NoMouseCursorChange

end)

imgui.OnFrame(
    function() return MODULE.Initial.Window[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(fa.GEARS .. u8' Ïåðâîíà÷àëüíàÿ íàñòðîéêà Rodina Helper ' .. fa.GEARS, MODULE.Initial.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
        change_dpi()
		if MODULE.Initial.step == 0 then
			if (doesFileExist(configDirectory .. '/Resourse/logo.png')) then
				if (not _G.helper_logo) then
					local path = configDirectory .. '/Resourse/logo.png'
					_G.helper_logo = imgui.CreateTextureFromFile(path)
				else
					imgui.Image(_G.helper_logo, imgui.ImVec2(520 * settings.general.custom_dpi, 150 * settings.general.custom_dpi))
				end
			else
				if imgui.BeginChild('##init1_1', imgui.ImVec2(520 * settings.general.custom_dpi, 150 * settings.general.custom_dpi), true) then
					imgui.Text("\n\n\n")
					imgui.CenterTextDisabled(u8('Íå óäàëîñü àâòîìàòè÷åñêè çàãðóçèòü ëîãîòèï è äðóãèå ôàéëû õåëïåðà!\n\n'))
					imgui.CenterTextDisabled(u8('Íà âðåìÿ âêëþ÷èòå VPN äëÿ ïîäãðóçêè íóæíûõ ôàéëîâ, ëèáî ñêà÷àéòå âðó÷íóþ'))
					imgui.CenterTextDisabled(u8('https://github.com/komarova140784-web/Rodina-Helper-'))
					imgui.EndChild()
				end
			end
			imgui.CenterText(u8("Ïîõîæå âû âïåðâûå çàïóñòèëè õåëïåð, èëè ñáðîñèëè íàñòðîéêè"))
			imgui.CenterText(u8("Íåîáõîäèìî ïðîèçâåñòè íàñòðîéêó äëÿ äîñòóïíîñòè êîìàíä è ôóíêöèé"))
			imgui.Separator()
			imgui.CenterText(u8("Âûáåðèòå ñïîñîá äëÿ íàñòðîéêè õåëïåðà:"))
			if imgui.CenterButton(fa.CIRCLE_ARROW_RIGHT .. u8(' Óêàçàòü äàííûå âðó÷íóþ ') .. fa.CIRCLE_ARROW_LEFT) then
				MODULE.Initial.fraction_type_selector = 0
				MODULE.Initial.step = 1
			end
			imgui.Separator()
			imgui.CenterText(u8("Åñëè ÷òî, â ëþáîé ìîìåíò âû ñìîæåòå çàíîâî ïåðåïðîéòè íàñòðîéêó õåëïåðà"))
		elseif MODULE.Initial.step == 1 then
			imgui.CenterText(u8('Âûáåðèòå òèï âàøåé îðãàíèçàöèè äëÿ èìïîðòà êîìàíä è ôóíêöèé:'))

			local function render_org_block(org_num, icon, name, fractions, tags)
				if imgui.BeginChild('##init1_'..org_num, imgui.ImVec2(170 * settings.general.custom_dpi, 45 * settings.general.custom_dpi), (MODULE.Initial.fraction_type_selector == org_num)) then
					if not (MODULE.Initial.fraction_type_selector == org_num) then
						imgui.SetCursorPos(imgui.ImVec2(0, 5 * settings.general.custom_dpi))
					end
					imgui.CenterText(icon .. u8(' '..name))
					imgui.CenterTextDisabled(u8(fractions))
					imgui.EndChild()
				end
				if imgui.IsItemClicked() then
					MODULE.Initial.fraction_type_selector = org_num
					MODULE.Initial.fraction_type_selector_text = name
					MODULE.Initial.fraction_type_icon = icon
				end
			end
			render_org_block(1, fa.BUILDING_SHIELD, 'ÌÂÄ', 'ÃÈÁÄÄ/ÃÓÂÄ/ÔÑÁ')
			imgui.SameLine()
			render_org_block(2, fa.HOSPITAL, 'Çäðàâî.', 'ÃÊÁ/ÎÊÁ')
			imgui.SameLine()
			render_org_block(3, fa.BUILDING_SHIELD, 'îáîðîíà', 'ÒÑÐ/Àðìèÿ')
			render_org_block(4, fa.BUILDING_NGO, 'Íîâîñíîå', 'ÃÒÐÊ')
			imgui.SameLine()
			render_org_block(5, fa.BUILDING_COLUMNS, 'Öåíòðàëüíûé àïïàðàò', 'Ïðàâî')
			imgui.SameLine()
			render_org_block(6, fa.HOTEL, '', '')
			render_org_block(7, fa.TORII_GATE, 'Ìàôèÿ', 'ÊÌ/ÓÌ/ÐÌ')
			imgui.SameLine()
			render_org_block(0, fa.BUILDING_CIRCLE_XMARK, 'Áåç îðãàíèçàöèè', 'Áèíäåð & Çàìåòêè')

			if imgui.Button(fa.CIRCLE_ARROW_LEFT .. u8(' Íàçàä'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				MODULE.Initial.step = 0
			end
			imgui.SameLine()
			if imgui.Button(u8('Âûáðàòü "' .. MODULE.Initial.fraction_type_selector_text .. '" ') .. fa.CIRCLE_ARROW_RIGHT, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				MODULE.Initial.slider[0] = 1
				if MODULE.Initial.fraction_type_selector ~= 0 then
					MODULE.Initial.step = 2
				else
					settings.player_info.fraction_rank = 'Íåòó'
					settings.player_info.fraction_rank_number = 0
					MODULE.Initial.step = 4
				end
			end
		elseif MODULE.Initial.step == 2 then
    		imgui.CenterText(u8('Âûáåðèòå ñâîþ îðãàíèçàöèþ èç êàòåãîðèè "' .. MODULE.Initial.fraction_type_selector_text .. '":'))

			local function render_fraction_block(org_num, name, fraction_tag)
				if imgui.BeginChild('##init2_'..org_num, imgui.ImVec2(170 * settings.general.custom_dpi, 45 * settings.general.custom_dpi), (MODULE.Initial.fraction_selector == org_num)) then
					if not (MODULE.Initial.fraction_selector == org_num) then
						imgui.SetCursorPos(imgui.ImVec2(0, 5 * settings.general.custom_dpi))
					end
					imgui.CenterText(u8(name))
					imgui.CenterTextDisabled(u8(fraction_tag))
					imgui.EndChild()
				end
				if imgui.IsItemClicked() then
					MODULE.Initial.fraction_selector = org_num
					MODULE.Initial.fraction_selector_text = name
					MODULE.Initial.step2_result = (MODULE.Initial.fraction_type_selector * 10) + org_num
				end
			end
			local orgs = {
				[1] = {
					{name = "Ïîëèöèÿ îêðóãà",			    tag = "ÃÓÂÄ"},
					{name = "Ãîðîäñêàÿ ïîëèöèÿ", 			tag = "ÃÈÁÄÄ"},
					{name = "Ôåä.Ñëóæáà Áåçîïàñíîñòè", 		tag = "ÔÑÁ"},
				},
				[2] = {
					{name = "Îêðóæíàÿ áîëüíèöà",   			tag = "ÎÊÁ"},
					{name = "Ãîðîäñêàÿ áîëüíèöà", 			tag = "ÃÊÁ"},
				},
				[3] = {
					{name = "Òþðìà Ñòðîãî Ðåæèì", 			tag = "ÔÑÈÍ"},
					{name = "Àðìèÿ", 						tag = "Àðìèÿ"},
				},
				[4] = {
					{name = "ÑÌÈ", 							tag = "ÃÒÐÊ"},
				},
				[5] = {
					{name = "Ïðàâèòåëüñòâî", 				tag = "Ïðàâî"},
					{name = "Öåíòð ëèöåíçèðîâàíèÿ", 		tag = "ÃÒÐÊ"},
				},
				[6] = {
					{name = "Ïîæàðíûé äåïàðòàìåíò", 		tag = "ÏÄ"},
				},
				[7] = {
					{name = "Óêðàèíñêàÿ ìàôèÿ", 			tag = "ÓÌ"},
					{name = "Êàâêàçêàÿ ìàôèÿ", 				tag = "ÊÌ"},
					{name = "Ðóññêàÿ ìàôèÿ", 				tag = "ÐÌ"},
				},
			}
			local org_list = orgs[MODULE.Initial.fraction_type_selector]
			for i, org in ipairs(org_list) do
				render_fraction_block(i, org.name, org.tag)
				if ((i % 3 ~= 0) and i ~= #org_list) then imgui.SameLine() end
			end

			if imgui.Button(fa.CIRCLE_ARROW_LEFT .. u8(' Íàçàä'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				MODULE.Initial.step = 1
			end
			imgui.SameLine()
			if imgui.Button(u8('Âûáðàòü "' .. MODULE.Initial.fraction_selector_text .. '" ') .. fa.CIRCLE_ARROW_RIGHT, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				if MODULE.Initial.step2_result ~= 0 then
					MODULE.Initial.step = 3
				end
			end
		elseif MODULE.Initial.step == 3 then
			imgui.CenterText(u8('Óêàæèòå âàøó äîëæíîñòü â îðãàíèçàöèè (ïîëíîå íàçâàíèå è ïîðÿäêîâûé íîìåð ðàíãà):'))
			imgui.PushItemWidth(520 * settings.general.custom_dpi)
			imgui.InputTextWithHint(u8'##input_fraction_rank', u8('Ââåäèòå ïîëíîå íàçâàíèå âàøåé äîëæíîñòè â îðãàíèçàöèè...'), MODULE.Initial.input, 256)
			imgui.PushItemWidth(520 * settings.general.custom_dpi)
			imgui.SliderInt('##fraction_rank_number', MODULE.Initial.slider, 1, 10)
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_ARROW_LEFT .. u8(' Íàçàä'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				imgui.StrCopy(MODULE.Initial.input, "")
				MODULE.Initial.step = 2
			end
			imgui.SameLine()
			if imgui.Button(u8('Ïðîäîëæèòü ') .. fa.CIRCLE_ARROW_RIGHT, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				settings.player_info.fraction_rank = u8:decode(ffi.string(MODULE.Initial.input))
				settings.player_info.fraction_rank_number = MODULE.Initial.slider[0]
				if settings.player_info.fraction_rank_number >= 9 then
					settings.general.auto_uninvite = true
				end
				imgui.StrCopy(MODULE.Initial.input, "")
				MODULE.Initial.step = 4
			end
		elseif MODULE.Initial.step == 4 then
			imgui.CenterText(u8('Ââåäèòå âàø ïîëíûé èãðîâîé íèêíåéì (íà àíãëèéñêîì):'))
			imgui.PushItemWidth(520 * settings.general.custom_dpi)
			imgui.InputText(u8'##input_nick', MODULE.Initial.input, 256)
			imgui.CenterTextDisabled(u8(TranslateNick(u8:decode(ffi.string(MODULE.Initial.input)))))
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_ARROW_LEFT .. u8(' Íàçàä'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				imgui.StrCopy(MODULE.Initial.input, "")
				MODULE.Initial.step = 3
			end
			imgui.SameLine()
			if imgui.Button(u8('Çàâåðøèòü íàñòðîéêó ') .. fa.FLAG_CHECKERED, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				settings.player_info.nick = u8:decode(ffi.string(MODULE.Initial.input))
				settings.player_info.name_surname = TranslateNick(settings.player_info.nick)
				MODULE.Initial.step = 5
			end
		elseif MODULE.Initial.step == 5 then
			local fraction_modes = {
				{id = 0,  name = "Îòñóòñòâóåò",         	   mode = "none",       tag = "Íåòó"},
				{id = 11, name = "Ãë. óïð. âíóòðåííèõ äåë",    mode = "police", 	tag = "ÃÓÂÄ"},
				{id = 12, name = "Ãîñ. Èíñïåê. Áåçîïàñí. Äîðîæ. Äâèæ.",         mode = "police", 	tag = "ÃÈÁÄÄ"},
				{id = 13, name = "Ôåä. Ñëóæáà Áåçîïàñíîñòè",   mode = "fcb", 		tag = "ÔÑÁ"},
				{id = 21, name = "Îêðóæíàÿ áîëüíèöà",      	   mode = "hospital", 	tag = "ÎÊÁ"},
				{id = 22, name = "Ãîðîäñêàÿ áîëüíèöà",     	   mode = "hospital", 	tag = "ÃÊÁ"},
				{id = 31, name = "Òþðìà ñòðîãî ðåæèìà",        mode = "prison", 	tag = "ÔÑÈÍ"},
				{id = 32, name = "Àðìèÿ",          			   mode = "army", 		tag = "Àðìèÿ"},
				{id = 41, name = "ÑÌÈ",            		       mode = "smi",	 	tag = "ÃÒÐÊ"},
				{id = 51, name = "Ïðàâèòåëüñòâî",              mode = "gov", 		tag = "Ïðà-âî"},
				{id = 52, name = "Öåíòð ëèöåíçèðîâàíèÿ",       mode = "lc", 		tag = "ÌÐÝÎ"},
				{id = 71, name = "Óêðàèíñêàÿ Ìàôèÿ",           mode = "mafia",		tag = "ÓÌ"},
				{id = 72, name = "Êàâêàçñêàÿ Ìàôèÿ",           mode = "mafia", 		tag = "ÊÌ"},
				{id = 73, name = "Ðóññêàÿ ìàôèÿ",              mode = "mafia", 		tag = "ÐÌ"},
			}	
			for index, value in ipairs(fraction_modes) do
				if value.id == MODULE.Initial.step2_result then
					settings.general.fraction_mode = value.mode
					settings.player_info.fraction = value.name
					settings.player_info.fraction_tag = value.tag
					break
				end
			end

			local function add_unique(tbl, cmds)
				for _, cmd in ipairs(cmds) do
					local exists = false
					for _, v in ipairs(tbl) do
						if v.cmd == cmd.cmd then exists = true break end
					end
					if not exists then table.insert(tbl, cmd) end
				end
			end
			add_unique(modules.commands.data.commands.my, get_fraction_cmds(settings.general.fraction_mode, false))
			add_unique(modules.commands.data.commands_manage.my, get_fraction_cmds(settings.general.fraction_mode, true))

			if settings.general.fraction_mode == 'police' or settings.general.fraction_mode == 'fcb' then
				add_notes()
			elseif settings.general.fraction_mode == 'prison' then
				add_notes('prison')
			end
	
			save_settings()
			save_module('commands')
			reload_script = true
			thisScript():reload()
		end
        imgui.End()
    end
)
--------------------------------------------- MAIN GUI --------------------------------------------
imgui.OnFrame(
    function() return MODULE.Main.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 430	* settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(getHelperIcon() .. " Rodina Helper " .. getHelperIcon() .. "##main", MODULE.Main.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize )
		change_dpi()
		if imgui.BeginTabBar('Ïðèâåò! Çà÷åì êîä ñìîòðèøü?') then	
			if imgui.BeginTabItem(fa.HOUSE..u8' Ãëàâíîå ìåíþ') then
				if (doesFileExist(configDirectory .. '/Resourse/logo.png')) then
					if (not _G.helper_logo) then
						local path = configDirectory .. '/Resourse/logo.png'
						_G.helper_logo = imgui.CreateTextureFromFile(path)
					else
						imgui.Image(_G.helper_logo, imgui.ImVec2(589 * settings.general.custom_dpi, 161 * settings.general.custom_dpi))
					end
				else
					if imgui.BeginChild('##1000000000000', imgui.ImVec2(589 * settings.general.custom_dpi, 161 * settings.general.custom_dpi), true) then
						imgui.Text("\n\n\n")
						imgui.CenterTextDisabled(u8('Íå óäàëîñü àâòîìàòè÷åñêè çàãðóçèòü ëîãîòèï è äðóãèå ôàéëû õåëïåðà!\n\n'))
						imgui.CenterTextDisabled(u8('Íà âðåìÿ âêëþ÷èòå VPN äëÿ ïîäãðóçêè íóæíûõ ôàéëîâ, ëèáî ñêà÷àéòå âðó÷íóþ'))
						imgui.CenterTextDisabled(u8('https://github.com/komarova140784-web/Rodina-Helper-'))
						imgui.EndChild()
					end
				end
				if imgui.BeginChild('##2', imgui.ImVec2(589 * settings.general.custom_dpi, 169 * settings.general.custom_dpi), true) then
					imgui.CenterText(getUserIcon() .. u8' Èíôîðìàöèÿ ïðî âàøåãî ïåðñîíàæà ' .. getUserIcon())
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"Èìÿ è Ôàìèëèÿ:")
					imgui.SetColumnWidth(-1, 230 * settings.general.custom_dpi)
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.name_surname))
					imgui.SetColumnWidth(-1, 250 * settings.general.custom_dpi)
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##name_surname') then
						settings.player_info.name_surname = TranslateNick(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
						imgui.StrCopy(MODULE.Main.input, u8(settings.player_info.name_surname))
						imgui.StrCopy(MODULE.Initial.input, u8(settings.player_info.nick))
						imgui.OpenPopup(getUserIcon() .. u8' Èìÿ è Ôàìèëèÿ ' .. getUserIcon() .. '##name_surname')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getUserIcon() .. u8' Èìÿ è Ôàìèëèÿ ' .. getUserIcon() .. '##name_surname', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##name_surname', u8('Ââåäèòå èìÿ è ôàìèëèþ âàøåãî ïåðñîíàæà...'), MODULE.Main.input, 256)
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						if imgui.InputTextWithHint(u8'##nickname', u8('Ââåäèòå âàø èãðîâîé íèêíåéì...'), MODULE.Initial.input, 256) then
							imgui.StrCopy(MODULE.Main.input, u8(TranslateNick(u8:decode(ffi.string(MODULE.Initial.input)))))
						end
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. '##cancel_name_surname', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. '##save_name_surname', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							settings.player_info.name_surname = u8:decode(ffi.string(MODULE.Main.input))
							settings.player_info.nick = u8:decode(ffi.string(MODULE.Initial.input))
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"Àêöåíò ïåðñîíàæà:")
					imgui.NextColumn()
					if MODULE.Main.checkbox.accent_enable[0] then
						imgui.CenterColumnText(u8(settings.player_info.accent))
					else 
						imgui.CenterColumnText(u8'Îòêëþ÷åíî')
					end
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##accent') then
						imgui.StrCopy(MODULE.Main.input, u8(settings.player_info.accent))
						imgui.OpenPopup(getUserIcon() .. u8' Àêöåíò ïåðñîíàæà ' .. getUserIcon() .. '##accent')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getUserIcon() .. u8' Àêöåíò ïåðñîíàæà ' .. getUserIcon() .. '##accent', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						if imgui.Checkbox('##MODULE.Main.checkbox.accent_enable', MODULE.Main.checkbox.accent_enable) then
							settings.player_info.accent_enable = MODULE.Main.checkbox.accent_enable[0]
							save_settings()
						end
						imgui.SameLine()
						imgui.PushItemWidth(375 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##accent_input', u8('Ââåäèòå àêöåíò âàøåãî ïåðñîíàæà...'), MODULE.Main.input, 256) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. '##cancel_accent', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. '##save_accent', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then 
							settings.player_info.accent = u8:decode(ffi.string(MODULE.Main.input))
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"Ïîë ïåðñîíàæà:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.sex))
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##sex') then
						settings.player_info.sex = (settings.player_info.sex ~= 'Ìóæ÷èíà') and 'Ìóæ÷èíà' or 'Æåíùèíà'
						save_settings()
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"Îðãàíèçàöèÿ:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.fraction))
					imgui.NextColumn()
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. "##fraction") then
						imgui.StrCopy(MODULE.Main.input, u8(settings.player_info.fraction))
						imgui.OpenPopup(getHelperIcon() .. u8' Îðãàíèçàöèÿ ' .. getHelperIcon() .. '##fraction')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' Îðãàíèçàöèÿ ' .. getHelperIcon() .. '##fraction', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##input_fraction_name', u8('Ââåäèòå íàçâàíèå âàøåé îðãàíèçàöèè...'), MODULE.Main.input, 256)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. '##cancel_fraction_edit', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. '##save_fraction_edit', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							settings.player_info.fraction = u8:decode(ffi.string(MODULE.Main.input))
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.GEAR .. '##fraction') then
						imgui.OpenPopup(getHelperIcon() .. u8' Ñìåíà îðãàíèçàöèè ' .. getHelperIcon() .. '##fraction')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' Ñìåíà îðãàíèçàöèè ' .. getHelperIcon() .. '##fraction', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8('Âû äåéñòâèòåëüíî õîòèòå èçìåíèòü îðãàíèçàöèþ?'))
						imgui.CenterText(u8('Âñå ñòàíäàðòíûå ôðàêöèîííûå RP êîìàíäû áóäóò ñáðîøåíû!'))
						imgui.CenterText(u8('Íî âàøè ëè÷íûå RP êîìàíäû, êîòîðûå âû äîáàâëÿëè, ñîõðàíÿòüñÿ'))
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. '##cancel_new_fraction', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.GEARS .. u8' Ñáðîñèòü ' .. fa.GEARS .. '##reset_fraction', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							delete_default_fraction_cmds(modules.commands.data.commands.my, get_fraction_cmds(settings.general.fraction_mode, false))
							delete_default_fraction_cmds(modules.commands.data.commands_manage.my, get_fraction_cmds(settings.general.fraction_mode, true))
							MODULE.Initial.Window[0] = true
							MODULE.Main.Window[0] = false
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"Äîëæíîñòü:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.fraction_rank) .. " (" .. settings.player_info.fraction_rank_number .. ")")
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. "##rank") then
						imgui.StrCopy(MODULE.Main.input, u8(settings.player_info.fraction_rank))
						MODULE.Main.slider[0] = settings.player_info.fraction_rank_number
						imgui.OpenPopup(getHelperIcon() .. u8' Äîëæíîñòü â îðãàíèçàöèè ' .. getHelperIcon() .. '##fraction_rank')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' Äîëæíîñòü â îðãàíèçàöèè ' .. getHelperIcon() .. '##fraction_rank', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##input_fraction_rank', u8('Ââåäèòå íàçâàíèå âàøåé äîëæíîñòè...'), MODULE.Main.input, 256)
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.SliderInt('##fraction_rank_number', MODULE.Main.slider, 1, 10) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. '##cancel_fraction_rank', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. '##save_fraction_rank', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							settings.player_info.fraction_rank = u8:decode(ffi.string(MODULE.Main.input))
							settings.player_info.fraction_rank_number = MODULE.Main.slider[0]
							if settings.player_info.fraction_rank_number >= 9 then
								settings.general.auto_uninvite = true
								registerCommandsFrom(modules.commands.data.commands_manage.my)
							end	
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.PASSPORT .. '##stats') then
						check_stats = true
						sampSendChat('/stats')
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"Òåã îðãàíèçàöèè:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.fraction_tag))
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##fraction_tag') then
						imgui.StrCopy(MODULE.Main.input, u8(settings.player_info.fraction_tag))
						imgui.OpenPopup(getHelperIcon() .. u8' Òåã îðãàíèçàöèè ' .. getHelperIcon() .. '##fraction_tag')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' Òåã îðãàíèçàöèè ' .. getHelperIcon() .. '##fraction_tag', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputText(u8'##input_fraction_tag', MODULE.Main.input, 256)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. '##cancel_fraction_rank', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. '##save_fraction_tag', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							settings.player_info.fraction_tag = u8:decode(ffi.string(MODULE.Main.input))
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
				imgui.EndChild()
				end
				if imgui.BeginChild('##3', imgui.ImVec2(589 * settings.general.custom_dpi, 28 * settings.general.custom_dpi), true) then
					imgui.Columns(2)
					imgui.Text(fa.HAND_HOLDING_DOLLAR .. u8"" .. fa.HAND_HOLDING_DOLLAR)
					imgui.SetColumnWidth(-1, 480 * settings.general.custom_dpi)
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(u8'') then
						imgui.OpenPopup(fa.SACK_DOLLAR .. u8'' .. fa.SACK_DOLLAR)
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.SACK_DOLLAR .. u8'' .. fa.SACK_DOLLAR, _, imgui.WindowFlags.NoCollapse  + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'')
						if imgui.Button(u8(''), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							openLink('')
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(u8(''), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							openLink('')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
					imgui.Columns(1)
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.RECTANGLE_LIST..u8' Êîìàíäû è RP îòûãðîâêè') then 
				if imgui.BeginTabBar('Ñïèñîê âñåõ êîìàíä') then
					if imgui.BeginTabItem(fa.BARS..u8' Ñòàíäàðòíûå êîìàíäû') then 
						if imgui.BeginChild('##99', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
							imgui.Columns(2)
							imgui.CenterColumnText(u8"Êîìàíäà")
							imgui.SetColumnWidth(-1, 220 * settings.general.custom_dpi)
							imgui.NextColumn()
							imgui.CenterColumnText(u8"Îïèñàíèå")
							imgui.SetColumnWidth(-1, 400 * settings.general.custom_dpi)
							imgui.Columns(1)
							imgui.Separator()
							if settings.general.rp_guns then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/rpguns")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Íàñòðîéêà RP îòûãðîâîê îðóæèÿ")
								imgui.Columns(1)
								imgui.Separator()
								end
							if not isMode('none') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/mb")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Êàñòîìíûé /members")
								imgui.Columns(1)
								imgui.Separator()
							end
							if not isMode('none') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/cafk")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Êîíòðîëåð ÀÔÊ")
								imgui.Columns(1)
								imgui.Separator()
							end							
							if not (isMode('ghetto') or isMode('mafia')) then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/dep")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Ðàöèÿ äåïàðòàìåíòà")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/sob")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Ïðîâåäåíèÿ ñîáåñåäîâàíèÿ")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/post")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Ìåíþ ñèñòåìû ïîñòîâ")
								imgui.Columns(1)
								imgui.Separator()
							end
							if isMode('prison') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/pum")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Ìåíþ óìíîãî ïîâûøåíèÿ ñðîêà")
								imgui.Columns(1)
								imgui.Separator()
							elseif isMode('police') or isMode('fcb') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/wanteds")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Ìåíþ îáùåãî ñïèñêà /wanted")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/patrool")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Ìåíþ ïàòðóëèðîâàíèÿ")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/sum")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Ìåíþ óìíîé âûäà÷è ðîçûñêà")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/tsm")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Ìåíþ óìíîé âûäà÷è øòðàôîâ")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/afind")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Ôëóäåð /find äëÿ ïîèñêà èãðîêà ïî ID")
								imgui.Columns(1)
								imgui.Separator()
							end
							imgui.EndChild()
						end
						imgui.EndTabItem()
					end
					function render_cmds(isManage)
						local cmd_array = (isManage and modules.commands.data.commands_manage.my or modules.commands.data.commands.my)
						if imgui.BeginChild('##' .. (isManage and 1 or 2), imgui.ImVec2(589 * settings.general.custom_dpi, 308 * settings.general.custom_dpi), true) then
							imgui.Columns(3)
							imgui.CenterColumnText(u8"Êîìàíäà")
							imgui.SetColumnWidth(-1, 170 * settings.general.custom_dpi)
							imgui.NextColumn()
							imgui.CenterColumnText(u8"Îïèñàíèå")
							imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
							imgui.NextColumn()
							imgui.CenterColumnText(u8"Äåéñòâèå")
							imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
							imgui.Columns(1)
							imgui.Separator()
							if isManage then
								imgui.Columns(3)
								imgui.CenterColumnText(u8"/spcar")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Çàñïàâíèòü òðàíñïîðò îðãàíèçàöèè")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Íåäîñòóïíî")
								imgui.Columns(1)
								imgui.Separator()	
							else
								imgui.Columns(3)
								imgui.CenterColumnText(u8"/stop")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Îñòàíîâèòü îòûãðîâêó ëþáîé RP êîìàíäû")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"Íåäîñòóïíî")
								imgui.Columns(1)
								imgui.Separator()
							end
							for index, command in ipairs(cmd_array) do
								imgui.Columns(3)
								if command.enable then imgui.CenterColumnText('/' .. u8(command.cmd)) else imgui.CenterColumnTextDisabled('/' .. u8(command.cmd)) end
								imgui.NextColumn()
								if command.enable then imgui.CenterColumnText(u8(command.description)) else imgui.CenterColumnTextDisabled(u8(command.description)) end
								imgui.NextColumn()
								imgui.Text('  ')
								imgui.SameLine()
								if imgui.SmallButton((command.enable and fa.TOGGLE_ON or fa.TOGGLE_OFF) .. '##' .. command.cmd) then
									command.enable = not command.enable
									save_module('commands')
									if command.enable then
										register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
									else
										sampUnregisterChatCommand(command.cmd)
									end
								end
								if imgui.IsItemHovered() then
									local tooltip = command.enable and "Îòêëþ÷åíèå êîìàíäû /" or "Âêëþ÷åíèå êîìàíäû /"
									imgui.SetTooltip(u8(tooltip .. command.cmd))
								end
								imgui.SameLine()
								if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##'..command.cmd) then
									if command.arg == '' then
										MODULE.Binder.ComboTags[0] = 0
									elseif command.arg == '{arg}' then	
										MODULE.Binder.ComboTags[0] = 1
									elseif command.arg == '{arg_id}' then
										MODULE.Binder.ComboTags[0] = 2
									elseif command.arg == '{arg_id} {arg2}' then
										MODULE.Binder.ComboTags[0] = 3
									elseif command.arg == '{arg_id} {arg2} {arg3}' then
										MODULE.Binder.ComboTags[0] = 4
									elseif command.arg == '{arg_id} {arg2} {arg3} {arg4}' then
										MODULE.Binder.ComboTags[0] = 5
									end
									MODULE.Binder.data = {
										change_waiting = command.waiting,
										change_cmd = command.cmd,
										change_text = command.text:gsub('&', '\n'),
										change_arg = command.arg,
										change_bind = command.bind,
										change_in_fastmenu = command.in_fastmenu,
										create_command_9_10 = isManage
									}
									MODULE.Binder.input_description = imgui.new.char[256](u8(command.description))
									MODULE.Binder.input_cmd = imgui.new.char[256](u8(command.cmd))
									MODULE.Binder.input_text = imgui.new.char[8192](u8(MODULE.Binder.data.change_text))
									MODULE.Binder.waiting_slider = imgui.new.float(tonumber(command.waiting))	
									MODULE.Binder.Window[0] = true
								end
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8"Èçìåíåíèå êîìàíäû /"..command.cmd)
								end
								imgui.SameLine()
								if imgui.SmallButton(fa.TRASH_CAN .. '##'..command.cmd) then
									imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION ..  '##' .. command.cmd)
								end
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8"Óäàëåíèå êîìàíäû /"..command.cmd)
								end
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION ..  '##' .. command.cmd, _, imgui.WindowFlags.NoResize ) then
									change_dpi()
									imgui.CenterText(u8'Âû äåéñòâèòåëüíî õîòèòå óäàëèòü êîìàíäó /' .. u8(command.cmd) .. '?')
									imgui.Separator()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' Íåò, îòìåíèòü ' .. fa.CIRCLE_XMARK .. '##delete_cmd' .. index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.TRASH_CAN .. u8' Äà, óäàëèòü ' .. fa.TRASH_CAN .. '##delete_cmd' .. index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										sampUnregisterChatCommand(command.cmd)
										table.remove(cmd_array, index)
										save_module('commands')
										imgui.CloseCurrentPopup()
									end
									imgui.End()
								end
								imgui.Columns(1)
								imgui.Separator()
							end
							imgui.EndChild()
						end
						if imgui.Button(fa.CIRCLE_PLUS .. u8' Ñîçäàòü íîâóþ êîìàíäó ' .. fa.CIRCLE_PLUS .. '##new_cmd' .. (isManage and 1 or 2), imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
							local my_cmds = isManage and #modules.commands.data.commands_manage.my or #modules.commands.data.commands.my
							local max_cmds = #get_fraction_cmds(settings.general.fraction_mode, isManage) + 10
							if my_cmds > max_cmds then
								return
							end
							local new_cmd = {cmd = '', description = '', text = '', arg = '', enable = true, waiting = '1.5', bind = "{}" }
							table.insert(cmd_array, new_cmd)
							MODULE.Binder.data = {
								change_waiting = new_cmd.waiting,
								change_cmd = new_cmd.cmd,
								change_text = new_cmd.text,
								change_arg = new_cmd.arg,
								change_bind = new_cmd.bind,
								change_in_fastmenu = false,
								create_command_9_10 = isManage
							}
							MODULE.Binder.ComboTags[0] = 0
							MODULE.Binder.input_description = imgui.new.char[256]("")
							MODULE.Binder.input_cmd = imgui.new.char[256]("")
							MODULE.Binder.input_text = imgui.new.char[8192]("")
							MODULE.Binder.waiting_slider = imgui.new.float(1.5)
							MODULE.Binder.Window[0] = true
						end
					end
					if imgui.BeginTabItem(fa.BARS..u8' RP êîìàíäû') then 
						render_cmds(false)
						imgui.EndTabItem()
					end
					if imgui.BeginTabItem(fa.BARS..u8' RP êîìàíäû (9/10)') then 
						if settings.player_info.fraction_rank_number == 9 or settings.player_info.fraction_rank_number == 10 then
							render_cmds(true)
						else
							if imgui.BeginChild('##no_rank_access', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
								imgui.CenterText(fa.TRIANGLE_EXCLAMATION .. u8" Âíèìàíèå " .. fa.TRIANGLE_EXCLAMATION)
								imgui.Separator()
								imgui.CenterText(u8"Ó âàñ íåòó äîñòóïà ê äàííûì êîìàíäàì!")
								imgui.CenterText(u8"Íåîáõîäèìî èìåòü 9 èëè 10 ðàíã, ó âàñ æå - " .. settings.player_info.fraction_rank_number .. u8" ðàíã!")
								imgui.Separator()
								imgui.EndChild()
							end
						end
						imgui.EndTabItem() 
					end
					if imgui.BeginTabItem(fa.COMPASS .. u8' Fast Menu') then 
						function render_fastmenu_item(name, use, text, text2)
							if imgui.BeginChild('##fastmenu'..name, imgui.ImVec2(194 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
								imgui.CenterText(u8(name))
								imgui.Separator()
								imgui.CenterText(u8("Èñïîëüçîâàíèå:"))
								imgui.CenterText(use)
								imgui.SetCursorPosY(110 * settings.general.custom_dpi)
								imgui.CenterText(u8("Îïèñàíèå:"))
								imgui.CenterText(u8(text))
								imgui.SetCursorPosY(200 * settings.general.custom_dpi)
								imgui.CenterText(u8("Òðåáóåòñÿ àðãóìåíò:"))
								imgui.CenterText(u8(text2))
								imgui.SetCursorPosY(290 * settings.general.custom_dpi)
								imgui.CenterText(u8("Âûáîðî÷íî âêë/âûêë êîìàíäû"))
								if imgui.Button(fa.GEAR .. u8(' Íàñòðîèòü êîìàíäû ìåíþ ') .. '##' .. name) then
									imgui.OpenPopup(fa.COMPASS .. u8' Íàñòðîéêà êîìàíä â ' .. u8(name) .. ' ' .. fa.COMPASS .. "##" .. name)
								end
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.COMPASS .. u8' Íàñòðîéêà êîìàíä â ' .. u8(name) .. ' ' .. fa.COMPASS .. "##" .. name, _, imgui.WindowFlags.NoResize ) then
									change_dpi()
									if imgui.BeginChild('##fastmenu_configurige'..name, imgui.ImVec2(589 * settings.general.custom_dpi, 366 * settings.general.custom_dpi), true) then
										local arr = {}
										if name == 'FastMenu' then
											arr = modules.commands.data.commands.my
										elseif name == 'Leader FastMenu' then
											arr = modules.commands.data.commands_manage.my
										elseif name == 'PieMenu' then
											
										end
										if name:find('Fast') then
											imgui.Columns(3)
											imgui.CenterColumnText(u8"Íàõîæäåíèå â ìåíþ")
											imgui.SetColumnWidth(-1, 160 * settings.general.custom_dpi)
											imgui.NextColumn()
											imgui.CenterColumnText(u8"Êîìàíäà")
											imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
											imgui.NextColumn()
											imgui.CenterColumnText(u8"Îïèñàíèå")
											imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
											imgui.Columns(1)
											for index, value in ipairs(arr) do
												if (value.arg == "{arg_id}") then
													imgui.Separator()
													imgui.Columns(3)
													local btn = (value.in_fastmenu) and (fa.SQUARE_CHECK .. u8'  (åñòü)') or (fa.SQUARE .. u8'  (íåòó)')
													if imgui.CenterColumnSmallButton(btn .. '##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
														value.in_fastmenu = not value.in_fastmenu
														save_module('commands')
													end
													imgui.NextColumn()
													imgui.CenterColumnText('/' .. value.cmd)
													imgui.NextColumn()
													imgui.CenterColumnText(u8(value.description))
													imgui.Columns(1)
												end
											end
											imgui.Separator()
										elseif name == 'PieMenu' then
											imgui.CenterText(u8('PieMenu âðåìåííî íåäîñòóïåí äëÿ ðåäàêòèðîâàíèÿ!'))
											imgui.Separator()
											imgui.CenterText(u8('Ðàáîòîñïîñîáíîñòü PieMenu (âûçîâ íà êîë¸ñèêî): ' .. tostring(settings.general.piemenu)))
											if imgui.CenterButton(settings.general.piemenu and u8('Îòêëþ÷èòü') or u8('Âêëþ÷èòü')) then
												settings.general.piemenu = not settings.general.piemenu
												MODULE.FastPieMenu.Window[0] = settings.general.piemenu
												save_settings()
											end
										end
										imgui.EndChild()
									end
									if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü ' .. fa.CIRCLE_XMARK .. '##close_fast', imgui.ImVec2(591 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.End()
								end
								imgui.EndChild()
							end
						end
						render_fastmenu_item(
							'FastMenu',
							u8'/hm ID èëè ' .. fa.KEYBOARD .. (isMonetLoader() and u8' Êíîïî÷êè' or u8' Hotkeys'),
							'Áûñòðûå RP êîìàíäû',
							'{arg_id}'
						)
						imgui.SameLine()
						render_fastmenu_item(
							'Leader FastMenu',
							u8'/lm ID èëè ' .. fa.KEYBOARD .. (isMonetLoader() and u8' Êíîïî÷êè' or u8' Hotkeys'),
							'Áûñòðûå RP êîìàíäû 9-10',
							'{arg_id}'
						)
						imgui.SameLine()
						render_fastmenu_item(
							'PieMenu',
							(isMonetLoader() and (fa.KEYBOARD .. u8' Êíîïî÷êè') or (fa.COMPUTER_MOUSE .. u8' ÑÊÌ (êîë¸ñèêî)')),
							'Áûñòðûé âûçîâ êîìàíä',
							'Áåç àðãóìåíòà'
						)
						imgui.EndTabItem() 
					end
					if imgui.BeginTabItem(fa.KEYBOARD .. (isMonetLoader() and u8' Êíîïî÷êè' or u8' Hotkeys')) then 
						if imgui.BeginChild('##999', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
							if isMonetLoader() then
								imgui.CenterText(u8('Íàýêðàííûå êíîïî÷êè äëÿ ðàáîòû ôóíêöèé õåëïåðà'))
								imgui.Separator()
								if imgui.Checkbox(u8(' Îòîáðàæåíèå êíîïêè "Âçàèìîäåéñòâèå" (àíàëîã /hm ID)'), MODULE.Main.checkbox.mobile_fastmenu_button) then
									settings.general.mobile_fastmenu_button = MODULE.Main.checkbox.mobile_fastmenu_button[0]
									MODULE.FastMenuButton.Window[0] = MODULE.Main.checkbox.mobile_fastmenu_button[0]
									save_settings()
								end
								if imgui.Checkbox(u8(' Îòîáðàæåíèå êíîïêè "Îñòàíîâèòü" (àíàëîã /stop)'), MODULE.Main.checkbox.mobile_stop_button) then
									settings.general.mobile_stop_button = MODULE.Main.checkbox.mobile_stop_button[0]
									save_settings()
								end
								if isMode('police') or isMode('fcb') then
									if imgui.Checkbox(u8(' Îòîáðàæåíèå êíîïêè "10-55 10-66"'), MODULE.Main.checkbox.mobile_meg_button) then
										settings.general.mobile_meg_button = MODULE.Main.checkbox.mobile_meg_button[0]
										MODULE.Megafon.Window[0] = settings.general.mobile_meg_button
										save_settings()
									end
								end
								if isMode('police') or isMode('fcb') or isMode('prison') then
									if imgui.Checkbox(u8(' Îòîáðàæåíèå êíîïêè "Taser" (àíàëîã /taser)'), MODULE.Main.checkbox.mobile_taser_button) then
										settings.mj.mobile_taser_button = MODULE.Main.checkbox.mobile_taser_button[0]
										MODULE.Taser.Window[0] = settings.mj.mobile_taser_button
										save_settings()
									end
								end
								imgui.Separator()
								if imgui.CenterButton(u8('[DEBUG] Äîáàâèòü ñâîþ êàñòîìíóþ êíîïî÷êó')) then
									sampAddChatMessage('[DEBUG] ÂÐÅÌÅÍÍÎ ÍÅÄÎÑÒÓÏÍÎ, ÁÓÄÅÒ ÊÎÃÄÀ-ÒÎ ÏÎÇÆÅ', -1)
								end
							else
								imgui.CenterText(fa.KEYBOARD .. u8' Ãëàâíûå áèíäû äëÿ ðàáîòû õåëïåðà (áèíäû äëÿ RP êîìàíä â ðåäàêòîðå êîìàíä) ' .. fa.KEYBOARD)
								--imgui.CenterText(u8'Áèíäû RP êîìàíä ïî êëàâèøå íóæíî äåëàòü â ðàçäåëå ðåäàêòèðîâàíèÿ RP êîìàíäû')	
								if hotkey_no_errors then
									imgui.Separator()
									imgui.CenterText(u8'Îòêðûòèå ãëàâíîãî ìåíþ õåëïåðà (àíàëîã /helper):')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_mainmenu))
									imgui.SetCursorPosX( width / 2 - calc.x / 2 )
									if MainMenuHotKey:ShowHotKey() then
										settings.general.bind_mainmenu = encodeJson(MainMenuHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'Îòêðûòèå áûñòðîãî ìåíþ âçàèìîäåéñòâèÿ ñ èãðîêîì (àíàëîã /hm):')
									imgui.CenterText(u8'Íàâåñòèñü íà èãðîêà ÷åðåç ÏÊÌ è íàæàòü')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_fastmenu))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if FastMenuHotKey:ShowHotKey() then
										settings.general.bind_fastmenu = encodeJson(FastMenuHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'Îòêðûòèå áûñòðîãî ìåíþ óïðàâëåíèÿ èãðîêîì (àíàëîã /lm äëÿ 9/10):')
									imgui.CenterText(u8'Íàâåñòèñü íà èãðîêà ÷åðåç ÏÊÌ è íàæàòü')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_leader_fastmenu))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if LeaderFastMenuHotKey:ShowHotKey() then
										settings.general.bind_leader_fastmenu = encodeJson(LeaderFastMenuHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'Âûïîëíèòü äåéñòâèå (íàïðèìåð ôóíêöèè "Õèë èç ÷àòà" / "Ðîçûñê ïî çàïðîñó" è ò.ä.):')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_action))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if ActionHotKey:ShowHotKey() then
										settings.general.bind_action = encodeJson(ActionHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'Ïðèîñòàíîâèòü îòûãðîâêó êîìàíäû (àíàëîã /stop):')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_command_stop))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if CommandStopHotKey:ShowHotKey() then
										settings.general.bind_command_stop = encodeJson(CommandStopHotKey:GetHotKey())
										save_settings()
									end
									imgui.Separator()
								else
									imgui.Separator()
									imgui.CenterText(fa.TRIANGLE_EXCLAMATION .. u8' Îøèáêà: ó âàñ îòñóñòâóåò áèáëèîòåêà mimgui_hotkeys.lua ' .. fa.TRIANGLE_EXCLAMATION)
								end
							end
							imgui.EndChild()
						end
						imgui.EndTabItem() 
					end
					imgui.EndTabBar() 
				end
				imgui.EndTabItem()
			end
			render_fractions_functions()
			if imgui.BeginTabItem(fa.FILE_PEN..u8' Çàìåòêè') then 
			 	imgui.BeginChild('##notes1', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true)
				imgui.Columns(2)
				imgui.CenterColumnText(u8"Ñïèñîê âñåõ âàøèõ çàìåòîê/øïàðãàëîê:")
				imgui.SetColumnWidth(-1, 495 * settings.general.custom_dpi)
				imgui.NextColumn()
				imgui.CenterColumnText(u8"Äåéñòâèå")
				imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
				imgui.Columns(1)
				imgui.Separator()
				for i, note in ipairs(modules.notes.data) do
					imgui.Columns(2)
					imgui.CenterColumnText(u8(note.note_name))
					imgui.NextColumn()
					if imgui.SmallButton(fa.UP_RIGHT_FROM_SQUARE .. '##' .. i) then
						MODULE.Note.show_note_name = u8(note.note_name)
						MODULE.Note.show_note_text = u8(note.note_text)
						MODULE.Note.Window[0] = true
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'Îòêðûòü çàìåòêó "' .. u8(note.note_name) .. '"')
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##' .. i) then
						local note_text = note.note_text:gsub('&','\n')
						MODULE.Note.input_text = imgui.new.char[1048576](u8(note_text))
						MODULE.Note.input_name = imgui.new.char[256](u8(note.note_name))
						imgui.OpenPopup(fa.PEN_TO_SQUARE .. u8' Ðåäàêòèðîâàíèå çàìåòêè ' .. fa.PEN_TO_SQUARE .. '##' .. i)	
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'Ðåäàêòèðîâàíèå çàìåòêè "' .. u8(note.note_name) .. '"')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.PEN_TO_SQUARE .. u8' Ðåäàêòèðîâàíèå çàìåòêè ' .. fa.PEN_TO_SQUARE .. '##' .. i, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
						change_dpi()
						if imgui.BeginChild('##node_edit_window', imgui.ImVec2(589 * settings.general.custom_dpi, 369 * settings.general.custom_dpi), true) then	
							imgui.PushItemWidth(578 * settings.general.custom_dpi)
							imgui.InputText(u8'##note_name', MODULE.Note.input_name, 6256)
							imgui.InputTextMultiline("##note_text", MODULE.Note.input_text, 1048576, imgui.ImVec2(578 * settings.general.custom_dpi, 329 * settings.general.custom_dpi))
							imgui.EndChild()
						end	
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü çàìåòêó ' .. fa.FLOPPY_DISK, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
							note.note_name = u8:decode(ffi.string(MODULE.Note.input_name))
							local temp = u8:decode(ffi.string(MODULE.Note.input_text))
							note.note_text = temp:gsub('\n', '&')
							save_module('notes')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.TRASH_CAN .. '##' .. i) then
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. i .. note.note_name)
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'Óäàëåíèå çàìåòêè "' .. u8(note.note_name) .. '"')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. i .. note.note_name, _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'Âû äåéñòâèòåëüíî õîòèòå óäàëèòü çàìåòêó "' .. u8(note.note_name) .. '" ?')
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Íåò, îòìåíèòü ' .. fa.CIRCLE_XMARK .. "##delete_note", imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.TRASH_CAN .. u8' Äà, óäàëèòü ' ..  fa.TRASH_CAN.. "##delete_note", imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							table.remove(modules.notes.data, i)
							save_module('notes')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Separator()
				end
				imgui.EndChild()
				if imgui.Button(fa.CIRCLE_PLUS .. u8' Ñîçäàòü íîâóþ çàìåòêó ' .. fa.CIRCLE_PLUS, imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
					if #modules.notes.data > 7 then
						return
					end
					table.insert(modules.notes.data, {note_name = "Íîâàÿ çàìåòêà " .. #modules.notes.data + 1, note_text = "Òåêñò âàøåé íîâîé çàìåòêè"})
					save_module('notes')
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.GEAR..u8' Íàñòðîéêè') then 
				if imgui.BeginChild('##1', imgui.ImVec2(589 * settings.general.custom_dpi, 145 * settings.general.custom_dpi), true) then
					imgui.CenterText(fa.CIRCLE_INFO .. u8' Äîïîëíèòåëüíàÿ èíôîðìàöèÿ ïðî õåëïåð ' .. fa.CIRCLE_INFO)
					imgui.Separator()
					imgui.Text(fa.CIRCLE_USER..u8" Ðàçðàáîòêà áàçîâîé ÷àñòè ñêðèïòà îñóùåñòâëåíà êîìàíäîé MTG")
					imgui.Text(fa.CIRCLE_USER..u8" Ðàáîòû ïî äîðàáîòêå ñêðèïòà âûïîëíåíû Àíäðååì Ôèëëîì") 
					imgui.Text(fa.CIRCLE_USER..u8" (ñîãëàñîâàíî MTG îò 23 Äåêàáðÿ 2025).")
					imgui.Separator()
					imgui.Text(fa.CIRCLE_INFO..u8" Óñòàíîâëåííàÿ âåðñèÿ õåëïåðà: " .. u8(thisScript().version))
					-- imgui.SameLine()
					-- if imgui.SmallButton(u8'Ïðîâåðèòü íàëè÷èå îáíîâëåíèé') then
					-- 	check_update()
					-- end
					imgui.Separator()
					imgui.Text(fa.BOOK ..u8" Ãàéä ïî èñïîëüçîâàíèþ õåëïåðà:")
					imgui.SameLine()
					imgui.Separator()
					imgui.Text(fa.HEADSET..u8" Òåõ.ïîääåðæêà ïî õåëïåðó:")
					imgui.SameLine()
					if imgui.SmallButton(u8'VK') then
						openLink('https://vk.com/rodina_helperspouser?act=s&id=233184401')
					end
					imgui.SameLine()
					if imgui.SmallButton(u8'TG') then
						openLink('https://t.me/podvalfil1')
					end					
					imgui.Separator()
					imgui.SameLine()
					imgui.EndChild()
				end
				if imgui.BeginChild('##2', imgui.ImVec2(589 * settings.general.custom_dpi, 60 * settings.general.custom_dpi), true) then
					imgui.CenterText(fa.PALETTE .. u8(' Öâåòîâàÿ òåìà èíòåðôåéñà õåëïåðà ') .. fa.PALETTE)
					imgui.Separator()
					imgui.Columns(3)
					if monet_no_errors then
						imgui.SetCursorPosX(55 * settings.general.custom_dpi)
						function moon_monet_edit()
							local r,g,b = MODULE.Main.mmcolor[0] * 255, MODULE.Main.mmcolor[1] * 255, MODULE.Main.mmcolor[2] * 255
							local argb = join_argb(0, r, g, b)
							settings.general.helper_theme = 0
							settings.general.moonmonet_theme_color = argb
							settings.general.message_color = argb
							message_color = "0x" .. argbToHexWithoutAlpha(0, r, g, b)
							message_color_hex = '{' .. argbToHexWithoutAlpha(0, r, g, b) .. '}'
							MODULE.Main.msgcolor[0], MODULE.Main.msgcolor[1], MODULE.Main.msgcolor[2] = color_to_float3(settings.general.message_color)
						end
						if imgui.RadioButtonIntPtr(u8" Custom", MODULE.Main.theme, 0) then
							moon_monet_edit()
							apply_moonmonet_theme()
							save_settings()
						end
						imgui.SameLine()
						if imgui.ColorEdit3('## COLOR1', MODULE.Main.mmcolor, imgui.ColorEditFlags.NoInputs) then
							if MODULE.Main.theme[0] == 0 then
								moon_monet_edit()
								apply_moonmonet_theme()
								save_settings()
							end
						end
					else
						if imgui.CenterColumnRadioButtonIntPtr(u8" Ñustom ", MODULE.Main.theme, 0) then
							MODULE.Main.theme[0] = settings.general.helper_theme
							sampAddChatMessage('[Rodina Helper] {ffffff}Óñòàíîâèòå áèáëèîòåêó MoonMonet!', message_color)
						end
					end
					imgui.NextColumn()
					if imgui.CenterColumnRadioButtonIntPtr(" Dark Theme ", MODULE.Main.theme, 1) then	
						settings.general.helper_theme = 1
						save_settings()
						apply_dark_theme()
					end
					imgui.NextColumn()
					if imgui.CenterColumnRadioButtonIntPtr(" White Theme ", MODULE.Main.theme, 2) then	
						settings.general.helper_theme = 2
						save_settings()
						apply_white_theme()
					end
					imgui.Columns(1)
					imgui.EndChild()
				end
				if imgui.BeginChild("##2_2",imgui.ImVec2(589 * settings.general.custom_dpi, 53 * settings.general.custom_dpi),true, imgui.WindowFlags.NoScrollbar) then
					imgui.CenterText(fa.PALETTE .. u8(' Öâåò ñîîáùåíèé îò õåëïåðà â ÷àòå ') .. fa.PALETTE)
					if MODULE.Main.theme[0] == 0 then
						imgui.Separator()
						imgui.CenterText(u8('Èñïîëüçóåòñÿ òàêîé-æå öâåò êàê â MoonMonet'))
					else
						imgui.SetCursorPosX((imgui.GetWindowWidth() / 2) - (10 * settings.general.custom_dpi))
						if imgui.ColorEdit3('## COLOR2', MODULE.Main.msgcolor, imgui.ColorEditFlags.NoInputs) then
							local r,g,b = MODULE.Main.msgcolor[0] * 255, MODULE.Main.msgcolor[1] * 255, MODULE.Main.msgcolor[2] * 255
							local argb = join_argb(0, r, g, b)
							settings.general.message_color = argb
							settings.general.moonmonet_theme_color = argb
							message_color = "0x" .. argbToHexWithoutAlpha(0, r, g, b)
							message_color_hex = '{' .. argbToHexWithoutAlpha(0, r, g, b) .. '}'
							save_settings()
						end
					end
					imgui.EndChild()
				end
				if imgui.BeginChild("##3",imgui.ImVec2(589 * settings.general.custom_dpi, 55 * settings.general.custom_dpi),true) then
					imgui.CenterText(fa.MAXIMIZE .. u8' Ðàçìåð ìåíþøåê ñêðèïòà ' .. fa.MAXIMIZE)
					if settings.general.custom_dpi ~= tonumber(string.format('%.3f', MODULE.Main.slider_dpi[0])) then
						imgui.SameLine(0, 15 * settings.general.custom_dpi)
						if imgui.SmallButton(fa.CIRCLE_ARROW_RIGHT .. u8' Ïðèìåíèòü ðàçìåð ' .. fa.CIRCLE_ARROW_LEFT) then
							imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##change_size')
						end
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##change_size', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'Âû äåéñòâèòåëüíî õîòèòå èçìåíèòü ðàçìåð ìåíþøåê?')
						imgui.Separator()
						imgui.CenterText(u8('Åñëè ìåíþøêè "ïëàâàþò" ïî ýêðàíó, ïîäáèðàéòå äðóãîé ðàçìåð'))
						local text = (settings.general.custom_dpi < MODULE.Main.slider_dpi[0]) and 'áîëüøîé' or 'ìåëêèé'
						imgui.CenterText(u8('Åñëè èíòåðôåéñ áóäåò ñëèøêîì ') .. u8(text) .. u8(', òî èñïîëüçóéòå /fixsize'))
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Íåò, îòìåíèòü ' .. fa.CIRCLE_XMARK .. '##change_size', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8' Äà, èçìåíèòü ' .. fa.CIRCLE_ARROW_LEFT .. "##change_size", imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							local new_dpi = tonumber(string.format('%.3f', MODULE.Main.slider_dpi[0]))
							if isMonetLoader() and new_dpi < MONET_DPI_SCALE then
								sampAddChatMessage('[Rodina Helper] {ffffff}Äëÿ âàøåãî äèñïëåÿ íåëüçÿ ñäåëàòü ðàçìåð ìåíüøå ' .. MONET_DPI_SCALE, message_color)
								imgui.CloseCurrentPopup()
							else
								settings.general.custom_dpi = new_dpi
								save_settings()
								sampAddChatMessage('[Rodina Helper] {ffffff}Ïåðåçàãðóçêà ñêðèïòà äëÿ ïðåìåíåíèÿ ðàçìåðà îêîí...', message_color)
								reload_script = true
								thisScript():reload()
							end
						end
						imgui.End()
					end
					imgui.PushItemWidth(578 * settings.general.custom_dpi)
					imgui.SliderFloat('##slider_helper_size', MODULE.Main.slider_dpi, 0.5, 3) 
					imgui.EndChild()
				end
				if imgui.BeginChild("##4",imgui.ImVec2(589 * settings.general.custom_dpi, 35 * settings.general.custom_dpi),true) then
					if imgui.Button(fa.POWER_OFF .. u8" Âûêëþ÷åíèå õåëïåðà " .. fa.POWER_OFF, imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						reload_script = true
						sampAddChatMessage('[Rodina Helper] {ffffff}Õåëïåð ïðèîñòàíîâèë ñâîþ ðàáîòó äî ñëåäóùåãî âõîäà â èãðó!', message_color)
						if not isMonetLoader() then 
							sampAddChatMessage('[Rodina Helper] {ffffff}Ëèáî èñïîëüçóéòå ' .. message_color_hex .. 'CTRL {ffffff}+ ' .. message_color_hex .. 'R {ffffff}÷òîáû çàïóñòèòü õåëïåð.', message_color)
						end
						thisScript():unload()
					end
					imgui.SameLine()
					if imgui.Button(fa.CLOCK_ROTATE_LEFT .. u8" Ñáðîñ âñåõ íàñòðîåê " .. fa.CLOCK_ROTATE_LEFT, imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##reset')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##reset', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'Âû äåéñòâèòåëüíî õîòèòå ñáðîñèòü âñå äàííûûå õåëïåðà?')
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Íåò, îòìåíèòü ' .. fa.CIRCLE_XMARK .. "##cancel_restore", imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.CLOCK_ROTATE_LEFT .. u8' Äà, ñáðîñèòü ' .. fa.CLOCK_ROTATE_LEFT .. '##restore', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							deleteHelperData()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.Button(fa.TRASH_CAN .. u8" Óäàëåíèå õåëïåðà " .. fa.TRASH_CAN, imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##delete')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##delete', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'Âû äåéñòâèòåëüíî õîòèòå óäàëèòü Rodina Helper?')
						imgui.CenterText(u8'Òàê-æå áóäóò óäàëåíû âñå íàñòðîéêè, êîìàíäû è çàìåòêè õåëïåðà')
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Íåò, îòìåíèòü ' .. fa.CIRCLE_XMARK.. '##cancel_delete_helper', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.TRASH_CAN .. u8' Äà, óäàëèòü ' .. fa.TRASH_CAN .. '##delete_helper', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							reload_script = true
							deleteHelperData(true)
						end
						imgui.End()
					end
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
		imgui.EndTabBar() end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.Binder.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 425	* settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.PEN_TO_SQUARE .. u8' Ðåäàêòèðîâàíèå êîìàíäû /' .. MODULE.Binder.data.change_cmd, MODULE.Binder.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		change_dpi()
		if imgui.BeginChild('##binder_edit', imgui.ImVec2(589 * settings.general.custom_dpi, 361 * settings.general.custom_dpi), true) then
			imgui.CenterText(fa.FILE_LINES .. u8' Îïèñàíèå êîìàíäû:')
			imgui.PushItemWidth(579 * settings.general.custom_dpi)
			imgui.InputText("##MODULE.Binder.data.input_description", MODULE.Binder.input_description, 256)
			imgui.Separator()
			imgui.CenterText(fa.TERMINAL .. u8' Êîìàíäà äëÿ èñïîëüçîâàíèÿ â ÷àòå (áåç /):')
			imgui.PushItemWidth(579 * settings.general.custom_dpi)
			imgui.InputText("##MODULE.Binder.input_cmd", MODULE.Binder.input_cmd, 256)
			imgui.Separator()
			imgui.CenterText(fa.CODE .. u8' Àðãóìåíòû êîòîðûå ïðèíèìàåò êîìàíäà:')
	    	imgui.Combo(u8'', MODULE.Binder.ComboTags, MODULE.Binder.ImItems, #MODULE.Binder.item_list)
	 	    imgui.Separator()
	        imgui.CenterText(fa.FILE_WORD .. u8' Òåêñòîâûé áèíä êîìàíäû:')
			imgui.InputTextMultiline("##text_multiple", MODULE.Binder.input_text, 8192, imgui.ImVec2(579 * settings.general.custom_dpi, 173 * settings.general.custom_dpi))
		imgui.EndChild() end
		if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. "##binder_cancel", imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
			MODULE.Binder.Window[0] = false
		end
		imgui.SameLine()
		if imgui.Button(fa.CLOCK .. u8' Çàäåðæêà ' .. fa.CLOCK .. "##binder_wait", imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
			imgui.OpenPopup(fa.CLOCK .. u8' Çàäåðæêà (â ñåêóíäàõ) '  .. fa.CLOCK)
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.CLOCK .. u8' Çàäåðæêà (â ñåêóíäàõ) ' .. fa.CLOCK, _, imgui.WindowFlags.NoResize ) then
			imgui.PushItemWidth(250 * settings.general.custom_dpi)
			imgui.SliderFloat(u8'##waiting', MODULE.Binder.waiting_slider, 0.3, 10)
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. '##binder_wait_menu', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				MODULE.Binder.waiting_slider = imgui.new.float(tonumber(MODULE.Binder.data.change_waiting))
				imgui.CloseCurrentPopup()
			end
			imgui.SameLine()
			if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. '##binder_wait_menu', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		imgui.SameLine()
		if imgui.Button(fa.TAGS .. u8' Òåãè ' .. fa.TAGS  .. "##binder_tags", imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
			imgui.OpenPopup(fa.TAGS .. u8' Òåãè äëÿ èñïîëüçîâàíèÿ â áèíäåðå')
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.TAGS .. u8' Òåãè äëÿ èñïîëüçîâàíèÿ â áèíäåðå', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
			imgui.CenterText(u8('ÑÈÑÒÅÌÀ ÒÅÃÎÂ ÁÓÄÅÒ ÈÇÌÅÍÅÍÀ'))
			imgui.Text(u8(binder_tags_text))
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		imgui.SameLine()
		if imgui.Button(fa.KEYBOARD .. u8' Çàáèíäèòü ' .. fa.KEYBOARD  .. '##binder_bind', imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
			if MODULE.Binder.ComboTags[0] == 0 then
				if isMonetLoader() then
					sampAddChatMessage('[Rodina Helper] {ffffff}Äàííàÿ ôóíêöèÿ äîñòóïà òîëüêî íà ÏÊ!', message_color)
				else
					if hotkey_no_errors then
						imgui.OpenPopup(fa.KEYBOARD .. u8' Áèíä äëÿ êîìàíäû /' .. MODULE.Binder.data.change_cmd)
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}Äàííàÿ ôóíêöèÿ íåäîñòóïíà, îòñóñòâóþò ôàéëû áèáëèîòåêè mimgui_hotkeys!', message_color)
					end
				end
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Äàííàÿ ôóíêöèÿ äîñòóïà òîëüêî åñëè êîìàíäà "Áåç àðãóìåíòîâ"', message_color)
			end
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.KEYBOARD .. u8' Áèíä äëÿ êîìàíäû /' .. MODULE.Binder.data.change_cmd, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
			local hotkeyObject = hotkeys[MODULE.Binder.data.change_cmd .. "HotKey"]
			if hotkeyObject then
				imgui.CenterText(u8('Êëàâèøà àêòèâàöèè áèíäà:'))
				local calc
				if MODULE.Binder.data.change_bind == '{}' or MODULE.Binder.data.change_bind == '[]' then
					calc = imgui.CalcTextSize('< click and select keys >')
				elseif MODULE.Binder.data.change_bind == nil then
					MODULE.Binder.data.change_bind = {}
				else
					calc = imgui.CalcTextSize(getNameKeysFrom(MODULE.Binder.data.change_bind))
				end
				local width = imgui.GetWindowWidth()
				local temp = (calc and calc.x and calc.x / 2) or 0
				imgui.SetCursorPosX(width / 2 - temp)
				if hotkeyObject:ShowHotKey() then
					MODULE.Binder.data.change_bind = encodeJson(hotkeyObject:GetHotKey())
				end
			else
				if not MODULE.Binder.data.change_bind then
				 	MODULE.Binder.data.change_bind = {}
				end
				
				hotkeys[MODULE.Binder.data.change_cmd .. "HotKey"] = hotkey.RegisterHotKey(MODULE.Binder.data.change_cmd .. "HotKey", false, decodeJson(MODULE.Binder.data.change_bind), function()
					if (not (sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive())) then
						sampProcessChatInput('/' .. MODULE.Binder.data.change_cmd)
					end
				end)
				hotkeyObject = hotkeys[MODULE.Binder.data.change_cmd .. "HotKey"]
			end
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü ' .. fa.CIRCLE_XMARK .. "##binder_bind_close", imgui.ImVec2(300 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
				hotkeyObject:RemoveHotKey()
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		imgui.SameLine()
		if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. '##binder_save', imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then	
			if ffi.string(MODULE.Binder.input_cmd):find('%W') or ffi.string(MODULE.Binder.input_cmd) == '' or ffi.string(MODULE.Binder.input_description) == '' or ffi.string(MODULE.Binder.input_text) == '' then
				imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' Îøèáêà ñîõðàíåíèÿ êîìàíäû ' .. fa.TRIANGLE_EXCLAMATION)
			else
				local new_arg = ''
				if MODULE.Binder.ComboTags[0] == 0 then
					new_arg = ''
				elseif MODULE.Binder.ComboTags[0] == 1 then
					new_arg = '{arg}'
				elseif MODULE.Binder.ComboTags[0] == 2 then
					new_arg = '{arg_id}'
				elseif MODULE.Binder.ComboTags[0] == 3 then
					new_arg = '{arg_id} {arg2}'
                elseif MODULE.Binder.ComboTags[0] == 4 then
					new_arg = '{arg_id} {arg2} {arg3}'
				elseif MODULE.Binder.ComboTags[0] == 5 then
					new_arg = '{arg_id} {arg2} {arg3} {arg4}'
				end
				local new_command = u8:decode(ffi.string(MODULE.Binder.input_cmd))
				local temp_array = (MODULE.Binder.data.create_command_9_10) and modules.commands.data.commands_manage.my or modules.commands.data.commands.my
				for _, command in ipairs(temp_array) do
					if command.cmd == MODULE.Binder.data.change_cmd and command.arg == MODULE.Binder.data.change_arg and command.text:gsub('&', '\n') == MODULE.Binder.data.change_text then
						command.cmd = new_command
						command.arg = new_arg
						command.description = u8:decode(ffi.string(MODULE.Binder.input_description))
						command.text = u8:decode(ffi.string(MODULE.Binder.input_text)):gsub('\n', '&')
						command.bind = MODULE.Binder.data.change_bind
						command.waiting = MODULE.Binder.waiting_slider[0]
						command.in_fastmenu = MODULE.Binder.data.change_in_fastmenu
						command.enable = true
						save_module('commands')
						if command.arg == '' then
							sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà ' .. message_color_hex .. '/' .. new_command .. ' {ffffff}óñïåøíî ñîõðàíåíà!', message_color)
						elseif command.arg == '{arg}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà ' .. message_color_hex .. '/' .. new_command .. ' [àðãóìåíò] {ffffff}óñïåøíî ñîõðàíåíà!', message_color)
						elseif command.arg == '{arg_id}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà ' .. message_color_hex .. '/' .. new_command .. ' [ID èãðîêà] {ffffff}óñïåøíî ñîõðàíåíà!', message_color)
						elseif command.arg == '{arg_id} {arg2}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà ' .. message_color_hex .. '/' .. new_command .. ' [ID èãðîêà] [àðãóìåíò] {ffffff}óñïåøíî ñîõðàíåíà!', message_color)
						elseif command.arg == '{arg_id} {arg2} {arg3}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà ' .. message_color_hex .. '/' .. new_command .. ' [ID èãðîêà] [÷èñëî] [àðãóìåíò] {ffffff}óñïåøíî ñîõðàíåíà!', message_color)
						elseif command.arg == '{arg_id} {arg2} {arg3} {arg4}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà ' .. message_color_hex .. '/' .. new_command .. ' [ID èãðîêà] [÷èñëî] [àðãóìåíò] [àðãóìåíò] {ffffff}óñïåøíî ñîõðàíåíà!', message_color)
						end
						sampUnregisterChatCommand(MODULE.Binder.data.change_cmd)
						register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
						if not isMonetLoader() then createHotkeyForCommand(command) end
						break
					end
				end
				MODULE.Binder.Window[0] = false
			end
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' Îøèáêà ñîõðàíåíèÿ êîìàíäû ' .. fa.TRIANGLE_EXCLAMATION, _, imgui.WindowFlags.AlwaysAutoResize) then
			if ffi.string(MODULE.Binder.input_cmd):find('%W') then
				imgui.BulletText(u8" Â êîìàíäå ìîæíî èñïîëüçîâàòü òîëüêî àíãë.áóêâû è/èëè öèôðû!")
			elseif ffi.string(MODULE.Binder.input_cmd) == '' then
				imgui.BulletText(u8" Òåêñòîâûé áèíä êîìàíäû íå ìîæåò áûòü ïóñòîé!")
			end
			if ffi.string(MODULE.Binder.input_description) == '' then
				imgui.BulletText(u8" Îïèñàíèå êîìàíäû íå ìîæåò áûòü ïóñòîå!")
			end
			if ffi.string(MODULE.Binder.input_text) == '' then
				imgui.BulletText(u8" Áèíä êîìàíäû íå ìîæåò áûòü ïóñòîé!")
			end
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü ' .. fa.CIRCLE_XMARK .. '##binder_error_save_close', imgui.ImVec2(350 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end	
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.Note.Window[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(400 * settings.general.custom_dpi, 300 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.FILE_PEN .. ' '.. MODULE.Note.show_note_name .. ' ' .. fa.FILE_PEN, MODULE.Note.Window)
        change_dpi()
		for line in MODULE.Note.show_note_text:gsub("&", "\n"):gmatch("[^\r\n]+") do -- by Milky
			imgui.TextUnformatted(line) 
		end
        imgui.End()
    end
)
------------------------------------------ FRACTION GUI -------------------------------------------
function render_fractions_functions()
	local function render_assist_item(name, description, tbl, key, isVip, func)
		imgui.Separator()
		imgui.Columns(3)
		imgui.CenterColumnText(u8(name))
		imgui.NextColumn()
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.CIRCLE_INFO .. ' ' .. u8(name) .. ' ' .. fa.CIRCLE_INFO, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
			change_dpi()
			imgui.TextWrapped(u8(description))
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü', imgui.ImVec2(500 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				imgui.CloseCurrentPopup()
			end
			imgui.EndPopup()
		end
		if imgui.CenterColumnSmallButton(u8('Ïîñìîòðåòü##' .. name .. key)) then
			imgui.OpenPopup(fa.CIRCLE_INFO .. ' ' .. u8(name) .. ' ' .. fa.CIRCLE_INFO)
		end
		imgui.NextColumn()
		if imgui.CenterColumnSmallButton(u8((tbl and tbl[key] and 'Îòêëþ÷èòü' or 'Âêëþ÷èòü') .. '##' .. name .. key)) then
				tbl[key] = not tbl[key]
				save_settings()
			end
		if func and tbl and tbl[key] then
			imgui.SameLine()
			if imgui.SmallButton(fa.GEAR .. '##' .. key) then
				func()
			end
		end
		imgui.Columns(1)
	end
	local function firs_render_assist_gui()
		imgui.Columns(3)
		imgui.CenterColumnText(u8("Íàçâàíèå ôóíêöèè"))
		imgui.SetColumnWidth(-1, 270 * settings.general.custom_dpi)
		imgui.NextColumn()
		imgui.CenterColumnText(u8("Îïèñàíèå ôóíêöèè"))
		imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
		imgui.NextColumn()
		imgui.CenterColumnText(u8("Óïðàâëåíèå"))
		imgui.SetColumnWidth(-1, 170 * settings.general.custom_dpi)
		imgui.NextColumn()
		imgui.Columns(1)
		render_assist_item(
			"RP îáùåíèå â ÷àòàõ",
			"Âàøè ñîîáùåíèÿ â ÷àò áóäóò îòïðàâëÿòüñÿ ñ çàãëàâíîé áóêâû è òî÷êîé â êîíöå.\nÒàê-æå ðàáîòàåò è â òàêèõ ÷àòàõ êàê: /s /do /f /fb /r /rb /j /jb /fam /al",
			settings.player_info,
			"rp_chat"
		)
		render_assist_item(
			"RP îòûãðîâêà îðóæèÿ",
			"Ïðè èñïîëüçîâàíèè èëè ñêðîëëå îðóæèÿ, â ÷àòå áóäóò RP îòûãðîâêè.\nÍàñòðîèòü ìîæíî ÷åðåç êîìàíäó /rpguns èëè êíîïêîé øåñòåðåíêè ñïðàâà.",
			settings.general,
			"rp_guns",
			false,
			function()
				MODULE.RPWeapon.Window[0] = true
			end
		)
		if isMode('police') or isMode('fcb') or settings.player_info.fraction_rank_number >= 9 then 
			render_assist_item(
				"RP ïðîâåðêà äîêóìåíòîâ",
				"Àâòîìàòè÷åñêè ïðèíèìàåò äîêóìåíòû èç /offer\nÒàê-æå ÷åðåç RP îòûãðîâêó ïðîâåðÿåò èõ, çàòåì âîçâðàùàåò.",
				settings.general,
				"auto_accept_docs",
				true
			)
		end
		render_assist_item(
			"Àâòîìàòè÷åñêàÿ ìàñêà",
			"Åñëè âàøà ìàñêà ñëåòàåò, ñðàçó æå àâòîìàòè÷åñêè íàäåâàåò íîâóþ\nÂàø öâåòíîé êëèñò äàæå íå óñïååò ïîÿâèòüñÿ íà êàðòå",
			settings.general,
			"auto_mask",
			true
		)
		render_assist_item(
			"Àâòî-îáíîâëåíèå ìåíþ /mb",
			"Àâòîìàòè÷åñêè îáíîâëÿåò ñïèñîê ñîòðóäíèêîâ êàæäûå 3 ñåêóíäû.",
			settings.mj,
			"auto_update_members",
			true
		)
		render_assist_item(
			"Àâòî-äîêëàä íà ïîñòó",
			"Àâòîìàòè÷åñêè îòïðàâëÿåò äîêëàä â ðàöèþ êàæäûå 5 ìèíóò íà ïîñòó.",
			settings.general,
			"auto_doklad_post",
			true
		)
		if settings.player_info.fraction_rank_number >= 9 then
			render_assist_item(
				"Àâòîòè÷åñêèé óâàë ÏÑÆ [9/10]",
				"Àâòîìàòè÷åñêîå óâîëüíåíèå ñîòðóäíèêîâ, êîòîðûå ïðîñÿò óâàë ÏÑÆ â /r /rb /f /fb\nÏðèìåð ñèòóàöèè êàê ýòî ðàáîòàåò:\n1) Èãðîê ïèøåò â /r Óâîëüòå ìåíÿ ïî ïñæ\n2) Cêðèïò îòâå÷àåò: /rb Nick_Name, îòïðàâüòå /rb +++ ÷òîáû óâîëèòüñÿ ÏÑÆ!\n3) Èãðîê îòïðàâëÿåò /rb +++ è ñêðèïò åãî óâîëüíÿåò ïî ÏÑÆ\n\nP.S. Åñëè èãðîê ôëóäèò ïðîñüáàìè îá óâàëå, ñêðèïò ÑÀÌ åãî óâîëèò, áåç +++\nP.S.S. Äàííàÿ ôóíêöèÿ ðàáîòàåò òîëüêî åñëè âû îäåòû â ðàáî÷óþ ôîðìó.",
				settings.general,
				"ïåðåçàëèë"
			)
			-- render_assist_item(
			-- 	"Àâòîìàòè÷åñêèé èíâàéò [9/10]",
			-- 	'Àâòîìàòè÷åñêè èíâàéòèò èãðîêîâ, êîòîðûå ïðîñÿò èíâàéò â ÷àòå.\nÅñëè ó èãðîêà âàðí, èëè íåòó æèëüÿ/çàêîíêè, îòâåòèò â ÷àò.',
			-- 	settings.general,
			-- 	"auto_invite",
			-- 	true
			-- )
		end
	end
	local fraction = settings.player_info.fraction_tag:sub(1, 5)
	if isMode('smi') then fraction = 'ÃÒÐÊ' end

	if imgui.BeginTabItem(fa.GEARS .. u8' Ôóíêöèè ' .. u8(fraction)) then
		if isMode('police') or isMode('fcb') then 
			if imgui.BeginTabBar('FractinFunctions') then
				if imgui.BeginTabItem(fa.ROBOT .. u8' Ëè÷íûé ïîìî÷íèê "Àññèñòåíò"') then 
					if imgui.BeginChild('##mj_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
						firs_render_assist_gui()
						render_assist_item(
							"Àâòî-äîêëàä â ïàòðóëå",
							"Àâòîìàòè÷åñêè îòïðàâëÿåò äîêëàä â ðàöèþ êàæäûå 10 ìèíóò ïàòðóëÿ.",
							settings.mj,
							"auto_doklad_patrool",
							true
						)
						render_assist_item(
							"Ñìåíà CODE 3/4 îò ìèãàëîê",
							"Àâòîìàòè÷åñêè ìåíÿåò ñèòóàöèîííûé êîä ïðè óïðàâëåíèè ìèãàëêàìè.",
							settings.mj,
							"auto_change_code_siren"
						)
						render_assist_item(
							"Àâòî-äîêëàä CODE 0",
							"Ïðè ïîëó÷åíèè óðîíà àâòîìàòè÷åñêè îòïðàâëÿåò äîêëàä CODE 0 ñ óêàçàíèåì íèêà íàïàäàâøåãî.",
							settings.mj,
							"auto_doklad_damage"
						)
						render_assist_item(
							"Àâòî-äîêëàä ïîñëå àðåñòà",
							"Ïîñëå çàâåðøåíèÿ àðåñòà àâòîìàòè÷åñêè îòïðàâëÿåò äîêëàä â ðàöèþ ñ èìåíåì àðåñòîâàííîãî.",
							settings.mj,
							"auto_doklad_arrest",
							true
						)
						render_assist_item(
							"/time íà îáûñê/ðîçûñê/àðåñò",
							"Àâòîìàòè÷åñêè äåëàåò /time äëÿ ñêðèíøîòîâ ïðè âàæíûõ äåéñòâèÿõ.",
							settings.mj,
							"auto_time",
							true
						)
						imgui.Separator()
						imgui.EndChild()
					end
					imgui.EndTabItem()
				end
				if imgui.BeginTabItem(fa.STAR .. u8' Ñèñòåìà óìíîãî ðîçûñêà') then 
					renderSmartGUI(
						'Ñèñòåìà óìíîãî ðîçûñêà',
						fa.STAR,
						'https://komarova140784-web.github.io/Rodina-Helper-/SmartUK/' .. getServerNumber() .. '/SmartUK.json', 
						'ñèñòåìû óìíîãî ðîçûñêà', 
						modules.smart_uk.data, 
						function() save_module("smart_uk") end, 
						'Èñïîëüçîâàíèå: /sum [ID èãðîêà]', 
						modules.smart_uk.path,
						'smart_uk',
						'óìíûé ðîçûñê'
					)
					imgui.EndTabItem()
				end
				if imgui.BeginTabItem(fa.TICKET .. u8' Ñèñòåìà óìíûõ øòðàôîâ') then 
					renderSmartGUI(
						'Ñèñòåìà óìíûõ øòðàôîâ', 
						fa.TICKET, 
						'https://komarova140784-web.github.io/Rodina-Helper-/SmartPDD/' .. getServerNumber() .. '/SmartPDD.json', 
						'ñèñòåìû óìíûõ øòðàôîâ', 
						modules.smart_pdd.data, 
						function() save_module("smart_pdd") end, 
						'Èñïîëüçîâàíèå: /tsm [ID èãðîêà]', 
						modules.smart_pdd.path,
						'smart_pdd',
						'óìíûå øòðàôû'
					)
					imgui.EndTabItem()
				end
				imgui.EndTabBar() 
			end
		elseif isMode('army') then
			if imgui.BeginChild('##army_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 367 * settings.general.custom_dpi), true) then
				firs_render_assist_gui()
				imgui.Separator()
				imgui.EndChild()
			end
		elseif isMode('prison') then
			if imgui.BeginTabBar('FractinFunctions') then
				if imgui.BeginTabItem(fa.ROBOT .. u8' Ëè÷íûé ïîìî÷íèê "Àññèñòåíò"') then 
					if imgui.BeginChild('##assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
						firs_render_assist_gui()
						imgui.Separator()
						imgui.EndChild()	
					end
					imgui.EndTabItem()
				end
				if imgui.BeginTabItem(fa.STAR .. u8' Ñèñòåìà óìíîãî ïðîäëåíèÿ ñðîêà') then 
					renderSmartGUI(
						'Ñèñòåìà óìíîãî ïðîäëåíèÿ ñðîêà', 
						fa.TICKET, 
						'https://Fil.github.io/arizona-helper/SmartRPTP/' .. getServerNumber() .. '/SmartRPTP.json', 
						'ñèñòåìû óìíîãî ñðîêà', 
						modules.smart_rptp.data, 
						function() save_module("smart_rptp") end, 
						'Èñïîëüçîâàíèå: /pum [ID èãðîêà]', 
						modules.smart_rptp.path,
						'smart_rptp',
						'óìíûé ñðîê'
					)
					imgui.EndTabItem()
				end
				imgui.EndTabBar() 
			end
		elseif isMode('smi') then
			if imgui.BeginTabBar('FractinFunctions') then
				if imgui.BeginTabItem(fa.ROBOT .. u8' Ëè÷íûé ïîìî÷íèê "Àññèñòåíò"') then 
					if imgui.BeginChild('##smi_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then	
						firs_render_assist_gui()
						render_assist_item(
							"Êîïèðêà îáüÿâ êîëëåã",
							"Ñîõðàíèå â èñòîðèþ îáüÿâ, êîòîðûå îòðåäàêòèðîâàëè âàøè êîëëåãè.\nÒàêèì îáðàçîì, ó âàñ áóäåò âîçìîæíîñòü áûñòðîé îòïðàâêè òàêîãî îáüÿâëåíèÿ",
							settings.smi,
							"steal_other_ads"
						)
						render_assist_item(
							"Àâòî-ðåäàêò (èç èñòîðèè)",
							"Ñêðèïò çàïîìèíàåò îáúÿâëåíèÿ èãðîêîâ, êîòîðûå âû ðåäàêòèðóåòå.\nÝòà ôóíêöèÿ àâòîìàòè÷åñêè îòïðàâèò ñîõðàí¸ííóþ îáúÿâó îò òîãî æå èãðîêà.\n\nÂÍÈÌÀÍÈÅ!\nÔóíêöèÿ ìîæåò áûòü çàïðåùåíà íà íåêîòîðûõ ñåðâåðàõ. Óòî÷íÿéòå â /report.",
							settings.smi,
							"auto_send_old"
						)
						render_assist_item(
							"Àâòî-ëîâëÿ îáúÿâëåíèé",
							"Ïðè ïîñòóïëåíèè íîâîãî îáúÿâëåíèÿ àâòîìàòè÷åñêè ïðîïèñûâàåò /newsredak âìåñòî âàñ.\n\nÂÍÈÌÀÍÈÅ!\nÔóíêöèÿ ìîæåò áûòü çàïðåùåíà íà íåêîòîðûõ ñåðâåðàõ. Óòî÷íÿéòå â /report.",
							settings.smi,
							"auto_lovlya_ads"
						)
						imgui.Separator()
						imgui.EndChild()
					end
					imgui.EndTabItem()
				end
				if imgui.BeginTabItem(fa.CLOCK_ROTATE_LEFT .. u8' Óïðàâëåíèå èñòîðèåé îáüÿâÿâëåíèé') then
					if imgui.BeginChild('##ads_history_menu', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
						if #modules.ads_history.data == 0 then
							imgui.CenterText(u8('Èñòîðèÿ îáüÿâëåíèé ïóñòà'))
							imgui.CenterText(u8('Îòðåäàêòèðîâàííûå îáüÿâëåíèÿ áóäóò îòîáðàæàòüñÿ çäåñü'))
						else
							imgui.PushItemWidth(580 * settings.general.custom_dpi)
							imgui.InputTextWithHint(u8'##input_ads_search', u8'Ïîèñê îáüÿâëåíèé ïî íóæíîé ôðàçå, íà÷èíàéòå ââîäèòü å¸ ñþäà...', MODULE.SmiEdit.input_ads_search, 128)
							imgui.Separator()
							imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
							if imgui.BeginPopupModal(fa.CLOCK_ROTATE_LEFT .. u8' Îáüÿâëåíèå èç èñòîðèè îòðåäà÷åííûõ îáüÿâ', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
								change_dpi()
								imgui.CenterText(u8(MODULE.SmiEdit.adshistory_orig))
								imgui.PushItemWidth(500 * settings.general.custom_dpi)
								imgui.InputTextWithHint(u8'##input_ads_my_edit', u8'Ââåäèòå âàø âàðèàíò ðåäàêöèè äàííîãî îáüÿàëåíèÿ...', MODULE.SmiEdit.adshistory_input_text, 128)
								imgui.Separator()
								if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
									imgui.CloseCurrentPopup()
								end
								
								imgui.SameLine()
								if imgui.Button(fa.TRASH_CAN .. u8' Óäàëèòü', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
									for id, ad in ipairs(modules.ads_history.data) do
										if ad.text == MODULE.SmiEdit.adshistory_orig then
											table.remove(modules.ads_history.data, id)
											save_module('ads_history')
											sampAddChatMessage("[Rodina Helper] {ffffff}Îáüÿâëåíèå èç èñòîðèè óñïåøíî óäàëåíî!", message_color)
											break
										end
									end
									imgui.CloseCurrentPopup()
								end
								imgui.SameLine()
								if imgui.Button(fa.CIRCLE_XMARK .. u8' Ñîõðàíèòü', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
									for id, ad in ipairs(modules.ads_history.data) do
										if ad.text == MODULE.SmiEdit.adshistory_orig then
											ad.my_text = u8:decode(ffi.string(MODULE.SmiEdit.adshistory_input_text))
											save_module('ads_history')
											sampAddChatMessage("[Rodina Helper] {ffffff}Îáüÿâëåíèå èç èñòîðèè óñïåøíî èçìåíåíî è ñîõðàíåíî!", message_color)
											break
										end
									end
									imgui.CloseCurrentPopup()
								end
								imgui.EndPopup()
							end
							local input_ads_decoded = u8:decode(ffi.string(MODULE.SmiEdit.input_ads_search))
							for id, ad in ipairs(modules.ads_history.data) do
								if input_ads_decoded == '' or ad.my_text:rupper():find(input_ads_decoded:rupper()) then
									if imgui.Button(u8(ad.my_text .. '##' .. id), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
										MODULE.SmiEdit.adshistory_orig = ad.text
										imgui.StrCopy(MODULE.SmiEdit.adshistory_input_text, u8(ad.my_text))
										imgui.OpenPopup(fa.CLOCK_ROTATE_LEFT .. u8' Îáüÿâëåíèå èç èñòîðèè îòðåäà÷åííûõ îáüÿâ')
									end
								end
							end
						end
						imgui.EndChild()
					end
					imgui.EndTabItem()
				end
				imgui.EndTabBar() 
			end
		elseif isMode('hospital') then
			if imgui.BeginTabBar('FractinFunctions') then
				if imgui.BeginTabItem(fa.ROBOT .. u8' Ëè÷íûé ïîìî÷íèê "Àññèñòåíò"') then 
					if imgui.BeginChild('##hospital_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
						firs_render_assist_gui()

						render_assist_item(
							"Õèë èç ÷àòà",
							"Ïîçâîëÿåò áûñòðî ëå÷èòü ïàöèåíòîâ êîòîðûå ïðîñÿò õèë.\nÅñòü äâà ðåæèìà ðàáîòû õèëà èç ÷àòà:\n1) Ïî íàæàòèþ êíîïêè\n2) Àâòîìàòè÷åñêèé\nÄëÿ ñìåíû ðåæèìà èñïîëüçóéòå êíîïî÷êó øåñòåð¸íêè ñïðàâà\n\nÏî äåôîëòó ðàáîòàåò ðåæèì ïî íàæàòèþ êíîïêè.",
							settings.mh.heal_in_chat,
							"enable",
							false,
							function() send_no_vip_msg() end
						)
						imgui.Separator()
						imgui.EndChild()	
					end
					imgui.EndTabItem()
				end
				if imgui.BeginTabItem(fa.SACK_DOLLAR .. u8' Öåíîâàÿ ïîëèòèêà áîëüíèöû') then 
					if imgui.BeginChild('##hospital_price', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
						local med_price_fields = {
							{label = '  Íå ïîäêëþ÷åíî, âñå öåíû â áèíäàõ',              		      key = 'heal'},							
						}
						for i, field in ipairs(med_price_fields) do
							imgui.PushItemWidth(65 * settings.general.custom_dpi)
							local buf = MODULE.MedicalPrice[field.key]
							if imgui.InputText(u8(field.label), buf, 8) then
								local str = u8:decode(ffi.string(buf)):gsub("%D", "")
								local num = tonumber(str)
								if num then
									settings.mh.price[field.key] = num
									save_settings()
								end
							end
							if field.same_line then 
								imgui.SameLine()
								imgui.SetCursorPosX((320 * settings.general.custom_dpi))
							else 
								imgui.Separator() 
							end
						end
						imgui.EndChild()
					end
					imgui.EndTabItem()
				end
				imgui.EndTabBar() 
			end
		elseif isMode('lc') then
			if imgui.BeginTabBar('FractinFunctions') then
				if imgui.BeginTabItem(fa.ROBOT .. u8' Ëè÷íûé ïîìî÷íèê "Àññèñòåíò"') then 
					if imgui.BeginChild('##assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
						firs_render_assist_gui()
						
						render_assist_item(
							"Àâòî-âûäà÷à ëèöåíçèé",
							"Àâòîìàòå÷åñêè âûäà¸ò ëèöåíçèè èãðîêàì ïîêà âû ñòîèòå çà ñòîéêîé.\nÈãðîêè äîëæíû íàïèñàòü â ÷àò òèï ëèöåíçèè (÷àñòîèñïîëüçóåìûå ôðàçû) è ñðîê.\nÅñëè ñðîê íå íàïèñàí, íàïðèìåð ïðîñòî \"ïðàâà\", òî àâòîâûäà÷à âûäàñò íà 3 ìåñÿöà.\n\nÅñòü äâà ðåæèìà ðàáîòû àâòî-âûäà÷è ëèöåíçèé:\n1) Áåç RP îòûãðîâîê\nÈñïîëüçóÿ RP îòûãðîâêó\nÄëÿ ñìåíû ðåæèìà èñïîëüçóéòå êíîïî÷êó øåñòåð¸íêè ñïðàâà",
							settings.lc.auto_lic,
							"enable",
							true,
							function()
								settings.lc.auto_lic.use_rp = not settings.lc.auto_lic.use_rp
								save_settings()
								if settings.lc.auto_lic.use_rp then
									sampAddChatMessage('[Rodina Helper | Àññèñòåíò] {ffffff}Ðåæèì ñ RP îòûãðîâêîé. Äëÿ ñìåíû ðåæèìà íàæìèòå åù¸ ðàç!', message_color)
								else
									sampAddChatMessage('[Rodina Helper | Àññèñòåíò] {ffffff}Ðåæèì áåç RP îòûãðîâîê. Äëÿ ñìåíû ðåæèìà íàæìèòå åù¸ ðàç!', message_color)
								end
							end
						)

						imgui.Separator()
						imgui.EndChild()	
					end
					imgui.EndTabItem()
				end
				if imgui.BeginTabItem(fa.SACK_DOLLAR .. u8' Öåíîâàÿ ïîëèòèêà ëèöåíçèé') then 
					if imgui.BeginChild('##license_price', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
						local license_types = {
							{name = 'Àâòî', key = 'avto'},
							{name = 'Ìîòî', key = 'moto'},
							{name = 'Ëîäêè', key = 'swim'},
							{name = 'Ïîëåòû', key = 'fly'},
							{name = 'Îðóæèå', key = 'gun'},
							{name = 'Ðûáàëêà', key = 'fish'},
							{name = 'Îõîòà', key = 'hunt'},
							{name = 'Ðàñêîïêè', key = 'klad'},
							{name = 'Òàêñè', key = 'taxi'},
							{name = 'Ìåõàíèê', key = 'mexa'},
						}
						for i, license in ipairs(license_types) do
							for month = 1, 3 do
								local month_label = (month == 1) and " %s (ìåñÿö)" or string.format(" %%s (%d ìåñÿöà)", month)
								local label = string.format(month_label, license.name)
								local key = license.key .. month
								local buf = MODULE.LicensePrice[key]
								imgui.PushItemWidth(65 * settings.general.custom_dpi)
								if imgui.InputText(u8(label), buf, 9) then
									local str = u8:decode(ffi.string(buf))
									str = str:gsub("%D","")
									local num = tonumber(str)
									if num then
										settings.lc.price[key] = num
										save_settings()
									end
								end
								if month == 1 then
									imgui.SameLine()
									imgui.SetCursorPosX(195 * settings.general.custom_dpi)
								elseif month == 2 then
									imgui.SameLine()
									imgui.SetCursorPosX(395 * settings.general.custom_dpi)
								elseif i ~= #license_types then
									imgui.Separator()
								end
							end
						end
						imgui.EndChild()
					end
					imgui.EndTabItem()
				end
				imgui.EndTabBar() 
			end
		elseif isMode('gov') then
			if imgui.BeginChild('##gov_assist', imgui.ImVec2(589 * settings.general.custom_dpi, 367 * settings.general.custom_dpi), true) then
				firs_render_assist_gui()
				render_assist_item(
					"Àíòè Òðåâîæíàÿ Êíîïêà",
					"Óáèðàåò òðåâîæíóþ êíîïêó êîòîðàÿ íàõîäèòñÿ íà 2 ýòàæå.\nÒåì ñàìûì âû íå áóäåòå ñëó÷àéíî âûçûâàòü ÌÞ èç-çà ýòîé êíîïêè.",
					settings.gov,
					"anti_trivoga"
				)	
				imgui.Separator()
				imgui.EndChild()
			end
		else
			if imgui.BeginChild('##assist', imgui.ImVec2(589 * settings.general.custom_dpi, 367 * settings.general.custom_dpi), true) then
				firs_render_assist_gui()
				imgui.Separator()
				imgui.CenterText(u8('Âàøà ôðàêöèÿ âðåìåííî íå ïîääåðæèâàåòüñÿ!'))
				imgui.TextWrapped(u8(configDirectory .. "/Settings.json"))
				imgui.EndChild()
			end
		end
		imgui.EndTabItem()
	end
end
if (not isMode('none')) then
	imgui.OnFrame(
		function() return MODULE.Members.Window[0] end,
		function(player)
			if #MODULE.Members.all == 0 then
				sampAddChatMessage('[Rodina Helper] {ffffff}Îøèáêà, ñïèñîê ñîòðóäíèêîâ ïóñòîé!', message_color)
				MODULE.Members.Window[0] = false
			elseif #MODULE.Members.all >= 16 then 
				sizeYY = 413 + 21
			else
				sizeYY = 24.5 * (#MODULE.Members.all + 1) + 21
			end
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(730 * settings.general.custom_dpi, sizeYY * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(getHelperIcon() .. " " ..  u8(MODULE.Members.info.fraction) .. " - " .. #MODULE.Members.all .. u8' ñîòðóäíèêîâ îíëàéí ' .. getHelperIcon(), MODULE.Members.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
			change_dpi()
			imgui.Columns(4)
			imgui.CenterColumnText(getUserIcon() .. u8(" Cîòðóäíèê"))
			imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(fa.RANKING_STAR .. u8(" Äîëæíîñòü"))
			imgui.SetColumnWidth(-1, 230 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(fa.TRIANGLE_EXCLAMATION .. u8(" Âûãîâîðû"))
			imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(fa.INFO .. u8(" Èíôî"))
			imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
			imgui.Columns(1)
			for i, v in ipairs(MODULE.Members.all) do
				imgui.Separator()
				imgui.Columns(4)
				if v.working then
					imgui_RGBA = (settings.general.helper_theme ~= 2) and imgui.ImVec4(1, 1, 1, 1) or imgui.ImVec4(0, 0, 0, 1)
				else
					imgui_RGBA = imgui.ImVec4(1, 0.231, 0.231, 1)
				end
				local text = u8(v.nick) .. ' [' .. v.id .. ']'
				if tonumber(v.afk) then
					local afk = tonumber(v.afk)
					if afk > 0 then
						if afk < 60 then
							text = text .. ' [AFK ' .. afk .. 's]'
						else
							text = text .. ' [AFK ' .. math.floor(afk / 60) .. 'm]'
						end
					end
				end
				imgui.CenterColumnColorText(imgui_RGBA, text)
				if (imgui.IsItemClicked() and settings.player_info.fraction_rank_number >= 9) then 
					show_leader_fast_menu(v.id)
					MODULE.Members.Window[0] = false
				end
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.rank) .. ' (' .. u8(v.rank_number) .. ')')
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.warns .. '/3'))
				imgui.NextColumn()
				if v.info == '-' then
					imgui.CenterColumnText(u8(v.info))
				else
					imgui_RGBA = imgui.ImVec4(1, 0.231, 0.231, 1)
					imgui.CenterColumnColorText(imgui_RGBA, u8(v.info))
				end
				imgui.Columns(1)
			end
			imgui.End()
		end
	)
end				
if not (isMode('ghetto') or isMode('mafia')) then
	imgui.OnFrame(
		function() return MODULE.Sobes.Window[0] end,
		function(player)
			if player_id ~= nil and isParamSampID(player_id) then
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
				imgui.Begin(fa.PERSON_CIRCLE_CHECK..u8' Ïðîâåäåíèå ñîáåñåäîâàíèÿ èãðîêó' .. u8(sampGetPlayerNickname(player_id)) .. ' ' .. fa.PERSON_CIRCLE_CHECK, MODULE.Sobes.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize)
				change_dpi()
				if imgui.BeginChild('sobes1', imgui.ImVec2(240 * settings.general.custom_dpi, 180 * settings.general.custom_dpi), true) then
					imgui.CenterColumnText(fa.BOOKMARK .. u8" Îñíîâíîå " .. fa.BOOKMARK)
					imgui.Separator()
					if imgui.Button(fa.PLAY .. u8" Íà÷àòü ñîáåñåäîâàíèå", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						lua_thread.create(function()
							sampSendChat("Çäðàâñòâóéòå, ÿ " .. settings.player_info.name_surname .. " - " .. settings.player_info.fraction_rank .. ' ' .. settings.player_info.fraction_tag)
							wait(1500)
							sampSendChat("Âû ïðèøëè ê íàì íà ñîáåñåäîâàíèå?")
						end)
					end
					if imgui.Button(fa.PASSPORT .. u8" Ïîïðîñèòü äîêóìåíòû", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						lua_thread.create(function()
							sampSendChat("Õîðîøî, ïðåäîñòàâüòå ìíå âñå âàøè äîêóìåíòû äëÿ ïðîâåðêè.")
							wait(1500)
							sampSendChat("Ìíå íóæåí âàø Ïàñïîðò, Ìåä.êàðòà è Ëèöåíçèè.")
							wait(1500)
							sampSendChat("/n " .. sampGetPlayerNickname(player_id) .. ", èñïîëüçóéòå /showpass")
							wait(1500)
							sampSendChat("/n Îáÿçàòåëüíî ñ RP îòûãðîâêàìè!")
						end)
					end
					if imgui.Button(fa.USER .. u8" Ðàññêàæèòå î ñåáå", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("Íåìíîãî ðàññêàæèòå î ñåáå.")
					end		
					if imgui.Button(fa.CHECK .. u8" îáåñåäîâàíèå ïðîéäåíî", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("/todo Ïîçäðàâëÿþ! Âû óñïåøíî ïðîøëè ñîáåñåäîâàíèå!*óëûáàÿñü")
					end
					if imgui.Button(fa.USER_PLUS .. u8" Ïðèãëàñèòü â îðãàíèçàöèþ", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						find_and_use_command('/invite {arg_id}', player_id)
						MODULE.Sobes.Window[0] = false
					end
					imgui.EndChild()
				end
				imgui.SameLine()
				if imgui.BeginChild('sobes2', imgui.ImVec2(240 * settings.general.custom_dpi, 180 * settings.general.custom_dpi), true) then
					imgui.CenterColumnText(fa.BOOKMARK..u8" Äîïîëíèòåëüíî" .. fa.BOOKMARK)
					imgui.Separator()
					if imgui.Button(fa.GLOBE .. u8" Íàëè÷èå ñïåö.ðàöèè Discord", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("Èìååòñÿ ëè ó Âàñ ñïåö. ðàöèÿ Discord?")
					end
					if imgui.Button(fa.CIRCLE_QUESTION .. u8" Íàëè÷èå îïûòà ðàáîòû", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("Èìååòñÿ ëè ó Âàñ îïûò ðàáîòû â íàøåé ñôåðå?")
					end
					if imgui.Button(fa.CIRCLE_QUESTION .. u8" Ïî÷åìó èìåííî ìû?", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("Ñêàæèòå ïî÷åìó Âû âûáðàëè èìåííî íàñ?")
					end
					if imgui.Button(fa.CIRCLE_QUESTION .. u8" ×òî òàêîå àäåêâàòíîñòü?", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("Ñêàæèòå ÷òî ïî âàøåìó çíà÷èò \"Àäåêâàòíîñòü\"?")
					end
					if imgui.Button(fa.CIRCLE_QUESTION .. u8" ×òî òàêîå ÄÌ?", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("Ñêàæèòå êàê âû äóìàåòå, ÷òî òàêîå \"ÄÌ\"?")
					end
				imgui.EndChild()
				end			
				if imgui.BeginChild('sobes4', imgui.ImVec2(240 * settings.general.custom_dpi, 180 * settings.general.custom_dpi), true) then
					imgui.CenterColumnText(fa.BOOKMARK .. u8" Ëåêöèè " .. fa.BOOKMARK)
					imgui.Separator()
					if imgui.Button(fa.PLAY .. u8" Ïðàâèëà ïîâåäåíèÿ ïðè ×Ñ", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						lua_thread.create(function()
							sampSendChat("Çäðàâñòâóéòå Óâàæàåìûå ñîòðóäíèêè!")
							wait(2500)
							sampSendChat("Ñåãîäíÿ ó íàñ ïðîéäåò ëåêöèÿ íà òåìó Ïðàâèëà ïîâåäåíèÿ â ×ðåçâû÷àéíûõ Ñèòóàöèÿõ")
							wait(2500)
							sampSendChat("×ðåçâû÷àéíûå Ñèòóàöèè ïðîèñõîäÿò ÷àñòî, ÷àùå âñåãî îò áàíäèòîâ èëè ãðàæäàíñêèõ")
							wait(2500)
							sampSendChat("Ïåðâûì äåëîì âàì íåîáõîäèìî ïðåäóïðåäèòü â ðàöèþ âñåõ âîåííîñëóæàùèõ")
							wait(2500)
							sampSendChat("Âòîðûì äåëîì îáúÿñíèòå ãäå îíè è êóäà íàïðàâëÿþòñÿ ïðèìåðíî")
							wait(2500)
							sampSendChat("Óêàæèòå êîëè÷åñòâî íàïàäàþùèõ, òàêæå ïðèìåòû")
							wait(2500)
							sampSendChat("Íå ãîâîðèòå ëîæíóþ èíôîðìàöèþ, èáî ýòî óñóãóáèò ñèòóàöèþ.")
							wait(2500)
							sampSendChat("Åñëè êîëè÷åñòâî íàïàäàþùèõ ïðåâûøàåò áîëåå 5, òî ïîïðîñèòå Îôèöåðà âûçâàòü ïîìîùü îò Ìèí.ÌÂÄ")
							wait(2500)
							sampSendChat("Ñòàðàéòåñü äåðæàòüñÿ âìåñòå, ÷òîáû áûñòðåå óñòðàíèòü ×Ñ,")
							wait(2500)
							sampSendChat("Íå èäèòå â îäèíî÷êó íà òîëïó ëþäåé,")
							wait(2500)
							sampSendChat("Ïðè âîçìîæíîñòè ñîîáùàéòå ïåðåäâèæåíèå íàïàäàþùèõ,")
							wait(2500)
							sampSendChat("Ïîñëå îêîí÷àíèÿ ×Ñ ïðåäóïðåäèòå â ðàöèþ.")
							wait(2500)
							sampSendChat("Íà ýòîì ëåêöèÿ îêîí÷åíà.")
						end)
					end
					if imgui.Button(fa.PASSPORT .. u8" Îáùàÿ èíôîðìàöèÿ", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						lua_thread.create(function()
							sampSendChat("Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ!")
							wait(1500)
							sampSendChat("Ìíå íóæåí âàø Ïàñïîðò, Ìåä.êàðòà è Ëèöåíçèè.")
							wait(1500)
							sampSendChat("/n " .. sampGetPlayerNickname(player_id) .. ", èñïîëüçóéòå /showpass")
							wait(1500)
							sampSendChat("/n Îáÿçàòåëüíî ñ RP îòûãðîâêàìè!")
						end)
					end
					if imgui.Button(fa.USER .. u8" Ðàññêàæèòå î ñåáå", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("Íåìíîãî ðàññêàæèòå î ñåáå.")
					end		
					if imgui.Button(fa.CHECK .. u8" îáåñåäîâàíèå ïðîéäåíî", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						sampSendChat("/todo Ïîçäðàâëÿþ! Âû óñïåøíî ïðîøëè ñîáåñåäîâàíèå!*óëûáàÿñü")
					end
					if imgui.Button(fa.USER_PLUS .. u8" Ïðèãëàñèòü â îðãàíèçàöèþ", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
						find_and_use_command('/invite {arg_id}', player_id)
						MODULE.Sobes.Window[0] = false
					end
					imgui.EndChild()
				end				
				imgui.SameLine()				
				if imgui.BeginChild('sobes3', imgui.ImVec2(150 * settings.general.custom_dpi, -1), true, imgui.WindowFlags.NoScrollbar) then
					imgui.CenterColumnText(fa.CIRCLE_XMARK .. u8" Îòêàçû " .. fa.CIRCLE_XMARK)
					imgui.Separator()
					local function otkaz(reason)
						lua_thread.create(function()
							MODULE.Sobes.Window[0] = false
							sampSendChat("/todo Ê ñîæàëåíèþ, âû íàì íå ïîäõîäèòå*ñ ðàçî÷àðîâàíèåì íà ëèöå")
							wait(1500)
							sampSendChat(reason)
						end)
					end
					if imgui.Selectable(u8"Íàðêîçàâèñèìîñòü") then
						otkaz("Âàì íåîáõîäèìî âûëå÷èòüñÿ â ëþáîé áîëüíèöå, â îòäåëå íàðêîëîãèè!")
					end
					if imgui.Selectable(u8"Íåòó ìåä.êàðòû") then
						otkaz("Ó âàñ íåòó ìåä.êàðòû, ïîëó÷èòå å¸ â ëþáîé áîëüíèöå.")
					end
					if imgui.Selectable(u8"Íåòó âîåííîãî áèëåòà") then
						otkaz("Ó âàñ íåòó âîåííîãî áèëåòà!")
					end
					if imgui.Selectable(u8"Ñîñòîèò â ×Ñ") then
						otkaz("Âû ñîñòîèòå â ×¸ðíîì Ñïèñêå íàøåé îðãàíèçàöèè!")
					end
					if imgui.Selectable(u8"Ïðîô.íåïðèãîäíîñòü") then
						otkaz("Âû íå ïîäõîäèòå äëÿ íàøåé ðàáîòû ïî ïðîôåññèîíàëüíûì êà÷åñòâàì.")
					end
				end
				imgui.EndChild()			
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîçèîøëà îøèáêà, ID èãðîêà íåäåéñòâèòåëåí!', message_color)
				MODULE.Sobes.Window[0] = false
			end
		end
	)
	
	imgui.OnFrame(
		function() return MODULE.Departament.Window[0] end,
		function(player)
			local function createTagPopup(tag_type, input_var, setting_key)
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
				if imgui.BeginPopupModal(fa.TAG .. u8' Òåãè îðãàíèçàöèé##'..tag_type, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
					change_dpi()
					if imgui.BeginTabBar('TabTags') then
						local function createTagTab(title, tags)
							if imgui.BeginTabItem(fa.BARS..u8' '..title..' ') then 
								local line_started = false
								for i, tag in ipairs(tags) do
									if tag ~= 'skip' then
										if line_started then
											imgui.SameLine()
										else
											line_started = true
										end
										if imgui.Button(' ' .. u8(tag) .. ' ##' .. i) then
											imgui.StrCopy(input_var, u8(tag))
											imgui.CloseCurrentPopup()
										end
									else
										line_started = false
									end
								end
								imgui.Separator()
								if title:find(u8'êàñòîì') then
									imgui.Separator()
									if imgui.Button(fa.CIRCLE_PLUS .. u8' Äîáàâèòü òåã ' .. fa.CIRCLE_PLUS, imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
										imgui.OpenPopup(fa.TAG .. u8' Äîáàâëåíèå íîâîãî òåãà ' .. fa.TAG .. '##'..tag_type)
									end
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(fa.TAG .. u8' Äîáàâëåíèå íîâîãî òåãà ' .. fa.TAG .. '##'..tag_type, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
										imgui.CenterText(u8('Åñëè íóæåí ïåðåõîä íà ñëåäóùóþ'))
										imgui.CenterText(u8('ñòðîêó, âìåñòî òåãà óêàæèòå skip'))
										imgui.PushItemWidth(215 * settings.general.custom_dpi)
										imgui.InputText('##MODULE.Departament.new_tag', MODULE.Departament.new_tag, 256) 
										if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. '##dep_add_tag'..tag_type, 
											imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. '##dep_add_tag'..tag_type, 
											imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
											table.insert(settings.departament.dep_tags_custom, u8:decode(ffi.string(MODULE.Departament.new_tag)))
											save_settings()
											imgui.CloseCurrentPopup()
										end
										imgui.End()
									end
								end
								imgui.EndTabItem()
							end
						end
						createTagTab(u8'Ñòàíäàðòíûå òåãè (ru)', settings.departament.dep_tags)
						createTagTab(u8'Ñòàíäàðòíûå òåãè (en)', settings.departament.dep_tags_en)
						createTagTab(u8'Âàøè êàñòîìíûå òåãè', settings.departament.dep_tags_custom)
						imgui.EndTabBar()
					end
					imgui.End()
				end
			end
			local function createFrequencyPopup()
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
				if imgui.BeginPopupModal(fa.WALKIE_TALKIE .. u8' ×àñòîòà äëÿ èñïîëüçîâàíèÿ ðàöèè /d', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
					imgui.SetWindowSizeVec2(imgui.ImVec2(400 * settings.general.custom_dpi, 95 * settings.general.custom_dpi))
					change_dpi()
					for i, tag in ipairs(settings.departament.dep_fms) do
						imgui.SameLine()
						if imgui.Button(' ' .. u8(tag) .. ' ##' .. i) then
							MODULE.Departament.fm = imgui.new.char[256](u8(tag))
							settings.departament.dep_fm = u8:decode(ffi.string(MODULE.Departament.fm))
							save_settings()
							imgui.CloseCurrentPopup()
						end
					end
					imgui.Separator()
					if imgui.Button(fa.CIRCLE_PLUS .. u8' Äîáàâèòü ÷àñòîòó', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
						imgui.OpenPopup(fa.TAG .. u8' Äîáàâëåíèå íîâîé ÷àñòîòû##2')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TAG .. u8' Äîáàâëåíèå íîâîé ÷àñòîòû##2', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
						imgui.PushItemWidth(215 * settings.general.custom_dpi)
						imgui.InputText('##MODULE.Departament.new_tag', MODULE.Departament.new_tag, 256) 
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. '##dep_add_fm', 
							imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. '##dep_add_fm', 
							imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
							table.insert(settings.departament.dep_fms, u8:decode(ffi.string(MODULE.Departament.new_tag)))
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
						imgui.CloseCurrentPopup()
					end
					imgui.End()
				end
			end
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.WALKIE_TALKIE .. u8" Ðàöèÿ äåïàðòàìåíòà " .. fa.WALKIE_TALKIE, MODULE.Departament.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)
			change_dpi()
			if imgui.BeginChild('##2', imgui.ImVec2(500 * settings.general.custom_dpi, 186 * settings.general.custom_dpi), true) then
				imgui.Columns(3)
				imgui.CenterColumnText(u8('Âàø òåã:'))
				imgui.PushItemWidth(155 * settings.general.custom_dpi)
				if imgui.InputText('##MODULE.Departament.tag1', MODULE.Departament.tag1, 256) then
					settings.departament.dep_tag1 = u8:decode(ffi.string(MODULE.Departament.tag1))
					save_settings()
				end
				if imgui.CenterColumnButton(u8('Âûáðàòü òåã##1')) then
					imgui.OpenPopup(fa.TAG .. u8' Òåãè îðãàíèçàöèé##1')
				end
				createTagPopup('1', MODULE.Departament.tag1, 'dep_tag1')
				
				imgui.NextColumn()
				imgui.CenterColumnText(u8('×àñòîòà ðàöèè:'))
				imgui.PushItemWidth(155 * settings.general.custom_dpi)
				if imgui.InputText('##MODULE.Departament.fm', MODULE.Departament.fm, 256) then
					settings.departament.dep_fm = u8:decode(ffi.string(MODULE.Departament.fm))
					save_settings()
				end
				if imgui.CenterColumnButton(u8('Âûáðàòü ÷àñòîòó##1')) then
					imgui.OpenPopup(fa.WALKIE_TALKIE .. u8' ×àñòîòà äëÿ èñïîëüçîâàíèÿ ðàöèè /d')
				end
				createFrequencyPopup()
				imgui.NextColumn()
				imgui.CenterColumnText(u8('Òåã ïîëó÷àòåëÿ:'))
				imgui.PushItemWidth(155 * settings.general.custom_dpi)
				if imgui.InputText('##MODULE.Departament.tag2', MODULE.Departament.tag2, 256) then
					settings.departament.dep_tag2 = u8:decode(ffi.string(MODULE.Departament.tag2))
					save_settings()
				end
				if imgui.CenterColumnButton(u8('Âûáðàòü òåã##2')) then
					imgui.OpenPopup(fa.TAG .. u8' Òåãè îðãàíèçàöèé##2')
				end
				createTagPopup('2', MODULE.Departament.tag2, 'dep_tag2')
				imgui.Columns(1)
				imgui.Separator()
				imgui.CenterText(u8('Òåêñò:'))
				imgui.PushItemWidth(405 * settings.general.custom_dpi)
				imgui.InputText(u8'##dep_input_text', MODULE.Departament.text, 256)
				imgui.SameLine()
				if imgui.Button(u8' Îòïðàâèòü ') then
					local tag1 = settings.departament.anti_skobki and u8:decode(ffi.string(MODULE.Departament.tag1)):gsub("[%[%]]", "") or u8:decode(ffi.string(MODULE.Departament.tag1))
					local tag2 = settings.departament.anti_skobki and u8:decode(ffi.string(MODULE.Departament.tag2)):gsub("[%[%]]", "") or u8:decode(ffi.string(MODULE.Departament.tag2))
					sampSendChat('/d ' .. tag1 .. ' ' .. u8:decode(ffi.string(MODULE.Departament.fm)) .. ' ' .. tag2 .. ': ' .. u8:decode(ffi.string(MODULE.Departament.text)))
				end
				local tag1 = ffi.string(MODULE.Departament.tag1)
				local tag2 = ffi.string(MODULE.Departament.tag2)
				local fm = ffi.string(MODULE.Departament.fm)
				local text = ffi.string(MODULE.Departament.text)
				if settings.departament.anti_skobki then
					tag1 = tag1:gsub("[%[%]]", "")
					tag2 = tag2:gsub("[%[%]]", "")
				end
				local preview_text = ('/d ' .. tag1 .. ' ' .. fm .. ' ' .. tag2 .. ': ' .. text)
				imgui.CenterText(preview_text)
				imgui.Separator()
				if imgui.Checkbox(u8(' Îòêëþ÷èòü èñïîëüçîâàíèå ñèìâîëîâ [] (ñêîáîê) â òåãàõ îðãàíèçàöèé'), MODULE.Main.checkbox.dep_anti_skobki) then
					settings.departament.anti_skobki = MODULE.Main.checkbox.dep_anti_skobki[0]
					save_settings()
				end
				imgui.EndChild()
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.Post.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.patrool_menu.x, settings.windows_pos.patrool_menu.y), imgui.Cond.FirstUseEver)
			imgui.Begin(getHelperIcon() .. u8" Rodina Helper " .. getHelperIcon() .. '##post_info_menu', MODULE.Post.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
			change_dpi()
			safery_disable_cursor(player)
			if MODULE.Post.active then
				imgui.Text(fa.MAP_LOCATION_DOT .. u8(' Ïîñò: ') .. u8(MODULE.Binder.tags.get_post_name()))
				imgui.Text(fa.CLOCK .. u8(' Âðåìÿ íà ïîñòó: ') .. u8(MODULE.Binder.tags.get_post_time()))
				imgui.Text(fa.CIRCLE_INFO .. u8(' Ñîñòîÿíèå: ') .. u8(MODULE.Binder.tags.get_post_code()))
				imgui.SameLine()
				if imgui.SmallButton(fa.GEAR) then
					imgui.OpenPopup(fa.BUILDING_SHIELD .. u8(' Rodina Helper##post_select_code'))
				end
				imgui.Separator()
				if imgui.Button(fa.WALKIE_TALKIE .. u8(' Äîêëàä##post'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					if (not MODULE.Post.process_doklad) then
						MODULE.Post.process_doklad = true
						lua_thread.create(function()
							MODULE.Binder.state.isActive = true
							sampSendChat('/r Äîêëàäûâàåò ' .. MODULE.Binder.tags.my_doklad_nick() .. '. Ïîñò: ' .. MODULE.Binder.tags.get_post_name() .. ', ñîñòîÿíèå ' .. MODULE.Binder.tags.get_post_code())
							wait(1500)
							sampSendChat('/r Íàõîæóñü íà ïîñòó óæå ' .. MODULE.Binder.tags.get_post_format_time())
							MODULE.Binder.state.isActive = false
							MODULE.Post.process_doklad = false
						end)
					end
				end	
				imgui.SameLine()
				if imgui.Button(fa.CIRCLE_STOP .. u8(' Êîíåö##post'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					lua_thread.create(function()
						MODULE.Post.Window[0] = false
						MODULE.Post.active = false
						MODULE.Binder.state.isActive = true
						sampSendChat('/r ' .. MODULE.Binder.tags.my_doklad_nick() .. ' íà CONTROL. Ïîñò: ' .. MODULE.Binder.tags.get_post_name() .. ', ñîñòîÿíèå ' .. MODULE.Binder.tags.get_post_code() .. '.')
						wait(1500)
						sampSendChat('/r Îñâîáîæäàþ ïîñò! Ïðîñòîÿë' .. MODULE.Binder.tags.sex() .. ' íà ïîñòó: ' .. MODULE.Binder.tags.get_post_format_time() .. '.', -1)
						MODULE.Binder.state.isActive = false
						MODULE.Post.time = 0
						MODULE.Post.start_time = 0
						MODULE.Post.current_time = 0
						MODULE.Post.code = 'CODE4'
						MODULE.Post.ComboCode[0] = 5
					end)
				end
			else
				player.HideCursor = false
				imgui.PushItemWidth(200 * settings.general.custom_dpi)
				if imgui.InputTextWithHint(u8'##post_name', u8('Óêàæèòå íàçâàíèå âàøåãî ïîñòà'), MODULE.Post.input, 256) then
					MODULE.Post.name = u8:decode(ffi.string(MODULE.Post.input))
				end
				imgui.Separator()
				if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà##post', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
					MODULE.Post.Window[0] = false
				end
				imgui.SameLine()
				if imgui.Button(fa.WALKIE_TALKIE .. u8' Çàñòóïèòü##post', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
					MODULE.Post.time = 0
					MODULE.Post.start_time = os.time()
					MODULE.Post.active = true
					MODULE.Binder.state.isActive = true
					sampSendChat('/r Äîêëàäûâàåò ' .. MODULE.Binder.tags.my_doklad_nick() .. '. Çàñòóïàþ íà ïîñò ' .. MODULE.Binder.tags.get_post_name() .. ', ñîñòîÿíèå ' .. MODULE.Binder.tags.get_post_code() .. '.')
					MODULE.Binder.state.isActive = false
					imgui.CloseCurrentPopup()
				end
			end
			if imgui.BeginPopup(fa.BUILDING_SHIELD .. u8(' Rodina Helper##post_select_code'), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  ) then
				change_dpi()
				player.HideCursor = false 
				imgui.PushItemWidth(150 * settings.general.custom_dpi)
				if imgui.Combo('##post_code', MODULE.Post.ComboCode, MODULE.Patrool.ImItemsCode, #MODULE.Post.combo_code_list) then
					MODULE.Post.code = MODULE.Post.combo_code_list[MODULE.Post.ComboCode[0] + 1]
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
			local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
			if posX ~= settings.windows_pos.post_menu.x or posY ~= settings.windows_pos.post_menu.y then
				settings.windows_pos.post_menu = {x = posX, y = posY}
				save_settings()
			end
			imgui.End()
		end
	)

end
if isMode('police') or isMode('fcb') or isMode('prison') then
	imgui.OnFrame(
		function() return MODULE.Taser.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.taser.x, settings.windows_pos.taser.y), imgui.Cond.FirstUseEver)
			imgui.Begin(" Rodina Helper##MODULE.Taser.Window", MODULE.Taser.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoTitleBar)
			change_dpi()
			safery_disable_cursor(player)
			if imgui.Button(fa.GUN .. u8' Taser ',  imgui.ImVec2(75 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				sampSendChat('/taser')
			end
			local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
			if posX ~= settings.windows_pos.taser.x or posY ~= settings.windows_pos.taser.y then
				settings.windows_pos.taser = {x = posX, y = posY}
				save_settings()
			end
			imgui.End()
		end
	)
end
if isMode('police') or isMode('fcb') or isMode('prison') then
	function renderSmartGUI(title, icon, downloadPath, editPopupTitle, data, saveFunction, usageText, pathDisplay, download_file_name, download_item)
		if imgui.BeginChild('##smart'..title, imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
			if #data ~= 0 then
				imgui.CenterText(u8("Àêòèâíî - ") .. u8(usageText))
			else
				imgui.CenterText(u8("Íåàêòèâíî - Çàãðóçèòå ") .. u8(download_item) .. u8(" èç îáëàêà èëè çàïîëíèòå âðó÷íóþ"))
			end
			imgui.Separator()
			imgui.SetCursorPosY(90 * settings.general.custom_dpi)
			imgui.SetCursorPosX(207 * settings.general.custom_dpi)

			if imgui.Button(fa.DOWNLOAD .. (#data ~= 0 and u8' Îáíîâèòü èç îáëàêà 'or u8' Çàãðóçèòü èç îáëàêà ') .. fa.DOWNLOAD .. '##smart'..title) then
				_G['download_'..title:lower()] = true
				download_file = download_file_name
				downloadFileFromUrlToPath(downloadPath, pathDisplay)
				imgui.OpenPopup(fa.CIRCLE_INFO .. u8' Îïîâåùåíèå ' .. fa.CIRCLE_INFO .. '##downloadsmart'..title)
			end
			imgui.CenterText(u8'Äàííûå èç îáëàêà óñòàðåëè èëè íåàêòóàëüíûå?')
			imgui.CenterText(u8'Ñîîáùèòå SMART ìîäåðàì íà íàøåì Discord ñåðâåðå.')
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
			if imgui.BeginPopupModal(fa.CIRCLE_INFO .. u8' Îïîâåùåíèå ' .. fa.CIRCLE_INFO .. '##downloadsmart'..title, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
				if _G['download_'..title:lower()] then
					change_dpi()
					imgui.CenterText(u8'Èä¸ò ñêà÷èâàíèå ' .. u8(editPopupTitle) .. u8' äëÿ ñåðâåðà ' .. u8(getServerName(getServerNumber())) .. " [" .. getServerNumber() .. ']')
					imgui.CenterText(u8'Ïîñëå óñïåøíîé çàãðóçêè ìåíþøêà ïðîïàä¸ò è âû óâèäèòå ñîîáùåíèå â ÷àòå ïðî çàâåðøåíèå.')
					imgui.Separator()
					imgui.CenterText(u8'Åñëè ïðîøëî áîëüøå 10 ñåêóíä è íè÷åãî íå ïðîèñõîäèò, çíà÷èò ïðîèçîøëà îøèáêà ñêà÷èâàíèÿ!')
					imgui.CenterText(u8'Ñïîñîáû ðåøåíèÿ îøèáêè àâòîìàòè÷åñêîãî ñêà÷èâàíèÿ:')
					imgui.CenterText(u8'1) Âû ìîæåòå âðó÷íóþ çàïîëíèòü äàííûå ïî êíîïêå "Îòðåäàêòèðîâàòü"')
					imgui.CenterText(u8'2) Âû ìîæåòå ñêà÷àòü ãîòîâûé ôàéëèê èç îáëàêà (êíîïêà) è çàêèíóòü åãî ïî ïî ïóòè:')
					imgui.CenterText(u8(pathDisplay))
					imgui.Separator()
				else
					MODULE.Main.Window[0] = false
					imgui.CloseCurrentPopup()
				end
				if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü ' .. fa.CIRCLE_XMARK .. '##close_smart' .. title, imgui.ImVec2(300 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					imgui.CloseCurrentPopup()
				end
				imgui.SameLine()
				if imgui.Button(fa.CIRCLE_PLAY .. u8' Îòêðûòü îáëàêî ' .. fa.CIRCLE_PLAY .. '##open_web_smart' .. title, imgui.ImVec2(300 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					openLink(downloadPath)
					MODULE.Main.Window[0] = false
				end
				imgui.EndPopup()
			end
			imgui.SetCursorPosY(220 * settings.general.custom_dpi)
			imgui.SetCursorPosX(190 * settings.general.custom_dpi)
			if imgui.Button(fa.PEN_TO_SQUARE .. u8' Îòðåäàêòèðîâàòü âðó÷íóþ ' .. fa.PEN_TO_SQUARE .. '##smart'..title) then
				imgui.OpenPopup(icon .. ' ' .. u8(title) .. ' ' .. icon .. '##smart'..title)
			end
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
			if imgui.BeginPopupModal(icon .. ' ' .. u8(title) .. ' ' .. icon .. '##smart'..title, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
				change_dpi()
				if imgui.BeginChild('##smart'..title..'edit', imgui.ImVec2(589 * settings.general.custom_dpi, 368 * settings.general.custom_dpi), true) then
					for chapter_index, chapter in ipairs(data) do
						imgui.Columns(2)
						imgui.Text("> " .. u8(chapter.name))
						imgui.SetColumnWidth(-1, 515 * settings.general.custom_dpi)
						imgui.NextColumn()
						if imgui.Button(fa.PEN_TO_SQUARE .. '##' .. title .. chapter_index) then
							imgui.OpenPopup(u8(chapter.name).. '##' .. title .. chapter_index)
						end
						imgui.SameLine()
						if imgui.Button(fa.TRASH_CAN .. '##' .. title .. chapter_index) then
							imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index)
						end
						imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index, _, imgui.WindowFlags.NoResize) then
							change_dpi()
							imgui.CenterText(u8'Âû äåéñòâèòåëüíî õîòèòå óäàëèòü ïóíêò?')
							if imgui.Button(fa.CIRCLE_XMARK .. u8' Íåò, îòìåíèòü ' .. fa.CIRCLE_XMARK .. '##cancel_delete_item_smart' .. chapter_index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
								imgui.CloseCurrentPopup()
							end
							imgui.SameLine()
							if imgui.Button(fa.TRASH_CAN .. u8' Äà, óäàëèòü ' .. fa.TRASH_CAN .. '##delete_item_smart' .. chapter_index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
								table.remove(data, chapter_index)
								saveFunction()
								imgui.CloseCurrentPopup()
							end
							imgui.End()
						end
						imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
						imgui.Columns(1)
						imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						if imgui.BeginPopupModal(u8(chapter.name).. '##' .. title .. chapter_index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
							change_dpi()
							if imgui.BeginChild('##smart'..title..'edititem', imgui.ImVec2(589 * settings.general.custom_dpi, 368 * settings.general.custom_dpi), true) then
								if chapter.item then
									for index, item in ipairs(chapter.item) do
										imgui.Columns(2)
										imgui.Text("> " .. u8(item.text))
										imgui.SetColumnWidth(-1, 515 * settings.general.custom_dpi)
										imgui.NextColumn()
										if imgui.Button(fa.PEN_TO_SQUARE .. '##' .. chapter_index .. '##' .. title .. index) then
											_G['input_'..title:lower()..'_text'] = imgui.new.char[8192](u8(item.text))
											_G['input_'..title:lower()..'_value'] = imgui.new.char[256](u8(item[title:find('óìíîãî') and 'lvl' or 'amount']))
											_G['input_'..title:lower()..'_reason'] = imgui.new.char[1024](u8(item.reason))
											imgui.OpenPopup(fa.PEN_TO_SQUARE .. u8(" Ðåäàêòèðîâàíèå ïîäïóíêòà##") .. title .. chapter.name .. index .. chapter_index)
										end
										imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
										if imgui.BeginPopupModal(fa.PEN_TO_SQUARE .. u8(" Ðåäàêòèðîâàíèå ïîäïóíêòà##") .. title .. chapter.name .. index .. chapter_index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
											change_dpi()
											if imgui.BeginChild('##smart'..title..'edititeminput', imgui.ImVec2(489 * settings.general.custom_dpi, 155 * settings.general.custom_dpi), true) then    
												imgui.CenterText(u8'Íàçâàíèå ïîäïóíêòà:')
												imgui.PushItemWidth(478 * settings.general.custom_dpi)
												imgui.InputText(u8'##input_'..title:lower()..'_text', _G['input_'..title:lower()..'_text'], 8192)
												if title == 'Ñèñòåìà óìíîãî ðîçûñêà' then
													imgui.CenterText(u8'Óðîâåíü ðîçûñêà äëÿ âûäà÷è (îò 1 äî 6):')
												elseif title == 'Ñèñòåìà óìíûõ øòðàôîâ' then
													imgui.CenterText(u8'Ñóììà øòðàôà (öèôðû áåç êàêèõ ëèáî ñèìâîëîâ):')
												elseif title == 'Ñèñòåìà óìíîãî ïðîäëåíèÿ ñðîêà' then
													imgui.CenterText(u8'Óðîâåíü ñðîêà äëÿ âûäà÷è (îò 1 äî 10):')
												end
												imgui.PushItemWidth(478 * settings.general.custom_dpi)
												imgui.InputText(u8'##input_'..title:lower()..'_value', _G['input_'..title:lower()..'_value'], 256)
												imgui.CenterText(u8'Ïðè÷èíà:')
												imgui.PushItemWidth(478 * settings.general.custom_dpi)
												imgui.InputText(u8'##input_'..title:lower()..'_reason', _G['input_'..title:lower()..'_reason'], 1024)
												imgui.EndChild()
											end    
											
											if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
												imgui.CloseCurrentPopup()
											end
											imgui.SameLine()
											if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
												local text = u8:decode(ffi.string(_G['input_'..title:lower()..'_text']))
												local value = u8:decode(ffi.string(_G['input_'..title:lower()..'_value']))
												local reason = u8:decode(ffi.string(_G['input_'..title:lower()..'_reason']))
												local isValid = false
												if title == 'Ñèñòåìà óìíîãî ðîçûñêà' then
													isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 6 and text ~= '' and reason ~= ''
												elseif title == 'Ñèñòåìà óìíûõ øòðàôîâ' then
													isValid = value ~= '' and value:find('%d') and not value:find('%D') and text ~= '' and reason ~= ''
												elseif title == 'Ñèñòåìà óìíîãî ïðîäëåíèÿ ñðîêà' then
													isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 10 and text ~= '' and reason ~= ''
												end
												if isValid then
													item.text = text
													item[title:find('óìíîãî') and 'lvl' or 'amount'] = value
													item.reason = reason
													saveFunction()
													imgui.CloseCurrentPopup()
												else
													sampAddChatMessage('[Rodina Helper] {ffffff}Îøèáêà â óêàçàííûõ äàííûõ, èñïðàâüòå!', message_color)
												end
											end
											imgui.EndPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.TRASH_CAN .. '##' .. chapter_index .. '##' .. title .. index) then
											imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index .. '##' .. index)
										end
										imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
										if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' Ïðåäóïðåæäåíèå ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index .. '##' .. index, _, imgui.WindowFlags.NoResize) then
											change_dpi()
											imgui.CenterText(u8'Âû äåéñòâèòåëüíî õîòèòå óäàëèòü ïîäïóíêò?')
											imgui.Separator()
											if imgui.Button(fa.CIRCLE_XMARK .. u8' Íåò, îòìåíèòü ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
												imgui.CloseCurrentPopup()
											end
											imgui.SameLine()
											if imgui.Button(fa.TRASH_CAN .. u8' Äà, óäàëèòü ' .. fa.TRASH_CAN, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
												table.remove(chapter.item, index)
												saveFunction()
												imgui.CloseCurrentPopup()
											end
											imgui.End()
										end
										
										imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
										imgui.Columns(1)
										imgui.Separator()
									end
								end
								imgui.EndChild()
							end
							if imgui.Button(fa.CIRCLE_PLUS .. u8' Äîáàâèòü íîâûé ïîäïóíêò ' .. fa.CIRCLE_PLUS .. "##smart_add_subitem" .. chapter_index, imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
								_G['input_'..title:lower()..'_text'] = imgui.new.char[8192](u8(''))
								_G['input_'..title:lower()..'_value'] = imgui.new.char[256](u8(''))
								_G['input_'..title:lower()..'_reason'] = imgui.new.char[8192](u8(''))
								imgui.OpenPopup(fa.CIRCLE_PLUS .. u8(' Äîáàâëåíèå íîâîãî ïîäïóíêòà ') .. fa.CIRCLE_PLUS .. '##smart_add_subitem' .. chapter_index)
							end
							imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
							if imgui.BeginPopupModal(fa.CIRCLE_PLUS .. u8(' Äîáàâëåíèå íîâîãî ïîäïóíêòà ') .. fa.CIRCLE_PLUS .. '##smart_add_subitem' .. chapter_index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
								if imgui.BeginChild('##smart'..title..'edititeminput', imgui.ImVec2(489 * settings.general.custom_dpi, 155 * settings.general.custom_dpi), true) then   
									change_dpi() 
									imgui.CenterText(u8'Íàçâàíèå ïîäïóíêòà:')
									imgui.PushItemWidth(478 * settings.general.custom_dpi)
									imgui.InputText(u8'##input_'..title:lower()..'_text', _G['input_'..title:lower()..'_text'], 8192)
									if title == 'Ñèñòåìà óìíîãî ðîçûñêà' then
										imgui.CenterText(u8'Óðîâåíü ðîçûñêà äëÿ âûäà÷è (îò 1 äî 6):')
									elseif title == 'Ñèñòåìà óìíûõ øòðàôîâ' then
										imgui.CenterText(u8'Ñóììà øòðàôà (öèôðû áåç êàêèõ ëèáî ñèìâîëîâ):')
									elseif title == 'Ñèñòåìà óìíîãî ïðîäëåíèÿ ñðîêà' then
										imgui.CenterText(u8'Óðîâåíü ñðîêà äëÿ âûäà÷è (îò 1 äî 10):')
									end
									imgui.PushItemWidth(478 * settings.general.custom_dpi)
									imgui.InputText(u8'##input_'..title:lower()..'_value', _G['input_'..title:lower()..'_value'], 256)
									imgui.CenterText(u8'Ïðè÷èíà:')
									imgui.PushItemWidth(478 * settings.general.custom_dpi)
									imgui.InputText(u8'##input_'..title:lower()..'_reason', _G['input_'..title:lower()..'_reason'], 8192)
									imgui.EndChild()
								end    
								if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK .. "##" .. chapter_index .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
									imgui.CloseCurrentPopup()
								end
								imgui.SameLine()
								if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK .. "##" .. chapter_index .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
									local text = u8:decode(ffi.string(_G['input_'..title:lower()..'_text']))
									local value = u8:decode(ffi.string(_G['input_'..title:lower()..'_value']))
									local reason = u8:decode(ffi.string(_G['input_'..title:lower()..'_reason']))
									local isValid = false
									if title == 'Ñèñòåìà óìíîãî ðîçûñêà' then
										isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 6 and text ~= '' and reason ~= ''
									elseif title == 'Ñèñòåìà óìíûõ øòðàôîâ' then
										isValid = value ~= '' and value:find('%d') and not value:find('%D') and text ~= '' and reason ~= ''
									elseif title == 'Ñèñòåìà óìíîãî ïðîäëåíèÿ ñðîêà' then
										isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 10 and text ~= '' and reason ~= ''
									end
									if isValid then
										local temp = { 
											text = text, 
											[title:find('óìíîãî') and 'lvl' or 'amount'] = value,
											reason = reason 
										}
										table.insert(chapter.item, temp)
										saveFunction()
										imgui.CloseCurrentPopup()
									else
										sampAddChatMessage('[Rodina Helper] {ffffff}Îøèáêà â óêàçàííûõ äàííûõ, èñïðàâüòå!', message_color)
									end
								end
								imgui.EndPopup()
							end
							imgui.SameLine()
							if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü ' .. fa.CIRCLE_XMARK .. "##close" .. chapter_index .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
								imgui.CloseCurrentPopup()
							end
							imgui.EndPopup()
						end
						imgui.Separator()
					end
					imgui.EndChild()	
					if imgui.Button(fa.CIRCLE_PLUS .. u8' Äîáàâèòü ïóíêò ' .. fa.CIRCLE_PLUS .. "##smart_add" .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
						_G['input_'..title:lower()..'_name'] = imgui.new.char[512](u8(''))
						imgui.OpenPopup(fa.CIRCLE_PLUS .. u8' Äîáàâëåíèå íîâîãî ïóíêòà ' .. fa.CIRCLE_PLUS)
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.CIRCLE_PLUS .. u8' Äîáàâëåíèå íîâîãî ïóíêòà ' .. fa.CIRCLE_PLUS, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
						imgui.PushItemWidth(400 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##input_'..title:lower()..'_name', u8("Ââåäèòå âàø íîâûé ïóíêò..."), _G['input_'..title:lower()..'_name'], 512)
						--imgui.CenterText(u8'Îáðàòèòå âíèìàíèå, âû íå ñìîæåòå èçìåíèòü åãî â äàëüíåéøåì!')
						if imgui.Button(fa.CIRCLE_PLUS .. u8' Äîáàâèòü ' .. fa.CIRCLE_PLUS .. "##smart_add" .. title, imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
							local temp = u8:decode(ffi.string(_G['input_'..title:lower()..'_name']))
							table.insert(data, {name = temp, item = {}})
							saveFunction()
							imgui.CloseCurrentPopup()
						end
						imgui.EndPopup()
					end
					imgui.SameLine()
					if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü ' .. fa.CIRCLE_XMARK .. '##smart_close' .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
						imgui.CloseCurrentPopup()
					end
					imgui.EndPopup()
				end
			end
			imgui.CenterText(u8'Íà ñëó÷àé îòñóñòâèÿ äàííûõ ïîä âàø ñåðâåð')
			imgui.CenterText(u8'Äëÿ ïðîäâèíóòûõ ïîëüçîâàòåëåé')
			imgui.EndChild()
		end
	end
end
if isMode('prison') then
	imgui.OnFrame(
		function() return MODULE.PumMenu.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 413 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.STAR .. u8" Óìíàÿ âûäà÷à ïîâûøåííîãî ñðîêà " .. fa.STAR .. "##pum_menu", MODULE.PumMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
			change_dpi()
			if modules.smart_rptp.data ~= nil and isParamSampID(player_id) then
				imgui.PushItemWidth(580 * settings.general.custom_dpi)
				imgui.InputTextWithHint(u8'##input_sum', u8('Ïîèñê ñòàòåé (ïîäïóíêòîâ) â ãëàâàõ (ïóíêòàõ)'), MODULE.PumMenu.input, 128) 
				imgui.Separator()
				local input_sum_decoded = u8:decode(ffi.string(MODULE.PumMenu.input))
				for _, chapter in ipairs(modules.smart_rptp.data) do
					local chapter_has_matching_item = false
					if chapter.item then
						for _, item in ipairs(chapter.item) do
							if item.text and item.text:rupper():find(input_sum_decoded:rupper()) or input_sum_decoded == '' then
								chapter_has_matching_item = true
								break
							end
						end
					end
					if chapter_has_matching_item then
						if imgui.CollapsingHeader(u8(chapter.name)) then
							for _, item in ipairs(chapter.item) do
								if item.text and item.text:rupper():find(input_sum_decoded:rupper()) or input_sum_decoded == '' then
									local popup_id = fa.TRIANGLE_EXCLAMATION .. u8' Ïåðåïðîâåðüòå äàííûå ïåðåä ïîâûøåíèåì ñðîêà ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. item.text .. item.lvl .. item.reason
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
									imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 0.00, 0.00, 0.65))
									if imgui.Button(u8(split_text_into_lines(item.text, 85))..'##' .. item.text .. item.lvl .. item.reason, imgui.ImVec2(imgui.GetMiddleButtonX(1), (25 * count_lines_in_text(item.text, 85)) * settings.general.custom_dpi)) then
										imgui.OpenPopup(popup_id)
									end
									imgui.PopStyleColor()
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(popup_id, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
										imgui.Text(fa.USER .. u8' Èãðîê: ' .. u8(sampGetPlayerNickname(player_id)) .. '[' .. player_id .. ']')
										imgui.Text(fa.STAR .. u8' Óðîâåíü ñðîêà: ' .. item.lvl)
										imgui.Text(fa.COMMENT .. u8' Ïðè÷èíà ïîâûøåíèÿ ñðîêà: ' .. u8(item.reason))
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.STAR .. u8' Ïîâûñèòü ñðîê ' .. fa.STAR, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											MODULE.PumMenu.Window[0] = false
											find_and_use_command('/punish {arg_id} {arg2} 2 {arg3}', player_id .. ' ' .. item.lvl .. ' ' .. item.reason)
											imgui.CloseCurrentPopup()
										end
										imgui.EndPopup()
									end
								end
							end
						end
					end
				end
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîèçîøëà îøèáêà óìíîãî ñðîêà (íåòó äàííûõ ëèáî èãðîê îôíóëñÿ)!', message_color)
				MODULE.SumMenu.Window[0] = false
			end
			imgui.End()
		end
	)
end
if isMode('police') or isMode('fcb') then
	imgui.OnFrame(
		function() return MODULE.Patrool.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.patrool_menu.x, settings.windows_pos.patrool_menu.y), imgui.Cond.FirstUseEver)
			imgui.Begin(getHelperIcon() .. u8" Rodina Helper " .. getHelperIcon() .. '##patrool_info_menu', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
			change_dpi()
			safery_disable_cursor(player)
			if MODULE.Patrool.active then
				imgui.Text(fa.CLOCK .. u8(' Âðåìÿ ïàòðóëèðîâàíèÿ: ') .. u8(MODULE.Binder.tags.get_patrool_time()))
				imgui.Text(fa.CIRCLE_INFO .. u8(' Âàøà ìàðêèðîâêà: ') .. u8(MODULE.Binder.tags.get_patrool_mark()))
				imgui.Text(fa.CIRCLE_INFO .. u8(' Âàøå ñîñòîÿíèå: ') .. u8(MODULE.Binder.tags.get_patrool_code()))
				imgui.SameLine()
				if imgui.SmallButton(fa.GEAR) then
					imgui.OpenPopup(fa.BUILDING_SHIELD .. u8(' Rodina Helper##patrool_select_code'))
				end
				imgui.Separator()
				if imgui.Button(fa.WALKIE_TALKIE .. u8(' Äîêëàä'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					if (not MODULE.Patrool.process_doklad) then
						MODULE.Patrool.process_doklad = true
						lua_thread.create(function()
							MODULE.Binder.state.isActive = true
							sampSendChat('/r ' .. MODULE.Binder.tags.my_doklad_nick() .. ' íà CONTROL.')
							wait(1500)
							sampSendChat('/r Ïðîäîëæàþ ïàòðóëü, íàõîæóñü â ðàéîíå ' .. MODULE.Binder.tags.get_area() .. " (" .. MODULE.Binder.tags.get_square() .. ').')
							wait(1500)
							if MODULE.Binder.tags.get_car_units() ~= 'Íåòó' then
								sampSendChat('/r Ïàòðóëèðóþ óæå ' .. MODULE.Binder.tags.get_patrool_format_time() .. ' â ñîñòàâå þíèòà ' .. MODULE.Binder.tags.get_car_units() .. ', ñîñòîÿíèå ' .. u8(MODULE.Binder.tags.get_patrool_code()) .. '.')
							else
								sampSendChat('/r Ïàòðóëèðóþ óæå ' .. MODULE.Binder.tags.get_patrool_format_time() .. ', ñîñòîÿíèå ' .. u8(MODULE.Binder.tags.get_patrool_code()) .. '.')
							end
							MODULE.Binder.state.isActive = false
							MODULE.Patrool.process_doklad = false
						end)
					end
				end
				imgui.SameLine()
				if imgui.Button(fa.CIRCLE_STOP .. u8(' Çàâåðøèòü'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					lua_thread.create(function()
						MODULE.Patrool.Window[0] = false
						MODULE.Patrool.active = false
						MODULE.Binder.state.isActive = true
						sampSendChat('/r ' .. MODULE.Binder.tags.my_doklad_nick() .. ' íà CONTROL.')
						wait(1500)
						sampSendChat('/r Çàâåðøàþ ïàòðóëü, îñâîáîæäàþ ìàðêèðîâêó ' .. MODULE.Binder.tags.get_patrool_mark() .. ', ñîñòîÿíèå ' .. MODULE.Binder.tags.get_patrool_code())
						wait(1500)
						sampSendChat('/r Ïàòðóëèðîâàë' .. MODULE.Binder.tags.sex() .. ' ' .. MODULE.Binder.tags.get_patrool_format_time())
						MODULE.Patrool.time = 0
						MODULE.Patrool.start_time = 0
						MODULE.Patrool.current_time = 0
						MODULE.Patrool.code = 'CODE4'
						MODULE.Patrool.ComboCode[0] = 5
						wait(1500)
						sampSendChat('/delvdesc')
						MODULE.Binder.state.isActive = false
					end)
				end
			else
				player.HideCursor = false	
				imgui.CenterText(u8('Íàñòðîéêà äàííûõ ïåðåä íà÷àëîì ïàòðóëÿ:'))
				imgui.Separator()
				imgui.Text(fa.CIRCLE_INFO .. u8(' Âàøà ìàðêèðîâêà: '))
				imgui.SameLine()
				imgui.PushItemWidth(150 * settings.general.custom_dpi)
				if imgui.Combo('##patrool_mark', MODULE.Patrool.ComboMark, MODULE.Patrool.ImItemsMark, #MODULE.Patrool.combo_mark_list) then
					MODULE.Patrool.mark = MODULE.Patrool.combo_mark_list[MODULE.Patrool.ComboMark[0] + 1] 
				end
				imgui.Separator()
				imgui.Text(fa.CIRCLE_INFO .. u8(' Âàøå ñîñòîÿíèå: '))
				imgui.SameLine()
				imgui.PushItemWidth(150 * settings.general.custom_dpi)
				if imgui.Combo('##patrool_code', MODULE.Patrool.ComboCode, MODULE.Patrool.ImItemsCode, #MODULE.Patrool.combo_code_list) then
					MODULE.Patrool.code = MODULE.Patrool.combo_code_list[MODULE.Patrool.ComboCode[0] + 1]
				end
				imgui.Separator()
				imgui.Text(fa.CIRCLE_INFO .. u8(' Íàïàðíèêè: ') .. u8(MODULE.Binder.tags.get_car_units()))
				imgui.Separator()
				if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
					MODULE.Patrool.Window[0] = false
				end
				imgui.SameLine()
				if imgui.Button(fa.WALKIE_TALKIE .. u8' Íà÷àòü ïàòðóëü', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
					MODULE.Patrool.time = 0
					MODULE.Patrool.start_time = os.time()
					MODULE.Patrool.active = true
					lua_thread.create(function()
						MODULE.Binder.state.isActive = true
						sampSendChat('/r ' .. MODULE.Binder.tags.my_doklad_nick() .. ' íà CONTROL.')
						wait(1500)
						sampSendChat('/r Íà÷èíàþ ïàòðóëü, íàõîæóñü â ðàéîíå ' .. MODULE.Binder.tags.get_area() .. " (" .. MODULE.Binder.tags.get_square() .. ').')
						wait(1500)
						if MODULE.Binder.tags.get_car_units() ~= 'Íåòó' then
							sampSendChat('/r Çàíèìàþ ìàðêèðîâêó ' .. MODULE.Binder.tags.get_patrool_mark() .. ', íàõîæóñü â ñîñòàâå þíèòà ' .. MODULE.Binder.tags.get_car_units() .. ', ñîñòîÿíèå ' .. MODULE.Binder.tags.get_patrool_code() .. '.')
						else
							sampSendChat('/r Çàíèìàþ ìàðêèðîâêó ' .. MODULE.Binder.tags.get_patrool_mark() .. ', ñîñòîÿíèå ' .. MODULE.Binder.tags.get_patrool_code() .. '.')
						end
						wait(1500)
						sampSendChat('/vdesc ' .. MODULE.Binder.tags.get_patrool_mark())
						MODULE.Binder.state.isActive = false
					end)
					imgui.CloseCurrentPopup()
				end
			end
			if imgui.BeginPopup(fa.BUILDING_SHIELD .. u8(' Rodina Helper##patrool_select_code'), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  ) then
				change_dpi()
				player.HideCursor = false 
				imgui.PushItemWidth(150 * settings.general.custom_dpi)
				if imgui.Combo('##patrool_code', MODULE.Patrool.ComboCode, MODULE.Patrool.ImItemsCode, #MODULE.Patrool.combo_code_list) then
					MODULE.Patrool.code = MODULE.Patrool.combo_code_list[MODULE.Patrool.ComboCode[0] + 1]
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
			local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
			if posX ~= settings.windows_pos.patrool_menu.x or posY ~= settings.windows_pos.patrool_menu.y then
				settings.windows_pos.patrool_menu = {x = posX, y = posY}
				save_settings()
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.Wanted.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.wanteds_menu.x, settings.windows_pos.wanteds_menu.y), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.STAR .. u8" Ñïèñîê ïðåñòóïíèêîâ (âñåãî " .. #MODULE.Wanted.wanted .. u8') ' .. fa.STAR, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoScrollbar)
			change_dpi()
			
			if tonumber(#MODULE.Wanted.wanted) == 0 then 
				sampAddChatMessage('[Rodina Helper] {ffffff}Ñåé÷àñ íà ñåðâåðå íåòó èãðîêîâ ñ ðîçûñêîì!', message_color)
				MODULE.Wanted.Window[0] = false
			end

			safery_disable_cursor(player)
			if settings.mj.auto_update_wanteds then
				local text_time_wait = tostring(15 - tonumber(MODULE.Wanted.updwanteds.time))
				if tonumber(text_time_wait) < 10 then
					text_time_wait = '0' .. text_time_wait
				end
				imgui.Text(u8('Îáíîâëåíèå ñïèñêà ïðåñòóïíèêîâ áóäåò ÷åðåç ') .. tostring(text_time_wait) .. u8(' ñåêóíä'))
				imgui.Separator()
			else
				if imgui.Button(u8'Îáíîâèòü ñïèñîê ïðåñòóïíèêîâ', imgui.ImVec2(340 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					MODULE.Wanted.Window[0] = false
					sampAddChatMessage('[Rodina Helper] {ffffff}Âû ìîæåòå âêëþ÷èòü àâòî-îáíîâëåíèå /wanteds â íàñòðîéêàõ Àññèñòåíòà!', message_color)
					sampProcessChatInput('/wanteds')
				end
				imgui.Separator()
			end	
			imgui.Columns(3)
			imgui.CenterColumnText(u8("Íèêíåéì"))
			imgui.SetColumnWidth(-1, 200 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8("Ðîçûñê"))
			imgui.SetColumnWidth(-1, 65 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8("Ðàññòîÿíèå"))
			imgui.SetColumnWidth(-1, 80 * settings.general.custom_dpi)
			imgui.Columns(1)
			for i, v in ipairs(MODULE.Wanted.wanted) do
				imgui.Separator()
				imgui.Columns(3)
				if sampGetPlayerColor(v.id) == 368966908 then
					imgui_RGBA = (settings.general.helper_theme ~= 2) and imgui.ImVec4(1, 1, 1, 1) or imgui.ImVec4(0, 0, 0, 1)
					imgui.CenterColumnColorText(imgui_RGBA, u8(v.nick) .. ' [' .. v.id .. ']')
				else
					local rgbNormalized = argbToRgbNormalized(sampGetPlayerColor(v.id))
					local imgui_RGBA = imgui.ImVec4(rgbNormalized[1], rgbNormalized[2], rgbNormalized[3], 1)
					imgui.CenterColumnColorText(imgui_RGBA, u8(v.nick) .. ' [' .. v.id .. ']')
				end
				if imgui.IsItemClicked() and not v.dist:find('Â èíòåðüåðå') then
					sampSendChat('/pursuit ' .. v.id)
				end
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.lvl) .. ' ' .. fa.STAR)
				imgui.NextColumn()
				imgui.CenterColumnText(u8(v.dist))
				imgui.NextColumn()
				imgui.Columns(1)
			end
			local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
			if posX ~= settings.windows_pos.wanteds_menu.x or posY ~= settings.windows_pos.wanteds_menu.y then
				settings.windows_pos.wanteds_menu = {x = posX, y = posY}
				save_settings()
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.Megafon.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.megafon.x, settings.windows_pos.megafon.y), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.BUILDING_SHIELD .. " Rodina Helper##fast_meg_button", MODULE.Megafon.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoTitleBar)
			change_dpi()
			safery_disable_cursor(player)
			if imgui.Button(fa.BULLHORN .. u8' 10-55 ',  imgui.ImVec2(75 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				sampProcessChatInput('/55')
			end
			imgui.SameLine()
			if imgui.Button(fa.BULLHORN .. u8' 10-66 ',  imgui.ImVec2(75 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				sampProcessChatInput('/66')
			end
			local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
			if posX ~= settings.windows_pos.megafon.x or posY ~= settings.windows_pos.megafon.y then
				settings.windows_pos.megafon = {x = posX, y = posY}
				save_settings()
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.SumMenu.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 413 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.STAR .. u8" Óìíàÿ âûäà÷à ðîçûñêà " .. fa.STAR .. "##sum_menu", MODULE.SumMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
			change_dpi()
			if modules.smart_uk.data ~= nil and isParamSampID(player_id) then
				imgui.PushItemWidth(580 * settings.general.custom_dpi)
				imgui.InputTextWithHint(u8'##input_sum', u8('Ïîèñê ñòàòåé (ïîäïóíêòîâ) â ãëàâàõ (ïóíêòàõ)'), MODULE.SumMenu.input, 128) 
				imgui.Separator()
				local input_sum_decoded = u8:decode(ffi.string(MODULE.SumMenu.input))
				for _, chapter in ipairs(modules.smart_uk.data) do
					local chapter_has_matching_item = false
					if chapter.item then
						for _, item in ipairs(chapter.item) do
							if item.text and item.text:rupper():find(input_sum_decoded:rupper()) or input_sum_decoded == '' then
								chapter_has_matching_item = true
								break
							end
						end
					end
					if chapter_has_matching_item then
						if imgui.CollapsingHeader(u8(chapter.name)) then
							for _, item in ipairs(chapter.item) do
								if item.text and item.text:rupper():find(input_sum_decoded:rupper()) or input_sum_decoded == '' then
									local popup_id = fa.TRIANGLE_EXCLAMATION .. u8' Ïåðåïðîâåðüòå äàííûå ïåðåä âûäà÷åé ðîçûñêà##' .. item.text .. item.lvl .. item.reason
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
									imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 0.00, 0.00, 0.65))
									if imgui.Button("> " .. u8(split_text_into_lines(item.text, 85))..'##' .. item.text .. item.lvl .. item.reason, imgui.ImVec2(imgui.GetMiddleButtonX(1), (25 * count_lines_in_text(item.text, 85)) * settings.general.custom_dpi)) then
										imgui.OpenPopup(popup_id)
									end
									imgui.PopStyleColor()
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(popup_id, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
										imgui.Text(fa.USER .. u8' Èãðîê: ' .. u8(sampGetPlayerNickname(player_id)) .. '[' .. player_id .. ']')
										imgui.Text(fa.STAR .. u8' Óðîâåíü ðîçûñêà: ' .. item.lvl)
										imgui.Text(fa.COMMENT .. u8' Ïðè÷èíà âûäà÷è ðîçûñêà: ' .. u8(item.reason))
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK, imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.WALKIE_TALKIE .. u8' Çàïðîñèòü ðîçûñê ' .. fa.WALKIE_TALKIE, imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											MODULE.SumMenu.Window[0] = false
											find_and_use_command('Ïðîøó îáüÿâèòü â ðîçûñê %{arg2%} ñòåïåíè äåëî N%{arg_id%}%. Ïðè÷èíà%: %{arg3%}', player_id .. ' ' .. item.lvl .. ' ' .. item.reason)
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										local text_rank = ((settings.general.fraction == 'ÔÑÁ' or settings.general.fraction == 'fcb') and ' [4+]' or ' [5+]')
										if imgui.Button(fa.STAR .. u8' Âûäàòü ðîçûñê' .. text_rank, imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											MODULE.SumMenu.Window[0] = false
											find_and_use_command('/su {arg_id} {arg2} {arg3}', player_id .. ' ' .. item.lvl .. ' ' .. item.reason)
											imgui.CloseCurrentPopup()
										end
										imgui.EndPopup()
									end
								end
							end
						end
					end
				end
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîèçîøëà îøèáêà óìíîãî ðîçûñêà (íåòó äàííûõ ëèáî èãðîê îôíóëñÿ)!', message_color)
				MODULE.SumMenu.Window[0] = false
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.TsmMenu.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 413 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.TICKET .. u8" Óìíàÿ âûäà÷à øòðàôîâ " .. fa.TICKET .. "##tsm_menu", MODULE.TsmMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
			change_dpi()
			if modules.smart_pdd.data ~= nil and isParamSampID(player_id) then
				imgui.PushItemWidth(580 * settings.general.custom_dpi)
				imgui.InputTextWithHint(u8'##input_tsm', u8('Ïîèñê ñòàòåé (ïîäïóíêòîâ) â ãëàâàõ (ïóíêòàõ)'), MODULE.TsmMenu.input, 128) 
				imgui.Separator()
				local input_tsm_decoded = u8:decode(ffi.string(MODULE.TsmMenu.input))
				for _, chapter in ipairs(modules.smart_pdd.data) do
					local chapter_has_matching_item = false
					if chapter.item then
						for _, item in ipairs(chapter.item) do
							if item.text and item.text:rupper():find(input_tsm_decoded:rupper()) or input_tsm_decoded == '' then
								chapter_has_matching_item = true
								break
							end
						end
					end
					if chapter_has_matching_item then
						if imgui.CollapsingHeader(u8(chapter.name)) then
							for _, item in ipairs(chapter.item) do
								if item.text and item.text:rupper():find(input_tsm_decoded:rupper()) or input_tsm_decoded == '' then
									local popup_id = fa.TRIANGLE_EXCLAMATION .. u8' Ïåðåïðîâåðüòå äàííûå ïåðåä âûäà÷åé øòðàôà##' .. item.text .. item.amount .. item.reason
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
									imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 0.00, 0.00, 0.65))
									if imgui.Button(u8(split_text_into_lines(item.text,85))..'##' .. item.text .. item.amount .. item.reason, imgui.ImVec2( imgui.GetMiddleButtonX(1), (25 * count_lines_in_text(item.text, 85)) * settings.general.custom_dpi)) then
										imgui.OpenPopup(popup_id)
									end 
									imgui.PopStyleColor()
									imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(popup_id, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
										imgui.Text(fa.USER .. u8' Èãðîê: ' .. u8(sampGetPlayerNickname(player_id)) .. '[' .. player_id .. ']')
										imgui.Text(fa.MONEY_CHECK_DOLLAR .. u8' Ñóììà øòðàôà: $' .. item.amount)
										imgui.Text(fa.COMMENT .. u8' Ïðè÷èíà âûäà÷è øòðàôà: ' .. u8(item.reason))
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.TICKET .. u8' Âûïèñàòü øòðàô ' .. fa.TICKET, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											MODULE.TsmMenu.Window[0] = false
											find_and_use_command('ticket {arg_id}', player_id .. ' ' .. item.amount .. ' ' .. item.reason)
											imgui.CloseCurrentPopup()
										end
										imgui.EndPopup()
									end
								end
							end
						end
					end
				end
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîèçîøëà îøèáêà óìíûõ øòðàôîâ (íåòó äàííûõ ëèáî èãðîê îôíóëñÿ)!', message_color)
				MODULE.TsmMenu.Window[0] = false
			end
			imgui.End()
		end
	)
end
if isMode('hospital') then
	imgui.OnFrame(
		function() return MODULE.MedCard.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.HOSPITAL.." Rodina Helper " .. fa.HOSPITAL .. "##medcard", MODULE.MedCard.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
			change_dpi()
			imgui.CenterText(u8'Ñðîê äåéñòâèÿ ìåä.êàðòû:')
			if imgui.RadioButtonIntPtr(u8" 7 äíåé ##0",MODULE.MedCard.days,0) then
				MODULE.MedCard.days[0] = 0
			end
			if imgui.RadioButtonIntPtr(u8" 14 äíåé ##1",MODULE.MedCard.days,1) then
				MODULE.MedCard.days[0] = 1
			end
			if imgui.RadioButtonIntPtr(u8" 30 äíåé ##2",MODULE.MedCard.days,2) then
				MODULE.MedCard.days[0] = 2
			end
			if imgui.RadioButtonIntPtr(u8" 60 äíåé ##3",MODULE.MedCard.days,3) then
				MODULE.MedCard.days[0] = 3
			end
			imgui.Separator()
			imgui.CenterText(u8'Còàòóñ çäîðîâüÿ ïàöèåíòà:')
			if imgui.RadioButtonIntPtr(u8" Íå îïðåäåëåí ##0", MODULE.MedCard.status,0) then
				MODULE.MedCard.status[0] = 0
			end
			if imgui.RadioButtonIntPtr(u8" Ïñèõè÷åñêè íå çäîðîâ ##1", MODULE.MedCard.status,1) then
				MODULE.MedCard.status[0] = 1
			end
			if imgui.RadioButtonIntPtr(u8" Íàáëþäàþòñÿ îòêëîíåíèÿ ##2", MODULE.MedCard.status,2) then
				MODULE.MedCard.status[0] = 2
			end
			if imgui.RadioButtonIntPtr(u8" Ïîëíîñòüþ çäîðîâ ##3", MODULE.MedCard.status,3) then
				MODULE.MedCard.status[0] = 3
			end
			imgui.Separator()
			if imgui.Button(fa.ID_CARD_CLIP..u8" Âûäàòü ìåä.êàðòó", imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				local command_find = false
				for _, command in ipairs(modules.commands.data.commands.my) do
					if command.enable and command.text:find('/medcard') then
						command_find = true
						local modifiedText = command.text
						local wait_tag = false
						local arg_id = player_id
						modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id) or "")
						modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id):gsub('_',' ') or "")
						modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}', TranslateNick(sampGetPlayerNickname(arg_id)) or "")
						modifiedText = modifiedText:gsub('%{arg_id%}', arg_id or "")
						lua_thread.create(function()
							MODULE.Binder.state.isActive = true
							MODULE.Binder.state.isPause = false
							if modifiedText:find('&.+&') then
								info_stop_command()
							end
							local lines = {}
							for line in string.gmatch(modifiedText, "[^&]+") do
								table.insert(lines, line)
							end
							for line_index, line in ipairs(lines) do 
								if MODULE.Binder.state.isStop then 
									MODULE.Binder.state.isStop = false 
									MODULE.Binder.state.isActive = false
									if isMonetLoader() and settings.general.mobile_stop_button then
										MODULE.CommandStop.Window[0] = false
									end
									sampAddChatMessage('[Rodina Helper] {ffffff}Îòûãðîâêà êîìàíäû /' .. command.cmd .. " óñïåøíî îñòàíîâëåíà!", message_color) 
									return 
								end
								if wait_tag then
									for tag, replacement in pairs(MODULE.Binder.tags) do
										if line:find("{" .. tag .. "}") then
											local success, result = pcall(string.gsub, line, "{" .. tag .. "}", replacement())
											if success then
												line = result
											end
										end
									end
									if line == "{pause}" then
										sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà /' .. command.cmd .. ' ïîñòàâëåíà íà ïàóçó!', message_color)
										MODULE.Binder.state.isPause = true
										MODULE.CommandPause.Window[0] = true
										while MODULE.Binder.state.isPause do
											wait(0)
										end
										if not MODULE.Binder.state.isStop then
											sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîäîëæàþ îòûãðîâêó êîìàíäû /' .. command.cmd, message_color)	
										end					
									else
										sampSendChat(line)
										if (MODULE.DEBUG) then sampAddChatMessage('[DEBUG] SEND: ' .. line, message_color) end	
										wait(command.waiting * 1000)
									end
								end
								if not wait_tag then
									if line == '{show_medcard_menu}' then
										wait_tag = true
									end
								end
							end
							MODULE.Binder.state.isActive = false
							if isMonetLoader() and settings.general.mobile_stop_button then
								MODULE.CommandStop.Window[0] = false
							end
						end)
					end
				end
				if not command_find then
					sampAddChatMessage('[Rodina Helper] {ffffff}Áèíä äëÿ âûäà÷è ìåä.êàðòû îòñóòñòâóåò ëèáî îòêëþ÷¸í!', message_color)
					sampAddChatMessage('[Rodina Helper] {ffffff}Ïîïðîáóéòå ñáðîñèòü íàñòðîéêè õåëïåðà!', message_color)
				end
				MODULE.MedCard.Window[0] = false
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.Recept.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.HOSPITAL.." Rodina Helper " .. fa.HOSPITAL .. "##recept", MODULE.Recept.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
			change_dpi()
			imgui.CenterText(u8'Êîëè÷åñòâî ðåöåïòîâ äëÿ âûäà÷è:')
			imgui.PushItemWidth(250 * settings.general.custom_dpi)
			imgui.SliderInt('', MODULE.Recept.recepts, 1, 5)
			imgui.Separator()
			if imgui.Button(fa.CAPSULES .. u8" Âûäàòü ðåöåïòû " .. fa.CAPSULES, imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				local command_find = false
				for _, command in ipairs(modules.commands.data.commands.my) do
					if command.enable and command.text:find('/recept') then
						command_find = true
						local modifiedText = command.text
						local wait_tag = false
						local arg_id = player_id
						modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id) or "")
						modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id):gsub('_',' ') or "")
						modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}', TranslateNick(sampGetPlayerNickname(arg_id)) or "")
						modifiedText = modifiedText:gsub('%{arg_id%}', arg_id or "")
						lua_thread.create(function()
							MODULE.Binder.state.isActive = true
							MODULE.Binder.state.isPause = false
							if modifiedText:find('&.+&') then
								info_stop_command()
							end
							local lines = {}
							for line in string.gmatch(modifiedText, "[^&]+") do
								table.insert(lines, line)
							end
							for line_index, line in ipairs(lines) do 
								if MODULE.Binder.state.isStop then 
									MODULE.Binder.state.isStop = false 
									MODULE.Binder.state.isActive = false
									if isMonetLoader() and settings.general.mobile_stop_button then
										MODULE.CommandStop.Window[0] = false
									end
									sampAddChatMessage('[Rodina Helper] {ffffff}Îòûãðîâêà êîìàíäû /' .. command.cmd .. " óñïåøíî îñòàíîâëåíà!", message_color) 
									return 
								end
								if wait_tag then
									for tag, replacement in pairs(MODULE.Binder.tags) do
										if line:find("{" .. tag .. "}") then
											local success, result = pcall(string.gsub, line, "{" .. tag .. "}", replacement())
											if success then
												line = result
											end
										end
									end
									if line == "{pause}" then
										sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà /' .. command.cmd .. ' ïîñòàâëåíà íà ïàóçó!', message_color)
										MODULE.Binder.state.isPause = true
										MODULE.CommandPause.Window[0] = true
										while MODULE.Binder.state.isPause do
											wait(0)
										end
										if not MODULE.Binder.state.isStop then
											sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîäîëæàþ îòûãðîâêó êîìàíäû /' .. command.cmd, message_color)	
										end					
									else
										sampSendChat(line)
										if (MODULE.DEBUG) then sampAddChatMessage('[DEBUG] SEND: ' .. line, message_color) end	
										wait(command.waiting * 1000)
									end
								end
								if not wait_tag then
									if line == '{show_recept_menu}' then
										wait_tag = true
									end
								end
							end
							MODULE.Binder.state.isActive = false
							if isMonetLoader() and settings.general.mobile_stop_button then
								MODULE.CommandStop.Window[0] = false
							end
						end)
					end
				end
				if not command_find then
					sampAddChatMessage('[Rodina Helper] {ffffff}Áèíä äëÿ âûäà÷è ðåöåïòîâ îòñóòñòâóåò ëèáî îòêëþ÷¸í!', message_color)
					sampAddChatMessage('[Rodina Helper] {ffffff}Ïîïðîáóéòå ñáðîñèòü íàñòðîéêè õåëïåðà!', message_color)
				end
				MODULE.Recept.Window[0] = false
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.Antibiotik.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.HOSPITAL.." Rodina Helper " .. fa.HOSPITAL .. "##ant", MODULE.Antibiotik.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
			change_dpi()
			imgui.CenterText(u8'Êîëè÷åñòâî àíòèáèîòèêîâ äëÿ âûäà÷è:')
			imgui.PushItemWidth(250 * settings.general.custom_dpi)
			imgui.SliderInt('', MODULE.Antibiotik.ants, 1, 20)
			imgui.Separator()
			if imgui.Button(fa.CAPSULES..u8" Âûäàòü àíòèáèîòèêè" , imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				local command_find = false
				for _, command in ipairs(modules.commands.data.commands.my) do
					if command.enable and command.text:find('/antibiotik') then
						command_find = true
						local modifiedText = command.text
						local wait_tag = false
						local arg_id = player_id
						modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id) or "")
						modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg_id):gsub('_',' ') or "")
						modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}', TranslateNick(sampGetPlayerNickname(arg_id)) or "")
						modifiedText = modifiedText:gsub('%{arg_id%}', arg_id or "")
						lua_thread.create(function()
							MODULE.Binder.state.isActive = true
							MODULE.Binder.state.isPause = false
							if modifiedText:find('&.+&') then
								info_stop_command()
							end
							local lines = {}
							for line in string.gmatch(modifiedText, "[^&]+") do
								table.insert(lines, line)
							end
							for line_index, line in ipairs(lines) do 
								if MODULE.Binder.state.isStop then 
									MODULE.Binder.state.isStop = false 
									MODULE.Binder.state.isActive = false
									if isMonetLoader() and settings.general.mobile_stop_button then
										MODULE.CommandStop.Window[0] = false
									end
									sampAddChatMessage('[Rodina Helper] {ffffff}Îòûãðîâêà êîìàíäû /' .. command.cmd .. " óñïåøíî îñòàíîâëåíà!", message_color) 
									return 
								end
								if wait_tag then
									for tag, replacement in pairs(MODULE.Binder.tags) do
										if line:find("{" .. tag .. "}") then
											local success, result = pcall(string.gsub, line, "{" .. tag .. "}", replacement())
											if success then
												line = result
											end
										end
									end
									if line == "{pause}" then
										sampAddChatMessage('[Rodina Helper] {ffffff}Êîìàíäà /' .. command.cmd .. ' ïîñòàâëåíà íà ïàóçó!', message_color)
										MODULE.Binder.state.isPause = true
										MODULE.CommandPause.Window[0] = true
										while MODULE.Binder.state.isPause do
											wait(0)
										end
										if not MODULE.Binder.state.isStop then
											sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîäîëæàþ îòûãðîâêó êîìàíäû /' .. command.cmd, message_color)	
										end					
									else
										sampSendChat(line)
										if (MODULE.DEBUG) then sampAddChatMessage('[DEBUG] SEND: ' .. line, message_color) end	
										wait(command.waiting * 1000)
									end
								end
								if not wait_tag then
									if line == '{show_ant_menu}' then
										wait_tag = true
									end
								end
							end
							MODULE.Binder.state.isActive = false
							if isMonetLoader() and settings.general.mobile_stop_button then
								MODULE.CommandStop.Window[0] = false
							end
						end)
					end
				end
				if not command_find then
					sampAddChatMessage('[Rodina Helper] {ffffff}Áèíä äëÿ âûäà÷è àíòèáèîòèêîâ îòñóòñòâóåò ëèáî îòêëþ÷¸í!', message_color)
					sampAddChatMessage('[Rodina Helper] {ffffff}Ïîïðîáóéòå ñáðîñèòü íàñòðîéêè õåëïåðà!', message_color)
				end
				MODULE.Antibiotik.Window[0] = false
			end
			imgui.End()
		end
	)
	imgui.OnFrame(
		function() return MODULE.HealChat.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 8.5, sizeY / 1.9), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.HOSPITAL.." Rodina Helper " .. fa.HOSPITAL .. "##fast_heal", MODULE.HealChat.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar +  imgui.WindowFlags.AlwaysAutoResize )
			change_dpi()
			if imgui.Button(fa.KIT_MEDICAL..u8' Âûëå÷èòü '.. u8(sampGetPlayerNickname(MODULE.HealChat.player_id))) then
				find_and_use_command("/heal {arg_id}", MODULE.HealChat.player_id)
				MODULE.HealChat.bool = false
				MODULE.HealChat.player_id = nil
				MODULE.HealChat.Window[0] = false
			end
			imgui.End()
		end
	)
end
if isMode('smi') then
	imgui.OnFrame(
		function() return MODULE.SmiEdit.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			local size_window_y = settings.smi.use_ads_buttons and 302 or 140
			imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, size_window_y * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
			imgui.Begin(fa.BUILDING_SHIELD.." Rodina Helper##MODULE.SmiEdit.Window", MODULE.SmiEdit.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar )
			change_dpi()
			imgui.Text(fa.CIRCLE_INFO .. u8" Îáúÿâëåíèå ïîäàë èãðîê: " .. u8(MODULE.SmiEdit.ad_from) .. '[' .. (sampGetPlayerIdByNickname(MODULE.SmiEdit.ad_from) and sampGetPlayerIdByNickname(MODULE.SmiEdit.ad_from) or 'OFF') .. ']')
			imgui.Text(fa.CIRCLE_INFO .. u8" Òåêñò: " .. (u8(MODULE.SmiEdit.ad_message)))
			imgui.SameLine()
			if imgui.SmallButton(fa.CIRCLE_ARROW_RIGHT) then
				imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(MODULE.SmiEdit.ad_message))
			end
			imgui.Separator()
			local window_size = imgui.GetWindowSize()
			local size_item_width = settings.smi.ads_history and 100 or 70
			imgui.PushItemWidth(window_size.x - size_item_width * settings.general.custom_dpi)
			imgui.InputTextWithHint('##smi_edit_ad', u8'Îòðåäàêòèðóéòå îáúÿâëåíèå ëèáî ââåäèòå ïðè÷èíó äëÿ îòêëîíåíèÿ', MODULE.SmiEdit.input_edit_text, 256)
			imgui.SameLine()
			if imgui.Button(fa.DELETE_LEFT, imgui.ImVec2(27 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text))
				if #text > 0 then
					imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text:sub(1, -2)))
				end
			end
			imgui.SameLine()
			if imgui.Button(fa.TRASH_CAN, imgui.ImVec2(25 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				imgui.StrCopy(MODULE.SmiEdit.input_edit_text, "")
			end
			if settings.smi.ads_history then
				imgui.SameLine()
				if imgui.Button(fa.CLOCK_ROTATE_LEFT, imgui.ImVec2(25 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					imgui.OpenPopup(fa.CLOCK_ROTATE_LEFT .. u8' Èñòîðèÿ îáüÿâëåíèé')	
				end
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
				if imgui.BeginPopupModal(fa.CLOCK_ROTATE_LEFT .. u8' Èñòîðèÿ îáüÿâëåíèé', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
					imgui.SetWindowSizeVec2(imgui.ImVec2(610 * settings.general.custom_dpi, 350 * settings.general.custom_dpi))
					if imgui.BeginChild('##99999999', imgui.ImVec2(600 * settings.general.custom_dpi, 285 * settings.general.custom_dpi), true) then	
						change_dpi()
						imgui.PushItemWidth(580 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##input_ads_search', u8'Ïîèñê îáüÿâëåíèé ïî íóæíîé ôðàçå, íà÷èíàéòå ââîäèòü å¸ ñþäà...', MODULE.SmiEdit.input_ads_search, 128)
						imgui.Separator()
						local input_ads_decoded = u8:decode(ffi.string(MODULE.SmiEdit.input_ads_search))
						for id, ad in ipairs(modules.ads_history.data) do
							if input_ads_decoded == '' or ad.my_text:rupper():find(input_ads_decoded:rupper()) then
								if imgui.Button(u8(ad.my_text .. '##' .. id), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
									imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(ad.my_text))
									imgui.CloseCurrentPopup()
									break
								end
							end
						end
						imgui.EndChild()
					end		
					if imgui.Button(fa.CIRCLE_XMARK .. u8' Çàêðûòü', imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						imgui.CloseCurrentPopup()
					end
					imgui.End()
				end
			end
			imgui.Separator()
			if settings.smi.use_ads_buttons then
				if imgui.BeginChild('##1', imgui.ImVec2(125 * settings.general.custom_dpi, 155 * settings.general.custom_dpi), true) then	
					if imgui.Button(u8('Êóïëþ'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'Êóïëþ '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					if imgui.Button(u8('Ïðîäàì'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'Ïðîäàì '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					if imgui.Button(u8('Îáìåíÿþ'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'Îáìåíÿþ '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					if imgui.Button(u8('Ñäàì â àðåíäó'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'Ñäàì â àðåíäó '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					if imgui.Button(u8('Àðåíäóþ'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'Àðåíäóþ '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.EndChild()
				end	
				imgui.SameLine()
				if imgui.BeginChild('##2', imgui.ImVec2(200 * settings.general.custom_dpi, 155 * settings.general.custom_dpi), true) then	
					if imgui.Button(u8('à/ì'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'à/ì '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('ò/ñ'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ò/ñ '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('ë/ä'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ë/ä '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('ã/ô'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ã/ô '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end

					if imgui.Button(u8('â/ò'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'â/ò '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('ì/ò'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ì/ò '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('ñ/ì'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ñ/ì '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('â/ñ'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'â/ñ '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end

					if imgui.Button(u8('ä/ò'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ä/ò '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('ð/ñ'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ð/ñ '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('î/ï'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'î/ï '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('ï/ì'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ï/ì '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end

					if imgui.Button(u8('à/ñ'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'à/ñ '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('ï/ò'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ï/ò '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('á/ç'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'á/ç '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('í/ç'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'í/ç '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end

					if imgui.Button(u8('ë/î'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ë/î '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('ì/ô'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'ì/ô '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('÷/ä'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '÷/ä '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
					if imgui.Button(u8('â/î'), imgui.ImVec2(imgui.GetMiddleButtonX(4), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'â/î '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.EndChild()
				end	
				imgui.SameLine()
				if imgui.BeginChild('##3', imgui.ImVec2(100 * settings.general.custom_dpi, 155 * settings.general.custom_dpi), true) then	
					if imgui.Button(u8('Öåíà:'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. ' Öåíà: '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					if imgui.Button(u8('Öåíà çà øò:'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. ' Öåíà çà øò: '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					if imgui.Button(u8('Äîãîâîðíàÿ'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'Äîãîâîðíàÿ'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					if imgui.Button(u8('Áþäæåò:'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. ' Áþäæåò: '
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					if imgui.Button(u8('Ñâîáîäíûé'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. 'Ñâîáîäíûé'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.EndChild()
				end	
				imgui.SameLine()
				if imgui.BeginChild('##4', imgui.ImVec2(150 * settings.general.custom_dpi, 155 * settings.general.custom_dpi), true) then
					-- Ïåðøèé ðÿäîê
					if imgui.Button(u8('1'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '1'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
				
					if imgui.Button(u8('2'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '2'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
				
					if imgui.Button(u8('3'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '3'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
				
					-- Äðóãèé ðÿäîê
					if imgui.Button(u8('4'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '4'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
				
					if imgui.Button(u8('5'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '5'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
				
					if imgui.Button(u8('6'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '6'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
				
					-- Òðåò³é ðÿäîê
					if imgui.Button(u8('7'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '7'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
				
					if imgui.Button(u8('8'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '8'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
				
					if imgui.Button(u8('9'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '9'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
				
					-- ×åòâåðòèé ðÿäîê
					if imgui.Button(u8('.'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '.'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
				
					if imgui.Button(u8('0'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '0'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
					imgui.SameLine()
				
					if imgui.Button(u8('$'), imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. '$'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end
				
					if imgui.Button(u8(' ñ ãðàâèðîâêîé +'), imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
						local text = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) .. ' ñ ãðàâèðîâêîé +'
						imgui.StrCopy(MODULE.SmiEdit.input_edit_text, u8(text))
					end

					imgui.EndChild()
				end
				imgui.Separator()
			end
			if isMonetLoader() then
				if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8" Îïóáëèêîâàòü", imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
					send_ad()
				end
			else
				if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8" Îïóáëèêîâàòü [" .. getNameKeysFrom(settings.general.bind_action) .. "]", imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
					send_ad()
				end
			end
			imgui.SameLine()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòêëîíèòü', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
				if u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text)) == '' then
					reason_cancel = 'Îòêàç ÏÐÎ'
				else
					reason_cancel = u8:decode(ffi.string(MODULE.SmiEdit.input_edit_text))
				end
				sampSendDialogResponse(MODULE.SmiEdit.ad_dialog_id, 0, 0, reason_cancel)
				imgui.StrCopy(MODULE.SmiEdit.input_edit_text, '')
				MODULE.SmiEdit.Window[0] = false
			end
			imgui.SameLine()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' Ïðîïóñòèòü', imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
				MODULE.SmiEdit.skip_dialog = true
				sampSendChat('/mm')
				imgui.StrCopy(MODULE.SmiEdit.input_edit_text, '')
				MODULE.SmiEdit.Window[0] = false
			end
			imgui.End()
		end
	)
end
if (settings.player_info.fraction_rank_number >= 9) then
	imgui.OnFrame(
		function() return MODULE.GiveRank.Window[0] end,
		function(player)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(getHelperIcon().." Rodina Helper " .. getHelperIcon() .. "##rank", MODULE.GiveRank.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
			change_dpi()
			imgui.CenterText(u8'Âûáåðèòå ðàíã äëÿ '.. u8(sampGetPlayerNickname(player_id)) .. ':')
			imgui.PushItemWidth(250 * settings.general.custom_dpi)
			imgui.SliderInt('', MODULE.GiveRank.number, 1, (settings.player_info.fraction_rank_number == 9) and 8 or 9) -- çàì íå ìîæåò äàòü 9 ðàíã
			imgui.Separator()
			local text = isMonetLoader() and " Âûäàòü ðàíã" or " Âûäàòü ðàíã [" .. getNameKeysFrom(settings.general.bind_action) .. "]"
			if imgui.Button(fa.USER .. u8(text), imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				give_rank()
				MODULE.GiveRank.Window[0] = false
			end
			imgui.End()
		end
	)
end
----------------------------------------- FAST MENU GUI -------------------------------------------
imgui.OnFrame(
    function() return MODULE.FastMenu.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.USER .. ' '.. u8(sampGetPlayerNickname(player_id)) ..' ['..player_id.. ']##FastMenu', MODULE.FastMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
		change_dpi()
		local check = false
		for _, command in ipairs(modules.commands.data.commands.my) do
			if command.enable and command.arg == '{arg_id}' and command.in_fastmenu then
				if imgui.Button(u8(command.description), imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
					sampProcessChatInput("/" .. command.cmd .. " " .. player_id)
					MODULE.FastMenu.Window[0] = false
				end
				check = true
			end
		end
		if not check then
			sampAddChatMessage('[Rodina Helper] {ffffff}Íàñòðîéòå FastMenu â /helper - Êîìàíäû è îòûãðîâêè!', message_color)
			MODULE.FastMenu.Window[0] = false
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.FastMenuButton.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.mobile_fastmenu_button.x, settings.windows_pos.mobile_fastmenu_button.y), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.BUILDING_SHIELD .." Rodina Helper##fast_menu_button", MODULE.FastMenuButton.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoBackground  )
		change_dpi()
		if imgui.Button(fa.IMAGE_PORTRAIT..u8' Âçàèìîäåéñòâèå ') then
			local players = get_players()
			if #players == 1 then
				show_fast_menu(players[1])
				MODULE.FastMenuButton.Window[0] = false
			elseif #players > 1 then
				MODULE.FastMenuPlayers.Window[0] = true
				MODULE.FastMenuButton.Window[0] = false
			end
		end
		local posX, posY = imgui.GetWindowPos().x, imgui.GetWindowPos().y
		if posX ~= settings.windows_pos.mobile_fastmenu_button.x or posY ~= settings.windows_pos.mobile_fastmenu_button.y then
			settings.windows_pos.mobile_fastmenu_button = {x = posX, y = posY}
			save_settings()
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.FastMenuPlayers.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() .. u8" Âûáåðèòå èãðîêà " .. getHelperIcon() .. "##fast_menu_players", MODULE.FastMenuPlayers.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		local players = get_players()
		if #players == 0 then
			show_fast_menu(players[1])
			MODULE.FastMenuPlayers.Window[0] = false
		elseif #players >= 1 then
			for _, player in ipairs(players) do
				local id = tonumber(player)
				if imgui.Button(u8(sampGetPlayerNickname(id)), imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					if #players ~= 0 then show_fast_menu(id) end
					MODULE.FastMenuPlayers.Window[0] = false
				end
			end
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.LeaderFastMenu.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getUserIcon() .. ' ' .. u8(sampGetPlayerNickname(player_id)) .. ' [' .. player_id .. ']##LeaderFastMenu', MODULE.LeaderFastMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize  )
		change_dpi()
		local check = false
		for _, command in ipairs(modules.commands.data.commands_manage.my) do
			if command.enable and command.arg == '{arg_id}' and command.in_fastmenu then
				if imgui.Button(u8(command.description), imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
					sampProcessChatInput("/" .. command.cmd .. " " .. player_id)
					MODULE.LeaderFastMenu.Window[0] = false
				end
				check = true
			end
		end
		if isMonetLoader() and not check then
			sampAddChatMessage('[Rodina Helper] {ffffff}Íàñòðîéòå LeaderFastMenu â /helper - Êîìàíäû è îòûãðîâêè!', message_color)
			MODULE.FastMenu.Window[0] = false
		elseif not isMonetLoader() then
			if imgui.Button(u8"Âûäàòü âûãîâîð",imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
				sampSetChatInputEnabled(true)
				sampSetChatInputText('/vig '..player_id..' ')
				MODULE.LeaderFastMenu.Window[0] = false
			end
			if imgui.Button(u8"Óâîëèòü èç îðãàíèçàöèè",imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
				sampSetChatInputEnabled(true)
				sampSetChatInputText('/unv '..player_id..' ')
				MODULE.LeaderFastMenu.Window[0] = false
			end
		end
		imgui.End()
    end
)
imgui.OnFrame(
	function() return MODULE.FastPieMenu.Window[0] end,
	function(player)
		imgui.Begin('##MODULE.FastPieMenu.Window', MODULE.FastPieMenu.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoTitleBar)
		safery_disable_cursor(player)
		if imgui.IsMouseClicked(2) then
			imgui.OpenPopup('PieMenu')
		end
		if pie.BeginPiePopup('PieMenu', 2) then
			player.HideCursor = false
			
			if pie.PieMenuItem(u8' Ìèðàíäà') then
				if imgui.IsMouseReleased(2) then 
					find_and_use_command('Âû èìååòå ïðàâî', "")
				end
			end

			if pie.PieMenuItem(u8' Ìèðàíäà') then
				if imgui.IsMouseReleased(2) then 
					find_and_use_command('Âû èìååòå ïðàâî', "")
				end
			end
			
			if pie.BeginPieMenu(u8'Òðàôôèê ñòîï') then
				if pie.PieMenuItem('10-55') then 
					if imgui.IsMouseReleased(2) then
						find_and_use_command('Ïðîâîæó 10%-55', "")
					end
				end
				if pie.PieMenuItem('10-66') then 
					if imgui.IsMouseReleased(2) then
						find_and_use_command('Ïðîâîæó 10%-66', "")
					end
				end
				pie.EndPieMenu()
			end
			
			if pie.PieMenuItem(u8'Òàéçåð', false) then 
				if imgui.IsMouseReleased(2) then
					sampSendChat('/taser')
				end
			end

			if pie.BeginPieMenu('Test', false) then 
				if pie.BeginPieMenu('Test 1') then 
					
					pie.EndPieMenu()
				end
				if pie.BeginPieMenu('Test 2') then 
					
					pie.EndPieMenu()
				end
				if pie.BeginPieMenu('Test 3') then 
					if pie.PieMenuItem(u8'Êðóãîâîå ìåíþ') then 
						if imgui.IsMouseReleased(2) then
							find_and_use_command('Ïðîâîæó 10%-55', "")
						end
					end
					if pie.PieMenuItem(u8'Êðàñèâî?') then 
						if imgui.IsMouseReleased(2) then
							find_and_use_command('Ïðîâîæó 10%-55', "")
						end
					end
					pie.EndPieMenu()
				end
				if pie.BeginPieMenu('Test 4') then 
					
					pie.EndPieMenu()
				end
				-- if pie.BeginPieMenu('Test 5') then 
					
				-- 	pie.EndPieMenu()
				-- end
				-- if pie.BeginPieMenu('Test 6') then 
					
				-- 	pie.EndPieMenu()
				-- end
				-- if pie.BeginPieMenu('Test 7') then 
					
				-- 	pie.EndPieMenu()
				-- end
				pie.EndPieMenu()
			end
			
			pie.EndPiePopup()
		end
		imgui.End()
	end
)
----------------------------------- UPDATE GUI -----------------------------
imgui.OnFrame(
    function() return MODULE.Update.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.CIRCLE_INFO .. u8" Äîñòóïíî îáíîâëåíèå õåëïåðà ".. fa.CIRCLE_INFO .. "##update_window", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
		if not isMonetLoader() then change_dpi() end
		imgui.CenterText(u8("Ñïèñîê èçìåíåíèé â íîâîé âåðñèè:"))
		imgui.Text(u8(MODULE.Update.info))
		imgui.Separator()
		if imgui.Button(fa.CIRCLE_XMARK .. u8' Íå îáíîâëÿòü ' .. fa.CIRCLE_XMARK, imgui.ImVec2(250 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
			MODULE.Update.Window[0] = false
		end
		imgui.SameLine()
		if imgui.Button(fa.DOWNLOAD ..u8' Çàãðóçèòü ' .. u8(MODULE.Update.version) .. ' ' .. fa.DOWNLOAD, imgui.ImVec2(250 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
			if thisScript().version:find('VIP') then
				sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå êîìàíäó /helper â íàøåì Telegram/Discord VIP áîòå!', message_color)
			else
				download_file = 'helper'
				downloadFileFromUrlToPath(MODULE.Update.url, getWorkingDirectory():gsub('\\','/') .. "/Rodina Helper.lua")
			end
			MODULE.Update.Window[0] = false
		end
		imgui.End()
    end
)
----------------------------------- Other GUI -----------------------------
imgui.OnFrame(
    function() return MODULE.RPWeapon.Window[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 425 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.GUN .. u8" RP îòûãðîâêà îðóæèÿ â ÷àòå " .. fa.GUN, MODULE.RPWeapon.Window, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		change_dpi()
        imgui.PushItemWidth(385 * settings.general.custom_dpi)
        imgui.InputTextWithHint(u8'##inputsearch_weapon_name', u8('Ââîäèòå ÷òîáû èñêàòü îðóæèå ïî åãî ID èëè íàçâàíèþ...'), MODULE.RPWeapon.input_search, 256) 
		imgui.SameLine()
		if imgui.Button(u8("Âêëþ÷èòü âñ¸")) then
			for index, value in ipairs(modules.rpgun.data.rp_guns) do
				value.enable = true
			end
			save_module('rpgun')
		end		
		imgui.SameLine()
		if imgui.Button(u8("Îòêëþ÷èòü âñ¸")) then
			for index, value in ipairs(modules.rpgun.data.rp_guns) do
				value.enable = false
			end
			save_module('rpgun')
		end		
		if imgui.BeginChild('##rpguns1', imgui.ImVec2(588 * settings.general.custom_dpi, 361 * settings.general.custom_dpi), true) then
			imgui.Columns(3)
			imgui.CenterColumnText(u8"Ðàáîòîñïîñîáíîñòü")
			imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8"ID è íàçâàíèå îðóæèÿ")
			imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8"Ðàñïîëîæåíèå")
			imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
			imgui.Columns(1)
			imgui.Separator()
			local decoded_input = u8:decode(ffi.string(MODULE.RPWeapon.input_search))
			for index, value in ipairs(modules.rpgun.data.rp_guns) do
				if decoded_input == '' or (value.name and value.name:upper():find(decoded_input:upper())) or value.id == tonumber(decoded_input) then
					imgui.Columns(3)
					if value.enable then
						if imgui.CenterColumnSmallButton(fa.SQUARE_CHECK .. u8'  (ðàáîòàåò)##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
							value.enable = not value.enable
							save_module('rpgun')
						end
					else
						if imgui.CenterColumnSmallButton(fa.SQUARE .. u8' (îòêëþ÷¸í)##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
							value.enable = not value.enable
							save_module('rpgun')
						end
					end
					imgui.NextColumn()
					imgui.CenterColumnText('[' .. value.id .. '] ' .. u8(value.name))
					imgui.SameLine()
					if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##weapon_name' .. index) then
						_G.weapon_input = imgui.new.char[256]()
						imgui.StrCopy(_G.weapon_input, u8(value.name))
						imgui.OpenPopup(fa.GUN .. u8' Íàçâàíèå îðóæèÿ ' .. fa.GUN .. '##weapon_name' .. index)
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.GUN .. u8' Íàçâàíèå îðóæèÿ ' .. fa.GUN .. '##weapon_name' .. index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize ) then
						change_dpi()
						imgui.PushItemWidth(400 * settings.general.custom_dpi)
						imgui.InputText(u8'##weapon_name', _G.weapon_input, 256) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							value.name = u8:decode(ffi.string(_G.weapon_input))
							save_module('rpgun')
							initialize_guns()
							_G.weapon_input = nil
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.NextColumn()
					local position = ''
					if value.rpTake == 1 then
						position = 'Ñïèíà'
					elseif value.rpTake == 2 then
						position = 'Êàðìàí'
					elseif value.rpTake == 3 then
						position = 'Ïîÿñ'
					elseif value.rpTake == 4 then
						position = 'Êîáóðà'
					end
					imgui.CenterColumnText(u8(position))
					imgui.SameLine()
					if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##weapon_position' .. index) then
						MODULE.RPWeapon.ComboTags[0] = value.rpTake - 1
						imgui.OpenPopup(fa.GUN .. u8' Ðàñïîëîæåíèå îðóæèÿ##weapon_name' .. index)
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.GUN .. u8' Ðàñïîëîæåíèå îðóæèÿ##weapon_name' .. index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize ) then
						change_dpi()
						imgui.PushItemWidth(400 * settings.general.custom_dpi)
						imgui.Combo(u8'##' .. index, MODULE.RPWeapon.ComboTags, MODULE.RPWeapon.ImItems, 4)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' Îòìåíà ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' Ñîõðàíèòü ' .. fa.FLOPPY_DISK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							value.rpTake = MODULE.RPWeapon.ComboTags[0] + 1
							save_module('rpgun')
							initialize_guns()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Separator()

				end
			end
			imgui.EndChild()
		end
        imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.CommandStop.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY - 50 * settings.general.custom_dpi), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() .. " Rodina Helper " .. getHelperIcon() .. "##MODULE.CommandStop.Window", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize )
		change_dpi()
		if isMonetLoader() and MODULE.Binder.state.isActive then
			if imgui.Button(fa.CIRCLE_STOP..u8' Îñòàíîâèòü îòûãðîâêó ') then
				MODULE.Binder.state.isStop = true 
				MODULE.CommandStop.Window[0] = false
			end
		else
			MODULE.CommandStop.Window[0] = false
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return MODULE.CommandPause.Window[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY - 50 * settings.general.custom_dpi), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() .." Rodina Helper " .. getHelperIcon() .. "##MODULE.CommandPause.Window", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		if MODULE.Binder.state.isPause then
			if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8' Ïðîäîëæèòü ', imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				MODULE.Binder.state.isPause = false
				MODULE.CommandPause.Window[0] = false
			end
			imgui.SameLine()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' Ïîëíûé STOP ', imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				MODULE.Binder.state.isStop = true 
				MODULE.Binder.state.isPause = false
				MODULE.CommandPause.Window[0] = false
			end
		else
			MODULE.CommandPause.Window[0] = false
		end
		imgui.End()
    end
)
---------------------------------- GUI ITEMS -----------------------------
function imgui.ToggleButton(str_id, bool)
    local rBool = false

    if LastActiveTime == nil then
        LastActiveTime = {}
    end
    if LastActive == nil then
        LastActive = {}
    end

    local function ImSaturate(f)
        return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
    end

    local p = imgui.GetCursorScreenPos()
    local dl = imgui.GetWindowDrawList()

    local height = imgui.GetTextLineHeightWithSpacing()
    local width = height * 1.75
    local radius = height * 0.50
    local ANIM_SPEED = 0.25
    local butPos = imgui.GetCursorPos()

    if imgui.InvisibleButton(str_id, imgui.ImVec2(width, height)) then
        bool[0] = not bool[0]
        rBool = true
        LastActiveTime[tostring(str_id)] = os.clock()
        LastActive[tostring(str_id)] = true
    end

    imgui.SetCursorPos(imgui.ImVec2(butPos.x + width + 8, butPos.y + 2.5))
    imgui.Text( str_id:gsub('##.+', '') )

    local t = bool[0] and 1.0 or 0.0

    if LastActive[tostring(str_id)] then
        local time = os.clock() - LastActiveTime[tostring(str_id)]
        if time <= ANIM_SPEED then
            local t_anim = ImSaturate(time / ANIM_SPEED)
            t = bool[0] and t_anim or 1.0 - t_anim
        else
            LastActive[tostring(str_id)] = false
        end
    end

	local toggle_bg = (settings.general.helper_theme ~= 2) and imgui.GetStyle().Colors[imgui.Col.FrameBg] or imgui.ImVec4(0.85, 0.85, 0.85, 1.0)
    local col_circle = bool[0] and imgui.ColorConvertFloat4ToU32(imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonActive])) or imgui.ColorConvertFloat4ToU32(imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.TextDisabled]))
	dl:AddRectFilled(p, imgui.ImVec2(p.x + width, p.y + height), imgui.ColorConvertFloat4ToU32(toggle_bg), height * 0.6)
    dl:AddCircleFilled(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0), p.y + radius), radius - 1.5, col_circle)
    return rBool
end
function imgui.TextQuestion(text)
    imgui.SameLine()
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.Text(text)
        imgui.EndTooltip()
    end
end
function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end
function imgui.CenterTextDisabled(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.TextDisabled(text)
end
function imgui.CenterColumnText(text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end
function imgui.CenterColumnTextDisabled(text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    imgui.TextDisabled(text)
end
function imgui.CenterColumnColorText(imgui_RGBA, text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
	imgui.TextColored(imgui_RGBA, text)
end
function imgui.CenterButton(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
	if imgui.Button(text) then
		return true
	else
		return false
	end
end
function imgui.CenterColumnButton(text)
	if text:find('(.+)##(.+)') then
		local text1, text2 = text:match('(.+)##(.+)')
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text1).x / 2)
	else
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
	end
    if imgui.Button(text) then
		return true
	else
		return false
	end
end
function imgui.CenterColumnSmallButton(text)
	if text:find('(.+)##(.+)') then
		local text1, text2 = text:match('(.+)##(.+)')
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text1).x / 2)
	else
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
	end
    if imgui.SmallButton(text) then
		return true
	else
		return false
	end
end
function imgui.CenterColumnRadioButtonIntPtr(text, arg1, arg2)
	if text:find('(.+)##(.+)') then
		local text1, text2 = text:match('(.+)##(.+)')
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text1).x / 2)
	else
		imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
	end
    if imgui.RadioButtonIntPtr(text, arg1, arg2) then
		return true
	else
		return false
	end
end
function imgui.GetMiddleButtonX(count)
    local width = imgui.GetWindowContentRegionWidth() 
    local space = imgui.GetStyle().ItemSpacing.x
    return count == 1 and width or width/count - ((space * (count-1)) / count)
end
function safery_disable_cursor(gui)
	if not isMonetLoader() and not sampIsChatInputActive() and isSampAvailable() and not sampIsCursorActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then gui.HideCursor = true else gui.HideCursor = false end
end
function apply_dark_theme()
	imgui.SwitchContext()
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2 * settings.general.custom_dpi, 2 * settings.general.custom_dpi)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 10 * settings.general.custom_dpi
    imgui.GetStyle().GrabMinSize = 10 * settings.general.custom_dpi
    imgui.GetStyle().WindowBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().ChildBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().PopupBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().FrameBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().TabBorderSize = 1 * settings.general.custom_dpi
	imgui.GetStyle().WindowRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ChildRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().FrameRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().PopupRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ScrollbarRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().GrabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().TabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().Colors[imgui.Col.Text]                   = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
    imgui.GetStyle().Colors[imgui.Col.WindowBg]               = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ChildBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PopupBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Border]                 = imgui.ImVec4(0.25, 0.25, 0.26, 0.54)
    imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = imgui.ImVec4(0.51, 0.51, 0.51, 1.00)
    imgui.GetStyle().Colors[imgui.Col.CheckMark]              = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Button]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Header]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = imgui.ImVec4(0.20, 0.20, 0.20, 1.00)
    imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = imgui.ImVec4(0.47, 0.47, 0.47, 1.00)
    imgui.GetStyle().Colors[imgui.Col.Separator]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = imgui.ImVec4(1.00, 1.00, 1.00, 0.25)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = imgui.ImVec4(1.00, 1.00, 1.00, 0.95)
    imgui.GetStyle().Colors[imgui.Col.Tab]                    = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabHovered]             = imgui.ImVec4(0.28, 0.28, 0.28, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabActive]              = imgui.ImVec4(0.30, 0.30, 0.30, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = imgui.ImVec4(0.07, 0.10, 0.15, 0.97)
    imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = imgui.ImVec4(0.14, 0.26, 0.42, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotLines]              = imgui.ImVec4(0.61, 0.61, 0.61, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = imgui.ImVec4(1.00, 0.00, 0.00, 0.35)
    imgui.GetStyle().Colors[imgui.Col.DragDropTarget]         = imgui.ImVec4(1.00, 1.00, 0.00, 0.90)
    imgui.GetStyle().Colors[imgui.Col.NavHighlight]           = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight]  = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
    imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
    imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]       = imgui.ImVec4(0.12, 0.12, 0.12, 0.95)
end
function apply_white_theme()
	imgui.SwitchContext()
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2 * settings.general.custom_dpi, 2 * settings.general.custom_dpi)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 10 * settings.general.custom_dpi
    imgui.GetStyle().GrabMinSize = 10 * settings.general.custom_dpi
    imgui.GetStyle().WindowBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().ChildBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().PopupBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().FrameBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().TabBorderSize = 1 * settings.general.custom_dpi
	imgui.GetStyle().WindowRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ChildRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().FrameRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().PopupRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ScrollbarRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().GrabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().TabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.00, 0.00, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.50, 0.50, 0.50, 1.00);
    imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.94, 0.94, 0.94, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ChildBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00);
    imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.94, 0.94, 0.94, 0.78);
    imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.43, 0.43, 0.50, 0.50);
    imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00);
    imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.94, 0.94, 0.94, 1.00);
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.88, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.80, 0.89, 0.97, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.94, 0.94, 0.94, 1.00) --imgui.ImVec4(0.94, 0.94, 0.94, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.94, 0.94, 0.94, 1.00) --imgui.ImVec4(0.30, 0.29, 0.28, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.94, 0.94, 0.94, 0.70) --imgui.ImVec4(0.00, 0.00, 0.00, 0.51);
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.94, 0.94, 0.94, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.02, 0.02, 0.02, 0.00);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.31, 0.31, 0.31, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.41, 0.41, 0.41, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.51, 0.51, 0.51, 1.00);
    imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.20, 0.20, 0.20, 1.00);
    imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.00, 0.48, 0.85, 1.00);
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.80, 0.80, 0.80, 1.00);
    imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.88, 0.88, 0.88, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.88, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.80, 0.89, 0.97, 1.00);
    imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.88, 0.88, 0.88, 1.00);
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.88, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.80, 0.89, 0.97, 1.00);
    imgui.GetStyle().Colors[imgui.Col.Separator] = imgui.ImVec4(0.43, 0.43, 0.50, 0.50);
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered] = imgui.ImVec4(0.10, 0.40, 0.75, 0.78);
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive] = imgui.ImVec4(0.10, 0.40, 0.75, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.00, 0.00, 0.00, 0.25);
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.00, 0.00, 0.00, 0.67);
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.00, 0.00, 0.00, 0.95);
    imgui.GetStyle().Colors[imgui.Col.Tab] = imgui.ImVec4(0.88, 0.88, 0.88, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TabHovered] = imgui.ImVec4(0.88, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TabActive] = imgui.ImVec4(0.80, 0.89, 0.97, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TabUnfocused] = imgui.ImVec4(0.07, 0.10, 0.15, 0.97);
    imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive] = imgui.ImVec4(0.14, 0.26, 0.42, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.61, 0.61, 0.61, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(1.00, 0.43, 0.35, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.90, 0.70, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.00, 0.47, 0.84, 1.00);
    imgui.GetStyle().Colors[imgui.Col.DragDropTarget] = imgui.ImVec4(1.00, 1.00, 0.00, 0.90);
    imgui.GetStyle().Colors[imgui.Col.NavHighlight] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00);
    imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight] = imgui.ImVec4(1.00, 1.00, 1.00, 0.70);
    imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg] = imgui.ImVec4(0.80, 0.80, 0.80, 0.20);
    imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg] = imgui.ImVec4(0.80, 0.80, 0.80, 0.8);
end
function apply_moonmonet_theme()
	local generated_color = moon_monet.buildColors(settings.general.moonmonet_theme_color, 1.0, true)
	imgui.SwitchContext()
	imgui.GetStyle().WindowPadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5 * settings.general.custom_dpi, 5 * settings.general.custom_dpi)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2 * settings.general.custom_dpi, 2 * settings.general.custom_dpi)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 10 * settings.general.custom_dpi
    imgui.GetStyle().GrabMinSize = 10 * settings.general.custom_dpi
    imgui.GetStyle().WindowBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().ChildBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().PopupBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().FrameBorderSize = 1 * settings.general.custom_dpi
    imgui.GetStyle().TabBorderSize = 1 * settings.general.custom_dpi
	imgui.GetStyle().WindowRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ChildRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().FrameRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().PopupRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().ScrollbarRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().GrabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().TabRounding = 8 * settings.general.custom_dpi
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
	imgui.GetStyle().Colors[imgui.Col.Text] = ColorAccentsAdapter(generated_color.accent2.color_50):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TextDisabled] = ColorAccentsAdapter(generated_color.neutral1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.WindowBg] = ColorAccentsAdapter(generated_color.accent2.color_900):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ChildBg] = ColorAccentsAdapter(generated_color.accent2.color_800):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PopupBg] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Border] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Separator] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
	imgui.GetStyle().Colors[imgui.Col.FrameBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x60):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x70):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x50):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TitleBg] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0x7f):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x91):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0,0,0,0)
	imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x85):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.CheckMark] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.SliderGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x80):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Button] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ButtonActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Tab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TabActive] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TabHovered] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.Header] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.HeaderActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xb3):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PlotLines] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
	imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0x99):as_vec4()
end
function argbToRgbNormalized(argb)
    local a = math.floor(argb / 0x1000000) % 0x100
    local r = math.floor(argb / 0x10000) % 0x100
    local g = math.floor(argb / 0x100) % 0x100
    local b = argb % 0x100
    local normalizedR = r / 255.0
    local normalizedG = g / 255.0
    local normalizedB = b / 255.0
    return {normalizedR, normalizedG, normalizedB}
end
function argbToHexWithoutAlpha(alpha, red, green, blue)
    return string.format("%02X%02X%02X", red, green, blue)
end
function rgba_to_argb(rgba_color)
    local r = bit32.band(bit32.rshift(rgba_color, 24), 0xFF)
    local g = bit32.band(bit32.rshift(rgba_color, 16), 0xFF)
    local b = bit32.band(bit32.rshift(rgba_color, 8), 0xFF)
    local a = bit32.band(rgba_color, 0xFF)
    local argb_color = bit32.bor(bit32.lshift(a, 24), bit32.lshift(r, 16), bit32.lshift(g, 8), b)
    return argb_color
end
function join_argb(a, r, g, b)
    local argb = b 
    argb = bit.bor(argb, bit.lshift(g, 8))
    argb = bit.bor(argb, bit.lshift(r, 16))    
    argb = bit.bor(argb, bit.lshift(a, 24))
    return argb
end
function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end
function rgba_to_hex(rgba)
    local r = bit.rshift(rgba, 24) % 256
    local g = bit.rshift(rgba, 16) % 256
    local b = bit.rshift(rgba, 8) % 256
    local a = rgba % 256
    return string.format("%02X%02X%02X", r, g, b)
end
function ARGBtoRGB(color) 
	return bit.band(color, 0xFFFFFF) 
end
function ColorAccentsAdapter(color)
    local a, r, g, b = explode_argb(color)
    local ret = {a = a, r = r, g = g, b = b}
    function ret:apply_alpha(alpha)
        self.a = alpha
        return self
    end
    function ret:as_u32()
        return join_argb(self.a, self.b, self.g, self.r)
    end
    function ret:as_vec4()
        return imgui.ImVec4(self.r / 255, self.g / 255, self.b / 255, self.a / 255)
    end
    function ret:as_argb()
        return join_argb(self.a, self.r, self.g, self.b)
    end
    function ret:as_rgba()
        return join_argb(self.r, self.g, self.b, self.a)
    end
    function ret:as_chat()
        return string.format("%06X", ARGBtoRGB(join_argb(self.a, self.r, self.g, self.b)))
    end  
    return ret
end
function change_dpi()
	imgui.PushFont(MODULE.FONT) 
end
function getHelperIcon()
	local modes = {
		{'police', fa.BUILDING_SHIELD},
		{'fcb', fa.BUILDING_SHIELD},
		{'army', fa.BUILDING_SHIELD},
		{'prison', fa.BUILDING_SHIELD},
		{'hospital', fa.HOSPITAL},
		{'smi', fa.BUILDING_NGO},
		{'gov', fa.BUILDING_COLUMNS},
		{'fd', fa.HOTEL},
		{'mafia', fa.TORII_GATE},
		{'ghetto', fa.BUILDING_WHEAT},
		{'none', fa.BUILDING_CIRCLE_XMARK}
	}
	for index, value in ipairs(modes) do
		if isMode(value[1]) then
			return value[2]
		end
	end
	return fa.BUILDING
end
function getUserIcon()
	local modes = {
		{'police', fa.USER_NURSE},
		{'fcb', fa.USER_NURSE},
		{'army', fa.PERSON_MILITARY_RIFLE},
		{'prison', fa.PERSON_MILITARY_RIFLE},
		{'hospital', fa.USER_DOCTOR},
		{'fd', fa.USER_ASTRONAUT},
		{'lc', fa.USER_TIE},
		{'ins', fa.USER_TIE},
		{'mafia', fa.USER_NINJA},
		{'ghetto', fa.USER_NINJA}
	}
	for index, value in ipairs(modes) do
		if isMode(value[1]) then
			return value[2]
		end
	end
	return fa.USER
end

function onScriptTerminate(script, game_quit)
    if script == thisScript() and not game_quit and not reload_script then
		if MODULE.InfraredVision then setInfraredVision(false) end
		if MODULE.NightVision then setNightVision(false) end
		sampAddChatMessage('[Rodina Helper] {ffffff}Ïðîèçîøëà íåèçâåñòíàÿ îøèáêà, õåëïåð ïðèîñòàíîâèë ñâîþ ðàáîòó!', message_color)
		if not isMonetLoader() then 
			sampAddChatMessage('[Rodina Helper] {ffffff}Èñïîëüçóéòå ' .. message_color_hex .. 'CTRL {ffffff}+ ' .. message_color_hex .. 'R {ffffff}÷òîáû ïåðåçàïóñòèòü õåëïåð.', message_color)
		end
    end
end
