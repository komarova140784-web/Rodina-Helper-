---@diagnostic disable: undefined-global, lowercase-global, need-check-nil, cast-local-type, unused-local

script_name("Rodina Helper")
script_description('Universal script for players Arizona Online')
script_author("MTG MODS")
script_version("1.8")
----------------------------------------------- INIT ---------------------------------------------
function isMonetLoader()
	return MONET_VERSION ~= nil
end
print('������������� �������...')
print('������: ' .. thisScript().version)
print('���������: ' .. (isMonetLoader() and 'MOBILE' or 'PC'))
------------------------------------------ INIT CRASH INFO ---------------------------------------
if not doesFileExist(getWorkingDirectory():gsub('\\','/') .. "/.Rodina Helper Crash Message.lua") then
	local file_path = getWorkingDirectory():gsub('\\','/') .. "/.Rodina Helper Crash Message.lua"
	local content = [[
function onSystemMessage(msg, type, script)
    if type == 3 and script and script.name == 'Rodina Helper' and msg and not msg:find('Script died due to an error') then
        local errorMessage = ('{ffffff}��������� ����������������� ������ � ������ �������, ��-�� ���� �� ��� ��������!\n\n' ..
		'��������� �������� � log � {ff9900}���.��������� Fil (Telegram/Discord/BlastHack){ffffff}.\n\n' ..
		'������ ��������� ������:\n{ff6666}' .. msg)
        sampShowDialog(789789, '{009EFF}Rodina Helper [' .. script.version .. ']', errorMessage, '{009EFF}�������', '', 0)
    end
end]]
	local file, errstr = io.open(file_path, 'w')
	if file then
		file:write(content)
		file:close()
		if not isMonetLoader() then
			os.execute('attrib +h "' .. file_path .. '"')
		end
	end
end
------------------------------------------ CONNECT LIBNARY ---------------------------------------
print('����������� ������ ���������...')

require('lib.moonloader')
require('encoding').default = 'CP1251'
local u8 = require('encoding').UTF8
local sampev = require('samp.events')
local imgui = require('mimgui')
local fa = require('fAwesome6_solid')
local ffi = require('ffi')
local effil = require('effil')
local monet_no_errors, moon_monet = pcall(require, 'MoonMonet')
local hotkey_no_errors, hotkey = pcall(require, 'mimgui_hotkeys')
local sizeX, sizeY = getScreenResolution()
print('���������� ������� ���������!')
----------------------------------------- JSON SETTINGS -----------------------------------------
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
		ping = false,
		mobile_fastmenu_button = true,
		mobile_stop_button = true,
		auto_notify_payday = true,
		auto_update_members = false,
		auto_accept_docs = false,
		auto_uval = false,
		probiv_api_key = ''
	},
	player_info = {
		name_surname = '',
		fraction = 'none',
		fraction_tag = '',
		fraction_rank = '',
		fraction_rank_number = 0,
		sex = '����������',
		accent_enable = true,
		accent = '[����������� ������]:',
		rp_chat = true,
	},
	deportament = {
		anti_skobki = false,
		dep_fm = '-',
		dep_tag1 = '',
		dep_tag2 = '[����]',
		dep_tags = {
			"[����]",
			"[����������]",
			"[���������]",
			"[���������]",
			'skip',
			"[����]",
			"[�����]",
			"[���]",
			"[����]",
			'skip',
			"[���.���]",
			"[���.��]",
			"[���.��]",
			"[���.��]",
			'skip',
			"[���]",
			"[���]",
			'skip',
			"[���-��]",
			"[���-��]",
			'skip',
			"[����]",
			"[����]",
			"[�����]",
		},
		dep_tags_custom = {},
		dep_fms = {
			'-',
		},
	},
	windows_pos = {
		megafon = {x = sizeX / 8.5, y = sizeY / 2.1},
		info_menu = {x = sizeX * 0.03, y = sizeY * 0.53},
		patrool_menu = {x = sizeX / 2, y = sizeY / 2},
		wanteds_menu = {x = sizeX / 1.2, y = sizeY / 2},
		mobile_fastmenu_button = {x = sizeX / 8.5, y = sizeY / 2.3},
		taser = {x = sizeX / 4.2, y = sizeY / 2.1},
	},
    mj = {
		awanted = false,
        auto_mask = false,
		auto_time = false,
		auto_doklad_patrool = false,
		auto_doklad_damage = false,
		auto_doklad_arrest = false,
		auto_change_code_siren = false,
		auto_clicker_situation = true,
		auto_update_wanteds = false,
		auto_case_documentation = false,
		mobile_meg_button = true,
		mobile_taser_button = true,
    },
	md = {
		auto_doklad_patrool = false,
		auto_doklad_damage = false,
	},
	mh = {
		auto_clicker_situation = false,
		heal_in_chat = {
			enable = true,
			auto_heal = false -- ������ ������� ��� �������������
		},
		price = {
			ant = 50000,
			recept = 50000,
			heal = 100000,
			heal_vc = 100,
			healactor = 800000,
			healactor_vc = 1000,
			healbad = 400000,
			medosm = 800000,
			mticket = 400000,
			med7 = 50000,
			med14 = 100000,
			med30 = 150000,
			med60 = 200000,
		},
	},
	lc = {
		auto_lic = false,
		auto_repair = false,
		auto_find_clorest_repair = true,
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
	},
	gov = {
		anti_trivoga = true,
	}
}
function load_settings()
    if not doesDirectoryExist(configDirectory) then
        createDirectory(configDirectory)
    end
    if not doesFileExist(configDirectory .. "/Settings.json") then
        settings = default_settings
		print('���� � ����������� �� ������, ��������� ����������� ���������!')
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
						print('����� ������, ����� ��������!')
						local fraction = settings.general.fraction_mode
						settings = default_settings
						settings.general.fraction_mode = fraction
						save_settings()
						reload_script = true
					else
						print('��������� ������� ���������!')
					end
				else
					print('�� ������� ������� ���� � �����������, ��������� ����������� ���������!')
				end
			else
                settings = default_settings
				print('�� ������� ������� ���� � �����������, ��������� ����������� ���������!')
			end
        else
            settings = default_settings
			print('�� ������� ������� ���� � �����������, ��������� ����������� ���������!')
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
			end
			local ok, encoded = pcall(encodeJson, array)
			if ok then return encoded else return {} end
		end
		local content = looklike(settings)
		if content and #content ~= 0 then
			file:write(content)
			print('��������� ������� ���������!')
		else
			print('�� ������� ��������� ��������� �������! ������ ��������� json')
		end
		file:close()
    else
        print('�� ������� ��������� ��������� �������, ������: ', errstr)
    end
end
load_settings()
-------------------------------------------- JSON MODULES ---------------------------------------------
local modules = {
	commands = {
		name = '�������',
		path = configDirectory .. "/Commands.json",
		data = {
			commands = {
				my = {
					{cmd = 'time' , description = '���������� �����' ,  text = '/me ��������{sex} �� ���� � ����������� Rodina Helper � ���������{sex} �����&/time&/do �� ����� ����� ����� {get_time}.' , arg = '' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'cure' , description = '������� ������ �� ������' ,  text = '/me ����������� ��� ���������, � ����������� ��� ����� �� ������ �������&/cure {arg_id}&/do ����� �����������.&/me �������� ������ �������� �������� ������ ������, ����� �� ������� �������� �����&/do ������ ��������� ����� ������ �������� ������ ������.&/do ������� ������ � ��������.&/todo �������*��������' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}"},
					},
				police = {
					{cmd = 'zd' , description = '����������� ������' , text = '������������ {get_ru_nick({arg_id})}&� {my_ru_nick} - {fraction_rank} {fraction_tag}&��� � ���� ��� ������?', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'mm' , description = '���/���� ������� � �/�' , text = '{switchCarSiren}', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'fara' , description = '�������� ��������� �� ����' , text = '/me ������� � ������������� ��������, ��������� ����� ����, �������� ���������&/do ��������� ������� �������� �� ����� ���� ������������� ��������.', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'pas' , description = '������ ���������� (��)' ,  text = '������������, ���������� {fraction_tag}, � {fraction_rank} {my_ru_nick}&/do C���� �� ����� ����� ������������, ������ ������� ������� � ������.&/me ������ ��� ������������� �� �������&/showbadge {arg_id}&����� ���������� ��������, �������������� ���� ��������.&/n @{get_nick({arg_id})}, ������� /showpass {my_id}' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'ts' , description = '�������� �����' ,  text = '/do ����-������� ���������� � ������� �����.&/writeticket {arg_id} {arg2}&/me ������ ��������� � ���� �������&/todo �������� �����*������ ����-������� ������� � ������' , arg = '{arg_id} {arg2}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'find' , description = '����� ������' ,  text = '/me ������{sex} ���� ��� � ����� � ���� ������ {fraction_tag} ������{sex} ���� ���������� N{arg_id}&/me �����{sex} �� ������ GPS ������������ �������������� ����������&/find {arg_id}' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'pr' , description = '������ �� ������������' ,  text = '/me ������{sex} ���� ��� � ����� � ���� ������ {fraction_tag} ������{sex} ���� ����������� N{arg_id}&/me �����{sex} �� ������ GPS ������������ �������������� ����������&/pursuit}' , arg = '' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'su' , description = '������ ������' ,  text = '/me ������{sex} ���� ��� � ������{sex} ���� ������ ������������&/me ������ ��������� � ���� ������ ������������&/su {arg_id} {arg2} {arg3}&/z {arg_id}&/todo �������, ���������� � �������*������ ���' , arg = '{arg_id} {arg2} {arg3}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'clear' , description = '����� ������' ,  text = '/me ������ ���� ��� � ��������� ���� ������ ������������&/me ����� ���� N{arg_id} ������ ��������� � ���� ������ ������������&/clear {arg_id}&/do ���� N{arg_id} ������ �� ��������� � ������ ������������� ������������.' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},

					{cmd = 'gcuff' , description = '������ ��������� � ����� �� �����' ,  text = '/do ��������� �� ����������� �����.&/todo � ������ �� ��� ���������*������ ��������� � ������������ �����&/cuff {arg_id}&/todo �� ����������*������� ��������� �� ��������&/me ���������� ������������ �� ���� � ���� ��� �� �����&/gotome {arg_id}&/do ����������� ��� � ������.' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}"},
					
					{cmd = 'cuff' , description = '������ ���������' ,  text = '/do ��������� �� ����������� �����.&/todo � ������ �� ��� ���������*������ ��������� � ������������ �����&/cuff {arg_id}&/todo �� ����������*������� ��������� �� ��������' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},
					{cmd = 'uncuff' , description = '����� ���������' ,  text = '/do �� ����������� ����� ����������� ����� �� ����������.&/me ���� � ����� ����� �� ���������� ���������{sex} ����� ���������� ������������&/uncuff {arg_id}&/todo ���� ���� ��������*������ ����� �� ��������� ������� �� ����', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'gtm' , description = '������� �� �����' ,  text = '/me ������ ������� ������������, ����{sex} ��� �� ����&/gotome {arg_id}&/do ����������� ��� � ������.', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'ungtm' , description = '��������� ����� �� �����' ,  text = '/me ��������� ���� ������������ � �������� ����� ��� �� �����&/ungotome {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},

					{cmd = 'bot' , description = '������ ������� � ������ (����� ����������)' ,  text = '/me ������{sex} ��� ����������� ���������� ������� ��� ������ ����������&/todo �� ��� ���� ����������?!*������ ������� � {get_rp_nick({arg_id})}&/bot {arg_id}' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'ss' , description = '��������' ,  text = '/s ���� ������� ���� �����, �������� {fraction_tag}!', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 't' , description = '������� �����' ,  text = '/taser', arg = '', enable = true, waiting = '2.5', bind = "[18,49]" },
					{cmd = 'fris' , description = '�����' ,  text = '/do ��������� �������� �� ����������� �����.&/todo ������ � ��������� ����� ���, �� ������� ����������� ���������*������� ��������� ��������&/me ����������� ���� � ������� ������������ ��������&/me ������ �� �������� ������������ ��� ��� ���� ��� ��������&/me ����������� ����������� ��� ��������� ���� � ������������ ��������&/frisk {arg_id}&/me ������� ��������� �������� � ������� �� �� ����������� �����&/do ������� � ������ � ��������� �������.&/me ����� � ���� ������� � ������, � ���������� ��� ���������� ��� �����&/me ������ �������, ������� ������� � ������ � ��������� ������', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'take' , description = '������� ��������� ������' , text = '/do � �������� ���������� ��������� ���-�����.&/me ������ �� �������� ���-����� � �������� ���&/me ����� � ���-����� ������� �������� ������������ ��������&/take {arg_id}&/do ������� �������� � ���-������.&/todo �������*������ ���-����� � ��������', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true  },
					{cmd = 'camon' , description = '�������� c������ ���� ������' ,  text = '/do � ����� ����������� ������� ���� ������.&/me ���������� ��������� ���� �������{sex} ���� ������.&/do ������� ���� ������ �������� � ������� �� ������������.', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'camoff' , description = '��������� c������ ���� ������' ,  text = '/do � ����� ����������� ������� ���� ������.&/me ���������� ��������� ���� ��������{sex} ���� ������.&/do ������� ���� ������ ��������� � ������ �� ������� �� ������������.', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'inc' , description = '�������� � ���������' ,  text = '/me ��������� ������ ����� ����������&/todo ��������� ������, ����� �����*���������� ������������ � ������������ ��������&/incar {arg_id} {arg2}&/me ��������� ������ ����� ����������&/do ����������� � ������������ ��������.', arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'ej' , description = '��������� �� ����������',  text = '/me ��������� ����� ����������&/me �������� �������� ����� �� ����������&/eject {arg_id}&/me ��������� ����� ����������', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},	
					{cmd = 'pl' , description = '��������� ������ �� ��� ����������',  text = '/me ������ ������ ������� ��������� ����� ���������� ������������&/pull {arg_id}&/me ����������� ������������ �� ��� ���������� � ������ ������� �������� ���', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},	
					{cmd = 'mr' , description = '�������� ������� �������',  text = '������������. �� ��������� ������������ {fraction_tag} �� ��������� ���������������� ������.&��� ������������ �����: ����� �� �������� � ����� �� ��������. ��� ���������� �������� �� ����� ������������.&�� ��������� ���� ����� ���� ������������ ������ ��� � ����.&���� �������� ���������� ������������� � ����������� ���� ������� � ����.&����� ��������. ������� ��������� ������ �� �������� � ���.', arg = '', enable = true, waiting = '2.5', bind = "{}"},	
					{cmd = 'unmask' , description = '����� ��������� � ������',  text = '/do ����������� � ���������.&/me ��������� ��������� � ������ ������������&/unmask {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}" , in_fastmenu = true},
					{cmd = 'arr' , description = '�������� � ���',  text = '/me �������� ���� �������� �������� � ������ ��� ������� ����������&/me ������� � ������ ���������� ���������� ���������� � ��������� ������&/do �������� ���������� ��������.&/me �������� �� ����� �������� ����� ������� � ������� �� ������������ ��������&/arrest', arg = '', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'drugs' , description = '�������� Drugs Test' ,  text = '/do �� ����������� ����� ��������� ��������.&/me ��������� �������� � ������ �� ���� ����� Drugs Test&/me ���� �� ������ �������� � �������� ������&/me �������� ��������� �������� � ��������&/me ������ �� �������� ���� �����-����-10 � ��������� ��� � ��������&/do � �������� � �������� ������� ��������� ����������� �������� � �����-����-10.&/me ����������� ���������� ����������� ��������&/do �� ����� �����-����-10 ���������� �������� �������� ����.&/todo ��, ��� ����� ���������*������ ��� ���������� �������� �������� ����&/me ������� �������� ������� � �������� � ��������� ���', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'rbomb' , description = '�������������� �����' ,  text = '/do �� ����������� ����� ��������� ������� �����.&/me ������� � ����� ������� ����� � ������ ��� �� �����, ����� ��������� ���&/do �������� ������� ����� ��������� �� �����.&/me ������ �� �������� ������ ����� � ������ ������ � ������ ��� �� �����&/me ������ �� �������� ������ �������&/do �������� � �����, � ����� � ������ ������ �� �����.&/do �� ������� ����� ��������� 2 �������.&/me ����������� ������� � ����� � ������� �� ������ � �������� � �������&/me ���������� ��������� ���� ��������� ������ �����&/me ����������� ����������� �����&/do ������ ����� ����� ������������ �����.&/me ������ �� �������� ������ �������&/do ������� � �����.&/me ���������� ��������� ������� ��������� ������� ������ �����&/do ������ �����������, ������� �� ������� ����� �� ������.&/me ���� � ���� ����������� ����� � ������ ������ � ����� ��� ������������ ����� �����&/removebomb&/do ����� �����������.&/me ������� ������� � ������� ������� � �������� ����� � ��������� ���', arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'delo' , description = '������������� ��������' ,  text = '/do ��������� ������ �� ����� ��������.&/todo ����, ��� �� ����� ���������*���������� ����� ��������&/me ����������� �  ������� ��� �����&{pause}&/me ������ �� �������� ����� ��� ������������� � �����&/me ��������� ����� ������������� ��������� ��� ��������� �����&{pause}&/me ���������� � ����� ������ ���� � ����� ��������&{pause}&/do ������� ������ ��������.&/me ���������� � ����� ������ ��������&{pause}&/do ����� ������������� �������� ��������� ��������.&/todo �������, ������������� ��������*������ ����� � ������', arg = '', enable = true, waiting = '2.5', bind = "{}"}
				},
				fbi = {
					{cmd = 'doc', description = '��������� ��������� (���)' ,  text = '������������, � {fraction_rank} {fraction_tag}&/do C���� �� ����� ����-����� ���.&/me ��������� ������� �� ���� ����-����� �� �����&����� ���������� ��������, �������������� ���� ��������.&/n ������� /showpass {my_id}' , arg = '' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'gwarn' , description = '������ ����-�������' ,  text = '/do ��� ���������� �� ������� ���������.&/me ���� � ���� ���� ��� � �������� ���&/me ������ ���� ������ {fraction_tag} ��������� � ������ ���������� ������������ ������ �����������&/me ��������� ���� ������� ���������� � ������ � ���� ���������&/do ��������� ������� ���������.&/gwarn {arg_id} {arg2}&/me ������� � ���� ������ {fraction_tag} � �������� ��� ������� ��� �� ������� ���������', arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'ungwarn' , description = '����� ����-�������' ,  text = '/do ��� ���������� �� ������� ���������.&/me ���� � ���� ���� ��� � �������� ���&/me ������ ���� ������ {fraction_tag} ��������� � ������ ���������� ������������ ������ �����������&/me ��������� ���� ������� ���������� � ������ � ���� ���������&/do ��������� ������� ���������.&/ungwarn {arg_id}&/me ������� � ���� ������ {fraction_tag} � �������� ��� ������� ��� �� ������� ���������', arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'dismiss' , description = '������� ������������ (1-4)' ,  text = '/do ��� ���������� �� ������� ���������.&/me ���� � ���� ���� ��� � �������� ���&/me ������ ���� ������ {fraction_tag} ��������� � ������ ���������� ������������ ������ �����������&/me ��������� ���� ������� ���������� � ������ � ���� ���������&/do ��������� ������� ���������.&/dismiss {arg_id} {arg2}&/me ������� � ���� ������ {fraction_tag} � �������� ��� ������� ��� �� ������� ���������', arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'cuff', description = '������� ��������', text = '/do � ������� ����������� ����� ������.&/me ������ ��������� ���� ������{sex} �� ������� ������&/me ���������� ���� �������� �������� � ��������� �&/cuff {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'uncuff', description = '��������� ��������', text = '/do �� ������ ����� ���������� ����������� ��������� ��� ����.&/me ��������� ������ ���� �������� ���, ���� ��� � ����&/do � ������ ���� ������ ���.&/me ������� � ������ �� �����, �������{sex} ������&/uncuff {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'lead', description = '����� ������ �� �����', text = '/me ��������� ���� ������� �� ������ ������, ���� ��� �� �����&/lead {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'unlead', description = '���������� ����� ������', text = '/me ��������� �������, �������� �������������� ������&/unlead {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'gag', description = '�������� ��� ������ �������', text = '/do �� ����� ���������� �����.&/me ������ ����� ��������� ������, ��������� �����&/do ������ ����� ����� ������.&/me ������� � ������, ������� ������{sex} �� ����� ������&/do ������ � ����� � ���������� ����.&/me ������ ������ �������� ������, ��������{sex} � ��� ������&/gag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}', in_fastmenu = true},
					{cmd = 'ungag', description = '�������� ������ ��� ��� ������', text = '/me ������� ����� � ������, ��������� ������ ���� �������{sex} �� ������ � ������{sex} ����&/ungag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'bag', description = '������ ����� �� ������ ������', text = '/do � ������� ������ ����� �������� �����.&/me ������{sex} �������� ����� �� �������, ���������{sex} ���&/me �������� �������� ����� �� ������ ������, �� ��������� ���&/bag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'unbag', description = '����� ����� � ������ ������', text = '/me ������ ��������� ���� ������� �� �����, �������{sex} ��� �����, ��� ����� ������ ����� � ������ ������&/unbag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}', in_fastmenu = true},
				},
				army = {
					{cmd = 'pas', description = '�������� ���������� (���)', text = '������������, � {fraction_rank} {fraction_tag} - {my_doklad_nick}.&/do ������������� ���������� � ����� ������� ����.&/me ������{sex} ������������� � �������{sex} ��� ����� ���������.&/do � ������������� �������: {fraction} - {fraction_rank} {my_doklad_nick}.&�������� ������� �������� �� ���������� �� ���� ����.&� ������������ ��� ���� ��������� ��� ��������!', arg = '', enable = true, waiting = '2.5', in_fastmenu = true  },
					{cmd = 'agenda' , description = '������ �������� ������' ,  text = '/do � ����� � ����������� ����� ����� � ������ ����� � �������� ��������.&/me ������ �� ����� ����� � ������ ������� ��������&/me �������� ��������� ��� ����������� ���� �� ������ ��������&/do ��� ������ � �������� ���������.&/me ������ �� �������� ����� � ������ {fraction_tag}&/do ������� ����� �������� � �����.&/todo �� �������� ������� � ��������� �� ���������� ������ � �������*��������� ��������&/agenda {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'siren' , description = '���/���� ������� � �/�' , text = '{switchCarSiren}', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
				},
				prison = {
					{cmd = 't' , description = '������� �����' ,  text = '/taser', arg = '', enable = true, waiting = '2.5', },
					{cmd = 'cuff', description = '������ ���������', text = '/do ��������� �� ����������� �����.&/me ������� ��������� � ����� � �������� �� �� ������������&/cuff {arg_id}&/do ����������� � ����������.', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'uncuff', description = '����� ���������', text = '/do �� ����������� ����� ����������� ����� �� ����������.&/me ������� � ����� ���� �� ���������� � ��������� �� � ��������� ������������&/me ������������ ���� � ���������� � ������� �� � ������������&/uncuff {arg_id}&/do ��������� ����� � ������������&/me ����� ���� � ��������� ������� �� ����������� ����', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'gotome', description = '������� �� �����', text = '/me ���������� ������������ �� ���� � ���� ��� �� �����&/gotome {arg_id}&/do ����������� ��� � ������.', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'ungotome', description = '��������� ����� �� �����', text = '/me ��������� ���� ������������ � �������� ����� ��� �� �����&/ungotome {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'take', description = '������� ��������� ������', text = '/do � �������� ���������� ��������� ���-�����.&/me ������ �� �������� ���-����� � �������� ���&/me ����� � ���-����� ������� �������� ������������ ��������&/take {arg_id}&/do ������� �������� � ���-������.&/todo �������*������ ���-����� � ��������', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'carcer', description = '������� ������ � ������',text = '/do �� ����� ����� ������ ������.&/me ��������� ������������ � �����, ���� ���� �� ������, ������ ������ ������&/me ������ ���������� ��� ��������� ������������ � ������, ����� ���� ������ �&/me ������ ���������� ��� �������� ���� � ������&/carcer {arg_id} {arg2} {arg3} {arg4}',arg = '{arg_id} {arg2} {arg3} {arg4}', enable = true, waiting = '2.5'},
					{cmd = 'setcarcer', description = '����� ������� ������', text = '/do �� ����� ����� ������ ������.&/me ������ ���������� ��� ���� ���� �� ������, ������ ��������� ������ � ������ ������������&/me ��������� ������������ �� ������ ������, ��������� �� ������, ������ ����� ����� �����&/me ������ ���������� ��� �������� ���� � ������&/setcarcer {arg_id} {arg2}', arg = '{arg_id}, {arg2}', enable = true, waiting = '2.5'},
					{cmd = 'uncarcer', description = '������ ������ �� �������', text = '/do �� ����� ����� ������ ������.&/me ���������� ��� ���� ���� �� ������, ������ ������ � ��������� �� �� ������������&/me ������ ������ ������, �������� ���� � ������&/uncarcer {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5' },
					{cmd = 'frisk', description = '����� ������������', text = '/do �������� �� �����.&/me ������� �������� � ����&/do �������� �����.&/me ����� ���������� �������� ��������&/frisk {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'punishsu', description = '�������� ������� ���������.', text ='/me ������ ���� ��� � ��������� ���� ������ ������&/me ������ ��������� � ���� ������ ������&/do ��������� �������� � ���� ������ ������.&/punish {arg_id} {arg2} 2 {arg3}', arg = '{arg_id} {arg2} {arg3}', enable = true, waiting = '2.5'},
					{cmd = 'punishclear', description = '�������� ������� ���������', text = '/me ������ ������� �� ���������� �������&/do ������� � ����.&/me ��������� ��� �� �������� � �������� � ��������� �����������.&/do � �������� ����� ������: "{get_rp_nick({arg_id})}, ��������� ���������...&/do ...������� � ������ ����������, ���������� ���������."&/me ���� ����� � ���������� ����� ���������� � �����������.&/do � �������� ��������� ������: "������������ �� ���������� �����...&/do ...�� {arg2} ���� �� �������������� ���������� ������������."&/me ��������� ������� � ������� ��� ������� � ������ �����.&/do ������ � ����������� �������������...&/do ...��� ������������ ������������ ��������������.', arg = '{arg_id} {arg2} {arg3}', enable = true, waiting = '2.5'},
				},
				hospital = {	
					{cmd = 'siren' , description = '���/���� ������� � �/�' , text = '{switchCarSiren}', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'hme' , description = '������� ������ ����' ,  text = '/me ������ �� ������ ���.����� ��������� � ��������� ���&/heal {my_id} {get_price_heal}' , arg = '' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'zd' , description = '���������� ������' , text = '������������ {get_ru_nick({arg_id})}&� {my_ru_nick} - {fraction_rank} {fraction_tag}&��� � ���� ��� ������?', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'go' , description = '������� ������ �� �����' , text = '������ {get_ru_nick({arg_id})}, �������� �� ����.', arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'hl' , description = '������� ������� ������' , text = '/me ������ �� ������ ���.����� ������ ��������� � ������� ��� �������� ��������&/todo ���������� ��� ���������, ��� ��� �������*��������&/heal {arg_id} {get_price_heal}&/n @{get_nick({arg_id})}, ������� ����������� � /offer ����� ����������!', arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'hla' , description = '������� ��������� ������' ,  text = '/me ������ �� ������ ���.����� ��������� � ������� ��� �������� ��������&/todo ������� ������ ��������� ��� ���������, ��� ��� �������*��������&/healactor {arg_id} {get_price_actorheal}&/n @{get_nick({arg_id})}, ������� ����������� � /offer ����� �������� ���������!' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'hlb' , description = '������� ������ �� ����������������' ,  text = '/me ������ �� ������ ���.����� �������� �� ���������������� � ������� �� �������� ��������&/todo ���������� ��� ��������, � � ������ ������� �� ���������� �� ����������������*��������&/healbad {arg_id}&/n @{get_nick({arg_id})}, ������� ����������� � /offer ����� ����������!' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},	
					{cmd = 'mt' , description = '���.�c���� ��� �������� ������' ,  text = '������, ������ � ������� ��� ���.������ ��� ��������� �������� ... &... ������ �� ����� ��������, �� ���� �� ����� ����� 1 �������!&/mticket {arg_id} {get_price_mticket}&/n @{get_nick({arg_id})}, ������� ����������� � /offer ��� ������ ���.�������!' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'pilot' , description = '���.������ ��� �������' ,  text = '������, ������ � ������� ��� ���.������ ��� �������.&/medcheck {arg_id} {get_price_medosm}&/n @{get_nick({arg_id})}, ������� ����������� � /offer ��� ����������� ���.�������!&/n ���� �� �� ������� �����������, �� �� ������ ������!&{pause}&� ���...&/me ������ �� ���.����� ���������� �������� � �������� �� �� ����&/do �������� �� �����.&/todo ����� ���.������*��������.&������ � ������� ���� �����, �������� ��� � �������� ����.&/me ������ �� ���.����� ������� � ������� ��� ����������� ����� �������� ��������&������, ������ ��������� ���, ������ � ������� ���� �����.&/me ��������� ������� �������� �� ����, �������� ������� � �����&/do ������ ���� ������������ �������� ��������.&/todo �������*�������� ������� � ������ ��� � ���.����&����, ������ � ������� ���� ������������, ������� ������������ ������� ������!&/me ������ �� ���.����� ��������� � �������� ��� � ����� �������� ��������� ������������&/do ������������ � ������ 65 ������ � ������.&/todo � ������������� � ��� ��� � �������*������ ��������� ������� � ���.����&/me ������� �� ����� ��� �������������� �������� � ����������� ��&�� ���-� � ���� ��� �������, �� ��������� � ��� ��� � �������, �� ��������!' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'medin' , description = '���������� ������ ���.���������' ,  text = '��� ���������� ���.��������� ��� ���������� �������� ����������� c����.&��������� ������� �� ����� �������� ������� ���.���������.&�� 1 ������ - $4��.���. �� 2 ������ - $8��.���. �� 3 ������ - $1.2��.���.&� ���, �������, �� ����� ���� ��� �������� ���.���������?&{pause}&/me ������ �� ������ ���.����� ������ ����� ���.���������, ����� � ������ {fraction_tag}&/me ��������� ����� ���.��������� � �������� ��� ���������, ����� ������ ������ {fraction_tag}&/me ��������� �������� ����� ���.��������� ������� ����� � ������ ������� � ���� ���.����&/givemedinsurance {arg_id}&/todo ��� ���� ���.���������, ������*���������� ����� � ���.���������� �������� �������� ����&/n @{get_nick({arg_id})}, ������� ����������� � /offer ��� ���������' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'med' , description = '���������� ������ ���.�����' ,  text = '���������� ���. ����� ������� � ������� �� � ����� ��������!&���. ����� �� 7 ���� - ${get_price_med7}, �� 14 ���� - ${get_price_med14}.&���. ����� �� 30 ���� - ${get_price_med30}, �� 60 ���� - ${get_price_med60}.&�������, ��� �� ����� ���� �������� ���. �����?&{show_medcard_menu}&������, ����� ��������� � ����������.&/me ������ �� ������ ���.����� ������ ���.�����, ����� � ������ {fraction_tag}&/me ��������� ������ ���.����� � �������� � ���������, ����� ������ ������ {fraction_tag}&/me ��������� �������� ���.����� ������� ����� � ������ ������� � ���� ���.����&/todo ��� ���� ���.�����, ������*���������� ����������� ���.����� �������� �������� ����&/medcard {arg_id} {get_medcard_status} {get_medcard_days} {get_medcard_price}&/n @{get_nick({arg_id})}, ������� ����������� � /offer ��� ��������� ��������' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'recept' , description = '������ ������ ��������' ,  text = '��������� ������ ������� ���������� ${get_price_recept}&������� ������� ��� ��������� ��������, ����� ���� �� ���������.&/n ��������! � ������� ���� ������� �������� 5 ��������!&{show_recept_menu}&������, ������ � ����� ��� �������.&/me ������ �� ������ ���.����� ����� ��� ���������� �������� � ������ ��� ���������&/me ������ �� ����� ������� ������ {fraction_tag}&/do ����� ������� ��������.&/todo ���, �������!*��������� �����  ������� �������� ��������&/recept {arg_id} {get_recepts}' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'ant' , description = '������ ������ ������������' ,  text = '��������� ������ ����������� ���������� ${get_price_ant}&������� ������� ��� ��������� ������������, ����� ���� �� ���������.&/n ��������! �� ������ ������ �� 1 �� 20 ����������� �� ���� ���!&{show_ant_menu}&������, ������ � ����� ��� �����������.&/me ��������� ���� ���.���� � ������ �� ���� ����� ������������, ����� ���� ��������� ���.����&/do ����������� ��������� � �����.&/todo ��� �������, ������������ �� ������ �� �������!*��������� ����������� �������� ��������&/antibiotik {arg_id} {get_ants}' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'osm' , description = '������ ���.������ ������ (��)' ,  text = '������, ������ � ������� ��� ���.������.&����� ��� ���� ���.����� ��� ��������.&/n @{get_nick({arg_id})}, ������� /showmc {my_id} ����� �������� ��� ���.�����.&{pause}&/me ������ �� ���.����� ���������� �������� � �������� �� �� ����&/do �������� �� �����.&/todo ����� ���.������*��������.&������ � ������� ���� �����, �������� ��� � �������� ����.&/n ����������� /me ������(-�) ��� ���� �� ����������&{pause}&/me ������ �� ���.����� ������� � ������� ��� ����������� ����� �������� ��������&������, ������ ��������� ���, ������ � ������� ���� �����.&/me ��������� ������� �������� �� ����, �������� ������� � �����&/do ������ ���� ������������ �������� ��������.&/todo �������*�������� ������� � ������ ��� � ���.����&����, ������ � ������� ���� ������������, ������� ������������ ������� ������!&/n @{get_nick({arg_id})}, ������� /showtatu ����� ����� ������ �� ��&{pause}&/me ������ �� ���.����� ��������� � �������� ��� � ����� �������� ��������� ������������&/do ������������ � ������ 65 ������ � ������.&/todo � ������������� � ��� ��� � �������*������ ��������� ������� � ���.����&/me ������� �� ����� ��� �������������� �������� � ����������� ��&�� ���-� � ���� ��� �������...&�� ��������� � ��� ��� � �������, �� ��������!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"} , 
					{cmd = 'gd' , description = '���������� ����� (/godeath)' ,  text = '/me ������ �� ������� ���� ������� � ������� � ���� ������ {fraction_tag}&/me ������������� ���������� � �������� ��������� � ���������� ����� ����������� ������&/godeath {arg_id}' , arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'exp' , description = '������� ������ �� ��������' ,  text = '�� ������ �� ������ ����� ����������, � ������� ��� �� ��������!&/me ������� �������� ���� � ������ �� �������� � ��������� �� ��� �����&/expel {arg_id} �.�.�.' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
				},
				smi = {
					{cmd = 'zd', description = '���������� ������' , text = '������������ {get_ru_nick({arg_id})}&� {my_ru_nick} - {fraction_rank} {fraction_tag}&��� � ���� ��� ������?', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},
					{cmd = 'go' , description = '������� ������ �� �����' , text = '������ {get_ru_nick({arg_id})}, �������� �� ����.', arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'expel' , description = '������� ������ �� ������' ,  text = '�� ������ �� ������ ����� ����������, � ������� ��� �� ������!&/me ������� �������� ���� � ������ �� ������ � ��������� �� ��� �����&/expel {arg_id} �.�.�.' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					
				},
				fd = {
					{cmd = 'siren' , description = '���/���� ������� � �/�' , text = '{switchCarSiren}', arg = '' , enable = true , waiting = '2.5', bind = "{}"},
					{cmd = 'zd' , description = '���������� ������' , text = '������������ {get_ru_nick({arg_id})}&� {my_ru_nick} - {fraction_rank} {fraction_tag}&��� � ���� ��� ������?', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}" , in_fastmenu = true},
				},
				lc = {
					{cmd = 'zd' , description = '���������� ������' , text = '������������, � {my_ru_nick} - {fraction_rank} {fraction_tag}&��� � ���� ��� ������? ���� ����� �������� - ������� ��� � ����', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'go', description = '������� ������ �� �����', text = '������ {get_ru_nick({arg_id})}, �������� �� ����.', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'gl' , description = '������ �������� ������' , text = '/me ����{sex} �� ����� ����� �� ��������� �������� � ��������{sex} ���&/do ������ ��������� ����� ����� �� ��������� �������� ��� ��������.&/me ���������� �������� �������{sex} � �������� ��������&/givelicense {arg_id}&��� ���� ��������, ����� ��� ��������!&/n @{get_nick({arg_id})}, ������� ������� /offer ����� �������� ��������!', arg = '{arg_id}' , enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'prices' , description = '���������� ������ � ������' , text = '/todo ������ � ����� ��� ���� �� ��������*�������� ����� ������ ����� � ������&/do ����� � ������ ���� �������� � �����.&/me ��������{sex} ����� ������� � ���� � �����{sex} ������ ����&�� ����������: 1 ����� - ${get_price_avto1}, 2 ������ - ${get_price_avto2}, 3 ������ - ${get_price_avto3}&�� ����: 1 ����� - ${get_price_moto1}, 2 ������ - ${get_price_moto2}, 3 ������ - ${get_price_moto3}&�� ������: 1 ����� - ${get_price_swim1}, 2 ������ - ${get_price_swim2}, 3 ������ - ${get_price_swim3}&�� �����: 1 ����� - ${get_price_fly1}&�� ������: 1 ����� - ${get_price_gun1}, 2 ������ - ${get_price_gun2}, 3 ������ - ${get_price_gun3}&�� �����: 1 ����� - ${get_price_hunt1}, 2 ������ - ${get_price_hunt2}, 3 ������ - ${get_price_hunt3}&�� �������: 1 ����� - ${get_price_fish1}, 2 ������ - ${get_price_fish2}, 3 ������ - ${get_price_fish3}&�� �����: 1 ����� - ${get_price_klad1}, 2 ������ - ${get_price_klad2}, 3 ������ - ${get_price_klad3}&�� �����: 1 ����� - ${get_price_taxi1}, 2 ������ - ${get_price_taxi2}, 3 ������ - ${get_price_taxi3}&�� ��������: 1 ����� - ${get_price_mexa1}, 2 ������ - ${get_price_mexa2}, 3 ������ - ${get_price_mexa3}&/todo ��� ����� � ��� ����*������ ����� � ������' , arg = '' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'medka' , description = '��������� �������� ��� ��������' , text = '����� �������� ��� ��������, �������� ��� ���� ���.�����&/n @{get_nick({arg_id})}, ������� ������� /showmc {my_id} ����� �������� ��� ��������&{pause}&/me ����� �� �������� �������� �������� � ����������� �&/todo ������, ���������*������� �������� ������� ���������' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'exp' , description = '������� ������ �� ��' ,  text = '�� ������ �� ������ ����� ����������, � ������� ��� �� ��!&/me ������� �������� ���� � ������ �� �� � ��������� �� ��� �����&/expel {arg_id} �.�.�.�.' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
				},
				ins = {
					{cmd = 'zd' , description = '���������� ������' , text = '������������, � {my_ru_nick} - {fraction_rank} {fraction_tag}&��� � ���� ��� ������? ���� ����� �������� - ������� ��� � ����', arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'go', description = '������� ������ �� �����', text = '������ {get_ru_nick({arg_id})}, �������� �� ����.', arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'ins' , description = '���������� ���.������' ,  text = '� ���� �������� "�������� ����������" ��� "���������� �����������"&��� ��� �����? ����������� ��� ��������, ���������� ��� ������&/insurance {arg_id}&/me ������ ������ ������ ��� ���������� � ������� �� �������� ��������' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
					{cmd = 'exp' , description = '������� ������ �� ��' ,  text = '�� ������ �� ������ ����� ����������, � ������� ��� �� ��!&/me ������� �������� ���� � ������ �� �� � ��������� �� ��� �����&/expel {arg_id} �.�.�.�.' , arg = '{arg_id}' , enable = true , waiting = '2.5', bind = "{}", in_fastmenu = true},
				},
				gov = {		
					{cmd = 'zd' , description = '���������� ������' , text = '������������, ���� ����� {my_ru_nick}, ��� � ���� ������?', arg = '{arg_id}' , enable = true , waiting = '2.5', in_fastmenu = true},
					{cmd = 'go' , description = '������� ������ �� �����' , text = '������ {get_ru_nick({arg_id})}, �������� �� ����.', arg = '{arg_id}' , enable = true, waiting = '2.5', in_fastmenu = true},
					{cmd = 'freely' , description = '���������� ������ ��������' ,  text = '/do ����� � ����������� ��������� � ����� ����.&/me ������ �����, �������{sex} �� �� ����� ��� ������������ ������������&/me ������ �� ������� �����, ��������{sex} �������� � �������{sex} �������� ��������&/todo ������� ���� ���� ������ � ��������� ������� �����*��������� ���� � ������&/free {arg_id} {arg2}' , arg = '{arg_id} {arg2}' , enable = true, waiting = '2.5'},
					{cmd = 'wed' , description = '����' , text = '������� ����������� � ��������� �����!&������� � ����� ������� � ��������� ���� � ����� �����!&�������� ����� � ��� ������ ����������� ���� ���� ������� ������.&������ �� ������ ���� ���� �� ����, ���� ������� � ������.&������� � ����, �� ����� �� ���� ��������� ���� ���� ����� ������ � ����� ������� ����������.&����� ��� ����������� ���� ��������� ������� �������� � ���� � ����������� ����������.&{pause}&� ������ ��������� �������� ��� ���� ��������������!&����� ���������� ������������ �������� � ���� ������ ����� � ��������.&/wedding {arg_id} {arg2}' , arg = '{arg_id} {arg2}' , enable = true, waiting = '2.5'},
					{cmd = 'frisk', description = '����� (7+)', text = '/do � ������� ��������� ����������� ��������� ��������&/me ������ �������� � ��������� ����� ��&/do �������� ������ �������� ���������&/me ����� ���������� ������, ������ ������������ ���������&/frisk {arg_id}&/me ��������� ���� �������� � ����� �� � ����������� ���������', arg = '{arg_id}', enable = false, waiting = '2.5' },
					{cmd = 'exp' , description = '������� ������ �� �������������' ,  text = '� ���������, �������� ��������� ��� �������� ������ � ����� � ���������� ����������.&/me �������, �� ����� ���� �� ������&/me ���������� � ������&/me ������ ����� � ����� ����� �� �����&/expel {arg_id} ��������� ������ ��������� � ��������������� ����������' , arg = '{arg_id}' , enable = true , waiting = '2.5', in_fastmenu = true},
					{cmd = 'pas' , description = '����� ����������' ,  text = '/do � ��������� ������� ��������� ��������� ���������&/me ������ ���������, ��������� ������� ��&/me ������� ��������� ��� ������������&/do ���������� ������� ���������&/pass {arg_id}' , arg = '{arg_id}' , enable = true , waiting = '2.5', in_fastmenu = true},
					
				},
				mafia = {
					{cmd = 'tie', description = '������� ������', text = '/do � ������� ����������� ����� ������.&/me ������ ��������� ���� ������{sex} �� ������� ������&/me ���������� ���� ������ �������� � ��������� �&/tie {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'untie', description = '��������� ������', text = '/do �� ������ ����� ���������� ����������� ��������� ��� ����.&/me ��������� ������ ���� �������� ���, ���� ��� � ����&/do � ������ ���� ������ ���.&/me ������� � ������ �� �����, �������{sex} ������&/untie {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'lead', description = '����� ������ �� �����', text = '/me ��������� ���� ������� �� ������ ������, ���� ��� �� �����&/lead {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'unlead', description = '���������� ����� ������', text = '/me ��������� �������, �������� �������������� ������&/unlead {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'gag', description = '�������� ��� ������ �������', text = '/do �� ����� ���������� �����.&/me ������ ����� ��������� ������, ��������� �����&/do ������ ����� ����� ������.&/me ������� � ������, ������� ������{sex} �� ����� ������&/do ������ � ����� � ���������� ����.&/me ������ ������ �������� ������, ��������{sex} � ��� ������&/gag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}', in_fastmenu = true},
					{cmd = 'ungag', description = '�������� ������ ��� ��� ������', text = '/me ������� ����� � ������, ��������� ������ ���� �������{sex} �� ������ � ������{sex} ����&/ungag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'bag', description = '������ ����� �� ������ ������', text = '/do � ������� ������ ����� �������� �����.&/me ������{sex} �������� ����� �� �������, ���������{sex} ���&/me �������� �������� ����� �� ������ ������, �� ��������� ���&/bag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}' , in_fastmenu = true},
					{cmd = 'unbag', description = '����� ����� � ������ ������', text = '/me ������ ��������� ���� ������� �� �����, �������{sex} ��� �����, ��� ����� ������ ����� � ������ ������&/unbag {arg_id}', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}', in_fastmenu = true},
					{cmd = 'in�ar', description = '��������� ������ � ������', text = '/me ��������� ����� �������&/me ����� ������ ��� ���� � ����������� ����� ������� � ������&/me ��������� ����� � ������� � ������&/incar {arg_id} 3', arg = '{arg_id}', enable = true, waiting = '2.5', bind = '{}', in_fastmenu = true},
				},
				ghetto = {}
			},
			commands_manage = {
				my = {},
				goss = {
					{cmd = 'inv' , description = '�������� ������ � �����������' , text = '/do � ������� ���� ������ � ������� �� ����������.&/me ������ �� ������� ���� ���� �� ������ ������ �� ����������&/todo ��������, ��� ���� �� ����� ����������*��������� ���� �������� ��������&/invite {arg_id}&/n @{get_nick({arg_id})} , ������� ����������� � /offer ����� �������� ������!' , arg = '{arg_id}', enable = true, waiting = '2.5'  , bind = "{}", in_fastmenu = true  },
					{cmd = 'gr' , description = '���������/��������� c���������' , text = '{show_rank_menu}&/me ������ �� ������� ���� ������� � ������� � ���� ������ {fraction_tag}&/me �������� ���������� � ���������� {get_ru_nick({arg_id})} � ���� ������ {fraction_tag}&/me ������� � ���� ������ � ������� ������� ������� � ������&/giverank {arg_id} {get_rank}&/r ��������� {get_ru_nick({arg_id})} ������� ����� ���������!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },	
					{cmd = 'fmutes' , description = '������ ��� ���������� (10 min)' , text = '/fmutes {arg_id} �.�.&/r ��������� {get_ru_nick({arg_id})} ������� ����� ������������ ����� �� 10 �����!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'funmute' , description = '����� ��� ����������' , text = '/funmute {arg_id}&/r ��������� {get_ru_nick({arg_id})} ������ ����� ������������ ������!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}", in_fastmenu = true   },
					{cmd = 'vig' , description = '������ �������� c���������' , text = '/me ������ �� ������� ���� ������� � ������� � ���� ������ {fraction_tag}&/me �������� ���������� � ���������� {get_ru_nick({arg_id})} � ���� ������ {fraction_tag}&/me ������� � ���� ������ � ������� ������� ������� � ������&/fwarn {arg_id} {arg2}&/r ���������� {get_ru_nick({arg_id})} ����� �������! �������: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'unvig' , description = '������ �������� c���������' , text = '/me ������ �� ������� ���� ������� � ������� � ���� ������ {fraction_tag}&/me �������� ���������� � ���������� {get_ru_nick({arg_id})} � ���� ������ {fraction_tag}&/me ������� � ���� ������ � ������� ������� ������� � ������&/unfwarn {arg_id}&/r ���������� {get_ru_nick({arg_id})} ��� ���� �������!' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}" , in_fastmenu = true  },
					{cmd = 'unv' , description = '���������� ������ �� �������' , text = '/me ������ �� ������� ���� ������� � ������� � ���� ������ {fraction_tag}&/me �������� ���������� � ���������� {get_ru_nick({arg_id})} � ���� ������ {fraction_tag}&/me ������� � ���� ������ � ������� ���� ������� ������� � ������&/uninvite {arg_id} {arg2}&/r ��������� {get_ru_nick({arg_id})} ��� ������ �� �������: {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'point' , description = '��������� ����� ��� �����������' , text = '/r ������ ������������ �� ���, ��������� ��� ����������...&/point' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'govka' , description = '������������� �� ����.�����' , text = '/d [{fraction_tag}] - [����]: ������� ��������������� �����, ������� �� ����������!&/gov [{fraction_tag}]: ������� ������� �����, ��������� ������ ������ �����!&/gov [{fraction_tag}]: ������ �������� ������������� � ����������� {fraction}}&/gov [{fraction_tag}]: ��� ���������� ��� ����� ����� ��������� � �������� � ��� � ����.&/d [{fraction_tag}] - [����]: ����������  ��������������� �����, ������� ��� �� ����������.' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
				},
				goss_fbi = {
					{cmd = 'demoute' , description = '������� ������������' ,  text = '/do ��� ���������� �� ������� ���������.&/me ���� � ���� ���� ��� � �������� ���&/me ������� � ���� ������ {fraction_tag} � ��������� � ������ ���������� ������������ ������ �����������&/me ��������� ���� ������� ���������� � ������ � ���� ���������&/do ��������� ������� ���������.&/demoute {arg_id} {arg2}&/me ������� � ���� ������ {fraction_tag} � �������� ��� ������� ��� �� ������� ���������', arg = '{arg_id} {arg2}', enable = false, waiting = '2.5', bind = "{}"},
				},
				goss_prison = {
					{cmd = 'unpunish', description = '������ ����������� �� ���', text = '/me ������ ���������� ��� ���� ���� ������������ � �����, ����� ��� �� ����&/do �� ����� ����� ����� � ������.&/me ����� ��������� ������ ���� ���� �����, ��������� ���� � ���� ������������&/me ������ ���������� ��� ����� ����� �� ����, ���� ������ � ������ � � ����&/me ������ ���������� ��� ������ ������ �� ����, ����� ���� ��������� ����&��� ���� ��������, ������������� � ������ � �������� ...&... ��������������� �� ���������� ���������� ������.&/unpunish {arg_id} {arg2}', arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'},
					{cmd = 'rjailreklama', description = '������� ���', text = '/rjail ������� ������� ����� �����������.&/rjail � ������ ������ �� ������ �������� ������ ��������, ����� ������� ���������� ������.&/rjail �������� ��������, ��� (������� �������� �����������) �������!&/rjail ������� �� ��������.', arg = '', enable = true, waiting = '2.5'}
				},
				goss_gov = {
					{cmd = 'lic' , description = '������ �������� ��������' , text = '/do ����� ��� ������ �������� ��������� ��� ������.&/me ������� ���� ��� ����, ����{sex} �����, ����� ���� ��������{sex} ��� ������ �����������&/todo ������� ���� ���� ������ � ��������� ������� �����*��������� ����� � �����&/givelicadvokat {arg_id}' , arg = '{arg_id}', enable = true, waiting = '2.5', },
					{cmd = 'demoute' , description = '������� ������������' ,  text = '/do ��� ���������� �� ������� ���������.&/me ���� � ���� ���� ��� � �������� ���&/me ������� � ���� ������ {fraction_tag} � ��������� � ������ ���������� ������������ ������ �����������&/me ��������� ���� ������� ���������� � ������ � ���� ���������&/do ��������� ������� ���������.&/demoute {arg_id} {arg2}&/me ������� � ���� ������ {fraction_tag} � �������� ��� ������� ��� �� ������� ���������', arg = '{arg_id} {arg2}', enable = false, waiting = '2.5', bind = "{}"},
				},
				mafia = {
					{cmd = 'inv' , description = '�������� ������ � �����������' , text = '/do � ������� ���� ������ � ������� �� ����������.&/me ������ �� ������� ���� ���� �� ������ ������ �� ����������&/todo ��������, ��� ���� �� ����� ����������*��������� ���� �������� ��������&/invite {arg_id}&/n @{get_nick({arg_id})} , ������� ����������� � /offer ����� �������� ������!' , arg = '{arg_id}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'rp' , description = '������ ���������� /fractionrp' , text = '/fractionrp {arg_id}' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"},
					{cmd = 'gr' , description = '���������/��������� c���������' , text = '{show_rank_menu}&/todo ��� ���� ����� �����!*���������� ����� �������� �������� &/giverank {arg_id} {get_rank}' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'fmutes' , description = '������ ��� ���������� (10 min)' , text = '/fmutes {arg_id} ������� � ���� ���������' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'funmute' , description = '����� ��� ����������' , text = '/funmute {arg_id}' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'vig' , description = '������ ��������' , text = '/f {get_ru_nick({arg_id})}, �� ����������(-����) � {arg2}!&/fwarn {arg_id} {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5'  , bind = "{}"},
					{cmd = 'unvig' , description = '������ �������� c���������' , text = '/f {get_ru_nick({arg_id})}, �� ������(-�)!&unfwarn {arg_id}' , arg = '{arg_id}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'unv' , description = '���������� ������ �� �������' , text = '/me �������� ��������������� ����� � ��������&/uninvite {arg_id} {arg2}' , arg = '{arg_id} {arg2}', enable = true, waiting = '2.5', bind = "{}"   },
					{cmd = 'point' , description = '���������� ����� ��� �����������' , text = '/f ������ ������������ �� ���, ��������� ��� ����������...&/point' , arg = '', enable = true, waiting = '2.5', bind = "{}"},
				},
				ghetto = {}
			}
		}
	},
	notes = {
		name = '�������',
		path = configDirectory .. "/Notes.json",
		data = {
			{ note_name = '�������� � �������', note_text = '������ ���� �������� ����� ���� ������, ��� �������:&-20 ��������� ���� ���� ����� (���/�����/�������)&-20/-40 ��������� ���� � ��� ���� ��������&-10 ��������� ��-�� ����� ��������� �� ��������&&������� �������� ���� �������� �� �������:&+5 ��������� ���� �� ���������� � �����&+7 ��������� ���� �������� � ����� � ������&+15 ��������� ���� � ��������� ���� \"������� �����\"&+10/+15/+20/+25/+26/+30/+35 ��������� ���� ������ ���������&- ����������� �� ���� ������'},
		}
	},
	rpgun = {
		name = '�� ������',
		path = configDirectory .. "/Guns.json",
		data = {
            rp_guns = {
                {id = 0, name = '������', enable = true, rpTake = 2},
				{id = 1, name = '�������', enable = false, rpTake = 2},
				{id = 2, name = '������ ��� ������', enable = false, rpTake = 1},
				{id = 3, name = '�������', enable = true, rpTake = 3},
				{id = 4, name = '������ ���', enable = false, rpTake = 3},
				{id = 5, name = '����', enable = false, rpTake = 1},
				{id = 6, name = '������', enable = true, rpTake = 1},
				{id = 7, name = '���', enable = false, rpTake = 1},
				{id = 8, name = '������', enable = false, rpTake = 1},
				{id = 9, name = '���������', enable = false, rpTake = 1},
				{id = 10, name = '�������', enable = false, rpTake = 2},
				{id = 11, name = '������� �������', enable = false, rpTake = 2},
				{id = 12, name = '�������� �������', enable = false, rpTake = 2},
				{id = 13, name = '������� �������', enable = false, rpTake = 2},
				{id = 14, name = '����� ������', enable = true, rpTake = 1},
				{id = 15, name = '������', enable = false, rpTake = 1},
				{id = 16, name = '���������� �������', enable = false, rpTake = 3},
				{id = 17, name = '������� �������', enable = true, rpTake = 3},
				{id = 18, name = '�������� ��������', enable = true, rpTake = 3},
				{id = 22, name = '�������� Colt45', enable = false, rpTake = 4},
				{id = 23, name = "������������ Taser X26P", enable = true, rpTake = 4},
				{id = 24, name = '�������� Desert Eagle', enable = true, rpTake = 4},
				{id = 25, name = '��������', enable = true, rpTake = 1},
				{id = 26, name = '�����', enable = true, rpTake = 4},
				{id = 27, name = '���������� �����', enable = false, rpTake = 1},
				{id = 28, name = '�� Micro Uzi', enable = true, rpTake = 3},
				{id = 29, name = '�� MP5', enable = true, rpTake = 4},
				{id = 30, name = '������� AK47', enable = true, rpTake = 1},
				{id = 31, name = '������� M4', enable = true, rpTake = 1},
				{id = 32, name = '�� Tec9', enable = true, rpTake = 4},
				{id = 33, name = '�������� Rifle', enable = true, rpTake = 1},
				{id = 34, name = '����������� ��������', enable = true, rpTake = 1},
				{id = 35, name = '���', enable = false, rpTake = 1},
				{id = 36, name = '����', enable = false, rpTake = 1},
				{id = 37, name = '������', enable = false, rpTake = 1},
				{id = 38, name = '�������', enable = false, rpTake = 1},
				{id = 39, name = '�������', enable = false, rpTake = 3},
				{id = 40, name = '���������', enable = false, rpTake = 3},
				{id = 41, name = '�������� ��������', enable = true, rpTake = 2},
				{id = 42, name = '������������', enable = true, rpTake = 1},
				{id = 43, name = '����������', enable = true, rpTake = 2},
				{id = 44, name = '���', enable = false, rpTake = 3},
				{id = 45, name = '����������', enable = false, rpTake = 3},
				{id = 46, name = '�������', enable = true, rpTake = 1},
				-- gta sa damage reason
				{id = 49, name = '�/�', rpTake = 1},
				{id = 50, name = '������� ��������', rpTake = 1},
				{id = 51, name = '�������', rpTake = 1},
				{id = 54, name = '��������/������', rpTake = 1},
				-- ARZ CUSTOM GUN
				{id = 71, name = '�������� Desert Eagle Steel', enable = true, rpTake = 4},
				{id = 72, name = '�������� Desert Eagle Gold', enable = true, rpTake = 4},
				{id = 73, name = '�������� Glock Gradient', enable = true, rpTake = 4},
				{id = 74, name = '�������� Desert Eagle Flame', enable = true, rpTake = 4},
				{id = 75, name = '�������� Python Royal', enable = true, rpTake = 4},
				{id = 76, name = '�������� Python Silver', enable = true, rpTake = 4},
				{id = 77, name = '������� AK-47 Roses', enable = true, rpTake = 1},
				{id = 78, name = '������� AK-47 Gold', enable = true, rpTake = 1},
				{id = 79, name = '������ M249 Graffiti', enable = true, rpTake = 1},
				{id = 80, name = '������� �����', enable = true, rpTake = 1},
				{id = 81, name = '�� Standart', enable = true, rpTake = 4},
				{id = 82, name = '������ M249', enable = true, rpTake = 1},
				{id = 83, name = '�� Skorp', enable = true, rpTake = 4},
				{id = 84, name = '������� AKS74 �����������', enable = true, rpTake = 1},
				{id = 85, name = '������� AK47 �����������', enable = true, rpTake = 1},
				{id = 86, name = '�������� Rebecca', enable = true, rpTake = 1},
				{id = 87, name = '���������� �����', enable = true, rpTake = 1},
				{id = 88, name = '������� ���', enable = true, rpTake = 1},
				{id = 89, name = '���������� �����', enable = true, rpTake = 4},
				{id = 90, name = '���������� �������', enable = true, rpTake = 3},
				{id = 91, name = '����������� �������', enable = true, rpTake = 3},
				{id = 92, name = '����������� �������� TAC50', enable = true, rpTake = 1},
				{id = 93, name = '���������� ��������', enable = true, rpTake = 4},
				{id = 94, name = '������� �����', enable = true, rpTake = 1},
				{id = 95, name = '���������� �������', enable = true, rpTake = 3},
				{id = 96, name = '������� M4 Gold', enable = true, rpTake = 1},
				{id = 97, name = '���������� ��������', enable = true, rpTake = 1},
				{id = 98, name = '�� Uzi Graffiti', enable = true, rpTake = 4},
				{id = 99, name = '������� ����������', enable = true, rpTake = 1},
				{id = 100, name = '���� Compton', enable = true, rpTake = 1},
				{id = 101, name = '�������� SciFi Deagle', enable = true, rpTake = 4},
				{id = 102, name = '������� SciFi AK47', enable = true, rpTake = 1},
				{id = 103, name = '�������� SciFi', enable = true, rpTake = 1},
				{id = 104, name = '��� SciFi', enable = true, rpTake = 3},
				{id = 106, name = '������� ���', enable = true, rpTake = 3},
            },
            rpTakeNames = {
				{"��-�� �����", "�� �����"},
				{"�� �������", "� ������"},
				{"�� �����", "�� ����"},
				{"�� ������", "� ������"}
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
		name = '����� ������',
		path = configDirectory .. "/SmartUK.json",
		data = {}
	},
    smart_pdd = {
		name = '����� ������',
		path = configDirectory .. "/SmartPDD.json",
		data = {}
	},
    smart_rptp = {
		name = '����� ����',
		path = configDirectory .. "/SmartRPTP.json",
		data = {}
	},
	arz_veh = {
		name = '���������',
		path = configDirectory .. "/Vehicles.json",
		data = {},
		cache = {}
	}
}
function load_module(key)
    local obj = modules[key]
	if not obj then
		print('������: ����������� ������ "' .. key .. '"!')
	else
		if doesFileExist(obj.path) then
			local file, errstr = io.open(obj.path, 'r')
			if file then
				local contents = file:read('*a')
				file:close()
				if #contents == 0 then
					print('�� ������� ������� ������ "' .. obj.name .. '". �������: ���� ������')
				else
					local result, loaded = pcall(decodeJson, contents)
					if result then
						obj.data = loaded
						print('������ "' .. obj.name .. '" ���������������! (���� ���� ��������� ������)')
					else
						print('�� ������� ������� ������ "' .. obj.name .. '". ������: decode json')
					end
				end
			else
				print('�� ������� ������� ������ "' .. obj.name .. '". ������: ' .. tostring(errstr or "�����������"))
			end
		else
			print('������ "' .. obj.name .. '" ���������������!')
		end
	end
end
function save_module(key)
    local obj = modules[key]
	if not obj then
		print('������: ����������� ������ "' .. key .. '"!')
	else
		local file, errstr = io.open(obj.path, 'w')
		if file then
			local function looklike(array)
				local dkok, dkjson = pcall(require, "dkjson")
				if dkok then
					local ok, encoded = pcall(dkjson.encode, array, {indent = true})
					if ok then return encoded end
				end
				local ok, encoded = pcall(encodeJson, array)
				if ok then return encoded else return {} end
			end
			local content = looklike(obj.data)
			if #content ~= 0 then
				file:write(content)
				print('������ "' .. obj.name .. '" �������!')
			else
				print('�� ������� ��������� ������ "' .. obj.name .. '" - ������ ��������� json!')
			end
			file:close()
		else
			print('�� ������� ��������� ������ "' .. obj.name .. '", ������: ' .. tostring(errstr or "�����������"))
		end
	end
end
------------------------------------------- MonetLoader --------------------------------------------------

if not settings.general.autofind_dpi then
	print('���������� ����-������� �������...')
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
	print('����������� ��������: ' .. settings.general.custom_dpi)
	print('�� � ����� ������ ������ �������� �������� � ����������!')
	save_settings()
end
----------------------------------------------- Functions -----------------------------------------------------
function isMode(mode_type)
	return settings.general.fraction_mode == mode_type
end
function add_notes(module)
	local situate_codes = { note_name = '������������ ����', note_text = 'CODE 0 - ������ �����.&CODE 1 - ������ � ����������� ���������, ����� ������ ���� ������.&CODE 2 - ������� ����� [��� �����/������������/���������� ���].&CODE 2 HIGHT - ������������ ����� [��� �����/������������/���������� ���].&CODE 3 - ������� ����� [������, �����������, ������������� ���].&CODE 4 - ���������, ������ �� ���������.&Code 4 ADAM - ������ �� ���������, �� ������� ���������� ������ ���� ������ ������� ������.&CODE 5 - �������� ��������� �������� �� �������� �����.&CODE 6 - ������������ �� ����� [������� ������� � �������,��������, 911].&CODE 7 - ������� �� ����.&CODE 30 - ������������ "�����" ������������ �� ����� ������������.&CODE 30 RINGER - ������������ "������� ������������ �� ����� ������������.&CODE 37 - ����������� ��������� �/c.&�ode TOM - ������� ��������� ������.' }
	table.insert(modules.notes.data, situate_codes)

	local teen_codes = { note_name = '���-����', note_text = '10-1 - ���� ���� �������� �� ���������.&10-2 - ����� � �������.&10-2R - �������� �������.&10-3 - �������������.&10-4 - �������.&10-5 - ���������.&10-6 - �� �������/�������/���.&10-7 - ��������.&10-8 - �� ��������/�����.&10-14 - ������ ���������������.&10-15 - ������������� ����������.&10-18 - ��������� ��������� �������������� ������.&10-20 - �������.&10-21 - ������ � ���������������.&10-22 - ������������ � �������.&10-27 - ����� ���������� �������.&10-30 - �������-������������ ������������.&10-40 - ������� ��������� ����� (����� 4).&10-41 - ����������� ����������.&10-46 - ������� �����.&10-55 - ������� ����.&10-57 VICTOR - ������ �� �����������.&10-57 FOXTROT - ����� ������.&10-66 - ������� ���� ����������� �����.&10-70 - ������ ���������.&10-71 - ������ ����������� ���������.&10-88 - ������/��.&10-99 - �������� �������������.&10-100 �������� ���������� ��� �������.' }
	table.insert(modules.notes.data, teen_codes)

	if module ~= 'prison' then
		local markup_patrool = { note_name = '���������� �������', note_text = '��������:&ADAM [A] - ������� �� 2/3 �������� �� �������.&LINCOLN [L] - ��������� ������� �� �������.&MARY [M] - ��������� ������� �� ���������.&HENRY [H] - ��������������� �������.&AIR [AIR] - ��������� �������.&Air Support Division [ASD] - ��������� ���������.&&��������������:&CHARLIE [C] - ������ �������.&ROBERT [R] - ����� ����������.&SUPERVISOR [SV] - ����������� ������.&DAVID [D] - C���������� ����� SWAT.&EDWARD [E] - ��������� �������.&NORA [N] - ��������������� ������� �������.'}
		table.insert(modules.notes.data, markup_patrool)
	end

	save_module('notes')
end
--------------------------------------------- GUI & Functions -------------------------------------------------
local InititalWindow = imgui.new.bool()

local MainWindow = imgui.new.bool()
local theme = imgui.new.int(tonumber(settings.general.helper_theme))
local slider_dpi = imgui.new.float(tonumber(settings.general.custom_dpi))
local input = imgui.new.char[256]()
local slider = imgui.new.int(0)

local checkbox = {
    accent_enable = imgui.new.bool(settings.player_info.accent_enable),
    mobile_stop_button = imgui.new.bool(settings.general.mobile_stop_button),
    mobile_fastmenu_button = imgui.new.bool(settings.general.mobile_fastmenu_button),
    auto_update_members = imgui.new.bool(settings.general.auto_update_members),
    auto_notify_payday = imgui.new.bool(settings.general.auto_notify_payday),
    auto_accept_docs = imgui.new.bool(settings.general.auto_accept_docs),
    -- auto_clicker_situation = imgui.new.bool((settings.mj.auto_clicker_situation or settings.mh.auto_clicker_situation)),
	dep_anti_skobki = imgui.new.bool(settings.deportament.anti_skobki),
    -- MJ
    auto_change_code_siren = imgui.new.bool(settings.mj.auto_change_code_siren),
    auto_doklad_patrool = imgui.new.bool(settings.mj.auto_doklad_patrool),
    auto_doklad_damage = imgui.new.bool(settings.mj.auto_doklad_damage),
    auto_doklad_arrest = imgui.new.bool(settings.mj.auto_doklad_arrest),
    auto_time = imgui.new.bool(settings.mj.auto_time),
    auto_update_wanteds = imgui.new.bool(settings.mj.auto_update_wanteds),
    auto_case_documentation = imgui.new.bool(settings.mj.auto_case_documentation),
    auto_mask = imgui.new.bool(settings.mj.auto_mask),
    awanted = imgui.new.bool(settings.mj.awanted),
    mobile_taser_button = imgui.new.bool(settings.mj.mobile_taser_button),
    mobile_meg_button = imgui.new.bool(settings.mj.mobile_meg_button),
	-- MD
	auto_doklad_patrool = imgui.new.bool(settings.md.auto_doklad_patrool),
    auto_doklad_damage = imgui.new.bool(settings.md.auto_doklad_damage),
}

-- MH
local get_price_mh = {
    heal = imgui.new.char[256](u8(settings.mh.price.heal)),
    heal_vc = imgui.new.char[256](u8(settings.mh.price.heal_vc)),
    healactor = imgui.new.char[256](u8(settings.mh.price.healactor)),
    healactor_vc = imgui.new.char[256](u8(settings.mh.price.healactor_vc)),
    medosm = imgui.new.char[256](u8(settings.mh.price.medosm)),
    mticket = imgui.new.char[256](u8(settings.mh.price.mticket)),
    recept = imgui.new.char[256](u8(settings.mh.price.recept)),
    ant = imgui.new.char[256](u8(settings.mh.price.ant)),
    healbad = imgui.new.char[256](u8(settings.mh.price.healbad)),
    med7 = imgui.new.char[256](u8(settings.mh.price.med7)),
    med14 = imgui.new.char[256](u8(settings.mh.price.med14)),
    med30 = imgui.new.char[256](u8(settings.mh.price.med30)),
    med60 = imgui.new.char[256](u8(settings.mh.price.med60))
}
local medCard = {
	menu = imgui.new.bool(),
	days = imgui.new.int(3),
	status = imgui.new.int(3)
}
local recept = {
	menu = imgui.new.bool(),
	recepts = imgui.new.int(1)
}
local antibiotik = {
	menu = imgui.new.bool(),
	ants = imgui.new.int(1)
}
local heal_in_chat = {
	fast_menu = imgui.new.bool(),
	bool = false,
	player_id = nil,
	worlds = {'������', '����', '���', '���', 'heal', 'hil', 'lek', '����', '�����', '������', '�����' , 'ktr', 'ktxb', 'ujkjdf'}
}
-- LC
local get_price_lc = {
    avto1 = imgui.new.char[256](u8(settings.lc.price.avto1)),
    avto2 = imgui.new.char[256](u8(settings.lc.price.avto2)),
    avto3 = imgui.new.char[256](u8(settings.lc.price.avto3)),
    moto1 = imgui.new.char[256](u8(settings.lc.price.moto1)),
    moto2 = imgui.new.char[256](u8(settings.lc.price.moto2)),
    moto3 = imgui.new.char[256](u8(settings.lc.price.moto3)),
    fish1 = imgui.new.char[256](u8(settings.lc.price.fish1)),
    fish2 = imgui.new.char[256](u8(settings.lc.price.fish2)),
    fish3 = imgui.new.char[256](u8(settings.lc.price.fish3)),
    swim1 = imgui.new.char[256](u8(settings.lc.price.swim1)),
    swim2 = imgui.new.char[256](u8(settings.lc.price.swim2)),
    swim3 = imgui.new.char[256](u8(settings.lc.price.swim3)),
    gun1 = imgui.new.char[256](u8(settings.lc.price.gun1)),
    gun2 = imgui.new.char[256](u8(settings.lc.price.gun2)),
    gun3 = imgui.new.char[256](u8(settings.lc.price.gun3)),
    hunt1 = imgui.new.char[256](u8(settings.lc.price.hunt1)),
    hunt2 = imgui.new.char[256](u8(settings.lc.price.hunt2)),
    hunt3 = imgui.new.char[256](u8(settings.lc.price.hunt3)),
    klad1 = imgui.new.char[256](u8(settings.lc.price.klad1)),
    klad2 = imgui.new.char[256](u8(settings.lc.price.klad2)),
    klad3 = imgui.new.char[256](u8(settings.lc.price.klad3)),
    taxi1 = imgui.new.char[256](u8(settings.lc.price.taxi1)),
    taxi2 = imgui.new.char[256](u8(settings.lc.price.taxi2)),
    taxi3 = imgui.new.char[256](u8(settings.lc.price.taxi3)),
    mexa1 = imgui.new.char[256](u8(settings.lc.price.mexa1)),
    mexa2 = imgui.new.char[256](u8(settings.lc.price.mexa2)),
    mexa3 = imgui.new.char[256](u8(settings.lc.price.mexa3)),
    fly1 = imgui.new.char[256](u8(settings.lc.price.fly1)),
    fly2 = imgui.new.char[256](u8(settings.lc.price.fly2)),
    fly3 = imgui.new.char[256](u8(settings.lc.price.fly3))
}



local DeportamentWindow = imgui.new.bool()
local inputs_dep = {
    fm      = imgui.new.char[32](u8(settings.deportament.dep_fm)),
    text    = imgui.new.char[256](),
    tag1    = imgui.new.char[32](u8(settings.deportament.dep_tag1)),
    tag2    = imgui.new.char[32](u8(settings.deportament.dep_tag2)),
    new_tag = imgui.new.char[32]()
}

local members = {
	menu = imgui.new.bool(),
	all = {},
	new = {},
	upd = {},
	info = {fraction = '', check = false},
}


local GiveRankMenu = imgui.new.bool()
local giverank = imgui.new.int(5)

local CommandStopWindow = imgui.new.bool()
local CommandPauseWindow = imgui.new.bool()
local LeaderFastMenu = imgui.new.bool()
local FastMenu = imgui.new.bool()
local FastPieMenu = imgui.new.bool()
local FastMenuButton = imgui.new.bool()
local FastMenuPlayers = imgui.new.bool()

local SobesMenu = imgui.new.bool()

local NoteWindow = imgui.new.bool()

local UpdateWindow = imgui.new.bool()
local update = {
	is_need_update = false,
	version = "",
	url = "",
	info = ""
}
local download_file = ""

local BinderWindow = imgui.new.bool()
local waiting_slider = imgui.new.float(0)
local ComboTags = imgui.new.int()
local item_list = {
	u8('��� ����������'),
	u8('{arg} - ����� ��������'),
	u8('{arg_id} - ID ������ - �������� /cure 429'),
	u8('{arg_id} {arg2} - ID ������ � ����� �������� - �������� /vig 429 ��� ��������'),
	u8('{arg_id} {arg2} {arg3} - ID ������, �����, � ����� �������� - �������� /su 429 2 ������������'),
	u8('{arg_id} {arg2} {arg3} {arg4} - ID ������, ����� � ��� ����� ��������� - �������� /carcer 429 1 5 �.�.')
}
local ImItems = imgui.new['const char*'][#item_list](item_list)
local binder_data = {change_waiting = nil, change_cmd = nil, change_text = nil, change_arg = nil, change_bind = nil, change_in_fastmenu = false, create_command_9_10 = false, input_description = nil}
local binder_tags_text = [[
{my_id} - ��� ID
{my_nick} - ��� ������� 
{my_rp_nick} - ��� ������� ��� _
{my_ru_nick} - ���� ��� � �������
{my_doklad_nick} - ������ ����� ������ ����� � �������

{fraction} - ���� �������
{fraction_rank} - ���� ����������� ���������
{fraction_tag} - ��� ����� �������

{sex} - ��������� ����� "�" ���� � ������� ������ ������� ���

{get_time} - �������� ������� �����
{get_city} - �������� ������� �����
{get_square} - �������� ������� �������
{get_area} - �������� ������� �����
{get_storecar_model} - �������� ������ ���������� � ��� ���� � ���������

{get_nick({arg_id})} - �������� ������� �� ��������� ID ������
{get_rp_nick({arg_id})} - �������� ������� ��� ������� _ �� ��������� ID ������
{get_ru_nick({arg_id})} - �������� ������� �� �������� �� ��������� ID ������ 

{get_price_heal} - ���� ������� ���������
{get_price_healbad} - ���� ������� �� ����������������
{get_price_actorheal} - ���� ������� ����������
{get_price_medosm} - ���� ���.������� ��� ������
{get_price_mticket} - ���� ������������ �������� ������
{get_price_ant} - ���� �����������   
{get_price_recept} - ���� �������
{get_price_med7} - ���� ��������� �� 7 ����   
{get_price_med14} - ���� ��������� �� 14 ����
{get_price_med30} - ���� ��������� �� 30 ����   
{get_price_med60} - ���� ��������� �� 60 ����

{show_medcard_menu} - ������� ���� ���.�����
{get_medcard_days} - �������� ����� ���������� ���-�� ����
{get_medcard_status} - �������� ����� ���������� �������
{get_medcard_price} - �������� ���� ���.����� ������ �� ����
{show_recept_menu} - ������� ���� ������ ��������
{get_recepts} - �������� ���-�� ��������� ��������
{show_ant_menu} - ������� ���� ������ ������������ 
{get_ants} - �������� ���-�� ��������� ������������
{lmenu_vc_vize} - ����-������ ���� Vice City
{give_platoon} - ��������� ����� ������
{show_rank_menu} - ������� ���� ������ ������
{get_rank} - �������� ��������� ����

{pause} - ��������� ��������� ������� �� ����� � ������� ��������]]

local RPWeaponWindow = imgui.new.bool()
local ComboTags2 = imgui.new.int()
local item_list2 = {u8'�����', u8'������', u8'����', u8'������'}
local ImItems2 = imgui.new['const char*'][#item_list2](item_list2)

local MegafonWindow = imgui.new.bool()

local TaserWindow = imgui.new.bool()

local WantedWindow = imgui.new.bool()

local updwanteds = {}
local wanted = {}
local wanted_new = {}
local check_wanted = false
local search_awanted = false

local PostMenu = imgui.new.bool()
local PatroolMenu = imgui.new.bool()
local patrool = {
	start_time = 0,
	current_time = 0,
	time = 0,
	code = 'CODE 4',
	mark = 'ADAM',
	name = '',
	active = false
}
local ComboPatroolMark = imgui.new.int(0)
local combo_patrool_mark_list = {'ADAM', 'LINCOLN', 'MARY', 'HENRY', 'AIR', 'ASD', 'CHARLIE', 'ROBERT', 'SUPERVISOR', 'DAVID', 'EDWARD', 'NORA'}
local ImItemsPatroolMark = imgui.new['const char*'][#combo_patrool_mark_list](combo_patrool_mark_list)
local ComboPatroolCode = imgui.new.int(5)
local combo_patrool_code_list = {'CODE 0', 'CODE 1', 'CODE 2', 'CODE 2 HIGHT', 'CODE 3', 'CODE 4', 'CODE 4 ADAM', 'CODE 5', 'CODE 6', 'CODE 7', 'CODE 30', 'CODE 30 RINGER', 'CODE 37', 'CODE TOM'}
local ImItemsPatroolCode = imgui.new['const char*'][#combo_patrool_code_list](combo_patrool_code_list)

local SumMenuWindow = imgui.new.bool()
local form_su = ''
local TsmMenuWindow = imgui.new.bool()

local PuMenuWindow = imgui.new.bool()


local ProbivMenu = imgui.new.bool()
local input_probiv_key = imgui.new.char[128]()

-------------------------------------------- Init Colors (MoonMonet) ----------------------------------------------------
function rgbToHex(rgb)
	local r = bit.band(bit.rshift(rgb, 16), 0xFF)
	local g = bit.band(bit.rshift(rgb, 8), 0xFF)
	local b = bit.band(rgb, 0xFF)
	local hex = string.format("%02X%02X%02X", r, g, b)
	return hex
end
if settings.general.helper_theme == 0 then
	if monet_no_errors then
		message_color = settings.general.moonmonet_theme_color
		message_color_hex = '{' ..  rgbToHex(settings.general.moonmonet_theme_color) .. '}'
		theme[0] = 0
	else
		print('������: ���� ���������� MoonMonet! ������ Dark Theme �� �������')
		settings.general.helper_theme = 1
		message_color = settings.general.message_color
		message_color_hex = '{' ..  rgbToHex(settings.general.message_color) .. '}'
		save_settings()
		theme[0] = 1
	end
else
	message_color = settings.general.message_color
	message_color_hex = '{' ..  rgbToHex(settings.general.message_color) .. '}'
	theme[0] = (settings.general.helper_theme == 1 and 1 or 2)
end
local tmp = imgui.ColorConvertU32ToFloat4(settings.general.moonmonet_theme_color)
local mmcolor = imgui.new.float[3](tmp.z, tmp.y, tmp.x)
tmp = imgui.ColorConvertU32ToFloat4(settings.general.message_color)
local msgcolor = imgui.new.float[3](tmp.z, tmp.y, tmp.x)
------------------------------------------- Mimgui Hotkey  ---------------------------------------------------
local hotkeys = {}
if not isMonetLoader() then
	if hotkey_no_errors and not isMode('') then
		hotkey.Text.NoKey = u8'< click and select keys >'
		hotkey.Text.WaitForKey = u8'< wait keys >'
		MainMenuHotKey = hotkey.RegisterHotKey('Open MainMenu', false, decodeJson(settings.general.bind_mainmenu), function()
			if not MainWindow[0] then
				MainWindow[0] = true
			end
		end)
		CommandStopHotKey = hotkey.RegisterHotKey('Stop Command', false, decodeJson(settings.general.bind_command_stop), function() 
			sampProcessChatInput('/stop')
		end)
		FastMenuHotKey = hotkey.RegisterHotKey('Open FastMenu', false, decodeJson(settings.general.bind_fastmenu), function() 
			local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
			if valid and doesCharExist(ped) then
				local result, id = sampGetPlayerIdByCharHandle(ped)
				if result and id ~= -1 and not LeaderFastMenu[0] then
					show_fast_menu(id)
				end
			end
		end)
		LeaderFastMenuHotKey = hotkey.RegisterHotKey('Open LeaderFastMenu', false, decodeJson(settings.general.bind_leader_fastmenu), function() 
			if settings.player_info.fraction_rank_number >= 9 then 
				local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
				if valid and doesCharExist(ped) then
					local result, id = sampGetPlayerIdByCharHandle(ped)
					if result and id ~= -1 and not FastMenu[0] then
						show_leader_fast_menu(id)
					end
				end
			end
		end)
		
		ActionHotKey = hotkey.RegisterHotKey('Action Key', false, decodeJson(settings.general.bind_action), function() 
			if isMode('hospital') then 
				if heal_in_chat.bool and heal_in_chat.player_id ~= nil and not sampIsDialogActive() and not sampIsChatInputActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then
					find_and_use_command("/heal {arg_id}", heal_in_chat.player_id)
					heal_in_chat.bool = false
					heal_in_chat.player_id = nil
				end
			end
		end)

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
			for _, command in ipairs(modules.commands.data.commands.my) do
				updateHotkeyForCommand(command)
			end
			for _, command in ipairs(modules.commands.data.commands_manage.my) do
				updateHotkeyForCommand(command)
			end
		end
		function updateHotkeyForCommand(command)
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
				print('������ ������ ��� ������� /' .. command.cmd .. ' �� ������� ' .. getNameKeysFrom(command.bind))
				sampAddChatMessage('[Rodina Helper] {ffffff}������ ������ ��� ������� ' .. message_color_hex .. '/' .. command.cmd .. ' {ffffff}�� ������� '  .. message_color_hex .. getNameKeysFrom(command.bind), message_color)
			end
		end
		addEventHandler('onWindowMessage', function(msg, key, lparam)
			if msg == 641 or msg == 642 or lparam == -1073741809 then hotkey.ActiveKeys = {} end
			if msg == 0x0005 then hotkey.ActiveKeys = {} end
		end)
	end
end
-------------------------------------------- RP GUNS INIT ---------------------------------------------
function initialize_guns()
    for i, weapon in pairs(modules.rpgun.data.rp_guns) do
        local rpTakeType = modules.rpgun.data.rpTakeNames[weapon.rpTake]
		local id = weapon.id
        modules.rpgun.data.gunActions.partOn[id] = rpTakeType[1]
        modules.rpgun.data.gunActions.partOff[id] = rpTakeType[2]
        if id == 3 or (id > 15 and id < 19) or (id == 90 or id == 91) then
            modules.rpgun.data.gunActions.on[id] = (settings.player_info.sex == "�������") and "�����" or "����"
        else
            modules.rpgun.data.gunActions.on[id] = (settings.player_info.sex == "�������") and "�������" or "������"
        end
        if id == 3 or (id > 15 and id < 19) or (id > 38 and id < 41) or (id == 90 or id == 91) then
            modules.rpgun.data.gunActions.off[id] = (settings.player_info.sex == "�������") and "��������" or "�������"
        else
            modules.rpgun.data.gunActions.off[id] = (settings.player_info.sex == "�������") and "������" or "�����"
        end
    end
end
function get_name_weapon(id) 
    for _, weapon in ipairs(modules.rpgun.data.rp_guns) do
        if weapon.id == id then
            return weapon.name
        end
    end
    return "������"
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
    sampAddChatMessage('[Rodina Helper] {ffffff}���������� ����� ������ � ID ' .. message_color_hex .. weaponId .. '{ffffff}, ��� ��� ��� "������" � ������������ "�����".', message_color)
    sampAddChatMessage('[Rodina Helper] {ffffff}�������� ��� ��� ������������ ������ �� ������ � /helper - ������� ���� - ����� RP ��������� ������ - ���������', message_color)
    table.insert(modules.rpgun.data.rp_guns, {id = weaponId, name = "������", enable = true, rpTake = 1})
	save_module('rpgun')
    initialize_guns()
end
function processWeaponChange(oldGun, nowGun)
    if not modules.rpgun.data.gunActions.off[oldGun] or not modules.rpgun.data.gunActions.on[nowGun] then
        sampAddChatMessage('������ ��������� ������', -1)
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
			sampSendChat(string.format("/me %s %s %s, ����� ���� %s %s %s",
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
------------------------------------------ Variables ---------------------------------------------------------
local binderTags = {
	my_id = function()
		if isMonetLoader() then
			local id = sampGetPlayerIdByNickname(ReverseTranslateNick(settings.player_info.name_surname))
			if id == nil then print('�� ������� �������� ��� ID, �������� ��� � ������� � ������� ����!') end
			return id or 'ID'
		else
			return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
		end
	end,
    my_nick = function()
		if isMonetLoader() then
			return ReverseTranslateNick(settings.player_info.name_surname)
		else
			return sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
		end
	end,
    my_rp_nick = function() 
		if isMonetLoader() then
			return ReverseTranslateNick(settings.player_info.name_surname):gsub('_',' ')
		else
			return sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))):gsub('_',' ') 
		end
	end,
    my_doklad_nick = function() 
		local nick
		if isMonetLoader() then
			nick = ReverseTranslateNick(settings.player_info.name_surname)
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
	my_ru_nick = function() return TranslateNick(settings.player_info.name_surname) end,
	fraction_rank_number = function() return settings.player_info.fraction_rank_number end,
	fraction_rank = function() return settings.player_info.fraction_rank end,
	fraction_tag = function() return settings.player_info.fraction_tag end,
	fraction = function() return settings.player_info.fraction end,
	sex = function() 
		return (settings.player_info.sex == '�������') and 'a' or ''
	end,
	get_time = function()
		return os.date("%H:%M:%S")
	end,
	get_date = function()
		return os.date("%H:%M:%S")
	end,
	get_rank = function()
		return giverank[0]
	end,
	get_square = function()
		local KV = {
			[1] = "�",
			[2] = "�",
			[3] = "�",
			[4] = "�",
			[5] = "�",
			[6] = "�",
			[7] = "�",
			[8] = "�",
			[9] = "�",
			[10] = "�",
			[11] = "�",
			[12] = "�",
			[13] = "�",
			[14] = "�",
			[15] = "�",
			[16] = "�",
			[17] = "�",
			[18] = "�",
			[19] = "�",
			[20] = "�",
			[21] = "�",
			[22] = "�",
			[23] = "�",
			[24] = "�",
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
			[0] = "��� ������",
			[1] = "��� ������",
			[2] = "��� ������",
			[3] = "��� ��������"
		}
		return city[getCityPlayerIsIn(PLAYER_PED)]
	end,
	get_storecar_model = function()
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
				if distance < closest_distance and vehicle ~= my_car then
					closest_distance = distance
					closest_car = vehicle
				end
				--sampAddChatMessage(select(2, sampGetPlayerIdByCharHandle(getDriverOfCar(vehicle))), 0x009EFF)
			end
		end
		if closest_car then
			-- local colorNames = {
			-- 	[0] = "�������",
			-- 	[1] = "������",
			-- 	[2] = "����������",
			-- 	[3] = "���������",
			-- 	[4] = "��������",
			-- 	[5] = "����������",
			-- 	[6] = "������",
			-- 	[7] = "��������",
			-- 	[8] = "������",
			-- 	[9] = "����������",
			-- 	[10] = "������",
			-- 	[11] = "������",
			-- 	[12] = "��������",
			-- 	[13] = "�����������",
			-- 	[14] = "��������",
			-- 	[15] = "��������",
			-- 	[16] = "��������",
			-- 	[17] = "���������",
			-- 	[18] = "���������",
			-- 	[19] = "������",
			-- 	[20] = "������",
			-- 	[21] = "���������",
			-- 	[22] = "���������",
			-- 	[23] = "������",
			-- 	[24] = "�����������",
			-- 	[25] = "������",
			-- 	[26] = "��������",
			-- 	[27] = "��������",
			-- 	[28] = "������",
			-- 	[29] = "��������",
			-- 	[30] = "���������",
			-- 	[31] = "���������",
			-- 	[32] = "������������",
			-- 	[33] = "������",
			-- 	[34] = "��������",
			-- 	[35] = "�����������",
			-- 	[36] = "������",
			-- 	[37] = "��������",
			-- 	[38] = "������",
			-- 	[39] = "������",
			-- 	[40] = "������",
			-- 	[41] = "�����������",
			-- 	[42] = "�����������",
			-- 	[43] = "���������",
			-- 	[44] = "��������",
			-- 	[45] = "���������",
			-- 	[46] = "��������",
			-- 	[47] = "�������",
			-- 	[48] = "����������",
			-- 	[49] = "��������",
			-- 	[50] = "������������",
			-- 	[51] = "��������",
			-- 	[52] = "������",
			-- 	[53] = "������",
			-- 	[54] = "������",
			-- 	[55] = "�����������",
			-- 	[56] = "��������",
			-- 	[57] = "�����������",
			-- 	[58] = "������������",
			-- 	[59] = "������",
			-- 	[60] = "��������",
			-- 	[61] = "�����������",
			-- 	[62] = "������������",
			-- 	[63] = "������������",
			-- 	[64] = "��������",
			-- 	[65] = "����������",
			-- 	[66] = "�����������",
			-- 	[67] = "������������",
			-- 	[68] = "����������",
			-- 	[69] = "����������",
			-- 	[70] = "������������",
			-- 	[71] = "��������",
			-- 	[72] = "�������",
			-- 	[73] = "����������",
			-- 	[74] = "���������",
			-- 	[75] = "������",
			-- 	[76] = "����������",
			-- 	[77] = "�����������",
			-- 	[78] = "��������",
			-- 	[79] = "������",
			-- 	[80] = "��������",
			-- 	[81] = "������",
			-- 	[82] = "������������",
			-- 	[83] = "����������",
			-- 	[84] = "�����������",
			-- 	[85] = "��������",
			-- 	[86] = "��������",
			-- 	[87] = "������",
			-- 	[88] = "�������",
			-- 	[89] = "����������",
			-- 	[90] = "��������",
			-- 	[91] = "����������",
			-- 	[92] = "����������",
			-- 	[93] = "������",
			-- 	[94] = "������",
			-- 	[95] = "������",
			-- 	[96] = "��������",
			-- 	[97] = "������������",
			-- 	[98] = "����������",
			-- 	[99] = "�����������",
			-- 	[100] = "��������������",
			-- 	[101] = "������������",
			-- 	[102] = "�����������",
			-- 	[103] = "������",
			-- 	[104] = "�����������",
			-- 	[105] = "������",
			-- 	[106] = "������",
			-- 	[107] = "����������",
			-- 	[108] = "��������������",
			-- 	[109] = "������",
			-- 	[110] = "����������",
			-- 	[111] = "��������",
			-- 	[112] = "������",
			-- 	[113] = "�����������",
			-- 	[114] = "�������",
			-- 	[115] = "������������",
			-- 	[116] = "������",
			-- 	[117] = "���������",
			-- 	[118] = "��������",
			-- 	[119] = "�����������",
			-- 	[120] = "����������",
			-- 	[121] = "���������",
			-- 	[122] = "����������",
			-- 	[123] = "�����������",
			-- 	[124] = "������������",
			-- 	[125] = "������",
			-- 	[126] = "��������",
			-- 	[127] = "�������",
			-- 	[128] = "�������",
			-- 	[129] = "���������",
			-- 	[130] = "������",
			-- 	[131] = "�����������",
			-- 	[132] = "������������",
			-- 	[133] = "�������",
			-- 	[134] = "������",
			-- 	[135] = "����������",
			-- 	[136] = "������������",
			-- 	[137] = "�������",
			-- 	[138] = "������",
			-- 	[139] = "����������",
			-- 	[140] = "��������",
			-- 	[141] = "����������",
			-- 	[142] = "����������",
			-- 	[143] = "�����������",
			-- 	[144] = "�����������",
			-- 	[145] = "�������",
			-- 	[146] = "�����������",
			-- 	[147] = "�����������",
			-- 	[148] = "����������",
			-- 	[149] = "������",
			-- 	[150] = "�������",
			-- 	[151] = "�������",
			-- 	[152] = "��������",
			-- 	[153] = "��������",
			-- 	[154] = "��������",
			-- 	[155] = "��������",
			-- 	[156] = "�����������",
			-- 	[157] = "�������",
			-- 	[158] = "��������",
			-- 	[159] = "�����������",
			-- 	[160] = "������������",
			-- 	[161] = "�����������",
			-- 	[162] = "�����������",
			-- 	[163] = "��������",
			-- 	[164] = "������",
			-- 	[165] = "�����������",
			-- 	[166] = "������",
			-- 	[167] = "����������",
			-- 	[168] = "������",
			-- 	[169] = "��������",
			-- 	[170] = "����������",
			-- 	[171] = "����������",
			-- 	[172] = "�������",
			-- 	[173] = "������",
			-- 	[174] = "������",
			-- 	[175] = "�����������",
			-- 	[176] = "����������",
			-- 	[177] = "�����������",
			-- 	[178] = "��������",
			-- 	[179] = "������",
			-- 	[180] = "��������",
			-- 	[181] = "��������",
			-- 	[182] = "����������",
			-- 	[183] = "����������",
			-- 	[184] = "��������",
			-- 	[185] = "�������",
			-- 	[186] = "�����������",
			-- 	[187] = "������",
			-- 	[188] = "�����������",
			-- 	[189] = "����������",
			-- 	[190] = "�������",
			-- 	[191] = "�������",
			-- 	[192] = "����������",
			-- 	[193] = "�����������",
			-- 	[194] = "��������",
			-- 	[195] = "�����������",
			-- 	[196] = "�������",
			-- 	[197] = "������",
			-- 	[198] = "�����������",
			-- 	[199] = "����������",
			-- 	[200] = "�������",
			-- 	[201] = "�����������",
			-- 	[202] = "�����������",
			-- 	[203] = "�����������",
			-- 	[204] = "�������",
			-- 	[205] = "������",
			-- 	[206] = "��������",
			-- 	[207] = "�������",
			-- 	[208] = "������",
			-- 	[209] = "��������",
			-- 	[210] = "�������",
			-- 	[211] = "������",
			-- 	[212] = "��������",
			-- 	[213] = "�������",
			-- 	[214] = "������",
			-- 	[215] = "�����������",
			-- 	[216] = "����������",
			-- 	[217] = "�����������",
			-- 	[218] = "������",
			-- 	[219] = "�������",
			-- 	[220] = "��������",
			-- 	[221] = "�������",
			-- 	[222] = "�����������",
			-- 	[223] = "�������",
			-- 	[224] = "������",
			-- 	[225] = "��������",
			-- 	[226] = "�������",
			-- 	[227] = "������",
			-- 	[228] = "�����������",
			-- 	[229] = "����������",
			-- 	[230] = "�������",
			-- 	[231] = "�����������",
			-- 	[232] = "������",
			-- 	[233] = "�������",
			-- 	[234] = "������",
			-- 	[235] = "�����������",
			-- 	[236] = "��������",
			-- 	[237] = "�������",
			-- 	[238] = "����������",
			-- 	[239] = "�����������",
			-- 	[240] = "��������",
			-- 	[241] = "��������",
			-- 	[242] = "�����������",
			-- 	[243] = "�������",
			-- 	[244] = "�����������",
			-- 	[245] = "��������",
			-- 	[246] = "��������",
			-- 	[247] = "������",
			-- 	[248] = "���������",
			-- 	[249] = "���������",
			-- 	[250] = "������",
			-- 	[251] = "������",
			-- 	[252] = "�������",
			-- 	[253] = "������",
			-- 	[254] = "�����������",
			-- 	[255] = "������"
			-- }
			local colorNames = {
				[0] = "�������",
				[1] = "������",
				[2] = "����������",
				[3] = "���������",
				[4] = "��������",
				[5] = "����������",
				[6] = "������",
				[7] = "��������",
				[8] = "������",
				[9] = "����������",
				[10] = "������",
				[11] = "������",
				[12] = "��������",
				[13] = "�����������",
				[14] = "��������",
				[15] = "��������",
				[16] = "��������",
				[17] = "���������",
				[18] = "���������",
				[19] = "������",
				[20] = "������",
				[21] = "���������",
				[22] = "���������",
				[23] = "������",
				[24] = "�����������",
				[25] = "������",
				[26] = "��������",
				[27] = "��������",
				[28] = "������",
				[29] = "��������",
				[30] = "���������",
				[31] = "���������",
				[32] = "������������",
				[33] = "������",
				[34] = "��������",
				[35] = "�����������",
				[36] = "������",
				[37] = "��������",
				[38] = "������",
				[39] = "������",
				[40] = "������",
				[41] = "�����������",
				[42] = "�����������",
				[43] = "���������",
				[44] = "��������",
				[45] = "���������",
				[46] = "��������",
				[47] = "����������",
				[48] = "����������",
				[49] = "������",
				[50] = "������������",
				[51] = "��������",
				[52] = "������",
				[53] = "������",
				[54] = "������",
				[55] = "�����������",
				[56] = "��������",
				[57] = "����������",
				[58] = "������������",
				[59] = "������",
				[60] = "��������",
				[61] = "����������",
				[62] = "������������",
				[63] = "������������",
				[64] = "��������",
				[65] = "����������",
				[66] = "�����������",
				[67] = "������������",
				[68] = "����������",
				[69] = "����������",
				[70] = "������������",
				[71] = "��������",
				[72] = "����������",
				[73] = "����������",
				[74] = "���������",
				[75] = "������",
				[76] = "����������",
				[77] = "����������",
				[78] = "���������",
				[79] = "������",
				[80] = "��������",
				[81] = "����������",
				[82] = "������������",
				[83] = "����������",
				[84] = "�����������",
				[85] = "��������",
				[86] = "��������",
				[87] = "������",
				[88] = "�������",
				[89] = "����������",
				[90] = "��������",
				[91] = "����������",
				[92] = "����������",
				[93] = "������������",
				[94] = "������",
				[95] = "������",
				[96] = "��������",
				[97] = "������������",
				[98] = "������������",
				[99] = "�����������",
				[100] = "��������������",
				[101] = "������������",
				[102] = "�����������",
				[103] = "������",
				[104] = "�����������",
				[105] = "������",
				[106] = "������",
				[107] = "����������",
				[108] = "��������������",
				[109] = "������",
				[110] = "����������",
				[111] = "������",
				[112] = "������",
				[113] = "�����������",
				[114] = "�������",
				[115] = "������������",
				[116] = "������",
				[117] = "���������",
				[118] = "��������",
				[119] = "�����������",
				[120] = "����������",
				[121] = "���������",
				[122] = "����������",
				[123] = "�����������",
				[124] = "������������",
				[125] = "������",
				[126] = "��������",
				[127] = "�������",
				[128] = "�������",
				[129] = "���������",
				[130] = "������",
				[131] = "�����������",
				[132] = "������������",
				[133] = "�������",
				[134] = "�����������",
				[135] = "����������",
				[136] = "������������",
				[137] = "�������",
				[138] = "������",
				[139] = "����������",
				[140] = "��������",
				[141] = "����������",
				[142] = "����������",
				[143] = "�����������",
				[144] = "�����������",
				[145] = "�������",
				[146] = "����������",
				[147] = "�����������",
				[148] = "����������",
				[149] = "������",
				[150] = "�����������",
				[151] = "��������",
				[152] = "������",
				[153] = "�������",
				[154] = "����������",
				[155] = "����������",
				[156] = "�����������",
				[157] = "��������",
				[158] = "����������",
				[159] = "�����������",
				[160] = "�����������",
				[161] = "�������",
				[162] = "������",
				[163] = "�����������",
				[164] = "�������",
				[165] = "����������",
				[166] = "����������",
				[167] = "�����������",
				[168] = "���������",
				[169] = "�����������",
				[170] = "�����������",
				[171] = "�����������",
				[172] = "��������",
				[173] = "�����������",
				[174] = "�����������",
				[175] = "�����������",
				[176] = "����������",
				[177] = "����������",
				[178] = "����������",
				[179] = "�����������",
				[180] = "�����������",
				[181] = "��������",
				[182] = "����������",
				[183] = "����������",
				[184] = "��������",
				[185] = "�������",
				[186] = "�������",
				[187] = "�������",
				[188] = "�������",
				[189] = "�������",
				[190] = "����������",
				[191] = "����������",
				[192] = "��������",
				[193] = "��������",
				[194] = "����������",
				[195] = "����������",
				[196] = "������",
				[197] = "����������",
				[198] = "������",
				[199] = "����������",
				[200] = "���������",
				[201] = "������",
				[202] = "�������",
				[203] = "������",
				[204] = "��������",
				[205] = "������",
				[206] = "����������",
				[207] = "��������",
				[208] = "������",
				[209] = "������",
				[210] = "������",
				[211] = "�����������",
				[212] = "����������",
				[213] = "��������",
				[214] = "����������",
				[215] = "�������",
				[216] = "����������",
				[217] = "����������",
				[218] = "������-��������",
				[219] = "����������",
				[220] = "��������",
				[221] = "����������",
				[222] = "����������",
				[223] = "������",
				[224] = "���������",
				[225] = "��������",
				[226] = "����������",
				[227] = "�������",
				[228] = "��������",
				[229] = "����������",
				[230] = "���������",
				[231] = "�����������",
				[232] = "��������",
				[233] = "����������",
				[234] = "�����������",
				[235] = "����������",
				[236] = "��������",
				[237] = "����������",
				[238] = "����������",
				[239] = "�����������",
				[240] = "��������",
				[241] = "��������",
				[242] = "�����������",
				[243] = "�������",
				[244] = "�����������",
				[245] = "��������",
				[246] = "��������",
				[247] = "������",
				[248] = "���������",
				[249] = "���������",
				[250] = "������",
				[251] = "������",
				[252] = "�������",
				[253] = "������",
				[254] = "�����������",
				[255] = "������"
			}
			local clr1, clr2 = getCarColours(closest_car)
			local CarColorName = " " .. colorNames[clr1] .. " �����"
			local function getVehPlateNumberByCarHandle(car)
				for i, plate in pairs(modules.arz_veh.cache) do
					result, veh = sampGetCarHandleBySampVehicleId(plate.carID)
					if result and veh == car then
						return ' c �������� ' .. plate.number
					end
				end
				return ''
			end
			return (getNameOfARZVehicleModel(getCarModel(closest_car)) .. CarColorName .. getVehPlateNumberByCarHandle(closest_car))
		else
			--sampAddChatMessage("[Rodina Helper] {ffffff}�� ������� �������� ������ ���������� �/c � ���������!", 0x009EFF)
			return '������������� ��������'
		end
	end,
	get_form_su = function()
		return form_su
	end,
	get_patrool_format_time = function()
		local hours = math.floor(patrool.time / 3600)
		local minutes = math.floor((patrool.time % 3600) / 60)
		local secs = patrool.time % 60
		if hours > 0 then
			return string.format("%d ����� %d ����� %d ������", hours, minutes, secs)
		elseif minutes > 0 then
			return string.format("%d ����� %d ������", minutes, secs)
		else
			return string.format("%d ������(-�)", secs)
		end
	end,
	get_patrool_time = function()
		local hours = math.floor(patrool.time / 3600)
		local minutes = math.floor(( patrool.time % 3600) / 60)
		local secs = patrool.time % 60
		if hours > 0 then
			return string.format("%02d:%02d:%02d", hours, minutes, secs)
		else
			return string.format("%02d:%02d", minutes, secs)
		end
	end,
	get_patrool_code = function()
		return patrool.code
	end,
	get_patrool_mark = function()
		return patrool.mark .. '-' .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
	end,
	get_patrool_name = function()
		return patrool.name
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
							units = units .. nickname .. ' ' -- � ������, ���� ��� �������������
						end
					end
					return units
				else
					--sampAddChatMessage('[Rodina Helper] � ����� ���� ���� ����� ����������!', -1)
					return '����'
				end
			else
				return '����'
			end
		else
			--sampAddChatMessage('[Rodina Helper] �� �� ���������� � ����, ���������� �������� ����� ����������!', -1)
			return '����'
		end
	end,
	switchCarSiren = function()
		if isCharInAnyCar(PLAYER_PED) then
			local car = storeCarCharIsInNoSave(PLAYER_PED)
			if getDriverOfCar(car) == PLAYER_PED then
				switchCarSiren(car, not isCarSirenOn(car))
				return '/me ' .. ( isCarSirenOn(car) and '��������' or '���������') .. ' ������� � ���� ������������ ��������'
			else
				--sampAddChatMessage('[Rodina Helper] {ffffff}�� �� �� ����!', 0x009EFF)
				return (isCarSirenOn(car) and '�������' or '������') .. ' �������!'
			end
		else
			--sampAddChatMessage('[Rodina Helper] {ffffff}�� �� � ����������!', 0x009EFF)
			return "���"
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
	get_price_healbad = function() return settings.mh.price.healbad end,
	get_price_ant = function() return settings.mh.price.ant end,
	get_price_recept = function() return settings.mh.price.recept end,
	get_price_med7 = function() return settings.mh.price.med7 end,
	get_price_med14 = function() return settings.mh.price.med14 end,
	get_price_med30 = function() return settings.mh.price.med30 end,
	get_price_med60 = function() return settings.mh.price.med60 end,
	get_medcard_days = function() 
		return medCard.days[0]
	end,
	get_medcard_status = function() 
		return medCard.status[0]
	end,
	get_recepts = function ()
		return recept.recepts[0]
	end,
	get_ants = function ()
		return antibiotik.ants[0]
	end,
	get_medcard_price = function ()
		if medCard.days[0] == 0 then
			return settings.mh.price.med7
		elseif medCard.days[0] == 1 then
			return settings.mh.price.med14
		elseif medCard.days[0] == 2 then
			return settings.mh.price.med30
		elseif medCard.days[0] == 3 then
			return settings.mh.price.med60
		else
			return 1000
		end
	end,
}
 
local PlayerID = nil
local player_id = nil
local check_stats = false
local clicked = false

local debug_mode = false

local commands = {isActive = false, isStop = false, isPause = false}
-- local commands.isStop = false
-- local commands.isPause = false

-- only 9/10
local spawncar_bool = false
local vc_vize = {bool = false, player_id = nil}

local message1
local message2
local message3
local anti_flood_auto_uval = false
local auto_uval_checker = false
local platoon_check = false

-- MH
local godeath_player_id = nil
local godeath_locate = ''
local godeath_city = ''
local auto_healme = false

-- MJ
local awanted = false
local afind = false

-- LC
local givelic = {bool = false, time = 1, type = ''}

local InfraredVision = false
local NightVision = false
------------------------------------------- Functions -----------------------------------------------------

function welcome_message()
	if not sampIsLocalPlayerSpawned() then 
		sampAddChatMessage('[Rodina Helper] {ffffff}������������� ������� ������ �������!',message_color)
		sampAddChatMessage('[Rodina Helper] {ffffff}��� ������ �������� ������� ������� ������������ (������� �� ������)',message_color)
		repeat wait(0) until sampIsLocalPlayerSpawned()
	end

	sampAddChatMessage('[Rodina Helper] {ffffff}�������� ������� ������ �������!', message_color)
	show_arz_notify('info', 'Rodina Helper', "�������� ������� ������ �������!", 3000)
	print('������ �������� ������� ������ �������!')

	show_arz_sms("������!", "Fil", 815168, 120012, 2000, "")

	if isMonetLoader() or settings.general.bind_mainmenu == nil then	
		sampAddChatMessage('[Rodina Helper] {ffffff}���� ������� ���� ������� ������� ������� ' .. message_color_hex .. '/helper', message_color)
	elseif hotkey_no_errors and settings.general.bind_mainmenu then
		sampAddChatMessage('[Rodina Helper] {ffffff}���� ������� ���� ������� ������� ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_mainmenu) .. ' {ffffff}��� ������� ������� ' .. message_color_hex .. '/helper', message_color)
	else
		sampAddChatMessage('[Rodina Helper] {ffffff}���� ������� ���� ������� ������� ������� ' .. message_color_hex .. '/helper', message_color)
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
		if not commands.isActive then
			if commands.isStop then
				commands.isStop = false
			end
			local arg_check = false
			local modifiedText = cmd_text
			if cmd_arg == '{arg}' then
				if arg and arg ~= '' then
					modifiedText = modifiedText:gsub('{arg}', arg or "")
					arg_check = true
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [��������]', message_color)
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
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ������]', message_color)
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
						sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ������] [��������]', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ������] [��������]', message_color)
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
						sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ������] [�����] [��������]', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ������] [�����] [��������]', message_color)
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
						sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ������] [�����] [��������] [��������]', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ������] [�����] [��������] [��������]', message_color)
					playNotifySound()
				end
			elseif cmd_arg == '' then
				arg_check = true
			end
			if arg_check then
				lua_thread.create(function()
					commands.isActive = true
					commands.isPause = false
					if modifiedText:find('&.+&') then
						info_stop_command()
					end
					local lines = {}
					for line in string.gmatch(modifiedText, "[^&]+") do
						table.insert(lines, line)
					end
					for line_index, line in ipairs(lines) do
						if commands.isStop then 
							commands.isStop = false 
							commands.isActive = false
							if isMonetLoader() and settings.general.mobile_stop_button then
								CommandStopWindow[0] = false
							end
							sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������� /' .. chat_cmd .. " ������� �����������!", message_color) 
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
								medCard.menu[0] = true
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
								recept.menu[0] = true
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
								antibiotik.menu[0] = true
								break
							elseif line == '{lmenu_vc_vize}' then
								if cmd_arg == '{arg_id}' then
									vc_vize.player_id = arg
								elseif cmd_arg == '{arg_id} {arg2}' then
									local arg_id, arg2 = arg:match('(%d+) (.+)')
									if arg_id and arg2 and isParamSampID(arg_id) then
										vc_vize.player_id = tonumber(arg_id)
									end
								end
								vc_vize.bool = true
								sampSendChat("/lmenu")
								break
							elseif line == '{give_platoon}' then
								if cmd_arg == '{arg_id}' then
									player_id = arg
								elseif cmd_arg == '{arg_id} {arg2}' then
									local arg_id, arg2 = arg:match('(%d+) (.+)')
									if arg_id and arg2 and isParamSampID(arg_id) then
										player_id = arg_id
									end
								end
								platoon_check = true
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
								GiveRankMenu[0] = true
								break
							elseif line == "{pause}" then
								sampAddChatMessage('[Rodina Helper] {ffffff}������� /' .. chat_cmd .. ' ���������� �� �����!', message_color)
								commands.isPause = true
								CommandPauseWindow[0] = true
								while commands.isPause do
									wait(0)
								end
								if not commands.isStop then
									sampAddChatMessage('[Rodina Helper] {ffffff}��������� ��������� ������� /' .. chat_cmd, message_color)	
								end			
							else
								if not commands.isStop then
									if line_index ~= 1 then wait(cmd_waiting * 1000) end
									if not commands.isStop then 
										for tag, replacement in pairs(binderTags) do
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
									commands.isStop = false 
									commands.isActive = false
									if isMonetLoader() and settings.general.mobile_stop_button then
										CommandStopWindow[0] = false
									end
									sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������� /' .. chat_cmd .. " ������� �����������!", message_color) 	
									break
								end
							end
						end
					end
					commands.isActive = false
					if isMonetLoader() and settings.general.mobile_stop_button then
						CommandStopWindow[0] = false
					end
				end)
			end
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
			playNotifySound()
		end
	end)
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
	sampAddChatMessage('[Rodina Helper] {ffffff}�� ���� ����� ���� ��� ���������� ���� �������! ���������� �������� ���������', message_color)
	playNotifySound()
end
function initialize_commands()
	sampRegisterChatCommand("helper", function() MainWindow[0] = not MainWindow[0] end)
	sampRegisterChatCommand("hm", show_fast_menu)
	sampRegisterChatCommand("stop", function() 
		if commands.isActive then 
			commands.isStop = true
		else 
			visualCEF('findGame.Success', true)
			sampAddChatMessage('[Rodina Helper] {ffffff}� ������ ������ ���� ������� �������� �������/���������!', message_color) 
		end
	end)
	sampRegisterChatCommand("debug", function() debug_mode = not debug_mode sampAddChatMessage('[Rodina Helper] {ffffff}������������ ������ � ������� ' .. (debug_mode and '��������!' or '���������!'), message_color) end)
	sampRegisterChatCommand("fixsize", function()
		settings.general.custom_dpi = 1.0
		settings.general.autofind_dpi = false
		sampAddChatMessage('[Rodina Helper] {ffffff}������ ������� ������� ������� � �����������! ����������...', message_color)
		save_settings()
		reload_script = true
		thisScript():reload()
	end)
	sampRegisterChatCommand("rpguns", function()
		imgui.StrCopy(input, '')
		RPWeaponWindow[0] = not RPWeaponWindow[0] 
	end)
	sampRegisterChatCommand('probiv', function(arg)
		if arg then
			probiv = nil
			if isParamSampID(arg) then
				imgui.StrCopy(input, sampGetPlayerNickname(arg))
			else
				imgui.StrCopy(input, arg)
			end
			imgui.StrCopy(input_probiv_key, u8(settings.general.probiv_api_key))
			ProbivMenu[0] = true
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}����������� /probiv [ID ��� Nick ������]', message_color)
		end
	end)
	sampRegisterChatCommand("pnv", function(arg)
		if not commands.isActive then
			NightVision = not NightVision
			if NightVision then
				sampSendChat('/me ������ �� ������� ���� ������� ������� � �������� ��')
			else
				sampSendChat('/me ������� � ���� ���� ������� ������� � ������� �� � ������')
			end
			setNightVision(NightVision)	
			InfraredVision = false
			setInfraredVision(InfraredVision)	
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
			playNotifySound()
		end
	end)
	sampRegisterChatCommand("irv", function(arg)
		if not commands.isActive then
			InfraredVision = not InfraredVision
			setInfraredVision(InfraredVision)	
			NightVision = false
			setNightVision(NightVision)	
			if InfraredVision then
				sampSendChat('/me ������ �� ������� ������������ ���� � �������� ��')
			else
				sampSendChat('/me ������� � ���� ������������ ���� � ������� �� � ������')
			end
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
			playNotifySound()
		end
	end)

	if not isMode('none') then
		sampRegisterChatCommand("mb", function(arg)
			if not commands.isActive then
				if members.menu[0] then
					members.menu[0] = false
					members.upd.check = false
					sampAddChatMessage('[Rodina Helper] {ffffff}���� ������ ����������� �������!', message_color)
				else
					members.new = {} 
					members.info.check = true 
					sampSendChat("/members")
				end
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("dep", function(arg)
			if not commands.isActive then
				DeportamentWindow[0] = not DeportamentWindow[0]
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("sob", function(arg)
			if not commands.isActive then
				if isParamSampID(arg) then
					player_id = tonumber(arg)
					SobesMenu[0] = not SobesMenu[0]
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/sob [ID ������]', message_color)
					playNotifySound()
				end	
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
				playNotifySound()
			end
		end)
	end

	if isMode('police') or isMode('fbi') then
		sampRegisterChatCommand("sum", function(arg) 
			if not commands.isActive then
				if isParamSampID(arg) then
					if #modules.smart_uk.data ~= 0 then
						player_id = tonumber(arg)
						SumMenuWindow[0] = true 
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}������� ���������/��������� ������� ������ ������� � /helper - ������� ����', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/sum [ID ������]', message_color)
					playNotifySound()
				end	
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("tsm", function(arg) 
			if not commands.isActive then
				if isParamSampID(arg) then
					if #modules.smart_pdd.data ~= 0 then
						player_id = tonumber(arg)
						TsmMenuWindow[0] = true
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}������� ���������/��������� ������� ����� ������� � /helper - ������� ����', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/tsm [ID ������]', message_color)
					playNotifySound()
				end	
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("meg", function ()
			MegafonWindow[0] = not MegafonWindow[0]
		end)
		sampRegisterChatCommand("afind", function (arg)
			sampAddChatMessage('[Rodina Helper] {ffffff}������ � VIP ������!', message_color)
		end)
		sampRegisterChatCommand("wanted", function(arg)
			sampSendChat('/wanted ' .. arg)
			sampAddChatMessage('[Rodina Helper] {ffffff}����� ����������� /wanteds ��� ���������������� ����� �������!', message_color)
		end)
		sampRegisterChatCommand("wanteds", function(arg)
			if WantedWindow[0] or updwanteds.stop then
				WantedWindow[0] = false
				check_wanted = false
				updwanteds.check = false
				sampAddChatMessage('[Rodina Helper] {ffffff}���� ������ ������������ �������!', message_color)
			elseif not commands.isActive then
				lua_thread.create(function()
					local max_lvl = isMode('fbi') and 7 or 6
					sampAddChatMessage('[Rodina Helper] {ffffff}������������ /wanted, �������� ' .. message_color_hex .. max_lvl .. ' {ffffff}������...', message_color)
					show_arz_notify('info', 'Rodina Helper', "������������ /wanted...", 2500)
					wanted_new = {}
					check_wanted = true
					for i = max_lvl, 1, -1 do
						printStringNow("CHECK WANTED " .. i, 1000)
						sampSendChat('/wanted ' .. i)
						wait(1000)
					end
					check_wanted = false
					if #wanted_new == 0 then
						sampAddChatMessage('[Rodina Helper] {ffffff}������ �� ������� ���� ������� � ��������!', message_color)
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}������������ /wanted ��������! ������� ������������: ' .. #wanted_new, message_color)
						wanted = wanted_new
						updwanteds.stop = false
						updwanteds.time = 0
						updwanteds.last_time = os.time()
						updwanteds.check = true
						WantedWindow[0] = true
						if settings.mj.awanted then
							search_awanted = truew
							sampAddChatMessage('[Rodina Helper - ���������] {ffffff}������� AWANTED ��������, �� ������ ������� ������� ������ ������������.', message_color)
							sampAddChatMessage('[Rodina Helper - ���������] {ffffff}���� ����� ��� ����� ����� � �������� - �� �������� ����������!', message_color)
						end
					end
				end)
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
				playNotifySound()
			end
		end)
		sampRegisterChatCommand("patrool", function(arg)
			if not commands.isActive then
				-- if isCharInAnyCar(PLAYER_PED) or PatroolMenu[0] then
				-- 	PatroolMenu[0] = not PatroolMenu[0]
				-- else
				-- 	sampAddChatMessage('[Rodina Helper] {ffffff}������ ������ �������, �� ������ ���� �� ���� ����������!', message_color)
				-- end
				PatroolMenu[0] = not PatroolMenu[0]
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
				playNotifySound()
			end
		end)
	end

	sampRegisterChatCommand("post", function(arg)
		if not commands.isActive then
			imgui.StrCopy(input, '')
			PostMenu[0] = not PostMenu[0]
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
			playNotifySound()
		end
	end)

	if isMode('prison') then
		sampRegisterChatCommand("pum", function(arg) 
			if not commands.isActive then
				if isParamSampID(arg) then
					if #modules.smart_rptp.data ~= 0 then
						player_id = tonumber(arg)
						PuMenuWindow[0] = true 
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}������� ���������/��������� ������� ������ ����� � /helper - ������� ����', message_color)
						playNotifySound()
					end
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/pum [ID ������]', message_color)
					playNotifySound()
				end	
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
				playNotifySound()
			end
		end)
	end

	if isMode('army') or isMode('prison') then
		
		

	end
	
	
	-- /do ��������� �� ������.&/me ��������� ��������� � ������ � ���������� � � ����������� �����&/mask&/do ��������� ����������� � ������������ �����.
	-- /do ��������� ����������� � ������������ �����.&/me ������ ��������� � ���������� � ���� �� ������&/mask&/do ��������� �� ������.

	registerCommandsFrom(modules.commands.data.commands.my)

	if settings.player_info.fraction_rank_number >= 9 then
		sampRegisterChatCommand("lm", show_leader_fast_menu)
		sampRegisterChatCommand("spcar", function()
			if not commands.isActive then
				lua_thread.create(function()
					commands.isActive = true
					if isMonetLoader() and settings.general.mobile_stop_button then
						sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ������ ����� ������', message_color)
						CommandStopWindow[0] = true
					elseif not isMonetLoader() and hotkey_no_errors and settings.general.bind_command_stop then
						sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_command_stop), message_color)
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop', message_color)
					end
					sampSendChat("/rb ��������! ����� 15 ������ ����� ����� ���������� �����������.")
					wait(1500)
					if commands.isStop then 
						commands.isStop = false 
						commands.isActive = false
						if isMonetLoader() and settings.general.mobile_stop_button then
							CommandStopWindow[0] = false
						end
						sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������� /spcar ������� �����������!', message_color) 
						return
					end
					sampSendChat("/rb ������� ���������, ����� �� ����� ���������.")
					wait(13500)	
					if commands.isStop then 
						commands.isStop = false 
						commands.isActive = false
						if isMonetLoader() and settings.general.mobile_stop_button then
							CommandStopWindow[0] = false
						end
						sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������� /spcar ������� �����������!', message_color) 
						return
					end
					spawncar_bool = true
					sampSendChat("/lmenu")
					commands.isActive = false
					if isMonetLoader() and settings.general.mobile_stop_button then
						CommandStopWindow[0] = false
					end
				end)
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
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
			append_commands(modules.commands.data.commands_manage.goss)
			if selected == 'fbi' then
				append_commands(modules.commands.data.commands_manage.goss_fbi)
			elseif selected == 'prison' then
				append_commands(modules.commands.data.commands_manage.goss_prison)
			elseif selected == 'gov' then
				append_commands(modules.commands.data.commands_manage.goss_gov)
			end
		end
	else
		if selected == 'police' then
			append_commands(modules.commands.data.commands.police)
		elseif selected == 'fbi' then
			append_commands(modules.commands.data.commands.police)
			append_commands(modules.commands.data.commands.fbi)
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

local russian_characters = {
    [168] = '�', [184] = '�', [192] = '�', [193] = '�', [194] = '�', [195] = '�', [196] = '�', [197] = '�', [198] = '�', [199] = '�', [200] = '�', [201] = '�', [202] = '�', [203] = '�', [204] = '�', [205] = '�', [206] = '�', [207] = '�', [208] = '�', [209] = '�', [210] = '�', [211] = '�', [212] = '�', [213] = '�', [214] = '�', [215] = '�', [216] = '�', [217] = '�', [218] = '�', [219] = '�', [220] = '�', [221] = '�', [222] = '�', [223] = '�', [224] = '�', [225] = '�', [226] = '�', [227] = '�', [228] = '�', [229] = '�', [230] = '�', [231] = '�', [232] = '�', [233] = '�', [234] = '�', [235] = '�', [236] = '�', [237] = '�', [238] = '�', [239] = '�', [240] = '�', [241] = '�', [242] = '�', [243] = '�', [244] = '�', [245] = '�', [246] = '�', [247] = '�', [248] = '�', [249] = '�', [250] = '�', [251] = '�', [252] = '�', [253] = '�', [254] = '�', [255] = '�',
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
        elseif ch == 168 then -- �
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
        elseif ch == 184 then -- �
            output = output .. russian_characters[168]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end
function TranslateNick(name)
	if name:match('%a+') then
        for k, v in pairs({['ph'] = '�',['Ph'] = '�',['Ch'] = '�',['ch'] = '�',['Th'] = '�',['th'] = '�',['Sh'] = '�',['sh'] = '�', ['ea'] = '�',['Ae'] = '�',['ae'] = '�',['size'] = '����',['Jj'] = '��������',['Whi'] = '���',['lack'] = '���',['whi'] = '���',['Ck'] = '�',['ck'] = '�',['Kh'] = '�',['kh'] = '�',['hn'] = '�',['Hen'] = '���',['Zh'] = '�',['zh'] = '�',['Yu'] = '�',['yu'] = '�',['Yo'] = '�',['yo'] = '�',['Cz'] = '�',['cz'] = '�', ['ia'] = '�', ['ea'] = '�',['Ya'] = '�', ['ya'] = '�', ['ove'] = '��',['ay'] = '��', ['rise'] = '����',['oo'] = '�', ['Oo'] = '�', ['Ee'] = '�', ['ee'] = '�', ['Un'] = '��', ['un'] = '��', ['Ci'] = '��', ['ci'] = '��', ['yse'] = '��', ['cate'] = '����', ['eow'] = '��', ['rown'] = '����', ['yev'] = '���', ['Babe'] = '�����', ['Jason'] = '�������', ['liy'] = '���', ['ane'] = '���', ['ame'] = '���'}) do
            name = name:gsub(k, v) 
        end
		for k, v in pairs({['B'] = '�',['Z'] = '�',['T'] = '�',['Y'] = '�',['P'] = '�',['J'] = '��',['X'] = '��',['G'] = '�',['V'] = '�',['H'] = '�',['N'] = '�',['E'] = '�',['I'] = '�',['D'] = '�',['O'] = '�',['K'] = '�',['F'] = '�',['y`'] = '�',['e`'] = '�',['A'] = '�',['C'] = '�',['L'] = '�',['M'] = '�',['W'] = '�',['Q'] = '�',['U'] = '�',['R'] = '�',['S'] = '�',['zm'] = '���',['h'] = '�',['q'] = '�',['y'] = '�',['a'] = '�',['w'] = '�',['b'] = '�',['v'] = '�',['g'] = '�',['d'] = '�',['e'] = '�',['z'] = '�',['i'] = '�',['j'] = '�',['k'] = '�',['l'] = '�',['m'] = '�',['n'] = '�',['o'] = '�',['p'] = '�',['r'] = '�',['s'] = '�',['t'] = '�',['u'] = '�',['f'] = '�',['x'] = 'x',['c'] = '�',['``'] = '�',['`'] = '�',['_'] = ' '}) do
            name = name:gsub(k, v) 
        end
        return name
    end
	return name
end
function ReverseTranslateNick(name)
    local translit_table = {
        ['�'] = 'f', ['�'] = 'F', ['�'] = 'ch', ['�'] = 'Ch',
        ['�'] = 't', ['�'] = 'T', ['�'] = 'sh', ['�'] = 'Sh',
        ['�'] = 'i', ['�'] = 'E', ['�'] = 'e', ['�'] = 's',
        ['�'] = 'zh', ['�'] = 'Zh', ['�'] = 'yu', ['�'] = 'Yu',
        ['�'] = 'yo', ['�'] = 'Yo', ['�'] = 'ts', ['�'] = 'Ts',
        ['�'] = 'ya', ['�'] = 'Ya', ['��'] = 'ov', ['��'] = 'ey',
        ['�'] = 'u', ['�'] = 'U', ['�'] = 'I', ['��'] = 'an',
        ['��'] = 'tsi', ['��'] = 'uz', ['����'] = 'kate', ['��'] = 'yau',
        ['����'] = 'rown', ['���'] = 'uev', ['�����'] = 'Baby',
        ['�������'] = 'Jason', ['���'] = 'liy', ['���'] = 'ein', ['���'] = 'ame'
    } 
    for k, v in pairs(translit_table) do
        name = name:gsub(k, v)
    end 
    local char_table = {
        ['�'] = 'A', ['�'] = 'B', ['�'] = 'V', ['�'] = 'G', ['�'] = 'D',
        ['�'] = 'E', ['�'] = 'Yo', ['�'] = 'Zh', ['�'] = 'Z', ['�'] = 'I',
        ['�'] = 'Y', ['�'] = 'K', ['�'] = 'L', ['�'] = 'M', ['�'] = 'N',
        ['�'] = 'O', ['�'] = 'P', ['�'] = 'R', ['�'] = 'S', ['�'] = 'T',
        ['�'] = 'U', ['�'] = 'F', ['�'] = 'H', ['�'] = 'Ts', ['�'] = 'Ch',
        ['�'] = 'Sh', ['�'] = 'Sch', ['�'] = '', ['�'] = 'Y', ['�'] = '',
        ['�'] = 'E', ['�'] = 'Yu', ['�'] = 'Ya',
        ['�'] = 'a', ['�'] = 'b', ['�'] = 'v', ['�'] = 'g', ['�'] = 'd',
        ['�'] = 'e', ['�'] = 'yo', ['�'] = 'zh', ['�'] = 'z', ['�'] = 'i',
        ['�'] = 'y', ['�'] = 'k', ['�'] = 'l', ['�'] = 'm', ['�'] = 'n',
        ['�'] = 'o', ['�'] = 'p', ['�'] = 'r', ['�'] = 's', ['�'] = 't',
        ['�'] = 'u', ['�'] = 'f', ['�'] = 'h', ['�'] = 'ts', ['�'] = 'ch',
        ['�'] = 'sh', ['�'] = 'sch', ['�'] = '', ['�'] = 'y', ['�'] = '',
        ['�'] = 'e', ['�'] = 'yu', ['�'] = 'ya', [' '] = '_'
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
		sampAddChatMessage('[Rodina Helper] {ffffff}��������/������ ������� �� FastMenu ����� � /helper - RP ������� - ���������, �������� {arg_id}, �������', message_color)
		player_id = tonumber(id)
		FastMenu[0] = true
	else
		if isMonetLoader() or settings.general.bind_fastmenu == nil then
			if not FastMenuPlayers[0] then
				sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/hm [ID]', message_color)
			end
		elseif settings.general.bind_fastmenu and hotkey_no_errors then
			sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/hm [ID] {ffffff}��� ���������� �� ������ ����� ' .. message_color_hex .. '��� + ' .. getNameKeysFrom(settings.general.bind_fastmenu), message_color) 
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/hm [ID]', message_color)
		end 
		playNotifySound()
	end 
end
function show_leader_fast_menu(id)
	if isParamSampID(id) then
		player_id = tonumber(id)
		sampAddChatMessage('[Rodina Helper] {ffffff}��������/������ ������� �� FastMenu ����� � /helper - RP ������� - ���������, �������� {arg_id}, �������', message_color)
		LeaderFastMenu[0] = true
	else
		if isMonetLoader() or settings.general.bind_leader_fastmenu == nil then
			sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/lm [ID]', message_color)
		elseif settings.general.bind_leader_fastmenu and hotkey_no_errors then
			sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/lm [ID] {ffffff}��� ���������� �� ������ ����� ' .. message_color_hex .. '��� + ' .. getNameKeysFrom(settings.general.bind_leader_fastmenu), message_color) 
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/lm [ID]', message_color)
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

function check(id, message)
    
end

-- MH
function fast_heal_in_chat(id)
	if isMonetLoader() then
		sampAddChatMessage('[Rodina Helper] {ffffff}���� �������� ������ ' .. sampGetPlayerNickname(id) .. ', � ������� 5-�� ������ ������� ������',message_color)
		heal_in_chat.player_id = id
		heal_in_chat.bool = true
		heal_in_chat.fast_menu[0] = true
		lua_thread.create(function()
			wait(5000)
			if heal_in_chat.bool then
				heal_in_chat.fast_menu[0] = false
				heal_in_chat.bool = false
				sampAddChatMessage('[Rodina Helper] {ffffff}�� �� ������ �������� ������ ' .. sampGetPlayerNickname(id), message_color)
			end
		end)
	elseif hotkey_no_errors then
		sampAddChatMessage('[Rodina Helper] {ffffff}����� �������� ������ ' .. sampGetPlayerNickname(id) .. ' ������� ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_action) .. ' {ffffff}� ������� 5-�� ������!',message_color)
		show_arz_notify('info', 'Rodina Helper', '������� ' .. getNameKeysFrom(settings.general.bind_action) .. ' ����� ������ �������� ������', 5000)
		heal_in_chat.player_id = id
		heal_in_chat.bool = true
		lua_thread.create(function()
			wait(5000)
			if heal_in_chat.bool then
				heal_in_chat.bool = false
				sampAddChatMessage('[Rodina Helper] {ffffff}�� �� ������ �������� ������ ' .. sampGetPlayerNickname(id), message_color)
			end
		end)
	end
end

function sampGetPlayerIdByNickname(nick)
	local id = nil
	nick = tostring(nick)
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	if sampGetPlayerNickname(myid):find(nick) then return myid end
	for i = 0, 999 do
	    if sampIsPlayerConnected(i) and sampGetPlayerNickname(i):find(nick) then
		   id = i
		   break
	    end
	end
	if id == nil then
		print('�� ������� �������� ID ������!')
		id = ''
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
				--sampAddChatMessage("[Rodina Helper] {ffffff}����� ��������� ��������� � ��� ��� " .. vehicle.name ..  " [ID " .. id .. "].", message_color)
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
		sampAddChatMessage('[Rodina Helper] {ffffff}��� �������� ������ �/c � ID ' .. id .. ", ��� ��� ���������� ���� Vehicles.json", message_color)
		sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������ "������������� ��������", � ������� ������� ����...', message_color)
		download_file = 'arz_veh'
		-- downloadFileFromUrlToPath('', modules.arz_veh.path)
		downloadFileFromUrlToPath('', modules.arz_veh.path)
		return '������������� ��������'
	end
end
function getAreaRu(x, y, z)
	local streets = {
		{"����������", -2667.810, -302.135, -28.831, -2646.400, -262.320, 71.169},
	}
    for i, v in ipairs(streets) do
        if (x >= v[2]) and (y >= v[3]) and (z >= v[4]) and (x <= v[5]) and (y <= v[6]) and (z <= v[7]) then
            return v[1]
        end
    end
    return '����������'
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
function info_stop_command()
	if isMonetLoader() and settings.general.mobile_stop_button then
		sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ������ ����� ������', message_color)
		CommandStopWindow[0] = true
	elseif not isMonetLoader() and hotkey_no_errors and settings.general.bind_command_stop then
		sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_command_stop), message_color)
	else
		sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop', message_color)
	end
end

local servers = {
	{name = 'Phoenix', number = ''},
}
function getARZServerNumber()
	local server = 0
	for _, s in ipairs(servers) do
		if sampGetCurrentServerName():gsub('%-', ' '):find(s.name) then
			server = s.number
			break
		end
	end
	return server
end
function getARZServerName(number)
	local server = ''
	for _, s in ipairs(servers) do
		if tostring(number) == tostring(s.number) then
			server = s.name
			break
		end
	end
	return server
end

if isMonetLoader() then
	function asyncHttpRequest(method, url, args, resolve, reject)
        local request_thread = effil.thread(function (method, url, args)
           	local requests = require 'requests'
			local result, response = pcall(requests.request, method, url, effil.dump(args))
			if result then
				response.json, response.xml = nil, nil
				return true, response
			else
				return false, response
			end
        end)(method, url, args)
        if not resolve then resolve = function() end end
        if not reject then reject = function() end end
        lua_thread.create(function()
            local runner = request_thread
            while true do
                local status, err = runner:status()
                if not err then
                    if status == 'completed' then
                        local result, response = runner:get()
                        if result then
                           resolve(response)
                        else
                           reject(response)
                        end
                        return
                    elseif status == 'canceled' then
                        return reject(status)
                    end
                else
                    return reject(err)
                end
                wait(0)
            end
        end)
    end
else
	function asyncHttpRequest(method, url, args, resolve, reject)
        local request_thread = effil.thread(function (method, url, args)
           	local requests = require 'requests'
			local result, response = pcall(requests.request, method, url, args)
			if result then
				response.json, response.xml = nil, nil
				return true, response
			else
				return false, response
			end
        end)(method, url, args)
        if not resolve then resolve = function() end end
        if not reject then reject = function() end end
        lua_thread.create(function()
            local runner = request_thread
            while true do
                local status, err = runner:status()
                if not err then
                    if status == 'completed' then
                        local result, response = runner:get()
                        if result then
                           resolve(response)
                        else
                           reject(response)
                        end
                        return
                    elseif status == 'canceled' then
                        return reject(status)
                    end
                else
                    return reject(err)
                end
                wait(0)
            end
        end)
    end
end
function downloadFileFromUrlToPath(url, path)
	print('������� ���������� ����� � ' .. path)
	local function on_finish_download()
		if download_file == 'update' then
			local function readJsonFile(filePath)
				if not doesFileExist(filePath) then
					print('������: ���� "' .. filePath .. ' �� ����������')
					return nil
				end
				local file = io.open(filePath, "r")
				local content = file:read("*a")
				file:close()
				local jsonData = decodeJson(content)
				if not jsonData then
					print('������: �������� ������ JSON � ����� ' .. filePath)
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
				
				print('������� ������������� ������:', thisScript().version)
				print('������� ������ � ������:', uVer)
				if uVer and thisScript().version ~= uVer then
					print('�������� ����������!')
					sampAddChatMessage('[Rodina Helper] {ffffff}�������� ����������!', message_color)
					update.is_need_update = true
					update.url = uUrl
					update.version = uVer
					update.info = uText
					UpdateWindow[0] = true
				else
					print('���������� �� �����!')
					sampAddChatMessage('[Rodina Helper] {ffffff}���������� �� �����, � ��� ���������� ������!', message_color)
				end
			end
		elseif download_file == 'helper' then
			sampAddChatMessage('[Rodina Helper] {ffffff}�������� ����� ������ ������� ������� ���������! ������������..',  message_color)
			reload_script = true
			thisScript():unload()
		elseif download_file == 'smart_uk' then
			sampAddChatMessage('[Rodina Helper] {ffffff}�������� ������� ����� ������ ������� ��� ������� ' .. message_color_hex .. getARZServerName(getARZServerNumber()) .. ' [' .. getARZServerNumber() ..  '] {ffffff}��������� �������!',  message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}������ �� ������ ������������ ������� ' .. message_color_hex .. '/sum [ID ������]', message_color)
			MainWindow[0] = false
			load_module('smart_uk')
		elseif download_file == 'smart_pdd' then
			sampAddChatMessage('[Rodina Helper] {ffffff}�������� ������� ����� ������ ������� ��� ������� ' .. message_color_hex .. getARZServerName(getARZServerNumber()) .. ' [' .. getARZServerNumber() ..  '] {ffffff}��������� �������!',  message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}������ �� ������ ������������ ������� ' .. message_color_hex .. '/tsm [ID ������]', message_color)
			MainWindow[0] = false
			load_module('smart_pdd')
		elseif download_file == 'smart_rptp' then
			sampAddChatMessage('[Rodina Helper] {ffffff}�������� ������� ������ ����� ��� ������� ' .. message_color_hex .. getARZServerName(getARZServerNumber()) .. ' [' .. getARZServerNumber() ..  '] {ffffff}��������� �������!',  message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}������ �� ������ ������������ ������� ' .. message_color_hex .. '/pum [ID ������]', message_color)
			MainWindow[0] = false
			load_module('smart_rptp')
		elseif download_file == 'arz_veh' then
			sampAddChatMessage('[Rodina Helper] {ffffff}�������� ���� ��������� �/� ������� ������� ����������!',  message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}�������� ����������� ������� ������� ����� ����������� ������ �/c.',  message_color)
			load_module('arz_veh')
		elseif download_file == 'notify' then
			if doesFileExist(configDirectory .. "/Resourse/notify.mp3") then
				print('���� ���������� ������� ��������!')
			end
		end
		download_file = ''
	end
	if isMonetLoader() then
		local function downloadToFile(url, path, callback, progressInterval)
			callback = callback or function() end
			progressInterval = progressInterval or 0.1
			local effil = require("effil")
			local progressChannel = effil.channel(0)
			local runner = effil.thread(function(url, path)
			local http = require("socket.http")
			local ltn = require("ltn12")
			local r, c, h = http.request({
				method = "HEAD",
				url = url,
			})
			if c ~= 200 then
				return false, c
			end
			local total_size = h["content-length"]
			local f = io.open(path, "wb")
			if not f then
				return false, "failed to open file"
			end
			local success, res, status_code = pcall(http.request, {
				method = "GET",
				url = url,
				sink = function(chunk, err)
				local clock = os.clock()
				if chunk and not lastProgress or (clock - lastProgress) >= progressInterval then
					progressChannel:push("downloading", f:seek("end"), total_size)
					lastProgress = os.clock()
				elseif err then
					progressChannel:push("error", err)
				end

				return ltn.sink.file(f)(chunk, err)
				end,
			})
			if not success then
				return false, res
			end
			if not res then
				return false, status_code
			end
			return true, total_size
			end)
			local thread = runner(url, path)
			local function checkStatus()
			local tstatus = thread:status()
			if tstatus == "failed" or tstatus == "completed" then
				local result, value = thread:get()
				if result then
					callback("finished", value)
				else
					callback("error", value)
				end
				return true
			end
			end
			lua_thread.create(function()
			if checkStatus() then
				return
			end
			while thread:status() == "running" do
				if progressChannel:size() > 0 then
					local type, pos, total_size = progressChannel:pop()
					callback(type, pos, total_size)
				end
				wait(0)
			end
			checkStatus()
			end)
		end
		downloadToFile(url, path, function(type, pos, total_size)
			if type == "downloading" then
				--print(("���������� %d/%d"):format(pos, total_size))
			elseif type == "finished" then
				on_finish_download()
			elseif type == "error" then
				sampAddChatMessage('[Rodina Helper] {ffffff}������ ��������: ' .. pos,  message_color)
			end
		end)
	else
		downloadUrlToFile(url, path, function(id, status)
			if status == 6 then
				on_finish_download()
			end
		end)
	end
end
function check_update()
	print('�������� �� ������� ����������...')
	sampAddChatMessage('[Rodina Helper] {ffffff}�������� �� ������� ����������...', message_color)
	download_file = 'update'
	-- https://komarova140784-web.github.io/Rodina-Helper-/Update.json
	downloadFileFromUrlToPath('https://komarova140784-web.github.io/Rodina-Helper-/Update.json', configDirectory .. "/Update.json")
end
function check_resourses()
	if not doesDirectoryExist(configDirectory .. '/Resourse') then
		createDirectory(configDirectory .. '/Resourse')
	end
	if not doesFileExist(configDirectory .. '/Resourse/logo.png') then
		print('��������� ������� �������...')
		-- https://github.com/komarova140784-web/Rodina-Helper-/raw/main/Resourse/logo.png
		downloadFileFromUrlToPath('https://github.com/komarova140784-web/Rodina-Helper-/raw/main/Resourse/logo.png', configDirectory .. '/Resourse/logo.png')
	end
	if not doesFileExist(configDirectory .. "/Resourse/notify.mp3") then
		print('��������� ���� ��� ���������� �������...')
		-- download_file = 'notify'
		-- https://github.com/komarova140784-web/Rodina-Helper-/raw/main/Resourse/notify.mp3
		downloadFileFromUrlToPath('https://github.com/komarova140784-web/Rodina-Helper-/raw/main/Resourse/notify.mp3', configDirectory .. "/Resourse/notify.mp3")
	end
	if not doesFileExist(modules.arz_veh.path) then
		print('��������� ������ ���� ��������� �/� ������� ��� ������������� �������...')
		download_file = 'arz_veh'
		downloadFileFromUrlToPath('', modules.arz_veh.path)
	end
end
check_resourses()

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
function change_dpi()
	imgui.PushFont(font_dpi)
end
function deleteHelperData(checker)
	os.remove(configDirectory .. "/Settings.json")
	os.remove(configDirectory .. "/Commands.json")
	os.remove(configDirectory .. "/Notes.json")
	os.remove(configDirectory .. "/Vehicles.json")
	os.remove(configDirectory .. "/Guns.json")
	os.remove(configDirectory .. "/Update.json")
	os.remove(configDirectory .. "/SmartUK.json")
	os.remove(configDirectory .. "/SmartPDD.json")
	os.remove(configDirectory .. "/SmartRPTP.json")
	if checker == 'full' then
		os.remove(configDirectory .. "/Resourse/notify.mp3")
		os.remove(configDirectory .. "/Resourse/logo1.png")
		os.remove(configDirectory .. "/Resourse/logo2.png")
		os.remove(getWorkingDirectory():gsub('\\','/') .. "/Rodina Helper.lua")
	end
end

-- MJ


-- LC
function check(id, message)
   
end
function get_lic_time(message)
   
end
function give_license(id, lic_type)
	
end

-- Probiv
function getPlayerInfo(nickname, serverId)
    local url = string.format("https://api.depscian.tech/v2/player/find?nickname=%s&serverId=%s", nickname, serverId)
    asyncHttpRequest(
        "GET",
        url,
        { headers = { ["X-API-Key"] = settings.general.probiv_api_key } },
        function(response)
            if response.status_code == 200 then
                local ok, result = pcall(decodeJson, u8:decode(response.text))
                if ok and result then
                    sampAddChatMessage('[Rodina Helper] {ffffff}����� ������! ������ ���������� ��� ����. ', message_color)
					
					probiv = result
                else
                    sampAddChatMessage('[Rodina Helper] {ffffff}������ ������������� ������.', message_color)
                end
            elseif response.status_code == 422 then
                sampAddChatMessage('[Rodina Helper] {ffffff}������ 422: ������� �� ������ ��� ������ � �������.', message_color)
            elseif response.status_code == 401 then
                sampAddChatMessage('[Rodina Helper] {ffffff}�������� API ����.', message_color)
            elseif response.status_code == 429 then
                sampAddChatMessage('[Rodina Helper] {ffffff}�������� ����� ��������. ��������� ���� �����.', message_color)
            else
                sampAddChatMessage('[Rodina Helper] {ffffff}������ API: ' .. tostring(response.status_code), message_color)
            end
        end,
        function(err)
            sampAddChatMessage('[Rodina Helper] {ffffff}������ �������: ' .. tostring(err), message_color)
        end
    )
end
function comma_value(n) -- MoneySeparator by Royan_Millans and YarikVL
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	if left and num and right then
		return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
	else
		return n
	end
end

function sampev.onShowTextDraw(id, data)
	if debug_mode then
		sampAddChatMessage('[DEBUG] {ffffff}ShowTextDraw | Id ' .. id .. " | Text " .. data.text .. ' | ModelID ' .. data.modelId .. " |", message_color)
		print("ShowTextDraw | Id " .. id .. " | Text " .. data.text .. ' | ModelID ' .. data.modelId .. " |")
	end
	if data.text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~r~Sport!') then
		sampAddChatMessage('[Rodina Helper] {ffffff}����������� ����� ���� Sport!', message_color)
		return false
	end
	if data.text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~g~Comfort!') then
		sampAddChatMessage('[Rodina Helper] {ffffff}����������� ����� ���� Comfort!', message_color)
		return false
	end
	--sampAddChatMessage(data.text .. ' , ' .. data., -1)
	
end
function sampev.onSendClickTextDraw(textdrawId)
	if debug_mode then
		sampAddChatMessage('[DEBUG] {ffffff}ClickTextDraw | Id ' .. textdrawId .. ' |', message_color)
		print('ClickTextDraw | Id ' .. textdrawId .. ' |')
	end
	if asdebug then
		table.insert(as_debug.clicked, textdrawId)
	end
end
function sampev.onDisplayGameText(style,time,text)
	if debug_mode then
		sampAddChatMessage('[DEBUG] {ffffff}GameText | Style ' .. style .. " | Time " .. time .. " | Text - " .. text .. " |", message_color)
		
	end
	if text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~r~Sport!') then
		sampAddChatMessage('[Rodina Helper] {ffffff}����������� ����� ���� Sport!', message_color)
		return false
	end
	if text:find('~n~~n~~n~~n~~n~~n~~n~~n~~w~Style: ~g~Comfort!') then
		sampAddChatMessage('[Rodina Helper] {ffffff}����������� ����� ���� Comfort!', message_color)
		return false
	end
end
function sampev.onSendTakeDamage(playerId,damage,weapon)
	if playerId ~= 65535 then
		playerId2 = playerId1
		playerId1 = playerId

		if debug_mode then
			sampAddChatMessage('[DEBUG] {ffffff}playerId -' .. playerId .. ", damage - " .. damage .. ", weapon - " .. weapon, message_color)
		end

		if isParamSampID(playerId) and playerId1 ~= playerId2 and tonumber(playerId) ~= 0 and weapon then
			local weapon_name = get_name_weapon(weapon)
			if weapon_name then
				sampAddChatMessage('[Rodina Helper] {ffffff}����� ' .. sampGetPlayerNickname(playerId) .. '[' .. playerId .. '] ����� �� ��� ��������� ' .. weapon_name .. '['.. weapon .. ']!', message_color)
				if isMode('police') or isMode('fbi') or isMode('army') or isMode('prison') then
					if ((PatroolMenu[0] or PostMenu[0]) and (ComboPatroolCode[0] ~= 1)) then
						sampAddChatMessage('[Rodina Helper - ���������] {ffffff}��� ������������ ��� ������ �� CODE 0.', message_color)
						ComboPatroolCode[0] = 1
						patrool.code = combo_patrool_code_list[ComboPatroolCode[0] + 1]
					end
					if (settings.mj.auto_doklad_damage or settings.md.auto_doklad_damage) then
						lua_thread.create(function ()
							wait(50)
							sampSendChat('/r ' .. binderTags.my_doklad_nick() .. ' �� CONTROL. ' .. (weapon ~= 0 and '�������� ��� ����' or '�� ���� ������') .. ' � ������ ' .. binderTags.get_area() .. ' (' .. binderTags.get_square() .. '), ��������� CODE 0!')
							wait(1000)
							sampSendChat('/rb ����������: ' .. sampGetPlayerNickname(playerId) .. '[' .. playerId .. '], ��(-�) ���������� ' .. weapon_name .. '!')
						end)
					end
				end
			end
		end
	end
end
function sampev.onSendGiveDamage(playerId, damage, weapon, bodypart)
	if playerId ~= 65535 then
		local nick = sampGetPlayerNickname(playerId)
		if (nick:find('Bogdan_Martelli') and getARZServerNumber():find('20')) or nick:find('%[20%]Bogdan_Martelli') then
			sampAddChatMessage('[Rodina Helper] {ffffff}Bogdan_Martelli - ��� ����������� Rodina Helper!', message_color)
			sampAddChatMessage('[Rodina Helper] {ffffff}�� ����� �������� ���� ������������ �������, ������������ :sob: :sob: :sob:', message_color)
			playNotifySound()
		end
		if debug_mode then
			sampAddChatMessage('[DEBUG] {ffffff}playerId -' .. playerId .. ", damage - " .. damage .. ", weapon - " .. weapon .. ", bodypart - " .. bodypart, message_color)
		end
	end
end
function sampev.onServerMessage(color,text)

	if text:find("1%.{6495ED} 111 %- {FFFFFF}��������� ������ ��������") or
		text:find("2%.{6495ED} 060 %- {FFFFFF}������ ������� �������") or
		text:find("3%.{6495ED} 911 %- {FFFFFF}����������� �������") or
		text:find("4%.{6495ED} 912 %- {FFFFFF}������ ������") or
		text:find("5%.{6495ED} 914 %- {FFFFFF}�����") or
		text:find("5%.{6495ED} 914 %- {FFFFFF}�������") or
		text:find("6%.{6495ED} 8828 %- {FFFFFF}���������� ������������ �����") or
		text:find("7%.{6495ED} 997 %- {FFFFFF}������ �� �������� ����� ������������ %(������ ��������� ����%)") then
		return false
	end
	if text:find("������ ��������� ��������������� �����:") then
		sampAddChatMessage('[Rodina Helper] {ffffff}������ ��������� ��������������� �����:', message_color)
		sampAddChatMessage('[Rodina Helper] {ffffff}111 ������ | 60 ����� | 911 �� | 912 �� | 913 ����� | 914 ���� | 8828 ���� | 997 ����', message_color)
		return false
	end

	if (text:find('@' .. binderTags.my_id()) or text:find('@' .. binderTags.my_nick())) then
		sampAddChatMessage('[Rodina Helper] {ffffff}���-�� �������� ��� � ����!', message_color)
		playNotifySound()
	end

	if text:find("�� ������� ������ �����") then
		sampAddChatMessage('[Rodina Helper] {ffffff}�� ������ �����', message_color)
		return false
	elseif text:find("�� ������� �������� �����") or text:find("�� ����� �����") then
		sampAddChatMessage('[Rodina Helper] {ffffff}�� ����� �����!', message_color)
		return false
	elseif text:find('����� �������� ����� (%d+) �����, ����� ������ ������� �� ������� ���������.') then
		local min = text:match('����� �������� ����� (%d+) �����, ����� ������ ������� �� ������� ���������.')

			sampAddChatMessage('[Rodina Helper] {ffffff}����� �������� ����� ' .. min .. ' �����!', message_color)

		return false
	elseif text:find('����� �������� ����� �������, ��� �������� �� ���������.') then
		
			sampAddChatMessage('[Rodina Helper] {ffffff}����� �������� ����� �������, ��� �������� �� ���������.', message_color)
		return false
	end

	if (settings.general.auto_uval and settings.player_info.fraction_rank_number >= 9) then
		if text:find("%[(.-)%] (.-) (.-)%[(.-)%]: (.+)") and color == 766526463 then -- /f /fb ��� /r /rb ��� ���� 
			local tag, rank, name, playerID, message = string.match(text, "%[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
			if ((not message:find(" ��������� (.+) +++ ����� �������� ���!") and not message:find("��������� (.+) ��� ������ �� �������(.+)")) and (message:rupper():find("���") or message:rupper():find("���.") or message:rupper():find("�������") or message:find("�������.") or message:rupper():find("����") or message:rupper():find("����."))) then
				message3 = message2
				message2 = message1
				message1 = text
				PlayerID = playerID
				if message3 == text then
					auto_uval_checker = true
					sampSendChat('/fmute ' .. playerID .. ' 1 [AutoUval] ��������')
				elseif tag == "R" then
					sampSendChat("/rb "..name.." ��������� /rb +++ ����� �������� ���!")
				elseif tag == "F" then
					sampSendChat("/fb "..name.." ��������� /fb +++ ����� �������� ���!")
				end
			elseif ((message == "(( +++ ))" or message == "(( +++. ))") and (PlayerID == playerID)) then
				auto_uval_checker = true
				sampSendChat('/fmute ' .. PlayerID .. ' 1 [AutoUval] ��������')
			end
		elseif text:find("%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)") and color == 766526463 then -- /r ��� /f � �����
			local tag, tag2, rank, name, playerID, message = string.match(text, "%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
			if not message:find(" ��������� (.+) +++ ����� �������� ���!") and not message:find("��������� (.+) ��� ������ �� �������(.+)") and message:rupper():find("���") or message:rupper():find("�������") or message:rupper():find("����") then
				message3 = message2
				message2 = message1
				message1 = text
				PlayerID = playerID
				if message3 == text then
					auto_uval_checker = true
					sampSendChat('/fmute ' .. playerID .. ' 1 [AutoUval] ��������')
				elseif tag == "R" then
					sampSendChat("/rb "..name.."["..playerID.."], ��������� /rb +++ ����� �������� ���!")
				elseif tag == "F" then
					sampSendChat("/fb "..name.."["..playerID.."], ��������� /fb +++ ����� �������� ���!")
				end
			elseif ((message == "(( +++ ))" or  message == "(( +++. ))") and (PlayerID == playerID)) then
				auto_uval_checker = true
				sampSendChat('/fmute ' .. playerID .. ' 1 [AutoUval] ��������')
			end
		end
		if text:find("(.+) ��������%(�%) ������ (.+) �� 1 �����. �������: %[AutoUval%] ��������") and auto_uval_checker then
			local text2 = text:gsub('{......}', '')
			local DATA, PlayerName, Time, Reason = text2:match("(.+) ��������%(�%) ������ (.+) �� 1 �����. �������: (.+)")
			local Name = DATA:match(" ([A-Za-z0-9_]+)%[")
			local MyName = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
			if Name == MyName then
				sampAddChatMessage('[Rodina Helper] {ffffff}�������� ������ ' .. sampGetPlayerNickname(PlayerID) .. '!', message_color)
				auto_uval_checker = false
				temp = PlayerID .. ' ���'
				find_and_use_command("/uninvite {arg_id} {arg2}", temp)
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}������ �����������/����� ��� ��������� ������ ' .. sampGetPlayerNickname(PlayerID) .. '!', message_color)
				auto_uval_checker = false
			end
		end
	end

	if isMode('police') or isMode('fbi') then
		if settings.player_info.fraction_rank_number >= (isMode('fbi') and 4 or 5) then
			if text:find("%[(.-)%] (.-) (.-)%[(.-)%]: (.+)") and color == 766526463 then -- /f /fb ��� /r /rb ��� ���� 
				local tag, rank, name, playerID, message = string.match(text, "%[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
				if message:find('����� �������� � ������ (%d) ������� ���� N(%d+)%. �������%: (.+)') and playerID ~= binderTags.my_id() then
					local lvl, id, reason = message:match('����� �������� � ������ (%d) ������� ���� N(%d+)%. �������%: (.+)')
					form_su = id .. ' ' .. lvl .. ' ' .. reason
					sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/givefsu ' .. playerID .. '{ffffff} ����� ������ ������ �� ������� ������� ' .. name, message_color)
					playNotifySound()
				end
			elseif text:find("%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)") and color == 766526463 then -- /r ��� /f � �����
				local tag, tag2, rank, name, playerID, message = string.match(text, "%[(.-)%] %[(.-)%] (.+) (.-)%[(.-)%]: (.+)")
				if message:find('����� �������� � ������ (%d) ������� ���� N(%d+)%. �������%: (.+)') and playerID ~= binderTags.my_id() then
					local lvl, id, reason = message:match('����� �������� � ������ (%d) ������� ���� N(%d+)%. �������%: (.+)')
					form_su = id .. ' ' .. lvl .. ' ' .. reason
					ssampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. '/givefsu ' .. playerID .. '{ffffff} ����� ������ ������ �� ������� ������� ' .. name, message_color)
				end
			end
		end
		if text:find('�������������� (.+) �������� �� ����� ������� ��������') and afind then
			printStringNow('AUTO FIND', 500)
			return false
		end
		if text:find('%[������%] %{FFFFFF%}���������: %/wanted %[������� ������� 1%-6%]') and check_wanted then
			return false
		end
		if text:find('%[������%].+������� � ����� ������� ������� ����') and check_wanted then 
			return false 
		end
		

	
	
		

	end
 	
	if isMode('hospital') then
		if ((settings.mh.heal_in_chat or settings.mh.auto_heal) and not heal_in_chat.bool and not commands.isActive) then	
			if (text:find('(.+)%[(%d+)%] �������:{B7AFAF} (.+)')) then
				local nick, id, message = text:match('(.+)%[(%d+)%] �������:{B7AFAF} (.+)')
				if (nick and id and message and tonumber(id) ~= select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) then
					for pon, keyword in ipairs(heal_in_chat.worlds) do
						if (message:rupper():find(keyword:rupper())) then
							fast_heal_in_chat(id)
							break
						end
					end
				end
			end
			if (text:find('(.+)%[(%d+)%] ������: (.+)')) then
				local nick, id, message = text:match('(.+)%[(%d+)%] ������: (.+)')
				if (nick and id and message and tonumber(id) ~= select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) then
					for pon, keyword in ipairs(heal_in_chat.worlds) do
						if (message:rupper():find(keyword:rupper())) then
							fast_heal_in_chat(id)
							break
						end
					end
				end
			end
		end
		if text:find('�������� �������� � ������������ �������� � ������ (.+) %((.+)%).') then
			godeath_locate, godeath_city = text:match('�������� �������� � ������������ �������� � ������ (.+) %((.+)%).')
			return false
		end
		if text:find('%(%( ����� ������� �����, ������� /godeath (%d+). ������ �� ����� (.+) %)%)') then
			godeath_player_id = text:match('%(%( ����� ������� �����, ������� /godeath (%d+). ������ �� ����� (.+) %)%)')
			godeath_player_id = tonumber(godeath_player_id)
			local cmd = '/godeath'
			for _, command in ipairs(modules.commands.data.commands.my) do
				if command.enable and command.text:find('/godeath {arg_id}') then
					cmd =  '/' .. command.cmd
				end
			end
			if godeath_locate == '�����������' then
				sampAddChatMessage('[Rodina Helper] {ffffff}�� ������ ' .. message_color_hex .. godeath_city .. ' {ffffff}�������� ����� � ������������ ' .. message_color_hex .. sampGetPlayerNickname(godeath_player_id), message_color)
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}�� ������ ' .. message_color_hex .. godeath_city .. ' (' .. godeath_locate .. ') {ffffff}�������� ����� � ������������ ' .. message_color_hex .. sampGetPlayerNickname(godeath_player_id), message_color)
			end
			sampAddChatMessage('[Rodina Helper] {ffffff}����� ������� �����, ����������� ������� ' .. message_color_hex .. cmd .. ' '.. godeath_player_id, message_color)
			return false
		end
		if text:find('$hme') then
			find_and_use_command("/heal {my_id}", "")
			return false
		end
		if ((auto_healme) and (text:find('%[�����������%]') or text:find('%[����� �����������%]'))) then
			return false
		end
		if (auto_healme and text:find('�� ��������� ����������� � �������')) then
			--sampAddChatMessage('[Rodina Helper] {ffffff}������� ����� ����� 7 ������, ��������', message_color)
			sampSendChat('/offer')
			return false
		end
		if ((auto_healme) and (text:find('��� ������� ����� ' .. binderTags.my_nick()))) then
			auto_healme = false
			return false
		end
		if text:find("������� (.+) �������� ������ (.+)����(.+)����") then
			local nick = text:match("������� (.+) �������� ������ (.+)����(.+)����")
			sampAddChatMessage('[Rodina Helper] {ffffff}������� ' .. nick .. ' �������� ����� � ���� ��������!', message_color)
			return false
		end
	end	

	if isMode('lc') then
		if text:find('������(.+)� ������ ��� ���� ����� �������� ������ ����� ��� (.+)') then
			local one, two = text:match('������(.+)� ������ ��� ���� ����� �������� ������ ����� ��� (.+)')
			sampAddChatMessage('[AS Helper] {ffffff}� ������ ��� ���� ����� �������� ������ ����� ��� ' .. two, message_color)
			sampSendChat('� ��� ��� ����� �������� ������ ����� ��� ' .. two)
			return false
		end
		if (text:find('������(.+)�� �� ������ ��������� �������� �� ����� ����')) and settings.general.auto_lic then
			givelic.bool = false
			sampAddChatMessage('[AS Helper] {ffffff}������, ��� ���� ����, ��� ��������� ��� ������ ������ ��������!', message_color)
			sampSendChat('�������� � �� ���� ������ ������ �������� ��-�� ������ ���������.')
			return false
		end
	
	end	

	if (text:find('Bogdan_Martelli') and getARZServerNumber():find('20')) or text:find('%[20%]Bogdan_Martelli') then
		local lastColor = text:match("(.+){%x+}$")
   		if not lastColor then
			lastColor = "{" .. rgba_to_hex(color) .. "}"
		end
		if text:find('%[VIP ADV%]') or text:find('%[FOREVER%]') then
			lastColor = "{FFFFFF}"
		end
		if text:find('%[20%]Bogdan_Martelli%[%d+%]') then
			local id = text:match('%[20%]Bogdan_Martelli%[(%d+)%]') or ''
			text = string.gsub(text, '%[20%]Bogdan_Martelli%[%d+%]', message_color_hex .. '[20]MTGMODS[' .. id .. ']' .. lastColor)
		elseif text:find('%[20%]Bogdan_Martelli') then
			text = string.gsub(text, '%[20%]Bogdan_Martelli', message_color_hex .. '[20]MTGMODS' .. lastColor)
		elseif text:find('Bogdan_Martelli%[%d+%]') then
			local id = text:match('Bogdan_Martelli%[(%d+)%]') or ''
			text = string.gsub(text, 'Bogdan_Martelli%[%d+%]', message_color_hex .. 'MTGMODS[' .. id .. ']' .. lastColor)
		elseif text:find('Bogdan_Martelli') then
			text = string.gsub(text, 'Bogdan_Martelli', message_color_hex .. 'MTGMODS' .. lastColor)
		end
		return {color,text}
	end
end
function sampev.onSendChat(text)
	if debug_mode then
		sampAddChatMessage('[DEBUG] {ffffff}' .. text, message_color)
	end
	local ignore = {
		[";)"] = true,
		[":D"] = true,
		[":O"] = true,
		[":|"] = true,
		[")"] = true,
		["))"] = true,
		["("] = true,
		["(("] = true,
		["xD"] = true,
		["q"] = true,
		["(+)"] = true,
		["(-)"] = true,
		[":)"] = true,
		[":("] = true,
		["=)"] = true,
		[":p"] = true,
		[";p"] = true,
		["(rofl)"] = true,
		["XD"] = true,
		["(agr)"] = true,
		["O.o"] = true,
		[">.<"] = true,
		[">:("] = true,
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
	if debug_mode then
		sampAddChatMessage('[DEBUG] {ffffff}' .. text, message_color)
	end
	if isMode('hospital') and text == "/me ������ �� ������ ���.����� ��������� � ��������� ���" then
		auto_healme = true
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

	if debug_mode then
		sampAddChatMessage('[DEBUG] {ffffff}ShowDialog | id ' .. id, message_color)
	end

	if title:find('�������� ����������') and check_stats then
		if text:find("{FFFFFF}���: {B83434}%[(.-)]") then
			settings.player_info.name_surname = TranslateNick(text:match("{FFFFFF}���: {B83434}%[(.-)]"))
			input_name_surname = imgui.new.char[256](u8(settings.player_info.name_surname))
			sampAddChatMessage('[Rodina Helper] {ffffff}���� ��� � ������� ����������: ' .. settings.player_info.name_surname, message_color)
		end
		if text:find("{FFFFFF}���: {B83434}%[(.-)]") then
			settings.player_info.sex = text:match("{FFFFFF}���: {B83434}%[(.-)]")
			sampAddChatMessage('[Rodina Helper] {ffffff}��� ��� ���������: ' .. settings.player_info.sex, message_color)
		end
		if text:find("{FFFFFF}�����������: {B83434}%[(.-)]") then
			settings.player_info.fraction = text:match("{FFFFFF}�����������: {B83434}%[(.-)]")
			if settings.player_info.fraction == '�� �������' then
				sampAddChatMessage('[Rodina Helper] {ffffff}�� �� �������� � �����������!', message_color)
				settings.player_info.fraction_tag = "none"
				settings.general.fraction_mode = "none"
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}���� ����������� ����������, ���: '..settings.player_info.fraction, message_color)
				local fraction_data = {
					['������� ��'] = {'����', 'police'}, ['������� LS'] = {'����', 'police'},
					['������� ��'] = {'����', 'police'}, ['������� LV'] = {'����', 'police'},
					['��������� �������'] = {'����', 'police'},
					['���'] = {'���', 'fbi'}, ['���'] = {'���', 'fbi'},
					['������ �������� ������ LV'] = {'���', 'prison'},
					['�����'] = {'�����', 'army'}, ['�����'] = {'�����', 'army'},
					['����'] = {'����', 'smi'}, ['����'] = {'����', 'smi'},
					['��������� ��������'] = {'��������� ��������', 'hospital'}, ['��������� ��������'] = {'��������� ��������', 'hospital'},
					['�������� ������'] = {'�������� ������', 'hospital'}, ['�������� ������'] = {'�������� ������', 'hospital'},
					['������������� LS'] = {'���-��', 'gov'}, ['������������� ��'] = {'���-��', 'gov'},
					['����� ��������������'] = {'���', 'lc'},
					['������� �����'] = {'��', 'mafia'},
					['���������� �����'] = {'��', 'mafia'},
					['��������� �����'] = {'��', 'mafia'},
				}
				local data = fraction_data[settings.player_info.fraction]
				if data then
					settings.player_info.fraction_tag = data[1]
					settings.general.fraction_mode = data[2]
					settings.deportament.dep_tag1 = '[' .. settings.player_info.fraction_tag .. ']'
					sampAddChatMessage('[Rodina Helper] {ffffff}����� ����������� �������� ��� '..settings.player_info.fraction_tag .. ". �� �� ������ �������� ���.", message_color)

					local fraction_cmds = get_fraction_cmds(settings.general.fraction_mode, false)
					for _, cmd in ipairs(fraction_cmds) do
						table.insert(modules.commands.data.commands.my, cmd)
					end
					local manage_cmds = get_fraction_cmds(settings.general.fraction_mode, true)
					for _, cmd in ipairs(manage_cmds) do
						table.insert(modules.commands.data.commands_manage.my, cmd)
					end
					save_module('commands')

					if settings.general.fraction_mode == 'police' or settings.general.fraction_mode == 'fbi' then
						add_notes()
					elseif settings.general.fraction_mode == 'prison' then
						add_notes('prison')
					end
				else
					settings.general.fraction_mode = 'none'
					settings.player_info.fraction_rank = "none"
					settings.player_info.fraction_rank_number = 0
					sampAddChatMessage('[Rodina Helper] {ffffff}���� ����������� ���� ��� �� �������������� � �������!', message_color)
					sampAddChatMessage('[Rodina Helper] {ffffff}�������� ������ ��������� ������� ��� �������������...', message_color)
				end
				if text:find("{FFFFFF}���������: {B83434}(.+)%((%d+)%)") then
					settings.player_info.fraction_rank, settings.player_info.fraction_rank_number = text:match("{FFFFFF}���������: {B83434}(.+)%((%d+)%)(.+)������� �������")
					settings.player_info.fraction_rank_number = tonumber(settings.player_info.fraction_rank_number)
					sampAddChatMessage('[Rodina Helper] {ffffff}���� ��������� ����������, ���: '..settings.player_info.fraction_rank.." ("..settings.player_info.fraction_rank_number..")", message_color)
					if settings.player_info.fraction_rank_number >= 9 then
						settings.general.auto_uval = true
					end
				else
					settings.player_info.fraction_rank = "none"
					settings.player_info.fraction_rank_number = 0
					sampAddChatMessage('[Rodina Helper] {ffffff}�� ���� �������� ��� ����!',message_color)
				end
			end
		end
		save_settings()
		sampSendDialogResponse(dialogid, 0, 0, 0)
		if check_stats == 'reload' then
			reload_script = true
			thisScript():reload()
		end
		return false
	end

	if members.info.check and title:find('(.+)%(� ����: (%d+)%)') then
        local count = 0
        local next_page = false
        local next_page_i = 0
		members.info.fraction = string.match(title, '(.+)%(� ����')
		members.info.fraction = string.gsub(members.info.fraction, '{(.+)}', '')
        for line in text:gmatch('[^\r\n]+') do
            count = count + 1
            if not line:find('���') and not line:find('��������') then

				local optional_info = ''

				if line:find('{FFA500}%(��%)') then
					line = line:gsub("{FFA500}%(��%)", "")
					optional_info = '(��)'
				end
				if line:find(' %/ � ���������') then
					line = line:gsub(" %/ � ���������", "")
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
					local color, nickname, id, rank, rank_number, color2, rank_time, warns, afk = string.match(line, "{(%x%x%x%x%x%x)}([%w_]+)%((%d+)%)%s*([^%(]+)%((%d+)%)%s*{(%x%x%x%x%x%x)}%(([^%)]+)%)%s*{FFFFFF}(%d+)%s*%[%d+%]%s*/%s*(%d+)%s*%d+ ��")
					if color ~= nil and nickname ~= nil and id ~= nil and rank ~= nil and rank_number ~= nil and warns ~= nil and afk ~= nil then
						local working = false
						if color:find('90EE90') then
							working = true
						end
						if rank_time then
							rank_number = rank_number .. ') (' .. rank_time
						end
						table.insert(members.new, { nick = nickname, id = id, rank = rank, rank_number = rank_number, warns = warns, afk = afk, working = working, info = optional_info})
					end
				else
					local color, nickname, id, rank, rank_number, rank_time, warns, afk = string.match(line, "{(%x%x%x%x%x%x)}%s*([^%(]+)%((%d+)%)%s*([^%(]+)%((%d+)%)%s*([^{}]+){FFFFFF}%s*(%d+)%s*%[%d+%]%s*/%s*(%d+)%s*%d+ ��")
					if color ~= nil and nickname ~= nil and id ~= nil and rank ~= nil and rank_number ~= nil and warns ~= nil and afk ~= nil then
						local working = false
						if color:find('90EE90') then
							working = true
						end

						table.insert(members.new, { nick = nickname, id = id, rank = rank, rank_number = rank_number, warns = warns, afk = afk, working = working, info = optional_info})
					end
				end
            end
            if line:match('��������� ��������') then
                next_page = true
                next_page_i = count - 2
            end
        end
        if next_page then
            sampSendDialogResponse(dialogid, 1, next_page_i, 0)
            next_page = false
            next_pagei = 0
		elseif #members.new ~= 0 then
            sampSendDialogResponse(dialogid, 0, 0, 0)
			members.all = members.new
			members.info.check = false
			members.menu[0] = true
		else
			sampSendDialogResponse(dialogid, 0, 0, 0)
			sampAddChatMessage('[Rodina Helper]{ffffff} ������ ����������� ����!', message_color)
			members.info.check = false
        end
        return false
    end

	if settings.player_info.fraction_rank_number >= 9 then
		if title:find('�������� ���� ��� (.+)') and text:find('��������') then -- invite
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
		if spawncar_bool and title:find('$') and text:find('����� ����������') then -- ����� ���������� 
			local count = 0
			for line in text:gmatch('[^\r\n]+') do
				if line:find('����� ����������') then
					sampSendDialogResponse(dialogid, 1, count, 0)
					spawncar_bool = false
					return false
				else
					count = count + 1
				end
			end
		end
		if vc_vize.bool then -- ���� ��� ��
			if text:find('���������� ������������ �� ������������ � Vice City') then
				local count = 0
				for line in text:gmatch('[^\r\n]+') do
					if line:find('���������� ������������ �� ������������ � Vice City') then
						sampSendDialogResponse(dialogid, 1, count, 0)
						return false 
					else
						count = count + 1
					end
				end
				
			end
			if title:find('������ ���������� �� ������� Vice City') then
				vc_vize.bool = false
				sampSendChat("/r ���������� "..TranslateNick(sampGetPlayerNickname(tonumber(vc_vize.player_id))).." ������ ���� Vice City!")
				sampSendDialogResponse(dialogid, 1, 0, tostring(vc_vize.player_id))
				return false 
			end	
			if title:find('������� ���������� �� ������� Vice City') then
				vc_vize.bool = false
				sampSendChat("/r � ���������� "..TranslateNick(sampGetPlayerNickname(tonumber(vc_vize.player_id))).." ���� ������ ���� Vice City!")
				sampSendDialogResponse(dialogid, 1, 0, tostring(sampGetPlayerNickname(vc_vize.player_id)))
				return false 
			end
		end
		if (platoon_check) then
			if text:find('��������� ����� ������') and text:find('��������� ������') then
				sampSendDialogResponse(dialogid, 1, 3, 0)
				return false 
			end
			if text:find('{FFFFFF}������� {FB8654}ID{FFFFFF} ������, �������� ������ ���������') then
				sampSendDialogResponse(dialogid, 1, 0, player_id)
				platoon_check = false
				return false 
			end
		end
	end

	if title:find('�������� �����') then -- arz fastmenu
		sampSendDialogResponse(dialogid, 0, 2, 0)
		return false 
	end

	if text:find('�� ������������� ������ ������� ����������� �������?') and settings.general.anti_trivoga then -- ��������� ������
		sampSendDialogResponse(dialogid, 0, 0, 0)
		return false
	end

	
	if isMode('police') or isMode('fbi') then
		if text:find('���') and text:find('������� �������') and text:find('����������') and check_wanted then
			local text = string.gsub(text, '%{......}', '')
			text = string.gsub(text, '���%s+������� �������%s+����������\n', '')
			for line in string.gmatch(text, '[^\n]+') do
				local nick, id, lvl, dist = string.match(line, '(%w+_%w+)%((%d+)%)%s+(%d) �������%s+%[(.+)%]')
				if nick and id and lvl and dist then
					if dist:find('� ���������') then
						dist = '� ����'
					end
					table.insert(wanted_new, {nick = nick, id = id, lvl = lvl, dist = dist})
				end
			end
			sampSendDialogResponse(dialogid, 0, 0, 0)
			return false
		end
		
	end
	
	if (isMode('hospital')) then
		
		if (auto_healme) then
			if title:find('�������� �����������') and text:find('�������') and text:find('�����') and text:find(binderTags.my_nick()) then
				sampSendDialogResponse(dialogid, 1, 0, 0)
				return false
			end
			if title:find('�������� �����������') and text:find('�������') and not text:find('�����') and text:find(binderTags.my_nick()) then
				sampSendDialogResponse(dialogid, 1, 2, 0)
				return false
			end
			if title:find('������������� ��������') and text:find('�������') and text:find(binderTags.my_nick()) then
				sampSendDialogResponse(dialogid, 1, 2, 0)
				return false
			end
		end
		if (text:find('{FFFFFF}����� {DAD540}(.+){FFFFFF} ����� �������� ��� �� {DAD540}') and text:find(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))):gsub('%[%d+%]',''))) then -- /hme
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
		if text:find("��������� � ����������� ������ ����� ������� ��� �����") and text:find("��������� ������") then  -- ���������� ���.�����
			sampAddChatMessage('[Rodina Helper] {ffffff}�������� ���� ����� ���������� ��������� ���. �����', message_color)
			sampSendDialogResponse(dialogid, 1, 0, 0)
			return false
		end
	end
	
	if (isMode('lc')) then
		
	end

end
function sampev.onCreate3DText(id, color, position, distance, testLOS, attachedPlayerId, attachedVehicleId, text_3d)
   	if text_3d and text_3d:find('��������� ������') and settings.general.anti_trivoga then
		return false
	end
end
function sampev.onPlayerChatBubble(player_id, color, distance, duration, message)
	if isMode('police') or isMode('fbi') then
		if message:find(" (.+) ������ ������� ��� ������ ����������") then
			local nick = message:match(' (.+) ������ ������� ��� ������ ����������')
			local result, handle = sampGetCharHandleBySampPlayerId(sampGetPlayerIdByNickname(nick))
			if result then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
				if dist <= 1.5 then
					sampAddChatMessage('[Rodina Helper] {ffffff}��������! ����� ' .. nick .. '[' .. sampGetPlayerIdByNickname(nick) .. '] ���������� ������� � �������� ���������� ���������!', message_color)
					sampAddChatMessage('[Rodina Helper] {ffffff}������� ������ ������� � ����� ������.', message_color)
					find_and_use_command('/bot {arg_id}', sampGetPlayerIdByNickname(nick))
				elseif dist > 50 then
					sampAddChatMessage('[Rodina Helper] {ffffff}��������! ����� ' .. nick .. '[' .. sampGetPlayerIdByNickname(nick) .. '] ���������� ������� � �������� ���������� ���������!', message_color)
					sampAddChatMessage('[Rodina Helper] {ffffff}��������� � ������ ' .. nick .. ' � ����������� ������� /bot ' .. sampGetPlayerIdByNickname(nick), message_color)
				end
			end
		end
	end
end
function sampev.onCreateObject(objectId, data)
	
end
-- by cef events wojciech?
function emulationCEF(str)
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
function show_arz_sms(title, contactName, user_id, message_id, timeoutMs, image)
	if isMonetLoader() then

	else
		local function escape_js(s)
			return s:gsub("\\", "\\\\"):gsub('"', '\\"')
		end
		local safe_title = escape_js(title)
		local safe_contact = escape_js(contactName)
		local safe_user_id = tostring(user_id)
		local safe_message_id = tostring(message_id)
		local safe_timeout = tostring(timeoutMs)
		local safe_image = escape_js(image)

		local json_str = string.format(
			'[{\\"title\\":\\"%s\\",\\"contactName\\":\\"%s\\",\\"user_id\\":%s,\\"message_id\\":%s,\\"timeoutMs\\":%s,\\"image\\":\\"%s\\"}]',
			safe_title, safe_contact, safe_user_id, safe_message_id, safe_timeout, safe_image
		)

		local str = string.format("window.executeEvent('event.messenger.notification.update', `%s`);", json_str)
		visualCEF(str, true)
	end
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
addEventHandler('onSendPacket', function(id, bs, priority, reliability, orderingChannel)
	if id == 220 then
		local id = raknetBitStreamReadInt8(bs)
		local packettype = raknetBitStreamReadInt8(bs)
		if isMonetLoader() then
			local strlen = raknetBitStreamReadInt8(bs)
			if debug_mode then
				sampAddChatMessage('[DEBUG] {ffffff}SEND | ' .. str, message_color)
				print(str)
			end
			if (settings.mj.auto_clicker_situation or settings.mh.auto_clicker_situation) and packettype == 66 and (strlen == 25 or strlen == 8) then
				clicked = false
			end
		else
			local strlen = raknetBitStreamReadInt16(bs)
			local str = raknetBitStreamReadString(bs, strlen)
			if packettype ~= 0 and packettype ~= 1 and #str > 2 then
				if debug_mode then
					sampAddChatMessage('[DEBUG] {ffffff}SEND | ' .. str, message_color)
					print(str)
				end
			end
		end
	end
end)
addEventHandler('onReceivePacket', function (id, bs)
	if id == 220 then
		local id = raknetBitStreamReadInt8(bs)
        local cmd = raknetBitStreamReadInt8(bs)
		local function dumpFullBitStream(bs)
			local bitsLeft = raknetBitStreamGetNumberOfUnreadBits(bs)
			if not bitsLeft then
				print("dumpFullBitStream: raknetBitStreamGetNumberOfUnreadBits �� �����������!")
				return
			end
			local bytesLeft = math.floor(bitsLeft / 8)
			if bytesLeft == 0 then
				print("dumpFullBitStream: ���� ��������� ����� ��� �������")
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
			print("BitStream raw bytes: " .. table.concat(hexStrParts, " "))
		end
		if cmd == 153 then
            local carId = raknetBitStreamReadInt16(bs)
            raknetBitStreamIgnoreBits(bs, 8)
            local numberlen = raknetBitStreamReadInt8(bs)
            -- raknetBitStreamIgnoreBits(bs, 24)
            local plate_number = raknetBitStreamReadString(bs, numberlen)
            local typelen = raknetBitStreamReadInt8(bs)
			-- raknetBitStreamIgnoreBits(bs, 24)
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
				if debug_mode then
					sampAddChatMessage('[DEBUG] {ffffff}GET | ' .. string, message_color)
					print(string)
				end
				
			end
		else
			if cmd == 17 then
				raknetBitStreamIgnoreBits(bs, 32)
				local length = raknetBitStreamReadInt16(bs)
				local encoded = raknetBitStreamReadInt8(bs)
				local cmd = (encoded ~= 0) and raknetBitStreamDecodeString(bs, length + encoded) or raknetBitStreamReadString(bs, length)
				if debug_mode then
					sampAddChatMessage('[DEBUG] {ffffff}GET | ' .. cmd, message_color)
					print(cmd)
				end
				

				if cmd:find('"�������� ����������","�������') then
					local find = cmd:match('%[.+%[(.+)%]%]')
					-- local find = cmd:match('"������� ��������� � ���������",%[(.+)%]%]')
					sampAddChatMessage("[Rodina Helper - ���������] {ffffff}���������� ��������: " .. find:gsub(',', ' '), message_color)
					sampShowDialog(897124, 'Rodina Helper - ���������', "���������� ��������: " .. find:gsub(',', ' '), '{009EFF}�������', '', 0)
				end
				--window.executeEvent('event.findGame.initialize', `["businessCenter","�������� ����������","������� ��������� � ���������",[7,9,14,21,22]]`);
				--window.executeEvent('event.findGame.initialize', `["businessCenter","�������� ����������","������� ��������� ��������� � ���������",[27,26,10,9,11]]`);
				-- if cmd:find('"businessCenter","�������� ����������","������� ��������� ��������� � ���������"') then
				-- 	local find = cmd:match('"������� ��������� ��������� � ���������",%[(.+)%]%]')
				-- 	sampAddChatMessage("[Rodina Helper - ���������] {ffffff}���������� ��������: " .. find:gsub(',', ' '), message_color)
				-- 	sampShowDialog(897124, 'Rodina Helper - ���������', "���������� ��������: " .. find:gsub(',', ' '), '{009EFF}�������', '', 0)
				-- end
			end
		end
	end
end)
addEventHandler('onReceiveRpc', function (id, bs)
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
				commands.isActive = true
				if isMonetLoader() and settings.general.mobile_stop_button then
					sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ������ ����� ������', message_color)
					CommandStopWindow[0] = true
				elseif not isMonetLoader() and hotkey_no_errors and settings.general.bind_command_stop then
					sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_command_stop), message_color)
				else
					sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop', message_color)
				end
				local lines = {}
				for line in string.gmatch(modifiedText, "[^&]+") do
					table.insert(lines, line)
				end
				for _, line in ipairs(lines) do 
					if commands.isStop then 
						commands.isStop = false 
						commands.isActive = false
						if isMonetLoader() and settings.general.mobile_stop_button then
							CommandStopWindow[0] = false
						end
						sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������� /' .. command.cmd .. " ������� �����������!", message_color) 
						return 
					end
					if wait_tag then
						for tag, replacement in pairs(binderTags) do
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
				commands.isActive = false
				if isMonetLoader() and settings.general.mobile_stop_button then
					CommandStopWindow[0] = false
				end
			end)
		end
	end
	if not command_find then
		sampAddChatMessage('[Rodina Helper] {ffffff}���� ��� ��������� ����� ����������� ���� ��������!', message_color)
		sampAddChatMessage('[Rodina Helper] {ffffff}���������� �������� ��������� �������!', message_color)
		sampSendChat('/giverank ' .. player_id .. " " .. giverank[0])
	end
end

imgui.OnInitialize(function()
	-- ��� �������� ��������
	imgui.GetIO().IniFilename = nil
	-- ������ ������ �� �������� � ���������� ����� �������� � ������
	imgui.GetIO().Fonts:Clear()
	local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
	if isMonetLoader() then
		font_dpi = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory():gsub('\\','/') .. '/lib/mimgui/trebucbd.ttf', 14 * settings.general.custom_dpi, _, glyph_ranges)
	else
		font_dpi = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14)..'\\trebucbd.ttf', 14 * settings.general.custom_dpi, _, glyph_ranges)
	end
   	fa.Init(14 * settings.general.custom_dpi)

	-- �������� ���� �������
	local themes = {
		[0] = function() if monet_no_errors then apply_moonmonet_theme() else apply_dark_theme() end end,
		[1] = apply_dark_theme,
		[2] = apply_white_theme
	}
	themes[settings.general.helper_theme]()
end)

function getUserIcon()
	local modes = {
		{'police', fa.USER_NURSE},
		{'fbi', fa.USER_NURSE},
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
function getHelperIcon()
	local modes = {
		{'police', fa.BUILDING_SHIELD},
		{'fbi', fa.BUILDING_SHIELD},
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

local init = {step = 0, step1_result = 0, fraction_selector = 0, fraction_selector_text = '��� �����������'}
imgui.OnFrame(
    function() return InititalWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(fa.GEARS .. u8' �������������� ��������� Rodina Helper ' .. fa.GEARS, InititalWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
        change_dpi()
		if init.step == 0 then
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
					imgui.CenterTextDisabled(u8('�� ������� ������������� ��������� ������� � ������ ����� �������!\n\n'))
					imgui.CenterTextDisabled(u8('�� ����� �������� VPN ��� ��������� ������ ������, ���� �������� �������'))
					imgui.CenterTextDisabled(u8('https://github.com/MTGMODS/arizona-helper'))
					imgui.EndChild()
				end
			end
			imgui.CenterText(u8("������ �� ������� ��������� ���� ������������� ������"))
			imgui.CenterText(u8("����� ���������� ��������� ������� ��� ����������� ������ � �������"))
			imgui.Separator()
			imgui.CenterText(u8("�������� ������ ��� ��������� ��������:"))
			if imgui.CenterButton(fa.CIRCLE_ARROW_RIGHT .. u8(' �������������, ������ �� ����� /stats (����������) ') .. fa.CIRCLE_ARROW_LEFT) then
				sampAddChatMessage('[Rodina Helper] {ffffff}������� �������� ��� /stats ��������� ���������� ������ ��� ���!', message_color)
				check_stats = "reload"
				sampSendChat('/stats')
				InititalWindow[0] = false
			end
			if imgui.CenterButton(fa.CIRCLE_ARROW_RIGHT .. u8(' ������� ������ �������������� ��������� ������� ') .. fa.CIRCLE_ARROW_LEFT) then
				init.step = 1
				sampAddChatMessage('[Rodina Helper] {ffffff}�������� ���� ����������� ��� ������������� ������ ������ �������...', message_color)
			end
			imgui.Separator()
			imgui.CenterText(u8("���� ���, � ����� ������ �� ������� ������ ���������� ��������� �������"))
		elseif init.step == 1 then
			
			local function render_org_block(org_num, icon, name, factions, org_options)
				if imgui.BeginChild('##init1_'..org_num, imgui.ImVec2(160 * settings.general.custom_dpi, 45 * settings.general.custom_dpi), (init.fraction_selector == org_num)) then
					if not (init.fraction_selector == org_num) then
						imgui.SetCursorPos(imgui.ImVec2(0, 5 * settings.general.custom_dpi))
					end
					imgui.CenterText(icon .. u8(' '..name))
					imgui.CenterTextDisabled(factions)
					imgui.EndChild()
				end
				if imgui.IsItemClicked() then
					init.fraction_selector = org_num
					if #org_options > 1 then
						imgui.OpenPopup(fa.GEARS .. u8(' ������������� ������ ') .. fa.GEARS .. '##init_step_'..org_num)
					elseif org_num == 0 then
						init.step1_result = 0
						init.fraction_selector_text = name
					else
						init.step1_result = (org_num * 10) + 1
						init.fraction_selector_text = name
					end
				end
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
				if imgui.BeginPopupModal(fa.GEARS .. u8(' ������������� ������ ') .. fa.GEARS .. '##init_step_'..org_num, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
					for i, option in ipairs(org_options) do
						if i % 2 == 0 then imgui.SameLine() end
						local button_width = 125
						if (i == #org_options) and not (i % 2 == 0) then
							button_width = button_width * 2 + imgui.GetStyle().ItemSpacing.x
						end
						if imgui.Button(u8(option), imgui.ImVec2(button_width * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							init.step1_result = (org_num * 10) + i
							init.fraction_selector_text = name
							imgui.CloseCurrentPopup()
						end
					end
					imgui.EndPopup()
				end
			end
			render_org_block(1, fa.BUILDING_SHIELD, '���', '������� ������/��������� �������/���', {"������� ������", "��������� �������", "���"})
			imgui.SameLine()
			render_org_block(2, fa.HOSPITAL, '���.�����.', '���/���', {"���", "���"})
			imgui.SameLine()
			render_org_block(3, fa.BUILDING_NGO, '���', '����', {"����"})

			render_org_block(4, fa.BUILDING_SHIELD, '�������', '�����', {"�����"})
			imgui.SameLine()
			render_org_block(5, fa.BUILDING_LOCK, '������', '���', {"���"})
			imgui.SameLine()
			render_org_block(6, fa.BUILDING, '��', '��', {"��"})

			render_org_block(7, fa.BUILDING_COLUMNS, '�������������', '���-��', {"GOV"})

			render_org_block(10, fa.TORII_GATE, '�����', '��/��/��', {"��", "��", "��"})
			imgui.SameLine()
			render_org_block(0, fa.BUILDING_CIRCLE_XMARK, '��� �����������', u8'������ & �������', {})

			if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8(' ������� "' .. init.fraction_selector_text .. '" ') .. fa.CIRCLE_ARROW_LEFT, imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				slider[0] = 1
				if init.step1_result ~= 0 then
					init.step = 2
				else
					settings.player_info.fraction_rank = '����'
					settings.player_info.fraction_rank_number = 0
					imgui.StrCopy(input, u8(TranslateNick(binderTags.my_nick())))
					init.step = 3
				end
			end
		elseif init.step == 2 then
			imgui.CenterText(u8('������� ���� ��������� � �����������'))
			imgui.PushItemWidth(320 * settings.general.custom_dpi)
			imgui.InputTextWithHint(u8'##input_fraction_rank', u8('������� ������ �������� ����� ���������'), input, 256)
			imgui.PushItemWidth(320 * settings.general.custom_dpi)
			imgui.SliderInt('##fraction_rank_number', slider, 1, 10)
			imgui.Separator()
			if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� � ���������� ' .. fa.FLOPPY_DISK .. '##input_nick', imgui.ImVec2(320 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				settings.player_info.fraction_rank = u8:decode(ffi.string(input))
				settings.player_info.fraction_rank_number = slider[0]
				if settings.player_info.fraction_rank_number >= 9 then
					settings.general.auto_uval = true
				end
				init.step = 3
				imgui.StrCopy(input, u8(TranslateNick(binderTags.my_nick())))
			end
		elseif init.step == 3 then
			imgui.CenterText(u8('������� ���� ��� � ������� (�� ��������)'))
			imgui.PushItemWidth(300 * settings.general.custom_dpi)
			imgui.InputText(u8'##input_name_surname', input, 256) 
			imgui.Separator()
			if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� � ���������� ' .. fa.FLOPPY_DISK .. '##input_nick', imgui.ImVec2(300 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				settings.player_info.name_surname = u8:decode(ffi.string(input))
				init.step = 4
			end
		elseif init.step == 4 then
			imgui.CenterText(u8('������� ��� ���������'))
			imgui.Separator()
			if imgui.Button(fa.PERSON .. u8' ������� ' .. fa.PERSON .. '##select_sex', imgui.ImVec2(160 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				settings.player_info.sex = '�������'
				init.step = 5
			end
			imgui.SameLine()
			if imgui.Button(fa.PERSON_DRESS .. u8' ������� ' .. fa.PERSON_DRESS .. '##select_sex', imgui.ImVec2(160 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				settings.player_info.sex = '�������'
				init.step = 5
			end
		elseif init.step == 5 then
			local fraction_modes = {
				{id = 0,  name = "�����������",          mode = "none",      tag = "����"},
				{id = 11, name = "������� ������",       mode = "police",    tag = "����"},
				{id = 12, name = "��������� �������",    mode = "police",    tag = "�����"},
				{id = 16, name = "���",                  mode = "fbi",       tag = "���"},
				{id = 21, name = "��������� ��������",   mode = "hospital",  tag = "���"},
				{id = 22, name = "�������� ������",      mode = "hospital",  tag = "���"},
				{id = 31, name = "����������",           mode = "smi",       tag = "CNN LS"},
				{id = 41, name = "�����",                mode = "army",      tag = "�����"},
				{id = 51, name = "������ �������� ������", mode = "prison",  tag = "���"},
				{id = 61, name = "����� ��������������", mode = "lc",    	 tag = "LC"},
				{id = 71, name = "�������������",        mode = "gov",       tag = "���-��"},
				{id = 101, name = "���������� �����",    mode = "mafia",     tag = "��"},
				{id = 102, name = "���������� �����",    mode = "mafia",     tag = "��"},
				{id = 103, name = "������� �����",       mode = "mafia",     tag = "��"},
				{id = 104, name = "Warlock MC",          mode = "mafia",     tag = "WMC"},
				{id = 105, name = "Tierra Robada Bikers",mode = "mafia",     tag = "TRB"},
				{id = 111, name = "Grove Street",        mode = "ghetto",    tag = "GROVE"},
				{id = 112, name = "East Side Ballas",    mode = "ghetto",    tag = "BALLAS"},
				{id = 113, name = "Los Santos Vagos",    mode = "ghetto",    tag = "VAGOS"},
				{id = 114, name = "Varrios Los Aztecas", mode = "ghetto",    tag = "AZTEC"},
				{id = 115, name = "The Rifa",            mode = "ghetto",    tag = "RIFA"},
				{id = 116, name = "Night Wolves",        mode = "ghetto",    tag = "NW"}
			}
			for index, value in ipairs(fraction_modes) do
				if value.id == init.step1_result then
					settings.general.fraction_mode = value.mode
					settings.player_info.fraction = value.name
					settings.player_info.fraction_tag = value.tag
					break
				end
			end
			local fraction_cmds = get_fraction_cmds(settings.general.fraction_mode, false)
			for _, cmd in ipairs(fraction_cmds) do
				table.insert(modules.commands.data.commands.my, cmd)
			end
			local manage_cmds = get_fraction_cmds(settings.general.fraction_mode, true)
			for _, cmd in ipairs(manage_cmds) do
				table.insert(modules.commands.data.commands_manage.my, cmd)
			end
			if settings.general.fraction_mode == 'police' or settings.general.fraction_mode == 'fbi' then
				add_notes()
			elseif settings.general.fraction_mode == 'prison' then
				add_notes('prison')
			end
			init.step = 6
		elseif init.step == 6 then
			imgui.CenterText(u8('������������ �������/����� ���������� �������'))
			imgui.CenterText(u8('����� ��������� ��� ���� � /helper - ���������'))
			imgui.Separator()
			if imgui.Button(fa.FLAG_CHECKERED .. u8' ��������� ��������� � ������������� ' .. fa.FLAG_CHECKERED .. '##end', imgui.ImVec2(320 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				save_settings()
				save_module('commands')
				reload_script = true
				thisScript():reload()
			end
		end
        imgui.End()
    end
)

function renderSmartSystem(title, icon, downloadPath, editPopupTitle, data, saveFunction, usageText, pathDisplay, download_file_name, download_item)
	if imgui.BeginChild('##smart'..title, imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
		if #data ~= 0 then
			imgui.CenterText(u8("������� - ") .. u8(usageText))
		else
			imgui.CenterText(u8("��������� - ��������� ") .. u8(download_item) .. u8(" �� ������ ��� ��������� �������"))
		end
		imgui.Separator()
		imgui.SetCursorPosY(90 * settings.general.custom_dpi)
		imgui.SetCursorPosX(207 * settings.general.custom_dpi)
		if imgui.Button(fa.DOWNLOAD .. u8' ��������� �� ������ ' .. fa.DOWNLOAD .. '##smart'..title) then
			_G['download_'..title:lower()] = true
			download_file = download_file_name
			downloadFileFromUrlToPath(downloadPath, pathDisplay)
			imgui.OpenPopup(fa.CIRCLE_INFO .. u8' ���������� ' .. fa.CIRCLE_INFO .. '##downloadsmart'..title)
		end
		imgui.CenterText(u8'������ �� ������ �������� ��� ������������?')
		imgui.CenterText(u8'�������� SMART ������� �� ����� Discord �������.')
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.CIRCLE_INFO .. u8' ���������� ' .. fa.CIRCLE_INFO .. '##downloadsmart'..title, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
			if _G['download_'..title:lower()] then
				change_dpi()
				imgui.CenterText(u8'����� �������� �������� ������� ������� � �� ������� ��������� � ���� ��� ����������.')
				imgui.Separator()
				imgui.CenterText(u8'���� ������ ������ 10 ������ � ������ �� ����������, ������ ��������� ������ ����������!')
				imgui.CenterText(u8'������� ������� ������ ��������������� ����������:')
				imgui.CenterText(u8'1) �� ������ ������� ��������� ������ �� ������ "���������������"')
				imgui.CenterText(u8'2) �� ������ ������� ������� ������ �� ������ (������) � �������� ��� �� �� ����:')
				imgui.CenterText(u8(pathDisplay))
				imgui.Separator()
			else
				MainWindow[0] = false
				imgui.CloseCurrentPopup()
			end
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ������� ' .. fa.CIRCLE_XMARK .. '##close_smart' .. title, imgui.ImVec2(300 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				imgui.CloseCurrentPopup()
			end
			imgui.SameLine()
			if imgui.Button(fa.CIRCLE_PLAY .. u8' ������� ������ ' .. fa.CIRCLE_PLAY .. '##open_web_smart' .. title, imgui.ImVec2(300 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				openLink(downloadPath)
				MainWindow[0] = false
			end
			imgui.EndPopup()
		end
		imgui.SetCursorPosY(220 * settings.general.custom_dpi)
		imgui.SetCursorPosX(190 * settings.general.custom_dpi)
		if imgui.Button(fa.PEN_TO_SQUARE .. u8' ��������������� ������� ' .. fa.PEN_TO_SQUARE .. '##smart'..title) then
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
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index)
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index, _, imgui.WindowFlags.NoResize) then
						change_dpi()
						imgui.CenterText(u8'�� ������������� ������ ������� �����?')
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ���, �������� ' .. fa.CIRCLE_XMARK .. '##cancel_delete_item_smart' .. chapter_index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.TRASH_CAN .. u8' ��, ������� ' .. fa.TRASH_CAN .. '##delete_item_smart' .. chapter_index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
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
										_G['input_'..title:lower()..'_value'] = imgui.new.char[256](u8(item[title:find('������') and 'lvl' or 'amount']))
										_G['input_'..title:lower()..'_reason'] = imgui.new.char[1024](u8(item.reason))
										imgui.OpenPopup(fa.PEN_TO_SQUARE .. u8(" �������������� ���������##") .. title .. chapter.name .. index .. chapter_index)
									end
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(fa.PEN_TO_SQUARE .. u8(" �������������� ���������##") .. title .. chapter.name .. index .. chapter_index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
										change_dpi()
										if imgui.BeginChild('##smart'..title..'edititeminput', imgui.ImVec2(489 * settings.general.custom_dpi, 155 * settings.general.custom_dpi), true) then    
											imgui.CenterText(u8'�������� ���������:')
											imgui.PushItemWidth(478 * settings.general.custom_dpi)
											imgui.InputText(u8'##input_'..title:lower()..'_text', _G['input_'..title:lower()..'_text'], 8192)
											if title == '������� ������ �������' then
												imgui.CenterText(u8'������� ������� ��� ������ (�� 1 �� 6):')
											elseif title == '������� ����� �������' then
												imgui.CenterText(u8'����� ������ (����� ��� ����� ���� ��������):')
											elseif title == '������� ������ ��������� �����' then
												imgui.CenterText(u8'������� ����� ��� ������ (�� 1 �� 10):')
											end
											imgui.PushItemWidth(478 * settings.general.custom_dpi)
											imgui.InputText(u8'##input_'..title:lower()..'_value', _G['input_'..title:lower()..'_value'], 256)
											imgui.CenterText(u8'�������:')
											imgui.PushItemWidth(478 * settings.general.custom_dpi)
											imgui.InputText(u8'##input_'..title:lower()..'_reason', _G['input_'..title:lower()..'_reason'], 1024)
											imgui.EndChild()
										end    
										
										if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
											local text = u8:decode(ffi.string(_G['input_'..title:lower()..'_text']))
											local value = u8:decode(ffi.string(_G['input_'..title:lower()..'_value']))
											local reason = u8:decode(ffi.string(_G['input_'..title:lower()..'_reason']))
											local isValid = false
											if title == '������� ������ �������' then
												isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 6 and text ~= '' and reason ~= ''
											elseif title == '������� ����� �������' then
												isValid = value ~= '' and value:find('%d') and not value:find('%D') and text ~= '' and reason ~= ''
											elseif title == '������� ������ ��������� �����' then
												isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 10 and text ~= '' and reason ~= ''
											end
											if isValid then
												item.text = text
												item[title:find('������') and 'lvl' or 'amount'] = value
												item.reason = reason
												saveFunction()
												imgui.CloseCurrentPopup()
											else
												sampAddChatMessage('[Rodina Helper] {ffffff}������ � ��������� ������, ���������!', message_color)
											end
										end
										imgui.EndPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.TRASH_CAN .. '##' .. chapter_index .. '##' .. title .. index) then
										imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index .. '##' .. index)
									end
									imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
									if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. title .. chapter_index .. '##' .. index, _, imgui.WindowFlags.NoResize) then
										change_dpi()
										imgui.CenterText(u8'�� ������������� ������ ������� ��������?')
										imgui.Separator()
										if imgui.Button(fa.CIRCLE_XMARK .. u8' ���, �������� ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
											imgui.CloseCurrentPopup()
										end
										imgui.SameLine()
										if imgui.Button(fa.TRASH_CAN .. u8' ��, ������� ' .. fa.TRASH_CAN, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
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
						if imgui.Button(fa.CIRCLE_PLUS .. u8' �������� ����� �������� ' .. fa.CIRCLE_PLUS .. "##smart_add_subitem" .. chapter_index, imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
							_G['input_'..title:lower()..'_text'] = imgui.new.char[8192](u8(''))
							_G['input_'..title:lower()..'_value'] = imgui.new.char[256](u8(''))
							_G['input_'..title:lower()..'_reason'] = imgui.new.char[8192](u8(''))
							imgui.OpenPopup(fa.CIRCLE_PLUS .. u8(' ���������� ������ ��������� ') .. fa.CIRCLE_PLUS .. '##smart_add_subitem' .. chapter_index)
						end
						imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						if imgui.BeginPopupModal(fa.CIRCLE_PLUS .. u8(' ���������� ������ ��������� ') .. fa.CIRCLE_PLUS .. '##smart_add_subitem' .. chapter_index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
							if imgui.BeginChild('##smart'..title..'edititeminput', imgui.ImVec2(489 * settings.general.custom_dpi, 155 * settings.general.custom_dpi), true) then   
								change_dpi() 
								imgui.CenterText(u8'�������� ���������:')
								imgui.PushItemWidth(478 * settings.general.custom_dpi)
								imgui.InputText(u8'##input_'..title:lower()..'_text', _G['input_'..title:lower()..'_text'], 8192)
								if title == '������� ������ �������' then
									imgui.CenterText(u8'������� ������� ��� ������ (�� 1 �� 6):')
								elseif title == '������� ����� �������' then
									imgui.CenterText(u8'����� ������ (����� ��� ����� ���� ��������):')
								elseif title == '������� ������ ��������� �����' then
									imgui.CenterText(u8'������� ����� ��� ������ (�� 1 �� 10):')
								end
								imgui.PushItemWidth(478 * settings.general.custom_dpi)
								imgui.InputText(u8'##input_'..title:lower()..'_value', _G['input_'..title:lower()..'_value'], 256)
								imgui.CenterText(u8'�������:')
								imgui.PushItemWidth(478 * settings.general.custom_dpi)
								imgui.InputText(u8'##input_'..title:lower()..'_reason', _G['input_'..title:lower()..'_reason'], 8192)
								imgui.EndChild()
							end    
							if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. "##" .. chapter_index .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
								imgui.CloseCurrentPopup()
							end
							imgui.SameLine()
							if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. "##" .. chapter_index .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
								local text = u8:decode(ffi.string(_G['input_'..title:lower()..'_text']))
								local value = u8:decode(ffi.string(_G['input_'..title:lower()..'_value']))
								local reason = u8:decode(ffi.string(_G['input_'..title:lower()..'_reason']))
								local isValid = false
								if title == '������� ������ �������' then
									isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 6 and text ~= '' and reason ~= ''
								elseif title == '������� ����� �������' then
									isValid = value ~= '' and value:find('%d') and not value:find('%D') and text ~= '' and reason ~= ''
								elseif title == '������� ������ ��������� �����' then
									isValid = value ~= '' and not value:find('%D') and tonumber(value) >= 1 and tonumber(value) <= 10 and text ~= '' and reason ~= ''
								end
								if isValid then
									local temp = { 
										text = text, 
										[title:find('������') and 'lvl' or 'amount'] = value,
										reason = reason 
									}
									table.insert(chapter.item, temp)
									saveFunction()
									imgui.CloseCurrentPopup()
								else
									sampAddChatMessage('[Rodina Helper] {ffffff}������ � ��������� ������, ���������!', message_color)
								end
							end
							imgui.EndPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������� ' .. fa.CIRCLE_XMARK .. "##close" .. chapter_index .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.EndPopup()
					end
					imgui.Separator()
				end
				imgui.EndChild()	
				if imgui.Button(fa.CIRCLE_PLUS .. u8' �������� ����� ' .. fa.CIRCLE_PLUS .. "##smart_add" .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
					_G['input_'..title:lower()..'_name'] = imgui.new.char[512](u8(''))
					imgui.OpenPopup(fa.CIRCLE_PLUS .. u8' ���������� ������ ������ ' .. fa.CIRCLE_PLUS)
				end
				imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
				if imgui.BeginPopupModal(fa.CIRCLE_PLUS .. u8' ���������� ������ ������ ' .. fa.CIRCLE_PLUS, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
					imgui.PushItemWidth(400 * settings.general.custom_dpi)
					imgui.InputTextWithHint(u8'##input_'..title:lower()..'_name', u8("������� ��� ����� �����..."), _G['input_'..title:lower()..'_name'], 512)
					--imgui.CenterText(u8'�������� ��������, �� �� ������� �������� ��� � ����������!')
					if imgui.Button(fa.CIRCLE_PLUS .. u8' �������� ' .. fa.CIRCLE_PLUS .. "##smart_add" .. title, imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
						local temp = u8:decode(ffi.string(_G['input_'..title:lower()..'_name']))
						table.insert(data, {name = temp, item = {}})
						saveFunction()
						imgui.CloseCurrentPopup()
					end
					imgui.EndPopup()
				end
				imgui.SameLine()
				if imgui.Button(fa.CIRCLE_XMARK .. u8' ������� ' .. fa.CIRCLE_XMARK .. '##smart_close' .. title, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
		end
		imgui.CenterText(u8'�� ������ ��������� ������ ��� ��� ������')
		imgui.CenterText(u8'��� ����������� �������������')
		imgui.EndChild()
	end
end


if isMode('police') or isMode('fbi') then
	function render_fractions_functions()
		if imgui.BeginTabItem(fa.GEARS .. u8' ������� ' .. u8(settings.player_info.fraction_tag)) then
			if imgui.BeginTabBar('Tabs3') then
				if imgui.BeginTabItem(fa.ROBOT .. u8' ������ �������� "���������"') then 
					imgui.Columns(3)
					imgui.CenterColumnText(u8("�������� �������"))
					imgui.NextColumn()
					imgui.CenterColumnText(u8("�������� �������"))
					imgui.NextColumn()
					imgui.CenterColumnText(u8("������"))
					imgui.NextColumn()
					imgui.Columns(1)


					-- imgui.Separator()
					-- imgui.Columns(3)
					-- imgui.CenterColumnText(u8(""))
					-- imgui.NextColumn()
					-- imgui.CenterColumnText(u8(""))
					-- if description_hovered then
					-- 	imgui.Tooltip(u8(description_hovered))
					-- 	-- imgui.SameLine(nil, 5)
					-- 	-- imgui.TextDisabled("[?]")
					-- 	-- if imgui.IsItemHovered() then
					-- 	--     imgui.SetTooltip(u8(description_hovered))
					-- 	-- end
					-- end
					-- imgui.NextColumn()
					-- if imgui.CenterColumnSmallButton(u8((config and '���������' or '��������') .. '##' .. name)) then
					-- 	config = not config
					-- 	save_settings()
					-- end
					-- imgui.Columns(1)
										
					-- render_assist_items("RP �������", settings.player_info.rp_chat, '��� ��� �������� [?]', "��� ���� ��������� � ��� ������������� ����� � ��������� ����� � � ������ � �����")

					-- local function toggle(text, config_ref)
					-- 	local bool = imgui.new.bool(config_ref.value)
					-- 	if imgui.ToggleButton(u8(text), bool) then
					-- 		config_ref.value = bool[0]
					-- 	end
					-- end

					-- toggle("RP �������", { value = settings.player_info.rp_chat })

					imgui.EndTabItem()
				end
				if imgui.BeginTabItem(fa.STAR .. u8' ������� ������ �������') then 
					renderSmartSystem(
						'������� ������ �������',
						fa.STAR,
						'https://github.com/komarova140784-web/Rodina-Helper-/tree/main/SmartUK' .. getARZServerNumber() .. '/SmartUK.json', 
						'������� ������ �������', 
						modules.smart_uk.data, 
						function() save_module("smart_uk") end, 
						'�������������: /sum [ID ������]', 
						modules.smart_uk.path,
						'smart_uk',
						'����� ������'
					)
					imgui.EndTabItem()
				end
				if imgui.BeginTabItem(fa.TICKET .. u8' ������� ����� �������') then 
					renderSmartSystem(
						'������� ����� �������', 
						fa.TICKET, 
						'https://github.com/komarova140784-web/Rodina-Helper-/tree/main/SmartPDD' .. getARZServerNumber() .. '/SmartPDD.json', 
						'������� ����� �������', 
						modules.smart_pdd.data, 
						function() save_module("smart_pdd") end, 
						'�������������: /tsm [ID ������]', 
						modules.smart_pdd.path,
						'smart_pdd',
						'����� ������'
					)
					imgui.EndTabItem()
				end
				imgui.EndTabBar() 
			end
			imgui.EndTabItem()
		end
	end
elseif isMode('army') or isMode('prison') then
	function render_fractions_functions()
		if imgui.BeginTabItem(fa.GEARS .. u8' ������� ' .. u8(settings.player_info.fraction_tag)) then
			if imgui.BeginTabBar('Tabs3') then
				if imgui.BeginTabItem(fa.ROBOT .. u8' ������ �������� "���������"') then 
					if imgui.BeginChild('##assist', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
						imgui.Columns(3)
						imgui.CenterColumnText(u8"�������")
						imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
						imgui.NextColumn()
						imgui.CenterColumnText(u8"��������")
						imgui.SetColumnWidth(-1, 330 * settings.general.custom_dpi)
						imgui.NextColumn()
						imgui.CenterColumnText(u8"����������")
						imgui.SetColumnWidth(-1, 120 * settings.general.custom_dpi)
						imgui.Columns(1)
						

						imgui.Separator()
						imgui.EndChild()	
					end
					imgui.EndTabItem()
				end
				if isMode('prison') then 
					if imgui.BeginTabItem(fa.STAR .. u8' ������� ������ ��������� �����') then 
						renderSmartSystem(
							'������� ������ ��������� �����', 
							fa.TICKET, 
							'/' .. getARZServerNumber() .. '/SmartRPTP.json', 
							'������� ������ �����', 
							modules.smart_rptp.data, 
							function() save_module("smart_rptp") end, 
							'�������������: /pum [ID ������]', 
							modules.smart_rptp.path,
							'smart_rptp',
							'����� ����'
						)
						imgui.EndTabItem()
					end
				end 
				imgui.EndTabBar() 
			end
			imgui.EndTabItem()
		end
	end
else
	function render_fractions_functions()
		if imgui.BeginTabItem(fa.GEARS .. u8' ������� ' .. u8(settings.player_info.fraction_tag)) then
			imgui.CenterText(u8('�������� �� ��������'))
			imgui.EndTabItem()
		end
	end
end

-- function render_fractions_functions()
-- 	if imgui.BeginTabItem(fa.GEARS .. u8' ������� ����') then


-- 		-- if imgui.BeginTabBar('Tabs3') then
-- 		-- 	if imgui.BeginTabItem(fa.ROBOT .. u8' ������ �������� "���������"') then 
-- 		-- 		imgui.Columns(3)
-- 		-- 		imgui.CenterColumnText(u8("�������� �������"))
-- 		-- 		imgui.NextColumn()
-- 		-- 		imgui.CenterColumnText(u8("�������� �������"))
-- 		-- 		imgui.NextColumn()
-- 		-- 		imgui.CenterColumnText(u8("������"))
-- 		-- 		imgui.NextColumn()
-- 		-- 		imgui.Columns(1)


-- 		-- 		-- imgui.Separator()
-- 		-- 		-- imgui.Columns(3)
-- 		-- 		-- imgui.CenterColumnText(u8(""))
-- 		-- 		-- imgui.NextColumn()
-- 		-- 		-- imgui.CenterColumnText(u8(""))
-- 		-- 		-- if description_hovered then
-- 		-- 		-- 	imgui.Tooltip(u8(description_hovered))
-- 		-- 		-- 	-- imgui.SameLine(nil, 5)
-- 		-- 		-- 	-- imgui.TextDisabled("[?]")
-- 		-- 		-- 	-- if imgui.IsItemHovered() then
-- 		-- 		-- 	--     imgui.SetTooltip(u8(description_hovered))
-- 		-- 		-- 	-- end
-- 		-- 		-- end
-- 		-- 		-- imgui.NextColumn()
-- 		-- 		-- if imgui.CenterColumnSmallButton(u8((config and '���������' or '��������') .. '##' .. name)) then
-- 		-- 		-- 	config = not config
-- 		-- 		-- 	save_settings()
-- 		-- 		-- end
-- 		-- 		-- imgui.Columns(1)
									
-- 		-- 		render_assist_items("RP �������", settings.player_info.rp_chat, '��� ��� �������� [?]', "��� ���� ��������� � ��� ������������� ����� � ��������� ����� � � ������ � �����")

-- 		-- 		-- local function toggle(text, config_ref)
-- 		-- 		-- 	local bool = imgui.new.bool(config_ref.value)
-- 		-- 		-- 	if imgui.ToggleButton(u8(text), bool) then
-- 		-- 		-- 		config_ref.value = bool[0]
-- 		-- 		-- 	end
-- 		-- 		-- end

-- 		-- 		-- toggle("RP �������", { value = settings.player_info.rp_chat })

-- 		-- 		imgui.EndTabItem()
-- 		-- 	end
-- 		-- 	if imgui.BeginTabItem(fa.STAR .. u8' ������� ������ �������') then 
-- 		-- 		renderSmartSystem(
-- 		-- 			'������� ������ �������',
-- 		-- 			fa.STAR,
-- 		-- 			'https://github.com/komarova140784-web/Rodina-Helper-/tree/main/SmartUK' .. getARZServerNumber() .. '/SmartUK.json', 
-- 		-- 			'������� ������ �������', 
-- 		-- 			modules.smart_uk.data, 
-- 		-- 			function() save_module("smart_uk") end, 
-- 		-- 			'�������������: /sum [ID ������]', 
-- 		-- 			modules.smart_uk.path,
-- 		-- 			'smart_uk',
-- 		-- 			'����� ������'
-- 		-- 		)
-- 		-- 		imgui.EndTabItem()
-- 		-- 	end
-- 		-- 	if imgui.BeginTabItem(fa.TICKET .. u8' ������� ����� �������') then 
-- 		-- 		renderSmartSystem(
-- 		-- 			'������� ����� �������', 
-- 		-- 			fa.TICKET, 
-- 		-- 			'https://github.com/komarova140784-web/Rodina-Helper-/tree/main/SmartPDD' .. getARZServerNumber() .. '/SmartPDD.json', 
-- 		-- 			'������� ����� �������', 
-- 		-- 			modules.smart_pdd.data, 
-- 		-- 			function() save_module("smart_pdd") end, 
-- 		-- 			'�������������: /tsm [ID ������]', 
-- 		-- 			modules.smart_pdd.path,
-- 		-- 			'smart_pdd',
-- 		-- 			'����� ������'
-- 		-- 		)
-- 		-- 		imgui.EndTabItem()
-- 		-- 	end
-- 		-- 	imgui.EndTabBar() 
-- 		-- end

-- 		if isMode('police') or isMode('fbi') then

-- 		elseif isMode('army') or isMode('prison') then

-- 		elseif isMode('hospital') then



-- 		else
-- 			imgui.CenterText(u8('��� ����� ����������� �������� �� ��������!'))
-- 		end
-- 		imgui.EndTabItem()
-- 	end
-- end
			

			-- if imgui.BeginTabItem(fa.MONEY_CHECK_DOLLAR..u8' ������� ��������') then 
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������� ������ (SA $)', input_heal, 8) then
			-- 		settings.mh.price.heal = u8:decode(ffi.string(input_heal))
			-- 		save_settings()
			-- 	end
			-- 	imgui.SameLine()
			-- 	imgui.SetCursorPosX(300 * settings.general.custom_dpi)
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������� ������ (VC $)', input_heal_vc, 8) then
			-- 		settings.mh.price.heal_vc = u8:decode(ffi.string(input_heal_vc))
			-- 		save_settings()
			-- 	end
			-- 	imgui.Separator()
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������� ��������� (SA $)', input_healactor, 8) then
			-- 		settings.mh.price.healactor = u8:decode(ffi.string(input_healactor))
			-- 		save_settings()
			-- 	end
			-- 	imgui.SameLine()
			-- 	imgui.SetCursorPosX(300 * settings.general.custom_dpi)
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������� ��������� (VC $)', input_healactor_vc, 8) then
			-- 		settings.mh.price.healactor_vc = u8:decode(ffi.string(input_healactor_vc))
			-- 		save_settings()
			-- 	end
			-- 	imgui.Separator()
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ���������� ���. ������� ��� �������', input_medosm, 8) then
			-- 		settings.mh.price.medosm = u8:decode(ffi.string(input_medosm))
			-- 		save_settings()
			-- 	end
			-- 	imgui.Separator()
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ���������� ���. ������� ��� �������� ������', input_mticket, 8) then
			-- 		settings.mh.price.mticket = u8:decode(ffi.string(input_mticket))
			-- 		save_settings()
			-- 	end
			-- 	imgui.Separator()
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ���������� ������ ������� ����������������', input_healbad, 8) then
			-- 		settings.mh.price.healbad = u8:decode(ffi.string(input_healbad))
			-- 		save_settings()
			-- 	end
			-- 	imgui.Separator()
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������ �������', input_recept, 8) then
			-- 		settings.mh.price.recept = u8:decode(ffi.string(input_recept))
			-- 		save_settings()
			-- 	end
			-- 	imgui.Separator()
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������ �����������', input_ant, 8) then
			-- 		settings.mh.price.ant = u8:decode(ffi.string(input_ant))
			-- 		save_settings()
			-- 	end
			-- 	imgui.Separator()
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������ ���.����� �� 7 ����', input_med7, 8) then
			-- 		settings.mh.price.med7 = u8:decode(ffi.string(input_med7))
			-- 		save_settings()
			-- 	end
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������ ���.����� �� 14 ����', input_med14, 8) then
			-- 		settings.mh.price.med14 = u8:decode(ffi.string(input_med14))
			-- 		save_settings()
			-- 	end
			-- 	imgui.Separator()
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������ ���.����� �� 30 ����', input_med30, 8) then
			-- 		settings.mh.price.med30 = u8:decode(ffi.string(input_med30))
			-- 		save_settings()
			-- 	end
			-- 	imgui.Separator()
			-- 	imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 	if imgui.InputText(u8'  ������ ���.����� �� 60 ����', input_med60, 8) then
			-- 		settings.mh.price.med60 = u8:decode(ffi.string(input_med60))
			-- 		save_settings()
			-- 	end
			-- imgui.EndTabItem()
			-- end


			-- if imgui.BeginTabItem(fa.MONEY_CHECK_DOLLAR..u8' ������� ��������') then 
			-- 	local input_prices = {
			-- 		avto = { imgui.new.char[256](u8(settings.lc.price.avto1)), imgui.new.char[256](u8(settings.lc.price.avto2)), imgui.new.char[256](u8(settings.lc.price.avto3},
			-- 		moto = { imgui.new.char[256](u8(settings.lc.price.moto1)), imgui.new.char[256](u8(settings.lc.price.moto2)), imgui.new.char[256](u8(settings.lc.price.moto3},
			-- 		fish = { imgui.new.char[256](u8(settings.lc.price.fish1)), imgui.new.char[256](u8(settings.lc.price.fish2)), imgui.new.char[256](u8(settings.lc.price.fish3},
			-- 		swim = { imgui.new.char[256](u8(settings.lc.price.swim1)), imgui.new.char[256](u8(settings.lc.price.swim2)), imgui.new.char[256](u8(settings.lc.price.swim3},
			-- 		gun = { imgui.new.char[256](u8(settings.lc.price.gun1)), imgui.new.char[256](u8(settings.lc.price.gun2)), imgui.new.char[256](u8(settings.lc.price.gun3},
			-- 		hunt = { imgui.new.char[256](u8(settings.lc.price.hunt1)), imgui.new.char[256](u8(settings.lc.price.hunt2)), imgui.new.char[256](u8(settings.lc.price.hunt3},
			-- 		klad = { imgui.new.char[256](u8(settings.lc.price.klad1)), imgui.new.char[256](u8(settings.lc.price.klad2)), imgui.new.char[256](u8(settings.lc.price.klad3},
			-- 		taxi = { imgui.new.char[256](u8(settings.lc.price.taxi1)), imgui.new.char[256](u8(settings.lc.price.taxi2)), imgui.new.char[256](u8(settings.lc.price.taxi3},
			-- 		mexa = { imgui.new.char[256](u8(settings.lc.price.mexa1)), imgui.new.char[256](u8(settings.lc.price.mexa2)), imgui.new.char[256](u8(settings.lc.price.mexa3},
			-- 		fly = { imgui.new.char[256](u8(settings.lc.price.fly1)), imgui.new.char[256](u8(settings.lc.price.fly2)), imgui.new.char[256](u8(settings.lc.price.fly3}
			-- 	}
			-- 	local license_types = {
			-- 		{ name = '����', key = 'avto' },
			-- 		{ name = '����', key = 'moto' },
			-- 		{ name = '�����', key = 'swim' },
			-- 		{ name = '������', key = 'fly' },
			-- 		{ name = '������', key = 'gun' },
			-- 		{ name = '�����', key = 'hunt' },
			-- 		{ name = '�������', key = 'fish' },
			-- 		{ name = '��������', key = 'klad' },
			-- 		{ name = '�����', key = 'taxi' },
			-- 		{ name = '�������', key = 'mexa' },
			-- 	}
			-- 	for _, license in ipairs(license_types) do
			-- 		for month = 1, 3 do
			-- 			imgui.PushItemWidth(65 * settings.general.custom_dpi)
			-- 			if imgui.InputText(u8(string.format('  %s (%d �����%s)', license.name, month, month == 1 and '' or '�')), input_prices[license.key][month], 9) then
			-- 				settings.price[license.key .. month] = u8:decode(ffi.string(input_prices[license.key][month]))
			-- 				save_settings()
			-- 			end
			-- 			if month == 1 then
			-- 				imgui.SameLine()
			-- 				imgui.SetCursorPosX(200 * settings.general.custom_dpi)
			-- 			elseif month == 2 then
			-- 				imgui.SameLine()
			-- 				imgui.SetCursorPosX(400 * settings.general.custom_dpi)
			-- 			else
			-- 				imgui.Separator()
			-- 			end
			-- 		end
			-- 	end
			-- imgui.EndTabItem()
			-- end



			-- if imgui.BeginChild('##2', imgui.ImVec2(589 * settings.general.custom_dpi, 58 * settings.general.custom_dpi), true) then
				-- 	imgui.CenterText(fa.ROBOT .. u8' ���������')
				-- 	imgui.Separator()
				-- 	imgui.Columns(2)
				-- 	imgui.CenterColumnText(u8("��� ����������� �������� ��� ������������� ��������� ��������"))
				-- 	imgui.SetColumnWidth(-1, 480 * settings.general.custom_dpi)
				-- 	imgui.NextColumn()
				-- 	if imgui.CenterColumnSmallButton(u8'����������') then
				-- 		--imgui.OpenPopup(fa.ROBOT .. u8' ��������� �������������� (��� ������) ��������� ���� ��������')
				-- 	end
				-- 	-- if imgui.BeginPopupModal(fa.ROBOT .. u8' ��������� �������������� (��� ������) ��������� ���� ��������', _, imgui.WindowFlags.NoCollapse  + imgui.WindowFlags.NoResize ) then
				-- 	-- 	change_dpi()
				-- 	-- 	imgui.BeginChild('##ai', imgui.ImVec2(589 * settings.general.custom_dpi, 350 * settings.general.custom_dpi), true)
				-- 	-- 	if imgui.Checkbox(u8(' [� �������] ������ � ����� ������ 10 ����� �������'), checkbox.patrool_autodoklad) then
				-- 	-- 		settings.general.auto_doklad_patrool = checkbox.patrool_autodoklad[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	if imgui.Checkbox(u8(' [� �������] ��������� ������������� ���� �� CODE 3/4 ��� ���/���� �������'), checkbox.change_code_siren) then
				-- 	-- 		settings.general.auto_change_code_siren = checkbox.change_code_siren[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	if imgui.Checkbox(u8(' [��� ��������� �����] ������ � ����� ��� CODE 0 � �������� ���� � ��� �����'), checkbox.autodoklad_damage) then
				-- 	-- 		settings.general.auto_doklad_damage = checkbox.autodoklad_damage[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	if imgui.Checkbox(u8(' [�������� ����������] �������� ��������/���.�����/�������� �� /offer � �� ����������'), checkbox.auto_accept_docs) then
				-- 	-- 		settings.general.auto_accept_docs = checkbox.auto_accept_docs[0]
				-- 	-- 		save_settings()
				-- 	-- 	end	
				-- 	-- 	if imgui.Checkbox(u8(' [����������� �����] ������ � ����� � ������ ������������'), checkbox.autodoklad_arrest) then
				-- 	-- 		settings.general.auto_doklad_arrest = checkbox.autodoklad_arrest[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	if imgui.Checkbox(u8(' [��� ������, ������ �������, ������] ������ /time ��� ����������'), checkbox.auto_time) then
				-- 	-- 		settings.general.auto_time = checkbox.auto_time[0]
				-- 	-- 		save_settings()
				-- 	-- 	end	
				-- 	-- 	if imgui.Checkbox(u8(' [�������������] ���������� ���� ������ ������ � ��������'), checkbox.autodocumentation) then
				-- 	-- 		settings.mj.auto_case_documentation = checkbox.autodocumentation[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	if imgui.Checkbox(u8(' [���� /wanteds] ���������� ������ ������������ ������ 15 ������'), checkbox.update_wanteds) then
				-- 	-- 		settings.mj.auto_update_wanteds = checkbox.update_wanteds[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	if imgui.Checkbox(u8(' [���� /mb] ���������� ������ ����������� ������ 2 �������'), checkbox.update_members) then
				-- 	-- 		settings.general.auto_update_members = checkbox.update_members[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	if imgui.Checkbox(u8(' [��� ����� ����� � ����] ������������ ��������� ����� �����'), checkbox.auto_mask) then
				-- 	-- 		settings.general.auto_mask = checkbox.auto_mask[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	if imgui.Checkbox(u8(' [��������� ��������] ���������� �� ���� ������ (') .. fa.TRIANGLE_EXCLAMATION .. u8(' ����� ���� ���������!)'), checkbox.auto_clicker) then
				-- 	-- 		(settings.mj.auto_clicker_situation or settings.mh.auto_clicker_situation) = checkbox.auto_clicker[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	if imgui.Checkbox(u8(' [AWANTED] ���������� ���� ���������� � ���� ���������� (') .. fa.TRIANGLE_EXCLAMATION .. u8(' ����� ���� ���������!)'), checkbox.awanted) then
				-- 	-- 		settings.mj.awanted = checkbox.awanted[0]
				-- 	-- 		save_settings()
				-- 	-- 	end
				-- 	-- 	imgui.EndChild()
		
				-- 	-- 	imgui.EndPopup()
				-- 	-- end
				-- 	imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
				-- 	imgui.Columns(1)
				-- imgui.EndChild()
				-- end

				-- if imgui.BeginChild('##2', imgui.ImVec2(589 * settings.general.custom_dpi, 150 * settings.general.custom_dpi), true) then
				-- 	imgui.CenterText(fa.SITEMAP .. u8' �������������� �������')
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"���� ��������� ������")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8"������� ��������� ������ ������� ��������� �� ������� �� 1 �����\n��� ����� �� �� ������ �������� �������� �� ��-�� ���� ������")
				-- 	end
				-- 	imgui.SetColumnWidth(-1, 230 * settings.general.custom_dpi)
				-- 	imgui.NextColumn()
				-- 	if settings.general.anti_trivoga then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.SetColumnWidth(-1, 250 * settings.general.custom_dpi)
				-- 	imgui.NextColumn()
				-- 	if settings.general.anti_trivoga then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##anti_trivoga') then
				-- 			settings.general.anti_trivoga = false
				-- 			save_settings()
				-- 		end
				-- 		else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##anti_trivoga') then
				-- 			settings.general.anti_trivoga = true
				-- 			save_settings()
				-- 		end
				-- 	end
				-- 	imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
				-- 	imgui.Columns(1)
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"��� �� ���� (������� ������)")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8"��������� �������� ����� ������ ������, �� ��, ������ ��������� ������� ������ ���� �� ��������")
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.mh.heal_in_chat then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.mh.heal_in_chat then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##heal_in_chat') then
				-- 			settings.mh.heal_in_chat = false
				-- 			save_settings()
				-- 		end
				-- 	else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##heal_in_chat') then
				-- 			if not isMonetLoader() and not hotkey_no_errors then
				-- 				sampAddChatMessage('[Rodina Helper] {ffffff}������, ������ �������� "��� �� ����" ��� ��� � ��� ���� Mimgui Hotkeys!', message_color)
				-- 			else
				-- 				settings.mh.heal_in_chat = true
				-- 				settings.mh.auto_heal = false
				-- 				save_settings()
				-- 			end
							
				-- 		end
				-- 	end
				-- 	imgui.Columns(1)
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"��� �� ���� (�������������)")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8"�������������, ��� ��, ����� ��������� ������� ������ ���� �� ��������")
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.mh.auto_heal then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.mh.auto_heal then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##auto_heal') then
				-- 			settings.mh.auto_heal = false
				-- 			save_settings()
				-- 		end
				-- 	else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##auto_heal') then
				-- 			settings.mh.auto_heal = true
				-- 			settings.mh.heal_in_chat = false
				-- 			save_settings()
				-- 		end
				-- 	end
				-- 	imgui.Columns(1)
				-- 	imgui.Separator()
				
				-- 	imgui.Columns(1)
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"������ �� ��� (��)")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8"���������� � �������� �� ��������� ��� (������� � ��)")
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.general.auto_clicker then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.general.auto_clicker then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##auto_clicker') then
				-- 			settings.general.auto_clicker = false
				-- 			save_settings()
				-- 		end
				-- 		else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##auto_clicker') then
				-- 			settings.general.auto_clicker = true
				-- 			save_settings()
				-- 		end
				-- 	end
				-- 	imgui.Columns(1)
				-- imgui.EndChild()
				-- end

				-- if imgui.BeginChild('##2', imgui.ImVec2(589 * settings.general.custom_dpi, 150 * settings.general.custom_dpi), true) then
				-- 	imgui.CenterText(fa.SITEMAP .. u8' �������������� �������')
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"RP �������")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8"��� ���� ��������� � ��� ������������� ����� � ��������� ����� � � ������ � �����")
				-- 	end
				-- 	imgui.SetColumnWidth(-1, 230 * settings.general.custom_dpi)
				-- 	imgui.NextColumn()
				-- 	if settings.general.rp_chat then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.SetColumnWidth(-1, 250 * settings.general.custom_dpi)
				-- 	imgui.NextColumn()
				-- 	if settings.general.rp_chat then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##rp_chat') then
				-- 			settings.general.rp_chat = false
				-- 			save_settings()
				-- 		end
				-- 		else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##rp_chat') then
				-- 			settings.general.rp_chat = true
				-- 			save_settings()
				-- 		end
				-- 	end
				-- 	imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
				-- 	imgui.Columns(1)
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"RP �������")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8"��� �������������/������� ������� � ���� ����� RP ���������.")
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.general.rp_gun then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.general.rp_gun then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##rp_gun') then
				-- 			settings.general.rp_gun = false
				-- 			save_settings()
				-- 		end
				-- 	else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##rp_gun') then
				-- 			settings.general.rp_gun = true
				-- 			save_settings()
				-- 		end
				-- 	end
				-- 	imgui.Columns(1)
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"����-������ ��������")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8'������������� ����� �������� ������� ���� �� ������ �� �������\n������ ������ �������� � ��� ��� �������� (����������������� �����) � ����\n���� �� ������� ����, � ������ �������� "�����", �� ���������� �� 1 �����')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.general.auto_lic then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.general.auto_lic then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##auto_lic') then
				-- 			settings.general.auto_lic = false
				-- 			save_settings()
				-- 		end
				-- 		else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##auto_lic') then
				-- 			settings.general.auto_lic = true
				-- 			save_settings()
				-- 		end
				-- 	end
				-- 	imgui.Columns(1)
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"����-������ ������� ������")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8'������������� ����������� �������� ����� ������� ����� ������')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.general.auto_repair then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.general.auto_repair then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##auto_repair') then
				-- 			settings.general.auto_repair = false
				-- 			save_settings()
				-- 		end
				-- 		else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##auto_repair') then
				-- 			settings.general.auto_repair = true
				-- 			save_settings()
				-- 		end
				-- 	end
				-- 	imgui.Columns(1)
			
				-- imgui.EndChild()
				-- end

				-- if imgui.BeginChild('##3', imgui.ImVec2(589 * settings.general.custom_dpi, 98 * settings.general.custom_dpi), true) then
				-- 	imgui.CenterText(fa.SITEMAP .. u8' �������������� ������� �������')
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"�������������� ����")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8"����������� �� ������ ������� � �����������")
				-- 	end
				-- 	imgui.SetColumnWidth(-1, 230 * settings.general.custom_dpi)
				-- 	imgui.NextColumn()
				-- 	if settings.general.use_info_menu then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.SetColumnWidth(-1, 250 * settings.general.custom_dpi)
				-- 	imgui.NextColumn()
				-- 	if settings.general.use_info_menu then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##info_menu') then
				-- 			settings.general.use_info_menu = false
				-- 			InformationWindow[0] = false
				-- 			save_settings()
				-- 		end
				-- 		else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##info_menu') then
				-- 			settings.general.use_info_menu = true
				-- 			InformationWindow[0] = true
				-- 			save_settings()
				-- 		end
				-- 	end
				-- 	imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
				-- 	imgui.Columns(1)
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"����� RP ��������� ������")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8"��� �������������/������� ������ � ���� ����� RP ���������.")
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.general.rp_gun then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if imgui.CenterColumnSmallButton(u8'���������##rp_gun') then
				-- 		imgui.OpenPopup(fa.GUN .. u8' ��������� RP ������##weapon_name')
				-- 	end
				-- 	if imgui.BeginPopupModal(fa.GUN .. u8' ��������� RP ������##weapon_name', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize ) then
				-- 		change_dpi()
				-- 		if imgui.Button((settings.general.rp_gun and u8'���������##rp_gun' or u8'��������##rp_gun'), imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				-- 			settings.general.rp_gun = not settings.general.rp_gun
				-- 			save_settings()
				-- 			imgui.CloseCurrentPopup()
				-- 		end
				-- 		imgui.SameLine()
				-- 		if imgui.Button(fa.GEAR .. u8' �������� RP ����', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				-- 			RPWeaponWindow[0] = true
				-- 			if not settings.general.rp_gun then
				-- 				settings.general.rp_gun = true
				-- 				save_settings()
				-- 			end
				-- 			imgui.CloseCurrentPopup()
				-- 		end
				-- 		imgui.End()
				-- 	end
				-- 	imgui.Columns(1)
				-- 	imgui.Separator()
				-- 	imgui.Columns(3)
				-- 	imgui.CenterColumnText(u8"����� RP ������� � �����")
				-- 	imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
				-- 	if imgui.IsItemHovered() then
				-- 		imgui.SetTooltip(u8"��� ���� ��������� ����� � ��������� ����� � � ������ � �����.\n�������� � ������� ���� � ��������� ����� ������������ ��������:\n/r /rb /j /jb /m /s /b /n /do /vr /fam /al")
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.player_info.rp_chat then
				-- 		imgui.CenterColumnText(u8'��������')
				-- 	else
				-- 		imgui.CenterColumnText(u8'���������')
				-- 	end
				-- 	imgui.NextColumn()
				-- 	if settings.player_info.rp_chat then
				-- 		if imgui.CenterColumnSmallButton(u8'���������##rp_chat') then
				-- 			settings.player_info.rp_chat = false
				-- 			save_settings()
				-- 		end
				-- 		else
				-- 		if imgui.CenterColumnSmallButton(u8'��������##rp_chat') then
				-- 			settings.player_info.rp_chat = true
				-- 			save_settings()
				-- 		end
				-- 	end
				-- 	imgui.Columns(1)
				-- imgui.EndChild()
				-- end



-- end

imgui.OnFrame(
    function() return MainWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 430	* settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(getHelperIcon() .. " Rodina Helper " .. getHelperIcon() .. "##main", MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize )
		change_dpi()
		if imgui.BeginTabBar('�� ��� ��������, �?') then	
			if imgui.BeginTabItem(fa.HOUSE..u8' ������� ����') then
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
						imgui.CenterTextDisabled(u8('�� ������� ������������� ��������� ������� � ������ ����� �������!\n\n'))
						imgui.CenterTextDisabled(u8('�� ����� �������� VPN ��� ��������� ������ ������, ���� �������� �������'))
						imgui.CenterTextDisabled(u8('https://github.com/komarova140784-web/Rodina-Helper-/tree/main'))
						imgui.EndChild()
					end
				end
				if imgui.BeginChild('##2', imgui.ImVec2(589 * settings.general.custom_dpi, 169 * settings.general.custom_dpi), true) then
					imgui.CenterText(getUserIcon() .. u8' ���������� ��� ������ ��������� ' .. getUserIcon())
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"��� � �������:")
					imgui.SetColumnWidth(-1, 230 * settings.general.custom_dpi)
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.name_surname))
					imgui.SetColumnWidth(-1, 250 * settings.general.custom_dpi)
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##name_surname') then
						settings.player_info.name_surname = TranslateNick(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
						imgui.StrCopy(input, u8(settings.player_info.name_surname))
						imgui.OpenPopup(getUserIcon() .. u8' ��� � ������� ' .. getUserIcon() .. '##name_surname')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getUserIcon() .. u8' ��� � ������� ' .. getUserIcon() .. '##name_surname', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##name_surname', u8('������� ��� � ������� ������ ���������...'), input, 256) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. '##cancel_name_surname', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
							imgui.StrCopy(input, '')
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. '##save_name_surname', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							settings.player_info.name_surname = u8:decode(ffi.string(input))
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"������ ���������:")
					imgui.NextColumn()
					if checkbox.accent_enable[0] then
						imgui.CenterColumnText(u8(settings.player_info.accent))
					else 
						imgui.CenterColumnText(u8'���������')
					end
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##accent') then
						imgui.StrCopy(input, u8(settings.player_info.accent))
						imgui.OpenPopup(getUserIcon() .. u8' ������ ��������� ' .. getUserIcon() .. '##accent')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getUserIcon() .. u8' ������ ��������� ' .. getUserIcon() .. '##accent', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						if imgui.Checkbox('##checkbox.accent_enable', checkbox.accent_enable) then
							settings.player_info.accent_enable = checkbox.accent_enable[0]
							save_settings()
						end
						imgui.SameLine()
						imgui.PushItemWidth(375 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##accent_input', u8('������� ������ ������ ���������...'), input, 256) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. '##cancel_accent', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.StrCopy(input, '')
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. '##save_accent', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then 
							settings.player_info.accent = u8:decode(ffi.string(input))
							save_settings()
							imgui.StrCopy(input, '')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"��� ���������:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.sex))
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##sex') then
						settings.player_info.sex = (settings.player_info.sex ~= '�������') and '�������' or '�������'
						save_settings()
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"�����������:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.fraction))
					imgui.NextColumn()
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. "##fraction") then
						imgui.StrCopy(input, u8(settings.player_info.fraction))
						imgui.OpenPopup(getHelperIcon() .. u8' ����������� ' .. getHelperIcon() .. '##fraction')
					end
					if imgui.BeginPopupModal(getHelperIcon() .. u8' ����������� ' .. getHelperIcon() .. '##fraction', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##input_fraction_name', u8('������� �������� ����� �����������...'), input, 256)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. '##cancel_fraction_edit', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.StrCopy(input, '')
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. '##save_fraction_edit', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							settings.player_info.fraction = u8:decode(ffi.string(input))
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.GEAR .. '##fraction') then
						imgui.OpenPopup(getHelperIcon() .. u8' ����� ����������� ' .. getHelperIcon() .. '##fraction')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' ����� ����������� ' .. getHelperIcon() .. '##fraction', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8('�� ������������� ������ �������� �����������?'))
						imgui.CenterText(u8('� ������ ����� ��� RP ������� ����� �������� �� ������!'))
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. '##cancel_new_fraction', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.StrCopy(input, '')
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.GEARS .. u8' �������� ' .. fa.GEARS .. '##reset_fraction', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							modules.commands.data.commands.my = {{cmd = 'time' , description = '���������� �����' ,  text = '/me ��������{sex} �� ���� ���� � ����������� Rodina Helper � ���������{sex} �����&/time&/do �� ����� ����� ����� {get_time}.' , arg = '' , enable = true, waiting = '2.5', bind = "{}" }}
							modules.commands.data.commands_manage.my = {}
							InititalWindow[0] = true
							MainWindow[0] = false
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"���������:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.fraction_rank) .. " (" .. settings.player_info.fraction_rank_number .. ")")
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. "##rank") then
						imgui.StrCopy(input, u8(settings.player_info.fraction_rank))
						slider[0] = settings.player_info.fraction_rank_number
						imgui.OpenPopup(getHelperIcon() .. u8' ��������� � ����������� ' .. getHelperIcon() .. '##fraction_rank')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' ��������� � ����������� ' .. getHelperIcon() .. '##fraction_rank', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputTextWithHint(u8'##input_fraction_rank', u8('������� �������� ����� ���������...'), input, 256)
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.SliderInt('##fraction_rank_number', slider, 1, 10) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. '##cancel_fraction_rank', imgui.ImVec2(132 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.StrCopy(input, '')
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.PASSPORT .. u8' �������� /stats ' .. fa.PASSPORT .. '##stats_fraction_rank', imgui.ImVec2(132 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							check_stats = true
							sampSendChat('/stats')
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. '##save_fraction_rank', imgui.ImVec2(132 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							settings.player_info.fraction_rank = u8:decode(ffi.string(input))
							imgui.StrCopy(input, '')
							settings.player_info.fraction_rank_number = slider[0]
							if settings.player_info.fraction_rank_number >= 9 then
								settings.general.auto_uval = true
								registerCommandsFrom(modules.commands.data.commands_manage.my)
							end	
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.Columns(1)
					imgui.Columns(1)
					imgui.Separator()
					imgui.Columns(3)
					imgui.CenterColumnText(u8"��� �����������:")
					imgui.NextColumn()
					imgui.CenterColumnText(u8(settings.player_info.fraction_tag))
					imgui.NextColumn()
					if imgui.CenterColumnSmallButton(fa.PEN_TO_SQUARE .. '##fraction_tag') then
						imgui.StrCopy(input, u8(settings.player_info.fraction_tag))
						imgui.OpenPopup(getHelperIcon() .. u8' ��� ����������� ' .. getHelperIcon() .. '##fraction_tag')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(getHelperIcon() .. u8' ��� ����������� ' .. getHelperIcon() .. '##fraction_tag', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.PushItemWidth(405 * settings.general.custom_dpi)
						imgui.InputText(u8'##input_fraction_tag', input, 256)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. '##cancel_fraction_rank', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.StrCopy(input, '')
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. '##save_fraction_tag', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							settings.player_info.fraction_tag = u8:decode(ffi.string(input))
							save_settings()
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
				imgui.EndChild()
				end
				if imgui.BeginChild('##3', imgui.ImVec2(589 * settings.general.custom_dpi, 28 * settings.general.custom_dpi), true) then
					if thisScript().version:find('VIP') then
						imgui.CenterText(fa.CROWN .. u8" �� VIP ������������ ������� �������! " .. fa.CROWN)
					else
						imgui.Columns(2)
						imgui.Text(fa.HAND_HOLDING_DOLLAR .. u8" VIP ������� �� �������� " .. fa.HAND_HOLDING_DOLLAR)
						imgui.SetColumnWidth(-1, 480 * settings.general.custom_dpi)
						imgui.NextColumn()
						if imgui.CenterColumnSmallButton(u8'���������') then
							imgui.OpenPopup(fa.SACK_DOLLAR .. u8' ��������� ������������')
						end
						if imgui.BeginPopupModal(fa.SACK_DOLLAR .. u8' ��������� ������������', _, imgui.WindowFlags.NoCollapse  + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
							change_dpi()
							if not isMonetLoader() then imgui.SetWindowFontScale(settings.general.custom_dpi) end
							imgui.CenterText(u8'��������� � Fil')
							--imgui.SetCursorPosX(20*settings.general.custom_dpi)
							if imgui.Button(u8('Telegram'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
								openLink('')
							end
							imgui.SameLine()
							if imgui.Button(u8('Discord'), imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
								openLink('')
							end
							imgui.End()
						end
						imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
						imgui.Columns(1)
					end
					
					imgui.EndChild()
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.RECTANGLE_LIST..u8' ������� � RP ���������') then 
				if imgui.BeginTabBar('Tabs2') then
					if imgui.BeginTabItem(fa.BARS..u8' �����������') then 
						if imgui.BeginChild('##99', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
							imgui.Columns(2)
							imgui.CenterColumnText(u8"�������")
							imgui.SetColumnWidth(-1, 220 * settings.general.custom_dpi)
							imgui.NextColumn()
							imgui.CenterColumnText(u8"��������")
							imgui.SetColumnWidth(-1, 400 * settings.general.custom_dpi)
							imgui.Columns(1)
							imgui.Separator()
							imgui.Columns(2)
							imgui.CenterColumnText(u8"/rpguns")
							imgui.NextColumn()
							imgui.CenterColumnText(u8"���� RP ������")
							imgui.Columns(1)
							imgui.Separator()
							imgui.Columns(2)
							imgui.CenterColumnText(u8"/pnv")
							imgui.NextColumn()
							imgui.CenterColumnText(u8"������/����� ���� ������� �������")
							imgui.Columns(1)
							imgui.Separator()
							imgui.Columns(2)
							imgui.CenterColumnText(u8"/irv")
							imgui.NextColumn()
							imgui.CenterColumnText(u8"������/����� ������������ ����")
							imgui.Columns(1)
							imgui.Separator()
							if not isMode('none') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/mb")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���� ������������� /members")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/dep")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���� ����� ������������")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/sob")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���� ���������� �������������")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/post")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���� ������� ������")
								imgui.Columns(1)
								imgui.Separator()
							end
							if isMode('prison') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/pum")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���� ������ ��������� �����")
								imgui.Columns(1)
								imgui.Separator()
							end
							if isMode('police') or isMode('fbi') then
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/wanteds")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���� ������ ������ /wanted")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/patrool")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���� ��������������")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/sum")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���� ����� ������ �������")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/tsm")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���� ����� ������ �������")
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(2)
								imgui.CenterColumnText(u8"/afind")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"������ /find ��� ������ ������ �� ID")
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
							imgui.CenterColumnText(u8"�������")
							imgui.SetColumnWidth(-1, 170 * settings.general.custom_dpi)
							imgui.NextColumn()
							imgui.CenterColumnText(u8"��������")
							imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
							imgui.NextColumn()
							imgui.CenterColumnText(u8"��������")
							imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
							imgui.Columns(1)
							imgui.Separator()
							if isManage then
								imgui.Columns(3)
								imgui.CenterColumnText(u8"�������������� ����")
								imgui.SameLine(nil, 5) imgui.TextDisabled("[?]")
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8"������� ������ ��� ������ ��� ��� ������������!\n��������� ������������� ��������� ��� ��� ������ ���\n� ������������� �� ������, ���� �������� ��������� � /rb")
								end
								imgui.NextColumn()
								if settings.general.auto_uval then
									imgui.CenterColumnText(u8'��������')
								else
									imgui.CenterColumnText(u8'���������')
								end
								imgui.NextColumn()
								if imgui.CenterColumnSmallButton(settings.general.auto_uval and u8('���������') or u8('��������') .. '##auto_uval') then
									settings.general.auto_uval = not settings.general.auto_uval 
									save_settings()
								end
								imgui.Columns(1)
								imgui.Separator()
								imgui.Columns(3)
								imgui.CenterColumnText(u8"/spcar")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���������� ��������� �����������")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"����������")
								imgui.Columns(1)
								imgui.Separator()	
							else
								imgui.Columns(3)
								imgui.CenterColumnText(u8"/stop")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"���������� ��������� ����� RP �������")
								imgui.NextColumn()
								imgui.CenterColumnText(u8"����������")
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
									local tooltip = command.enable and "���������� ������� /" or "��������� ������� /"
									imgui.SetTooltip(u8(tooltip .. command.cmd))
								end
								imgui.SameLine()
								if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##'..command.cmd) then
									if command.arg == '' then
										ComboTags[0] = 0
									elseif command.arg == '{arg}' then	
										ComboTags[0] = 1
									elseif command.arg == '{arg_id}' then
										ComboTags[0] = 2
									elseif command.arg == '{arg_id} {arg2}' then
										ComboTags[0] = 3
									elseif command.arg == '{arg_id} {arg2} {arg3}' then
										ComboTags[0] = 4
									elseif command.arg == '{arg_id} {arg2} {arg3} {arg4}' then
										ComboTags[0] = 5
									end
									binder_data = {
										change_waiting = command.waiting,
										change_cmd = command.cmd,
										change_text = command.text:gsub('&', '\n'),
										change_arg = command.arg,
										change_bind = command.bind,
										change_in_fastmenu = command.in_fastmenu,
										create_command_9_10 = isManage
									}
									input_description = imgui.new.char[256](u8(command.description))
									input_cmd = imgui.new.char[256](u8(command.cmd))
									input_text = imgui.new.char[8192](u8(binder_data.change_text))
									waiting_slider = imgui.new.float(tonumber(command.waiting))	
									BinderWindow[0] = true
								end
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8"��������� ������� /"..command.cmd)
								end
								imgui.SameLine()
								if imgui.SmallButton(fa.TRASH_CAN .. '##'..command.cmd) then
									imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION ..  '##' .. command.cmd)
								end
								if imgui.IsItemHovered() then
									imgui.SetTooltip(u8"�������� ������� /"..command.cmd)
								end
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION ..  '##' .. command.cmd, _, imgui.WindowFlags.NoResize ) then
									change_dpi()
									imgui.CenterText(u8'�� ������������� ������ ������� ������� /' .. u8(command.cmd) .. '?')
									imgui.Separator()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ���, �������� ' .. fa.CIRCLE_XMARK .. '##delete_cmd' .. index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.TRASH_CAN .. u8' ��, ������� ' .. fa.TRASH_CAN .. '##delete_cmd' .. index, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
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
						if imgui.Button(fa.CIRCLE_PLUS .. u8' ������� ����� ������� ' .. fa.CIRCLE_PLUS .. '##new_cmd' .. (isManage and 1 or 2), imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
							local new_cmd = {cmd = '', description = '', text = '', arg = '', enable = true, waiting = '2.5', bind = "{}" }
							table.insert(cmd_array, new_cmd)
							binder_data = {
								change_waiting = new_cmd.waiting,
								change_cmd = new_cmd.cmd,
								change_text = new_cmd.text,
								change_arg = new_cmd.arg,
								change_bind = new_cmd.bind,
								change_in_fastmenu = false,
								create_command_9_10 = isManage
							}
							ComboTags[0] = 0
							input_description = imgui.new.char[256]("")
							input_cmd = imgui.new.char[256]("")
							input_text = imgui.new.char[8192]("")
							waiting_slider = imgui.new.float(1.5)
							BinderWindow[0] = true
						end
					end
					if imgui.BeginTabItem(fa.BARS..u8' RP ������� (�����)') then 
						render_cmds(false)
						imgui.EndTabItem()
					end
					if imgui.BeginTabItem(fa.BARS..u8' RP ������� (��� 9/10)') then 
						if settings.player_info.fraction_rank_number == 9 or settings.player_info.fraction_rank_number == 10 then
							render_cmds(true)
						else
							imgui.CenterText(fa.TRIANGLE_EXCLAMATION .. u8" �������� " .. fa.TRIANGLE_EXCLAMATION)
							imgui.Separator()
							imgui.CenterText(u8"� ��� ���� ������� � ������ ��������!")
							imgui.CenterText(u8"���������� ����� 9 ��� 10 ����, � ��� �� - "..settings.player_info.fraction_rank_number..u8" ����!")
							imgui.Separator()
						end
						imgui.EndTabItem() 
					end
					if imgui.BeginTabItem(fa.COMPASS .. u8' Fast Menu') then 
						function render_fastmenu_item(name, use, text, text2)
							if imgui.BeginChild('##fastmenu'..name, imgui.ImVec2(194 * settings.general.custom_dpi, 339 * settings.general.custom_dpi), true) then
								imgui.CenterText(u8(name))
								imgui.Separator()
								imgui.CenterText(u8("�������������:"))
								imgui.CenterText(use)
								imgui.SetCursorPosY(110 * settings.general.custom_dpi)
								imgui.CenterText(u8("��������:"))
								imgui.CenterText(u8(text))
								imgui.SetCursorPosY(200 * settings.general.custom_dpi)
								imgui.CenterText(u8("��������� �������� �������:"))
								imgui.CenterText(u8(text2))
								imgui.SetCursorPosY(290 * settings.general.custom_dpi)
								imgui.CenterText(u8("��������� ���/���� �������"))
								if imgui.Button(fa.GEAR .. u8(' ��������� ������� ���� ') .. '##' .. name) then
									if name == 'PieMenu' then
										sampAddChatMessage('[Rodina Helper] {ffffff}PieMenu �������� ���������� ��� ��������������', message_color)
									else
										imgui.OpenPopup(fa.COMPASS .. u8' ��������� ������ � ' .. u8(name) .. ' ' .. fa.COMPASS .. "##" .. name)
									end
								end
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.COMPASS .. u8' ��������� ������ � ' .. u8(name) .. ' ' .. fa.COMPASS .. "##" .. name, _, imgui.WindowFlags.NoResize ) then
									change_dpi()
									if imgui.BeginChild('##fastmenu_configurige'..name, imgui.ImVec2(589 * settings.general.custom_dpi, 366 * settings.general.custom_dpi), true) then
										local arr = {}
										if name == 'FastMenu' then
											arr = modules.commands.data.commands.my
										elseif name == 'Leader FastMenu' then
											arr = modules.commands.data.commands_manage.my
										elseif name == 'piemenu' then
											arr = modules.commands.data.commands_pie.my or {}
										end
										imgui.Columns(3)
										imgui.CenterColumnText(u8"���������� � ����")
										imgui.SetColumnWidth(-1, 160 * settings.general.custom_dpi)
										imgui.NextColumn()
										imgui.CenterColumnText(u8"�������")
										imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
										imgui.NextColumn()
										imgui.CenterColumnText(u8"��������")
										imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
										imgui.Columns(1)
										for index, value in ipairs(arr) do
											if (value.arg == "{arg_id}") then
												imgui.Separator()
												imgui.Columns(3)
												local btn = (value.in_fastmenu) and (fa.SQUARE_CHECK .. u8'  (����)') or (fa.SQUARE .. u8'  (����)')
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
										imgui.EndChild()
									end
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ������� ' .. fa.CIRCLE_XMARK .. '##close_fast', imgui.ImVec2(591 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.End()
								end
								imgui.EndChild()
							end
						end
						render_fastmenu_item(
							'FastMenu',
							u8'/hm ID ��� ' .. fa.KEYBOARD .. (isMonetLoader() and u8' ��������' or u8' Hotkeys'),
							'������� ����� RP ������',
							'{arg_id}'
						)
						imgui.SameLine()
						render_fastmenu_item(
							'Leader FastMenu',
							u8'/lm ID ��� ' .. fa.KEYBOARD .. (isMonetLoader() and u8' ��������' or u8' Hotkeys'),
							'������� ����� RP ������ 9-10',
							'{arg_id}'
						)
						imgui.SameLine()
						render_fastmenu_item(
							'PieMenu',
							(isMonetLoader() and (fa.KEYBOARD .. u8' ��������') or (fa.COMPUTER_MOUSE .. u8' ��� (�������)')),
							'������� ����� RP ������',
							'��� ���������'
						)
						imgui.EndTabItem() 
					end
					if imgui.BeginTabItem(fa.KEYBOARD .. (isMonetLoader() and u8' ��������' or u8' Hotkeys')) then 
						if imgui.BeginChild('##999', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true) then
							if isMonetLoader() then
								imgui.CenterText(u8('���������� �������� ��� ������ ������� �������'))
								imgui.Separator()
								if imgui.Checkbox(u8(' ����������� ������ "��������������" (������ /hm ID)'), checkbox.mobile_fastmenu_button) then
									settings.general.mobile_fastmenu_button = checkbox.mobile_fastmenu_button[0]
									FastMenuButton[0] = checkbox.mobile_fastmenu_button[0]
									save_settings()
								end
								if imgui.Checkbox(u8(' ����������� ������ "����������" (������ /stop)'), checkbox.mobile_stop_button) then
									settings.general.mobile_stop_button = checkbox.mobile_stop_button[0]
									save_settings()
								end
								if imgui.Checkbox(u8(' ����������� ������ "10-55 10-66"'), checkbox.mobile_meg_button) then
									settings.general.mobile_meg_button = checkbox.mobile_meg_button[0]
									MegafonWindow[0] = settings.general.mobile_meg_button
									save_settings()
								end
								if imgui.Checkbox(u8(' ����������� ������ "Taser" (������ /taser)'), checkbox.mobile_taser_button) then
									settings.general.mobile_taser_button = checkbox.mobile_taser_button[0]
									TaserWindow[0] = settings.general.mobile_taser_button
									save_settings()
								end
							else
								imgui.CenterText(fa.KEYBOARD .. u8' ������� ����� ��� ������ ������� (����� ��� RP ������ � ��������� ������) ' .. fa.KEYBOARD)
								--imgui.CenterText(u8'����� RP ������ �� ������� ����� ������ � ������� �������������� RP �������')	
								if hotkey_no_errors then
									imgui.Separator()
									imgui.CenterText(u8'�������� �������� ���� ������� (������ /helper):')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_mainmenu))
									imgui.SetCursorPosX( width / 2 - calc.x / 2 )
									if MainMenuHotKey:ShowHotKey() then
										settings.general.bind_mainmenu = encodeJson(MainMenuHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'�������� �������� ���� �������������� � ������� (������ /hm):')
									imgui.CenterText(u8'��������� �� ������ ����� ��� � ������')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_fastmenu))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if FastMenuHotKey:ShowHotKey() then
										settings.general.bind_fastmenu = encodeJson(FastMenuHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'�������� �������� ���� ���������� ������� (������ /lm ��� 9/10):')
									imgui.CenterText(u8'��������� �� ������ ����� ��� � ������')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_leader_fastmenu))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if LeaderFastMenuHotKey:ShowHotKey() then
										settings.general.bind_leader_fastmenu = encodeJson(LeaderFastMenuHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'��������� �������� (�������� ������� "��� �� ����" / "������ �� �������" � �.�.):')
									local width = imgui.GetWindowWidth()
									local calc = imgui.CalcTextSize(getNameKeysFrom(settings.general.bind_action))
									imgui.SetCursorPosX(width / 2 - calc.x / 2)
									if ActionHotKey:ShowHotKey() then
										settings.general.bind_action = encodeJson(ActionHotKey:GetHotKey())
										save_settings()
									end

									imgui.Separator()
									imgui.CenterText(u8'������������� ��������� ������� (������ /stop):')
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
									imgui.CenterText(fa.TRIANGLE_EXCLAMATION .. u8' ������: � ��� ���������� ���������� mimgui_hotkeys.lua ' .. fa.TRIANGLE_EXCLAMATION)
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
			if imgui.BeginTabItem(fa.FILE_PEN..u8' �������') then 
			 	imgui.BeginChild('##notes1', imgui.ImVec2(589 * settings.general.custom_dpi, 338 * settings.general.custom_dpi), true)
				imgui.Columns(2)
				imgui.CenterColumnText(u8"������ ���� ����� �������/���������:")
				imgui.SetColumnWidth(-1, 495 * settings.general.custom_dpi)
				imgui.NextColumn()
				imgui.CenterColumnText(u8"��������")
				imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
				imgui.Columns(1)
				imgui.Separator()
				for i, note in ipairs(modules.notes.data) do
					imgui.Columns(2)
					imgui.CenterColumnText(u8(note.note_name))
					imgui.NextColumn()
					if imgui.SmallButton(fa.UP_RIGHT_FROM_SQUARE .. '##' .. i) then
						show_note_name = u8(note.note_name)
						show_note_text = u8(note.note_text)
						NoteWindow[0] = true
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'������� ������� "' .. u8(note.note_name) .. '"')
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##' .. i) then
						local note_text = note.note_text:gsub('&','\n')
						input_text_note = imgui.new.char[16384](u8(note_text))
						input_name_note = imgui.new.char[256](u8(note.note_name))
						imgui.OpenPopup(fa.PEN_TO_SQUARE .. u8' �������������� ������� ' .. fa.PEN_TO_SQUARE .. '##' .. i)	
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'�������������� ������� "' .. u8(note.note_name) .. '"')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.PEN_TO_SQUARE .. u8' �������������� ������� ' .. fa.PEN_TO_SQUARE .. '##' .. i, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
						change_dpi()
						if imgui.BeginChild('##node_edit_window', imgui.ImVec2(589 * settings.general.custom_dpi, 369 * settings.general.custom_dpi), true) then	
							imgui.PushItemWidth(578 * settings.general.custom_dpi)
							imgui.InputTextWithHint(u8'##note_name', u8('������� �������� ����� �������'),input_name_note, 256)
						
							imgui.InputTextMultiline("##note_text", input_text_note, 16384, imgui.ImVec2(578 * settings.general.custom_dpi, 329 * settings.general.custom_dpi))
							
							imgui.EndChild()
						end	
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ������� ' .. fa.FLOPPY_DISK, imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
							note.note_name = u8:decode(ffi.string(input_name_note))
							local temp = u8:decode(ffi.string(input_text_note))
							note.note_text = temp:gsub('\n', '&')
							save_module('notes')
							imgui.CloseCurrentPopup()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.SmallButton(fa.TRASH_CAN .. '##' .. i) then
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. i .. note.note_name)
					end
					if imgui.IsItemHovered() then
						imgui.SetTooltip(u8'�������� ������� "' .. u8(note.note_name) .. '"')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. i .. note.note_name, _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'�� ������������� ������ ������� ������� "' .. u8(note.note_name) .. '" ?')
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ���, �������� ' .. fa.CIRCLE_XMARK .. "##delete_note", imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.TRASH_CAN .. u8' ��, ������� ' ..  fa.TRASH_CAN.. "##delete_note", imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
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
				if imgui.Button(fa.CIRCLE_PLUS .. u8' ������� ����� ������� ' .. fa.CIRCLE_PLUS, imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
					table.insert(modules.notes.data, {note_name = "����� �������", note_text = "����� ����� ����� �������"})
					save_module('notes')
				end
				imgui.EndTabItem()
			end
			if imgui.BeginTabItem(fa.GEAR..u8' ���������') then 
				if imgui.BeginChild('##1', imgui.ImVec2(589 * settings.general.custom_dpi, 145 * settings.general.custom_dpi), true) then
					imgui.CenterText(fa.CIRCLE_INFO .. u8' �������������� ���������� ��� ������ ' .. fa.CIRCLE_INFO)
					imgui.Separator()
					imgui.Text(fa.CIRCLE_USER..u8" ������ ��� ��������� Andrey_Fil ����� MTG")
					imgui.Separator()
					imgui.Text(fa.CIRCLE_INFO..u8" ������������� ������ �������: " .. u8(thisScript().version))
					-- imgui.SameLine()
					-- if imgui.SmallButton(u8'��������� ������� ����������') then
					-- 	check_update()
					-- end
					imgui.Separator()
					imgui.Text(fa.BOOK ..u8" ���� �� ������������� �������:")
					imgui.SameLine()
					if imgui.SmallButton(u8'YouTube') then
						openLink('')
					end
					imgui.Separator()
					imgui.Text(fa.HEADSET..u8" ���.��������� �� �������:")
					imgui.SameLine()
					if imgui.SmallButton(u8'Discord') then
						openLink('')
					end
					imgui.SameLine()
					imgui.Text('/')
					imgui.SameLine()
					if imgui.SmallButton(u8'Telegram') then
						openLink('')
					end
					imgui.SameLine()
					imgui.Text('/')
					imgui.SameLine()
					if imgui.SmallButton(u8'BlastHack') then
						--openLink('/')
					end
					imgui.Separator()
					imgui.Text(fa.GLOBE..u8" ������ ������� ���")
					imgui.SameLine()
					imgui.Text(u8"�����")
					imgui.EndChild()
				end
				if imgui.BeginChild('##2', imgui.ImVec2(589 * settings.general.custom_dpi, 60 * settings.general.custom_dpi), true) then
					imgui.CenterText(fa.PALETTE .. u8(' �������� ���� ���������� ������� ') .. fa.PALETTE)
					imgui.Separator()
					imgui.Columns(3)
					if monet_no_errors then
						imgui.SetCursorPosX(55 * settings.general.custom_dpi)
						if imgui.RadioButtonIntPtr(u8" Custom", theme, 0) then
							local r,g,b = mmcolor[0] * 255, mmcolor[1] * 255, mmcolor[2] * 255
							local argb = join_argb(0, r, g, b)
							settings.general.helper_theme = 0
							settings.general.moonmonet_theme_color = argb
							settings.general.message_color = argb
							message_color = "0x" .. argbToHexWithoutAlpha(0, r, g, b)
							message_color_hex = '{' .. argbToHexWithoutAlpha(0, r, g, b) .. '}'
							local tmp = imgui.ColorConvertU32ToFloat4(settings.general.message_color)
							msgcolor = imgui.new.float[3](tmp.z, tmp.y, tmp.x)
							apply_moonmonet_theme()
							save_settings()
						end
						imgui.SameLine()
						if imgui.ColorEdit3('## COLOR1', mmcolor, imgui.ColorEditFlags.NoInputs) then
							local r,g,b = mmcolor[0] * 255, mmcolor[1] * 255, mmcolor[2] * 255
							local argb = join_argb(0, r, g, b)
							settings.general.moonmonet_theme_color = argb
							settings.general.message_color = argb
							message_color = "0x" .. argbToHexWithoutAlpha(0, r, g, b)
							message_color_hex = '{' .. argbToHexWithoutAlpha(0, r, g, b) .. '}'
							local tmp = imgui.ColorConvertU32ToFloat4(settings.general.message_color)
							msgcolor = imgui.new.float[3](tmp.z, tmp.y, tmp.x)
							if theme[0] == 0 then
								apply_moonmonet_theme()
								save_settings()
							end
						end
					else
						if imgui.CenterColumnRadioButtonIntPtr(u8" �ustom ", theme, 0) then
							theme[0] = settings.general.helper_theme
							sampAddChatMessage('[Rodina Helper] {ffffff}���������� ���������� MoonMonet!', message_color)
						end
					end
					imgui.NextColumn()
					if imgui.CenterColumnRadioButtonIntPtr(" Dark Theme ", theme, 1) then	
						settings.general.helper_theme = 1
						save_settings()
						apply_dark_theme()
					end
					imgui.NextColumn()
					if imgui.CenterColumnRadioButtonIntPtr(" White Theme ", theme, 2) then	
						settings.general.helper_theme = 2
						save_settings()
						apply_white_theme()
					end
					imgui.Columns(1)
					imgui.EndChild()
				end
				if imgui.BeginChild("##2_2",imgui.ImVec2(589 * settings.general.custom_dpi, 53 * settings.general.custom_dpi),true, imgui.WindowFlags.NoScrollbar) then
					imgui.CenterText(fa.PALETTE .. u8(' ���� ��������� �� ������� � ���� ') .. fa.PALETTE)
					if theme[0] == 0 then
						imgui.Separator()
						imgui.CenterText(u8('������������ �����-�� ���� ��� � MoonMonet'))
					else
						imgui.SetCursorPosX((imgui.GetWindowWidth() / 2) - (10 * settings.general.custom_dpi))
						if imgui.ColorEdit3('## COLOR2', msgcolor, imgui.ColorEditFlags.NoInputs) then
							local r,g,b = msgcolor[0] * 255, msgcolor[1] * 255, msgcolor[2] * 255
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
					imgui.CenterText(fa.MAXIMIZE .. u8' ������ ������� ������� ' .. fa.MAXIMIZE)
					if settings.general.custom_dpi ~= tonumber(string.format('%.3f', slider_dpi[0])) then
						imgui.SameLine(0, 15 * settings.general.custom_dpi)
						if imgui.SmallButton(fa.CIRCLE_ARROW_RIGHT .. u8' ��������� ������ ' .. fa.CIRCLE_ARROW_LEFT) then
							imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##change_size')
						end
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##change_size', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'�� ������������� ������ �������� ������ �������?')
						imgui.Separator()
						imgui.CenterText(u8('���� ������� "�������" �� ������, ���������� ������ ������'))
						local text = (settings.general.custom_dpi < slider_dpi[0]) and '�������' or '������'
						imgui.CenterText(u8('���� ��������� ����� ������� ') .. u8(text) .. u8(', �� ����������� /fixsize'))
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ���, �������� ' .. fa.CIRCLE_XMARK .. '##change_size', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8' ��, �������� ' .. fa.CIRCLE_ARROW_LEFT .. "##change_size", imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							local new_dpi = tonumber(string.format('%.3f', slider_dpi[0]))
							if isMonetLoader() and new_dpi < MONET_DPI_SCALE then
								sampAddChatMessage('[Rodina Helper] {ffffff}��� ������ ������� ������ ������� ������ ������ ' .. MONET_DPI_SCALE, message_color)
								imgui.CloseCurrentPopup()
							else
								settings.general.custom_dpi = new_dpi
								save_settings()
								sampAddChatMessage('[Rodina Helper] {ffffff}������������ ������� ��� ���������� ������� ����...', message_color)
								reload_script = true
								thisScript():reload()
							end
						end
						imgui.End()
					end
					imgui.PushItemWidth(578 * settings.general.custom_dpi)
					imgui.SliderFloat('##slider_helper_size', slider_dpi, 0.5, 3) 
					imgui.EndChild()
				end
				if imgui.BeginChild("##4",imgui.ImVec2(589 * settings.general.custom_dpi, 35 * settings.general.custom_dpi),true) then
					if imgui.Button(fa.POWER_OFF .. u8" ���������� ������� " .. fa.POWER_OFF, imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						reload_script = true
						sampAddChatMessage('[Rodina Helper] {ffffff}������ ������������ ���� ������ �� ��������� ����� � ����!', message_color)
						if not isMonetLoader() then 
							sampAddChatMessage('[Rodina Helper] {ffffff}���� ����������� ' .. message_color_hex .. 'CTRL {ffffff}+ ' .. message_color_hex .. 'R {ffffff}����� ��������� ������.', message_color)
						end
						thisScript():unload()
					end
					imgui.SameLine()
					if imgui.Button(fa.CLOCK_ROTATE_LEFT .. u8" ����� ���� �������� " .. fa.CLOCK_ROTATE_LEFT, imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##reset')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##reset', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'�� ������������� ������ �������� ��� ��������� �������?')
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ���, �������� ' .. fa.CIRCLE_XMARK .. "##cancel_restore", imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.CLOCK_ROTATE_LEFT .. u8' ��, �������� ' .. fa.CLOCK_ROTATE_LEFT .. '##restore', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							deleteHelperData()
							reload_script = true
							thisScript():reload()
						end
						imgui.End()
					end
					imgui.SameLine()
					if imgui.Button(fa.TRASH_CAN .. u8" �������� ������� " .. fa.TRASH_CAN, imgui.ImVec2(imgui.GetMiddleButtonX(3), 25 * settings.general.custom_dpi)) then
						imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##delete')
					end
					imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' �������������� ' .. fa.TRIANGLE_EXCLAMATION .. '##delete', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar) then
						change_dpi()
						imgui.CenterText(u8'�� ������������� ������ ������� Rodina Helper?')
						imgui.CenterText(u8'���-�� ����� ������� ��� ���������, ������� � ������� �������')
						imgui.Separator()
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ���, �������� ' .. fa.CIRCLE_XMARK.. '##cancel_delete_helper', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.TRASH_CAN .. u8' ��, ������� ' .. fa.TRASH_CAN .. '##delete_helper', imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							reload_script = true
							deleteHelperData('full')
							sampAddChatMessage('[Rodina Helper] {ffffff}������ ��������� ����� �� ������ ����������!', message_color)
							thisScript():unload()
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
    function() return DeportamentWindow[0] end,
    function(player)
        local function createTagPopup(tag_type, input_var, setting_key)
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
            if imgui.BeginPopupModal(fa.TAG .. u8' ���� �����������##'..tag_type, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
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
							if title:find(u8'������') then
								imgui.Separator()
								if imgui.Button(fa.CIRCLE_PLUS .. u8' �������� ��� ' .. fa.CIRCLE_PLUS, imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * settings.general.custom_dpi)) then
									imgui.OpenPopup(fa.TAG .. u8' ���������� ������ ���� ' .. fa.TAG .. '##'..tag_type)
								end
								imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
								if imgui.BeginPopupModal(fa.TAG .. u8' ���������� ������ ���� ' .. fa.TAG .. '##'..tag_type, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
									imgui.CenterText(u8('���� ����� ������� �� ��������'))
									imgui.CenterText(u8('������, ������ ���� ������� skip'))
									imgui.PushItemWidth(215 * settings.general.custom_dpi)
									imgui.InputText('##inputs_dep.new_tag', inputs_dep.new_tag, 256) 
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. '##dep_add_tag'..tag_type, 
										imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. '##dep_add_tag'..tag_type, 
										imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
										table.insert(settings.deportament.dep_tags_custom, u8:decode(ffi.string(inputs_dep.new_tag)))
										save_settings()
										imgui.CloseCurrentPopup()
									end
									imgui.End()
								end
							end
                            imgui.EndTabItem()
                        end
                    end
                    createTagTab(u8'����������� ���� (ru)', settings.deportament.dep_tags)
					createTagTab(u8'���� ��������� ����', settings.deportament.dep_tags_custom)
                    imgui.EndTabBar()
                end
                imgui.End()
            end
        end
        local function createFrequencyPopup()
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
            if imgui.BeginPopupModal(fa.WALKIE_TALKIE .. u8' ������� ��� ������������� ����� /d', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
                imgui.SetWindowSizeVec2(imgui.ImVec2(400 * settings.general.custom_dpi, 95 * settings.general.custom_dpi))
                change_dpi()
                for i, tag in ipairs(settings.deportament.dep_fms) do
                    imgui.SameLine()
                    if imgui.Button(' ' .. u8(tag) .. ' ##' .. i) then
                        inputs_dep.fm = imgui.new.char[256](u8(tag))
                        settings.deportament.dep_fm = u8:decode(ffi.string(inputs_dep.fm))
                        save_settings()
                        imgui.CloseCurrentPopup()
                    end
                end
                imgui.Separator()
                if imgui.Button(fa.CIRCLE_PLUS .. u8' �������� �������', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
                    imgui.OpenPopup(fa.TAG .. u8' ���������� ����� �������##2')
                end
                if imgui.BeginPopupModal(fa.TAG .. u8' ���������� ����� �������##2', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
                    imgui.PushItemWidth(215 * settings.general.custom_dpi)
                    imgui.InputText('##inputs_dep.new_tag', inputs_dep.new_tag, 256) 
                    imgui.Separator()
                    if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. '##dep_add_fm', 
                        imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.SameLine()
                    if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. '##dep_add_fm', 
                        imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
                        table.insert(settings.deportament.dep_fms, u8:decode(ffi.string(inputs_dep.new_tag)))
                        save_settings()
                        imgui.CloseCurrentPopup()
                    end
                    imgui.End()
                end
                imgui.SameLine()
                if imgui.Button(fa.CIRCLE_XMARK .. u8' �������', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
                    imgui.CloseCurrentPopup()
                end
                imgui.End()
            end
        end
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(fa.WALKIE_TALKIE .. u8" ����� ������������ " .. fa.WALKIE_TALKIE, DeportamentWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar)
        change_dpi()
        if imgui.BeginChild('##2', imgui.ImVec2(500 * settings.general.custom_dpi, 186 * settings.general.custom_dpi), true) then
            imgui.Columns(3)
            imgui.CenterColumnText(u8('��� ���:'))
            imgui.PushItemWidth(155 * settings.general.custom_dpi)
            if imgui.InputText('##inputs_dep.tag1', inputs_dep.tag1, 256) then
                settings.deportament.dep_tag1 = u8:decode(ffi.string(inputs_dep.tag1))
                save_settings()
            end
            if imgui.CenterColumnButton(u8('������� ���##1')) then
                imgui.OpenPopup(fa.TAG .. u8' ���� �����������##1')
            end
            createTagPopup('1', inputs_dep.tag1, 'dep_tag1')
            
            imgui.NextColumn()
            imgui.CenterColumnText(u8('������� �����:'))
            imgui.PushItemWidth(155 * settings.general.custom_dpi)
            if imgui.InputText('##inputs_dep.fm', inputs_dep.fm, 256) then
                settings.deportament.dep_fm = u8:decode(ffi.string(inputs_dep.fm))
                save_settings()
            end
            if imgui.CenterColumnButton(u8('������� �������##1')) then
                imgui.OpenPopup(fa.WALKIE_TALKIE .. u8' ������� ��� ������������� ����� /d')
            end
            createFrequencyPopup()
            imgui.NextColumn()
            imgui.CenterColumnText(u8('��� ����������:'))
            imgui.PushItemWidth(155 * settings.general.custom_dpi)
            if imgui.InputText('##inputs_dep.tag2', inputs_dep.tag2, 256) then
                settings.deportament.dep_tag2 = u8:decode(ffi.string(inputs_dep.tag2))
                save_settings()
            end
            if imgui.CenterColumnButton(u8('������� ���##2')) then
                imgui.OpenPopup(fa.TAG .. u8' ���� �����������##2')
            end
            createTagPopup('2', inputs_dep.tag2, 'dep_tag2')
            imgui.Columns(1)
            imgui.Separator()
            imgui.CenterText(u8('�����:'))
            imgui.PushItemWidth(405 * settings.general.custom_dpi)
            imgui.InputText(u8'##dep_input_text', inputs_dep.text, 256)
            imgui.SameLine()
            if imgui.Button(u8' ��������� ') then
                local tag1 = settings.deportament.anti_skobki and u8:decode(ffi.string(inputs_dep.tag1)):gsub("[%[%]]", "") or u8:decode(ffi.string(inputs_dep.tag1))
                local tag2 = settings.deportament.anti_skobki and u8:decode(ffi.string(inputs_dep.tag2)):gsub("[%[%]]", "") or u8:decode(ffi.string(inputs_dep.tag2))
                sampSendChat('/d ' .. tag1 .. ' ' .. u8:decode(ffi.string(inputs_dep.fm)) .. ' ' .. tag2 .. ': ' .. u8:decode(ffi.string(inputs_dep.text)))
            end
            local tag1 = ffi.string(inputs_dep.tag1)
			local tag2 = ffi.string(inputs_dep.tag2)
			local fm = ffi.string(inputs_dep.fm)
			local text = ffi.string(inputs_dep.text)
			if settings.deportament.anti_skobki then
				tag1 = tag1:gsub("[%[%]]", "")
				tag2 = tag2:gsub("[%[%]]", "")
			end
			local preview_text = ('/d ' .. tag1 .. ' ' .. fm .. ' ' .. tag2 .. ': ' .. text)
			imgui.CenterText(preview_text)
            imgui.Separator()
            if imgui.Checkbox(u8(' ��������� ������������� �������� [] (������) � ����� �����������'), checkbox.dep_anti_skobki) then
                settings.deportament.anti_skobki = checkbox.dep_anti_skobki[0]
                save_settings()
            end
            imgui.EndChild()
        end
        imgui.End()
    end
)

imgui.OnFrame(
    function() return BinderWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 425	* settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.PEN_TO_SQUARE .. u8' �������������� ������� /' .. binder_data.change_cmd, BinderWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  )
		change_dpi()
		if imgui.BeginChild('##binder_edit', imgui.ImVec2(589 * settings.general.custom_dpi, 361 * settings.general.custom_dpi), true) then
			imgui.CenterText(fa.FILE_LINES .. u8' �������� �������:')
			imgui.PushItemWidth(579 * settings.general.custom_dpi)
			imgui.InputText("##input_description", input_description, 256)
			imgui.Separator()
			imgui.CenterText(fa.TERMINAL .. u8' ������� ��� ������������� � ���� (��� /):')
			imgui.PushItemWidth(579 * settings.general.custom_dpi)
			if imgui.InputText("##input_cmd", input_cmd, 256) then
				-- sampAddChatMessage(ffi.string(input_cmd), -1)
				-- if ffi.string(input_cmd):find('%/') then
				-- 	imgui.StrCopy(input_cmd, ffi.string(input_cmd):gsub('%/', ''))
				-- end
			end
			imgui.Separator()
			imgui.CenterText(fa.CODE .. u8' ��������� ������� ��������� �������:')
	    	imgui.Combo(u8'',ComboTags, ImItems, #item_list)
	 	    imgui.Separator()
	        imgui.CenterText(fa.FILE_WORD .. u8' ��������� ���� �������:')
		
			imgui.InputTextMultiline("##text_multiple", input_text, 8192, imgui.ImVec2(579 * settings.general.custom_dpi, 173 * settings.general.custom_dpi))
		imgui.EndChild() end
		if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. "##binder_cancel", imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
			BinderWindow[0] = false
		end
		imgui.SameLine()
		if imgui.Button(fa.CLOCK .. u8' �������� ' .. fa.CLOCK .. "##binder_wait",imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
			imgui.OpenPopup(fa.CLOCK .. u8' �������� (� ��������) '  .. fa.CLOCK)
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.CLOCK .. u8' �������� (� ��������) ' .. fa.CLOCK, _, imgui.WindowFlags.NoResize ) then
			imgui.PushItemWidth(250 * settings.general.custom_dpi)
			imgui.SliderFloat(u8'##waiting', waiting_slider, 0.3, 10)
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK .. '##binder_wait_menu', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				waiting_slider = imgui.new.float(tonumber(binder_data.change_waiting))
				imgui.CloseCurrentPopup()
			end
			imgui.SameLine()
			if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. '##binder_wait_menu', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		imgui.SameLine()
		if imgui.Button(fa.TAGS .. u8' ���� ' .. fa.TAGS  .. "##binder_tags", imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
			imgui.OpenPopup(fa.TAGS .. u8' ���� ��� ������������� � �������')
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.TAGS .. u8' ���� ��� ������������� � �������', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize ) then
			imgui.Text(u8(binder_tags_text))
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' �������', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		imgui.SameLine()
		if imgui.Button(fa.KEYBOARD .. u8' ��������� ' .. fa.KEYBOARD  .. '##binder_bind', imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
			if ComboTags[0] == 0 then
				if isMonetLoader() then
					sampAddChatMessage('[Rodina Helper] {ffffff}������ ������� ������� ������ �� ��!', message_color)
				else
					if hotkey_no_errors then
						imgui.OpenPopup(fa.KEYBOARD .. u8' ���� ��� ������� /' .. binder_data.change_cmd)
					else
						sampAddChatMessage('[Rodina Helper] {ffffff}������ ������� ���������, ������� ���������� ����� ���������� mimgui_hotkeys!', message_color)
					end
				end
			else
				sampAddChatMessage('[Rodina Helper] {ffffff}������ ������� ������� ������ ���� ������� "��� ����������"', message_color)
			end
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.KEYBOARD .. u8' ���� ��� ������� /' .. binder_data.change_cmd, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
			local hotkeyObject = hotkeys[binder_data.change_cmd .. "HotKey"]
			if hotkeyObject then
				imgui.CenterText(u8('������� ��������� �����:'))
				local calc
				if binder_data.change_bind == '{}' or binder_data.change_bind == '[]' then
					calc = imgui.CalcTextSize('< click and select keys >')
				elseif binder_data.change_bind == nil then
					binder_data.change_bind = {}
				else
					calc = imgui.CalcTextSize(getNameKeysFrom(binder_data.change_bind))
				end
				local width = imgui.GetWindowWidth()
				local temp = (calc and calc.x and calc.x / 2) or 0
				imgui.SetCursorPosX(width / 2 - temp)
				if hotkeyObject:ShowHotKey() then
					binder_data.change_bind = encodeJson(hotkeyObject:GetHotKey())
				end
			else
				if not binder_data.change_bind then
				 	binder_data.change_bind = {}
				end
				
				hotkeys[binder_data.change_cmd .. "HotKey"] = hotkey.RegisterHotKey(binder_data.change_cmd .. "HotKey", false, decodeJson(binder_data.change_bind), function()
					if (not (sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive())) then
						sampProcessChatInput('/' .. binder_data.change_cmd)
					end
				end)
				hotkeyObject = hotkeys[binder_data.change_cmd .. "HotKey"]
			end
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ������� ' .. fa.CIRCLE_XMARK .. "##binder_bind_close", imgui.ImVec2(300 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
				hotkeyObject:RemoveHotKey()
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end
		imgui.SameLine()
		if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK .. '##binder_save', imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then	
			if ffi.string(input_cmd):find('%W') or ffi.string(input_cmd) == '' or ffi.string(input_description) == '' or ffi.string(input_text) == '' then
				imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8' ������ ���������� ������� ' .. fa.TRIANGLE_EXCLAMATION)
			else
				local new_arg = ''
				if ComboTags[0] == 0 then
					new_arg = ''
				elseif ComboTags[0] == 1 then
					new_arg = '{arg}'
				elseif ComboTags[0] == 2 then
					new_arg = '{arg_id}'
				elseif ComboTags[0] == 3 then
					new_arg = '{arg_id} {arg2}'
                elseif ComboTags[0] == 4 then
					new_arg = '{arg_id} {arg2} {arg3}'
				elseif ComboTags[0] == 5 then
					new_arg = '{arg_id} {arg2} {arg3} {arg4}'
				end
				local new_command = u8:decode(ffi.string(input_cmd))
				local temp_array = (binder_data.create_command_9_10) and modules.commands.data.commands_manage.my or modules.commands.data.commands.my
				for _, command in ipairs(temp_array) do
					if command.cmd == binder_data.change_cmd and command.arg == binder_data.change_arg and command.text:gsub('&', '\n') == binder_data.change_text then
						command.cmd = new_command
						command.arg = new_arg
						command.description = u8:decode(ffi.string(input_description))
						command.text = u8:decode(ffi.string(input_text)):gsub('\n', '&')
						command.bind = binder_data.change_bind
						command.waiting = waiting_slider[0]
						command.in_fastmenu = binder_data.change_in_fastmenu
						command.enable = true
						save_module('commands')
						if command.arg == '' then
							sampAddChatMessage('[Rodina Helper] {ffffff}������� ' .. message_color_hex .. '/' .. new_command .. ' {ffffff}������� ���������!', message_color)
						elseif command.arg == '{arg}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}������� ' .. message_color_hex .. '/' .. new_command .. ' [��������] {ffffff}������� ���������!', message_color)
						elseif command.arg == '{arg_id}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}������� ' .. message_color_hex .. '/' .. new_command .. ' [ID ������] {ffffff}������� ���������!', message_color)
						elseif command.arg == '{arg_id} {arg2}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}������� ' .. message_color_hex .. '/' .. new_command .. ' [ID ������] [��������] {ffffff}������� ���������!', message_color)
						elseif command.arg == '{arg_id} {arg2} {arg3}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}������� ' .. message_color_hex .. '/' .. new_command .. ' [ID ������] [�����] [��������] {ffffff}������� ���������!', message_color)
						elseif command.arg == '{arg_id} {arg2} {arg3} {arg4}' then
							sampAddChatMessage('[Rodina Helper] {ffffff}������� ' .. message_color_hex .. '/' .. new_command .. ' [ID ������] [�����] [��������] [��������] {ffffff}������� ���������!', message_color)
						end
						sampUnregisterChatCommand(binder_data.change_cmd)
						register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
						if not isMonetLoader() then updateHotkeyForCommand(command) end
						break
					end
				end
				BinderWindow[0] = false
			end
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8' ������ ���������� ������� ' .. fa.TRIANGLE_EXCLAMATION, _, imgui.WindowFlags.AlwaysAutoResize) then
			if ffi.string(input_cmd):find('%W') then
				imgui.BulletText(u8" � ������� ����� ������������ ������ ����.����� �/��� �����!")
			elseif ffi.string(input_cmd) == '' then
				imgui.BulletText(u8" ��������� ���� ������� �� ����� ���� ������!")
			end
			if ffi.string(input_description) == '' then
				imgui.BulletText(u8" �������� ������� �� ����� ���� ������!")
			end
			if ffi.string(input_text) == '' then
				imgui.BulletText(u8" ���� ������� �� ����� ���� ������!")
			end
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ������� ' .. fa.CIRCLE_XMARK .. '##binder_error_save_close', imgui.ImVec2(350 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				imgui.CloseCurrentPopup()
			end
			imgui.End()
		end	
		imgui.End()
    end
)

imgui.OnFrame(
    function() return members.menu[0] end,
    function(player)
		if #members.all == 0 then
			sampAddChatMessage('[Rodina Helper] {ffffff}������, ������ ����������� ������!', message_color)
			members.menu[0] = false
		elseif #members.all >= 16 then 
			sizeYY = 413 + 21
		else
			sizeYY = 24.5 * (#members.all + 1) + 21
		end
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(730 * settings.general.custom_dpi, sizeYY * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(getHelperIcon() .. " " ..  u8(members.info.fraction) .. " - " .. #members.all .. u8' ����������� ������ ' .. getHelperIcon(), members.menu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		change_dpi()
		imgui.Columns(4)
		imgui.CenterColumnText(getUserIcon() .. u8(" C��������"))
		imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
		imgui.NextColumn()
		imgui.CenterColumnText(fa.RANKING_STAR .. u8(" ���������"))
		imgui.SetColumnWidth(-1, 230 * settings.general.custom_dpi)
		imgui.NextColumn()
		imgui.CenterColumnText(fa.TRIANGLE_EXCLAMATION .. u8(" ��������"))
		imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
		imgui.NextColumn()
		imgui.CenterColumnText(fa.INFO .. u8(" ����"))
		imgui.SetColumnWidth(-1, 100 * settings.general.custom_dpi)
		imgui.Columns(1)
		for i, v in ipairs(members.all) do
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
				members.menu[0] = false
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


imgui.OnFrame(
    function() return WantedWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.wanteds_menu.x, settings.windows_pos.wanteds_menu.y), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.STAR .. u8" ������ ������������ (����� " .. #wanted .. u8') ' .. fa.STAR, WantedWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoScrollbar)
		change_dpi()
		
		if tonumber(#wanted) == 0 then 
			sampAddChatMessage('[Rodina Helper] {ffffff}������ �� ������� ���� ������� � ��������!', message_color)
			WantedWindow[0] = false
		end

		if not isMonetLoader() and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then player.HideCursor = true else player.HideCursor = false end
		if imgui.Button(u8'�������� ������ ������������', imgui.ImVec2(340 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				WantedWindow[0] = false
				sampAddChatMessage('[Rodina Helper] {ffffff}�� ������ �������� ����-���������� /wanteds � ���������� ����������!', message_color)
				sampProcessChatInput('/wanteds')
			end
			imgui.Separator()
		imgui.Columns(3)
		imgui.CenterColumnText(u8("�������"))
		imgui.SetColumnWidth(-1, 200 * settings.general.custom_dpi)
		imgui.NextColumn()
		imgui.CenterColumnText(u8("������"))
		imgui.SetColumnWidth(-1, 65 * settings.general.custom_dpi)
		imgui.NextColumn()
		imgui.CenterColumnText(u8("����������"))
		imgui.SetColumnWidth(-1, 80 * settings.general.custom_dpi)
		imgui.Columns(1)
		for i, v in ipairs(wanted) do
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
			if imgui.IsItemClicked() and not v.dist:find('� ���������') then
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
    function() return MegafonWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.megafon.x, settings.windows_pos.megafon.y), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.BUILDING_SHIELD .. " Rodina Helper##fast_meg_button", MegafonWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoTitleBar)
		change_dpi()
		if not isMonetLoader() and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then player.HideCursor = true else player.HideCursor = false end
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
    function() return TaserWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.taser.x, settings.windows_pos.taser.y), imgui.Cond.FirstUseEver)
		imgui.Begin(" Rodina Helper##TaserWindow", TaserWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoTitleBar)
		change_dpi()
		if not isMonetLoader() and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then player.HideCursor = true else player.HideCursor = false end
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

imgui.OnFrame(
    function() return SumMenuWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 413 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.STAR .. u8" ����� ������ ������� " .. fa.STAR .. "##sum_menu", SumMenuWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		change_dpi()
		if modules.smart_uk.data ~= nil and isParamSampID(player_id) then
			imgui.PushItemWidth(580 * settings.general.custom_dpi)
			imgui.InputTextWithHint(u8'##input_sum', u8('����� ������ (����������) � ������ (�������)'), input, 128) 
			imgui.Separator()
			local input_sum_decoded = u8:decode(ffi.string(input))
			for _, chapter in ipairs(modules.smart_uk.data) do
				local chapter_has_matching_item = false
				if chapter.item then
					for _, item in ipairs(chapter.item) do
						if item.text:rupper():find(input_sum_decoded:rupper()) or input_sum_decoded == '' then
							chapter_has_matching_item = true
							break
						end
					end
				end
				if chapter_has_matching_item then
					if imgui.CollapsingHeader(u8(chapter.name)) then
						for _, item in ipairs(chapter.item) do
							if item.text:rupper():find(input_sum_decoded:rupper()) or input_sum_decoded == '' then
								local popup_id = fa.TRIANGLE_EXCLAMATION .. u8' ������������� ������ ����� ������� �������##' .. item.text .. item.lvl .. item.reason
								imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
								imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 0.00, 0.00, 0.65))
								if imgui.Button("> " .. u8(split_text_into_lines(item.text, 85))..'##' .. item.text .. item.lvl .. item.reason, imgui.ImVec2(imgui.GetMiddleButtonX(1), (25 * count_lines_in_text(item.text, 85)) * settings.general.custom_dpi)) then
									imgui.OpenPopup(popup_id)
								end
								imgui.PopStyleColor()
								imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
								if imgui.BeginPopupModal(popup_id, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
									imgui.Text(fa.USER .. u8' �����: ' .. u8(sampGetPlayerNickname(player_id)) .. '[' .. player_id .. ']')
									imgui.Text(fa.STAR .. u8' ������� �������: ' .. item.lvl)
									imgui.Text(fa.COMMENT .. u8' ������� ������ �������: ' .. u8(item.reason))
									imgui.Separator()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK, imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.WALKIE_TALKIE .. u8' ��������� ������ ' .. fa.WALKIE_TALKIE, imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										SumMenuWindow[0] = false
										find_and_use_command('����� �������� � ������ %{arg2%} ������� ���� N%{arg_id%}%. �������%: %{arg3%}', player_id .. ' ' .. item.lvl .. ' ' .. item.reason)
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									local text_rank = ((settings.general.fraction == '���' or settings.general.fraction == 'fbi') and ' [4+]' or ' [5+]')
									if imgui.Button(fa.STAR .. u8' ������ ������' .. text_rank, imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										SumMenuWindow[0] = false
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
            sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������ ������ ������� (���� ������ ���� ����� �������)!', message_color)
            SumMenuWindow[0] = false
        end
        imgui.End()
    end
)

imgui.OnFrame(
    function() return PuMenuWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 413 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.STAR .. u8" ����� ������ ����������� ����� " .. fa.STAR .. "##pum_menu", PuMenuWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		change_dpi()
		if modules.smart_rptp.data ~= nil and isParamSampID(player_id) then
			imgui.PushItemWidth(580 * settings.general.custom_dpi)
			imgui.InputTextWithHint(u8'##input_sum', u8('����� ������ (����������) � ������ (�������)'), input, 128) 
			imgui.Separator()
			local input_sum_decoded = u8:decode(ffi.string(input))
			for _, chapter in ipairs(modules.smart_rptp.data) do
				local chapter_has_matching_item = false
				if chapter.item then
					for _, item in ipairs(chapter.item) do
						if item.text:rupper():find(input_sum_decoded:rupper()) or input_sum_decoded == '' then
							chapter_has_matching_item = true
							break
						end
					end
				end
				if chapter_has_matching_item then
					if imgui.CollapsingHeader(u8(chapter.name)) then
						for _, item in ipairs(chapter.item) do
							if item.text:rupper():find(input_sum_decoded:rupper()) or input_sum_decoded == '' then
								local popup_id = fa.TRIANGLE_EXCLAMATION .. u8' ������������� ������ ����� ���������� ����� ' .. fa.TRIANGLE_EXCLAMATION .. '##' .. item.text .. item.lvl .. item.reason
								imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
								imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 0.00, 0.00, 0.65))
								if imgui.Button(u8(split_text_into_lines(item.text, 85))..'##' .. item.text .. item.lvl .. item.reason, imgui.ImVec2(imgui.GetMiddleButtonX(1), (25 * count_lines_in_text(item.text, 85)) * settings.general.custom_dpi)) then
									imgui.OpenPopup(popup_id)
								end
								imgui.PopStyleColor()
								imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
								if imgui.BeginPopupModal(popup_id, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
									imgui.Text(fa.USER .. u8' �����: ' .. u8(sampGetPlayerNickname(player_id)) .. '[' .. player_id .. ']')
									imgui.Text(fa.STAR .. u8' ������� �����: ' .. item.lvl)
									imgui.Text(fa.COMMENT .. u8' ������� ��������� �����: ' .. u8(item.reason))
									imgui.Separator()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.STAR .. u8' �������� ���� ' .. fa.STAR, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										PuMenuWindow[0] = false
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
            sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������ ������ ����� (���� ������ ���� ����� �������)!', message_color)
            SumMenuWindow[0] = false
        end
        imgui.End()
    end
)

imgui.OnFrame(
    function() return TsmMenuWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 413 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.TICKET .. u8" ����� ������ ������� " .. fa.TICKET .. "##tsm_menu", TsmMenuWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		change_dpi()
		if modules.smart_pdd.data ~= nil and isParamSampID(player_id) then
			imgui.PushItemWidth(580 * settings.general.custom_dpi)
			imgui.InputTextWithHint(u8'##input_tsm', u8('����� ������ (����������) � ������ (�������)'), input, 128) 
			imgui.Separator()
			local input_tsm_decoded = u8:decode(ffi.string(input))
			for _, chapter in ipairs(modules.smart_pdd.data) do
				local chapter_has_matching_item = false
				if chapter.item then
					for _, item in ipairs(chapter.item) do
						if item.text:rupper():find(input_tsm_decoded:rupper()) or input_tsm_decoded == '' then
							chapter_has_matching_item = true
							break
						end
					end
				end
				if chapter_has_matching_item then
					if imgui.CollapsingHeader(u8(chapter.name)) then
						for _, item in ipairs(chapter.item) do
							if item.text:rupper():find(input_tsm_decoded:rupper()) or input_tsm_decoded == '' then
								local popup_id = fa.TRIANGLE_EXCLAMATION .. u8' ������������� ������ ����� ������� ������##' .. item.text .. item.amount .. item.reason
								imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
								imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1.00, 0.00, 0.00, 0.65))
								if imgui.Button(u8(split_text_into_lines(item.text,85))..'##' .. item.text .. item.amount .. item.reason, imgui.ImVec2( imgui.GetMiddleButtonX(1), (25 * count_lines_in_text(item.text, 85)) * settings.general.custom_dpi)) then
									imgui.OpenPopup(popup_id)
								end 
								imgui.PopStyleColor()
								imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
								if imgui.BeginPopupModal(popup_id, nil, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
									imgui.Text(fa.USER .. u8' �����: ' .. u8(sampGetPlayerNickname(player_id)) .. '[' .. player_id .. ']')
									imgui.Text(fa.MONEY_CHECK_DOLLAR .. u8' ����� ������: $' .. item.amount)
									imgui.Text(fa.COMMENT .. u8' ������� ������ ������: ' .. u8(item.reason))
									imgui.Separator()
									if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										imgui.CloseCurrentPopup()
									end
									imgui.SameLine()
									if imgui.Button(fa.TICKET .. u8' �������� ����� ' .. fa.TICKET, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
										TsmMenuWindow[0] = false
										find_and_use_command('/writeticket {arg_id}', player_id .. ' ' .. item.amount .. ' ' .. item.reason)
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
			sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������ ����� ������� (���� ������ ���� ����� �������)!', message_color)
            TsmMenuWindow[0] = false
        end
        imgui.End()
    end
)

imgui.OnFrame(
    function() return NoteWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(fa.FILE_PEN .. ' '.. show_note_name .. ' ' .. fa.FILE_PEN, NoteWindow, imgui.WindowFlags.AlwaysAutoResize)
        change_dpi()
        imgui.Text(show_note_text:gsub('&','\n'))
        imgui.End()
    end
)

imgui.OnFrame(
    function() return FastMenu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		--imgui.SetNextWindowSize(imgui.ImVec2(290 * settings.general.custom_dpi, 415 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.USER .. ' '..sampGetPlayerNickname(player_id)..' ['..player_id.. ']##FastMenu', FastMenu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
		change_dpi()
		local check = false
		for _, command in ipairs(modules.commands.data.commands.my) do
			if command.enable and command.arg == '{arg_id}' and command.in_fastmenu then
				if imgui.Button(u8(command.description), imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
					sampProcessChatInput("/" .. command.cmd .. " " .. player_id)
					FastMenu[0] = false
				end
				check = true
			end
		end
		if not check then
			sampAddChatMessage('[Rodina Helper] {ffffff}���� ������ ���������� �� ������ � FastMenu!', message_color)
			FastMenu[0] = false
		end
		imgui.End()
    end
)

imgui.OnFrame(
    function() return FastMenuButton[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.mobile_fastmenu_button.x, settings.windows_pos.mobile_fastmenu_button.y), imgui.Cond.FirstUseEver)
		imgui.Begin(fa.BUILDING_SHIELD .." Justice Helper##fast_menu_button", FastMenuButton, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoBackground  )
		change_dpi()
		if imgui.Button(fa.IMAGE_PORTRAIT..u8' �������������� ') then
			if tonumber(#get_players()) == 1 then
				show_fast_menu(get_players()[1])
				FastMenuButton[0] = false
			elseif tonumber(#get_players()) > 1 then
				FastMenuPlayers[0] = true
				FastMenuButton[0] = false
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
    function() return LeaderFastMenu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getUserIcon() ..' '..sampGetPlayerNickname(player_id)..' ['..player_id..']##LeaderFastMenu', LeaderFastMenu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize  )
		change_dpi()
		local check = false
		for _, command in ipairs(modules.commands.data.commands_manage.my) do
			if command.enable and command.arg == '{arg_id}' and command.in_fastmenu then
				if imgui.Button(u8(command.description), imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
					sampProcessChatInput("/" .. command.cmd .. " " .. player_id)
					LeaderFastMenu[0] = false
				end
			end
		end
		if not isMonetLoader() then
			if imgui.Button(u8"������ �������",imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
				sampSetChatInputEnabled(true)
				sampSetChatInputText('/vig '..player_id..' ')
				LeaderFastMenu[0] = false
			end
			if imgui.Button(u8"������� �� �����������",imgui.ImVec2(290 * settings.general.custom_dpi, 30 * settings.general.custom_dpi)) then
				sampSetChatInputEnabled(true)
				sampSetChatInputText('/unv '..player_id..' ')
				LeaderFastMenu[0] = false
			end
		end
		imgui.End()
    end
)

imgui.OnFrame(
    function() return GiveRankMenu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon().." Rodina Helper " .. getHelperIcon() .. "##rank", GiveRankMenu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		imgui.CenterText(u8'�������� ���� ��� '.. sampGetPlayerNickname(player_id) .. ':')
		imgui.PushItemWidth(250 * settings.general.custom_dpi)
		imgui.SliderInt('', giverank, 1, (settings.player_info.fraction_rank_number == 9) and 8 or 9) -- ��� �� ����� ���� 9 ����
		imgui.Separator()
		local text = isMonetLoader() and " ������ ����" or " ������ ���� [Enter]"
		if imgui.Button(fa.USER .. u8(text), imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
			give_rank()
			GiveRankMenu[0] = false
		end
		imgui.End()
    end
)

imgui.OnFrame(
    function() return CommandStopWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY - 50 * settings.general.custom_dpi), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() .. " Rodina Helper " .. getHelperIcon() .. "##CommandStopWindow", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize )
		change_dpi()
		if isMonetLoader() and commands.isActive then
			if imgui.Button(fa.CIRCLE_STOP..u8' ���������� ��������� ') then
				commands.isStop = true 
				CommandStopWindow[0] = false
			end
		else
			CommandStopWindow[0] = false
		end
		imgui.End()
    end
)

imgui.OnFrame(
    function() return CommandPauseWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY - 50 * settings.general.custom_dpi), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() .." Rodina Helper " .. getHelperIcon() .. "##CommandPauseWindow", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		if commands.isPause then
			if imgui.Button(fa.CIRCLE_ARROW_RIGHT .. u8' ���������� ', imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				commands.isPause = false
				CommandPauseWindow[0] = false
			end
			imgui.SameLine()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ STOP ', imgui.ImVec2(150 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				commands.isStop = true 
				commands.isPause = false
				CommandPauseWindow[0] = false
			end
		else
			CommandPauseWindow[0] = false
		end
		imgui.End()
    end
)

imgui.OnFrame(
    function() return FastMenuPlayers[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() ..u8" �������� ������ " .. getHelperIcon() .. "##fast_menu_players", FastMenuPlayers, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		if tonumber(#get_players()) == 0 then
			show_fast_menu(get_players()[1])
			FastMenuPlayers[0] = false
		elseif tonumber(#get_players()) >= 1 then
			for _, playerId in ipairs(get_players()) do
				local id = tonumber(playerId)
				if imgui.Button(sampGetPlayerNickname(id), imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
					if tonumber(#get_players()) ~= 0 then show_fast_menu(id) end
					FastMenuPlayers[0] = false
				end
			end
		end
		imgui.End()
    end
)

imgui.OnFrame(
    function() return UpdateWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.CIRCLE_INFO .. u8" �������� ���������� ������� ".. fa.CIRCLE_INFO .. "##update_window", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
		if not isMonetLoader() then change_dpi() end
		imgui.CenterText(u8("������ ��������� � ����� ������:"))
		imgui.Text(u8(update.info))
		imgui.Separator()
		if imgui.Button(fa.CIRCLE_XMARK .. u8' �� ��������� ' .. fa.CIRCLE_XMARK, imgui.ImVec2(250 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
			UpdateWindow[0] = false
		end
		imgui.SameLine()
		if imgui.Button(fa.DOWNLOAD ..u8' ��������� ' .. u8(update.version) .. ' ' .. fa.DOWNLOAD, imgui.ImVec2(250 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
			if thisScript().version:find('VIP') then
				sampAddChatMessage('[Rodina Helper] {ffffff}��������� � VIP ��� � ������� �������� ���������� ������!', message_color)
			else
				download_file = 'helper'
				downloadFileFromUrlToPath(update.url, getWorkingDirectory():gsub('\\','/') .. "/Rodina Helper.lua")
			end
			UpdateWindow[0] = false
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return SobesMenu[0] end,
    function(player)
		if player_id ~= nil and isParamSampID(player_id) then
			imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(fa.PERSON_CIRCLE_CHECK..u8' ���������� ������������� ������ ' .. sampGetPlayerNickname(player_id) .. ' ' .. fa.PERSON_CIRCLE_CHECK, SobesMenu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize)
			change_dpi()
			if imgui.BeginChild('sobes1', imgui.ImVec2(240 * settings.general.custom_dpi, 182 * settings.general.custom_dpi), true) then
				imgui.CenterColumnText(fa.BOOKMARK .. u8" �������� " .. fa.BOOKMARK)
				imgui.Separator()
				if imgui.Button(fa.PLAY .. u8" ������ �������������", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					lua_thread.create(function()
						sampSendChat("������������, � " .. settings.player_info.name_surname .. " - " .. settings.player_info.fraction_rank .. ' ' .. settings.player_info.fraction_tag)
						wait(1500)
						sampSendChat("�� ������ � ��� �� �������������?")
					end)
				end
				if imgui.Button(fa.PASSPORT .. u8" ��������� ���������", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					lua_thread.create(function()
						sampSendChat("������, ������������ ��� ��� ���� ��������� ��� ��������.")
						wait(1500)
						sampSendChat("��� ����� ��� �������, ���.����� � ��������.")
						wait(1500)
						sampSendChat("/n " .. sampGetPlayerNickname(player_id) .. ", ����������� /showpass")
						wait(1500)
						sampSendChat("/n ����������� � RP �����������!")
					end)
				end
				if imgui.Button(fa.USER .. u8" ���������� � ����", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					sampSendChat("������� ���������� � ����.")
				end		
				if imgui.Button(fa.CHECK .. u8" ������������� ��������", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					sampSendChat("/todo ����������! �� ������� ������ �������������!*��������")
				end
				if imgui.Button(fa.USER_PLUS .. u8" ���������� � �����������", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					find_and_use_command('/invite {arg_id}', player_id)
					SobesMenu[0] = false
				end
				imgui.EndChild()
			end
			imgui.SameLine()
			if imgui.BeginChild('sobes2', imgui.ImVec2(240 * settings.general.custom_dpi, 182 * settings.general.custom_dpi), true) then
				imgui.CenterColumnText(fa.BOOKMARK..u8" ������������� " .. fa.BOOKMARK)
				imgui.Separator()
				if imgui.Button(fa.GLOBE .. u8" ������� ����.����� Discord", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					sampSendChat("������� �� � ��� ����. ����� Discord?")
				end
				if imgui.Button(fa.CIRCLE_QUESTION .. u8" ������� ����� ������", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					sampSendChat("������� �� � ��� ���� ������ � ����� �����?")
				end
				if imgui.Button(fa.CIRCLE_QUESTION .. u8" ������ ������ ��?", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					sampSendChat("������� ������ �� ������� ������ ���?")
				end
				if imgui.Button(fa.CIRCLE_QUESTION .. u8" ��� ����� ������������?", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					sampSendChat("������� ��� �� ������ ������ \"������������\"?")
				end
				if imgui.Button(fa.CIRCLE_QUESTION .. u8" ��� ����� ��?", imgui.ImVec2(-1, 25 * settings.general.custom_dpi)) then
					sampSendChat("������� ��� �� �������, ��� ����� \"��\"?")
				end
			imgui.EndChild()
			end
			imgui.SameLine()
			if imgui.BeginChild('sobes3', imgui.ImVec2(150 * settings.general.custom_dpi, -1), true) then
				imgui.CenterColumnText(fa.CIRCLE_XMARK .. u8" ������ " .. fa.CIRCLE_XMARK)
				imgui.Separator()
				local function otkaz(reason)
					lua_thread.create(function ()
						SobesMenu[0] = false
						sampSendChat("/todo � ���������, �� ��� �� ���������*� �������������� �� ����")
						wait(1500)
						sampSendChat(reason)
					end)
				end
				if imgui.Selectable(u8"�����������������") then
					otkaz("� ��� ������ �����������������.")
				end
				if imgui.Selectable(u8"����������������") then
					otkaz("��� ���������� ���������� � ����� ��������, � ������ ����������!")
				end
				if imgui.Selectable(u8"�������� ��������") then
					otkaz("� ��� ��������, ��������� ���� �������� ������������ � ��������.")
				end
				if imgui.Selectable(u8"���� ���.�����") then
					otkaz("� ��� ���� ���.�����, �������� � � ����� ��������.")
				end
				if imgui.Selectable(u8"���� �������� ������") then
					otkaz("� ��� ���� �������� ������!")
				end
				if imgui.Selectable(u8"���� �����") then
					otkaz("� ��� ���� �����! ������� ���� ���/�����/�������.")
				end
				if imgui.Selectable(u8"������� � ��") then
					otkaz("�� �������� � ׸���� ������ ����� �����������!")
				end
				if imgui.Selectable(u8"����.�������������") then
					otkaz("�� �� ��������� ��� ����� ������ �� ���������������� ���������.")
				end
			end
			imgui.EndChild()
		else
			sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������, ID ������ ��������������!', message_color)
			SobesMenu[0] = false
		end
    end
)

imgui.OnFrame(
    function() return RPWeaponWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(600 * settings.general.custom_dpi, 425 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.GUN .. u8" RP ��������� ������ � ���� " .. fa.GUN, RPWeaponWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
		change_dpi()
        imgui.PushItemWidth(385 * settings.general.custom_dpi)
        imgui.InputTextWithHint(u8'##inputsearch_weapon_name', u8('������� ����� ������ ������ �� ��� ID ��� ��������...'), input, 256) 
		imgui.SameLine()
		if imgui.Button(u8("�������� ��")) then
			for index, value in ipairs(modules.rpgun.data.rp_guns) do
				value.enable = true
			end
			save_module('rpgun')
		end		
		imgui.SameLine()
		if imgui.Button(u8("��������� ��")) then
			for index, value in ipairs(modules.rpgun.data.rp_guns) do
				value.enable = false
			end
			save_module('rpgun')
		end		
		if imgui.BeginChild('rpguns1', imgui.ImVec2(588 * settings.general.custom_dpi, 361 * settings.general.custom_dpi), true) then
			imgui.Columns(3)
			imgui.CenterColumnText(u8"�����������������")
			imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8"ID � �������� ������")
			imgui.SetColumnWidth(-1, 300 * settings.general.custom_dpi)
			imgui.NextColumn()
			imgui.CenterColumnText(u8"������������")
			imgui.SetColumnWidth(-1, 150 * settings.general.custom_dpi)
			imgui.Columns(1)
			imgui.Separator()
			local decoded_input = u8:decode(ffi.string(input or ""))
			for index, value in ipairs(modules.rpgun.data.rp_guns) do
				if decoded_input == '' or (value.name and value.name:upper():find(decoded_input:upper())) or value.id == tonumber(decoded_input) then
					imgui.Columns(3)
					if value.enable then
						if imgui.CenterColumnSmallButton(fa.SQUARE_CHECK .. u8'  (��������)##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
							value.enable = not value.enable
							save_module('rpgun')
						end
					else
						if imgui.CenterColumnSmallButton(fa.SQUARE .. u8' (��������)##' .. index, imgui.ImVec2(imgui.GetMiddleButtonX(5), 0)) then
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
						imgui.OpenPopup(fa.GUN .. u8' �������� ������ ' .. fa.GUN .. '##weapon_name' .. index)
					end
					if imgui.BeginPopupModal(fa.GUN .. u8' �������� ������ ' .. fa.GUN .. '##weapon_name' .. index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize ) then
						change_dpi()
						imgui.PushItemWidth(400 * settings.general.custom_dpi)
						imgui.InputText(u8'##weapon_name', _G.weapon_input, 256) 
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
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
						position = '�����'
					elseif value.rpTake == 2 then
						position = '������'
					elseif value.rpTake == 3 then
						position = '����'
					elseif value.rpTake == 4 then
						position = '������'
					end
					imgui.CenterColumnText(u8(position))
					imgui.SameLine()
					if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##weapon_position' .. index) then
						ComboTags2[0] = value.rpTake - 1
						imgui.OpenPopup(fa.GUN .. u8' ������������ ������##weapon_name' .. index)
					end
					if imgui.BeginPopupModal(fa.GUN .. u8' ������������ ������##weapon_name' .. index, _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize ) then
						change_dpi()
						imgui.PushItemWidth(400 * settings.general.custom_dpi)
						imgui.Combo(u8'##' .. index, ComboTags2, ImItems2, #item_list2)
						if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ' .. fa.CIRCLE_XMARK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							imgui.CloseCurrentPopup()
						end
						imgui.SameLine()
						if imgui.Button(fa.FLOPPY_DISK .. u8' ��������� ' .. fa.FLOPPY_DISK, imgui.ImVec2(200 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
							value.rpTake = ComboTags2[0] + 1
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

-- MH
imgui.OnFrame(
    function() return medCard.menu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.HOSPITAL.." Rodina Helper " .. fa.HOSPITAL .. "##medcard", medCard.menu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		imgui.CenterText(u8'���� �������� ���.�����:')
		if imgui.RadioButtonIntPtr(u8" 7 ���� ##0",medCard.days,0) then
			medCard.days[0] = 0
		end
		if imgui.RadioButtonIntPtr(u8" 14 ���� ##1",medCard.days,1) then
			medCard.days[0] = 1
		end
		if imgui.RadioButtonIntPtr(u8" 30 ���� ##2",medCard.days,2) then
			medCard.days[0] = 2
		end
		if imgui.RadioButtonIntPtr(u8" 60 ���� ##3",medCard.days,3) then
			medCard.days[0] = 3
		end
		imgui.Separator()
		imgui.CenterText(u8'C����� �������� ��������:')
		if imgui.RadioButtonIntPtr(u8" �� ��������� ##0", medCard.status,0) then
			medCard.status[0] = 0
		end
		if imgui.RadioButtonIntPtr(u8" ���������� �� ������ ##1", medCard.status,1) then
			medCard.status[0] = 1
		end
		if imgui.RadioButtonIntPtr(u8" ����������� ���������� ##2", medCard.status,2) then
			medCard.status[0] = 2
		end
		if imgui.RadioButtonIntPtr(u8" ��������� ������ ##3", medCard.status,3) then
			medCard.status[0] = 3
		end
		imgui.Separator()
		if imgui.Button(fa.ID_CARD_CLIP..u8" ������ ���.�����", imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
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
						commands.isActive = true
						commands.isPause = false
						if modifiedText:find('&.+&') then
							if isMonetLoader() and settings.general.mobile_stop_button then
								sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ������ ����� ������', message_color)
								CommandStopWindow[0] = true
							elseif not isMonetLoader() and hotkey_no_errors and settings.general.bind_command_stop and settings.general.use_binds then
								sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_command_stop), message_color)
							else
								sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop', message_color)
							end
						end
						local lines = {}
						for line in string.gmatch(modifiedText, "[^&]+") do
							table.insert(lines, line)
						end
						for line_index, line in ipairs(lines) do 
							if commands.isStop then 
								commands.isStop = false 
								commands.isActive = false
								if isMonetLoader() and settings.general.mobile_stop_button then
									CommandStopWindow[0] = false
								end
								sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������� /' .. command.cmd .. " ������� �����������!", message_color) 
								return 
							end
							if wait_tag then
								for tag, replacement in pairs(binderTags) do
									if line:find("{" .. tag .. "}") then
										local success, result = pcall(string.gsub, line, "{" .. tag .. "}", replacement())
										if success then
											line = result
										end
									end
								end
								if line == "{pause}" then
									sampAddChatMessage('[Rodina Helper] {ffffff}������� /' .. command.cmd .. ' ���������� �� �����!', message_color)
									commands.isPause = true
									CommandPauseWindow[0] = true
									while commands.isPause do
										wait(0)
									end
									if not commands.isStop then
										sampAddChatMessage('[Rodina Helper] {ffffff}��������� ��������� ������� /' .. command.cmd, message_color)	
									end					
								else
									sampSendChat(line)
									if debug_mode then sampAddChatMessage('[Rodina Helper DEBUG] SEND: ' .. line, message_color) end	
									wait(command.waiting * 1000)
								end
							end
							if not wait_tag then
								if line == '{show_medcard_menu}' then
									wait_tag = true
								end
							end
						end
						commands.isActive = false
						if isMonetLoader() and settings.general.mobile_stop_button then
							CommandStopWindow[0] = false
						end
					end)
				end
			end
			if not command_find then
				sampAddChatMessage('[Rodina Helper] {ffffff}���� ��� ������ ���.����� ����������� ���� ��������!', message_color)
				sampAddChatMessage('[Rodina Helper] {ffffff}���������� �������� ��������� �������!', message_color)
			end
			medCard.menu[0] = false
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return recept.menu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.HOSPITAL.." Rodina Helper " .. fa.HOSPITAL .. "##recept", recept.menu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		imgui.CenterText(u8'���������� �������� ��� ������:')
		imgui.PushItemWidth(250 * settings.general.custom_dpi)
		imgui.SliderInt('', recept.recepts, 1, 5)
		imgui.Separator()
		if imgui.Button(fa.CAPSULES .. u8" ������ ������� " .. fa.CAPSULES, imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
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
						commands.isActive = true
						commands.isPause = false
						if modifiedText:find('&.+&') then
							if isMonetLoader() and settings.general.mobile_stop_button then
								sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ������ ����� ������', message_color)
								CommandStopWindow[0] = true
							elseif not isMonetLoader() and hotkey_no_errors and settings.general.bind_command_stop and settings.general.use_binds then
								sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_command_stop), message_color)
							else
								sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop', message_color)
							end
						end
						local lines = {}
						for line in string.gmatch(modifiedText, "[^&]+") do
							table.insert(lines, line)
						end
						for line_index, line in ipairs(lines) do 
							if commands.isStop then 
								commands.isStop = false 
								commands.isActive = false
								if isMonetLoader() and settings.general.mobile_stop_button then
									CommandStopWindow[0] = false
								end
								sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������� /' .. command.cmd .. " ������� �����������!", message_color) 
								return 
							end
							if wait_tag then
								for tag, replacement in pairs(binderTags) do
									if line:find("{" .. tag .. "}") then
										local success, result = pcall(string.gsub, line, "{" .. tag .. "}", replacement())
										if success then
											line = result
										end
									end
								end
								if line == "{pause}" then
									sampAddChatMessage('[Rodina Helper] {ffffff}������� /' .. command.cmd .. ' ���������� �� �����!', message_color)
									commands.isPause = true
									CommandPauseWindow[0] = true
									while commands.isPause do
										wait(0)
									end
									if not commands.isStop then
										sampAddChatMessage('[Rodina Helper] {ffffff}��������� ��������� ������� /' .. command.cmd, message_color)	
									end					
								else
									sampSendChat(line)
									if debug_mode then sampAddChatMessage('[Rodina Helper DEBUG] SEND: ' .. line, message_color) end	
									wait(command.waiting * 1000)
								end
							end
							if not wait_tag then
								if line == '{show_recept_menu}' then
									wait_tag = true
								end
							end
						end
						commands.isActive = false
						if isMonetLoader() and settings.general.mobile_stop_button then
							CommandStopWindow[0] = false
						end
					end)
				end
			end
			if not command_find then
				sampAddChatMessage('[Rodina Helper] {ffffff}���� ��� ������ �������� ����������� ���� ��������!', message_color)
				sampAddChatMessage('[Rodina Helper] {ffffff}���������� �������� ��������� �������!', message_color)
			end
			recept.menu[0] = false
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return antibiotik.menu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.HOSPITAL.." Rodina Helper " .. fa.HOSPITAL .. "##ant", antibiotik.menu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		imgui.CenterText(u8'���������� ������������ ��� ������:')
		imgui.PushItemWidth(250 * settings.general.custom_dpi)
		imgui.SliderInt('', antibiotik.ants, 1, 20)
		imgui.Separator()
		if imgui.Button(fa.CAPSULES..u8" ������ �����������" , imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
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
						commands.isActive = true
						commands.isPause = false
						if modifiedText:find('&.+&') then
							if isMonetLoader() and settings.general.mobile_stop_button then
								sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ������ ����� ������', message_color)
								CommandStopWindow[0] = true
							elseif not isMonetLoader() and hotkey_no_errors and settings.general.bind_command_stop and settings.general.use_binds then
								sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop {ffffff}��� ������� ' .. message_color_hex .. getNameKeysFrom(settings.general.bind_command_stop), message_color)
							else
								sampAddChatMessage('[Rodina Helper] {ffffff}����� ���������� ��������� ������� ����������� ' .. message_color_hex .. '/stop', message_color)
							end
						end
						local lines = {}
						for line in string.gmatch(modifiedText, "[^&]+") do
							table.insert(lines, line)
						end
						for line_index, line in ipairs(lines) do 
							if commands.isStop then 
								commands.isStop = false 
								commands.isActive = false
								if isMonetLoader() and settings.general.mobile_stop_button then
									CommandStopWindow[0] = false
								end
								sampAddChatMessage('[Rodina Helper] {ffffff}��������� ������� /' .. command.cmd .. " ������� �����������!", message_color) 
								return 
							end
							if wait_tag then
								for tag, replacement in pairs(binderTags) do
									if line:find("{" .. tag .. "}") then
										local success, result = pcall(string.gsub, line, "{" .. tag .. "}", replacement())
										if success then
											line = result
										end
									end
								end
								if line == "{pause}" then
									sampAddChatMessage('[Rodina Helper] {ffffff}������� /' .. command.cmd .. ' ���������� �� �����!', message_color)
									commands.isPause = true
									CommandPauseWindow[0] = true
									while commands.isPause do
										wait(0)
									end
									if not commands.isStop then
										sampAddChatMessage('[Rodina Helper] {ffffff}��������� ��������� ������� /' .. command.cmd, message_color)	
									end					
								else
									sampSendChat(line)
									if debug_mode then sampAddChatMessage('[Rodina Helper DEBUG] SEND: ' .. line, message_color) end	
									wait(command.waiting * 1000)
								end
							end
							if not wait_tag then
								if line == '{show_ant_menu}' then
									wait_tag = true
								end
							end
						end
						commands.isActive = false
						if isMonetLoader() and settings.general.mobile_stop_button then
							CommandStopWindow[0] = false
						end
					end)
				end
			end
			if not command_find then
				sampAddChatMessage('[Rodina Helper] {ffffff}���� ��� ������ ������������ ����������� ���� ��������!', message_color)
				sampAddChatMessage('[Rodina Helper] {ffffff}���������� �������� ��������� �������!', message_color)
			end
			antibiotik.menu[0] = false
		end
		imgui.End()
    end
)
imgui.OnFrame(
    function() return heal_in_chat.fast_menu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 8.5, sizeY / 1.9), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.HOSPITAL.." Rodina Helper " .. fa.HOSPITAL .. "##fast_heal", heal_in_chat.fast_menu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar +  imgui.WindowFlags.AlwaysAutoResize )
		change_dpi()
		if imgui.Button(fa.KIT_MEDICAL..u8' �������� '..sampGetPlayerNickname(heal_in_chat.player_id)) then
			find_and_use_command("/heal {arg_id}", heal_in_chat.player_id)
			heal_in_chat.bool = false
			heal_in_chat.player_id = nil
			heal_in_chat.fast_menu[0] = false
		end
		imgui.End()
    end
)

-- MJ
imgui.OnFrame(
    function() return PatroolMenu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.patrool_menu.x, settings.windows_pos.patrool_menu.y), imgui.Cond.FirstUseEver)
		--imgui.SetNextWindowSize(imgui.ImVec2(225 * settings.general.custom_dpi, 113 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(getHelperIcon() .. u8" Rodina Helper " .. getHelperIcon() .. '##patrool_info_menu', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
		change_dpi()
		if not isMonetLoader() and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then player.HideCursor = true else player.HideCursor = false end
		if patrool.active then
			imgui.Text(fa.CLOCK .. u8(' ����� ��������������: ') .. u8(binderTags.get_patrool_time()))
			imgui.Separator()
			imgui.Text(fa.CIRCLE_INFO .. u8(' ���� ���������: ') .. u8(binderTags.get_patrool_code()))
			imgui.SameLine()
			if imgui.SmallButton(fa.GEAR) then
				imgui.OpenPopup(fa.BUILDING_SHIELD .. u8(' Rodina Helper##patrool_select_code'))
			end
			imgui.Separator()
			if imgui.Button(fa.WALKIE_TALKIE .. u8(' ������'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				lua_thread.create(function ()
					sampSendChat('/r ' .. binderTags.my_doklad_nick() .. ' �� CONTROL.')
					wait(1500)
					sampSendChat('/r ��������� �������, �������� � ������ ' .. binderTags.get_area() .. " (" .. binderTags.get_square() .. ').')
					wait(1500)
					if binderTags.get_car_units() ~= '����' then
						sampSendChat('/r ���������� ��� ' .. binderTags.get_patrool_format_time() .. ' � ������� ����� ' .. binderTags.get_car_units() .. ', ��������� ' .. binderTags.get_patrool_code() .. '.')
					else
						sampSendChat('/r ���������� ��� ' .. binderTags.get_patrool_format_time() .. ', ��������� ' .. binderTags.get_patrool_code() .. '.')
					end
				end)
			end
			imgui.SameLine()
			if imgui.Button(fa.CIRCLE_STOP .. u8(' ���������'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				lua_thread.create(function ()
					PatroolMenu[0] = false
					patrool.active = false
					sampSendChat('/r ' .. binderTags.my_doklad_nick() .. ' �� CONTROL.')
					wait(1500)
					sampSendChat('/r �������� �������, ���������� ���������� ' .. binderTags.get_patrool_mark() .. ', ��������� ' .. binderTags.get_patrool_code())
					wait(1500)
					sampSendChat('/r ������������ ' .. binderTags.get_patrool_format_time(), -1)
					patrool.time = 0
					patrool.start_time = 0
					patrool.current_time = 0
					patrool.code = 'CODE4'
					ComboPatroolCode[0] = 5
					wait(1500)
					sampSendChat('/delvdesc')
				end)
			end
		else
			player.HideCursor = false	
			imgui.CenterText(u8('��������� ������ ����� ������� �������:'))
			imgui.Separator()
			imgui.Text(fa.CIRCLE_INFO .. u8(' ���� ����������: '))
			imgui.SameLine()
			imgui.PushItemWidth(150 * settings.general.custom_dpi)
			if imgui.Combo('##patrool_mark', ComboPatroolMark, ImItemsPatroolMark, #combo_patrool_mark_list) then
				patrool.mark = combo_patrool_mark_list[ComboPatroolMark[0] + 1] 
			end
			imgui.Separator()
			imgui.Text(fa.CIRCLE_INFO .. u8(' ���� ���������: '))
			imgui.SameLine()
			imgui.PushItemWidth(150 * settings.general.custom_dpi)
			if imgui.Combo('##patrool_code', ComboPatroolCode, ImItemsPatroolCode, #combo_patrool_code_list) then
				patrool.code = combo_patrool_code_list[ComboPatroolCode[0] + 1]
			end
			imgui.Separator()
			imgui.Text(fa.CIRCLE_INFO .. u8(' ���������: ') .. u8(binderTags.get_car_units()))
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ������ ', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
				PatroolMenu[0] = false
			end
			imgui.SameLine()
			if imgui.Button(fa.WALKIE_TALKIE .. u8' ������ �������', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
				patrool.time = 0
				patrool.start_time = os.time()
				patrool.active = true
				lua_thread.create(function ()
					sampSendChat('/r ' .. binderTags.my_doklad_nick() .. ' �� CONTROL.')
					wait(1500)
					sampSendChat('/r ������� �������, �������� � ������ ' .. binderTags.get_area() .. " (" .. binderTags.get_square() .. ').')
					wait(1500)
					if binderTags.get_car_units() ~= '����' then
						sampSendChat('/r ������� ���������� ' .. binderTags.get_patrool_mark() .. ', �������� � ������� ����� ' .. binderTags.get_car_units() .. ', ��������� ' .. binderTags.get_patrool_code() .. '.')
					else
						sampSendChat('/r ������� ���������� ' .. binderTags.get_patrool_mark() .. ', ��������� ' .. binderTags.get_patrool_code() .. '.')
					end
					wait(1500)
					sampSendChat('/vdesc ' .. binderTags.get_patrool_mark())
				end)
				imgui.CloseCurrentPopup()
			end
		end
		if imgui.BeginPopup(fa.BUILDING_SHIELD .. u8(' Rodina Helper##patrool_select_code'), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  ) then
			change_dpi()
			player.HideCursor = false 
			imgui.PushItemWidth(150 * settings.general.custom_dpi)
			if imgui.Combo('##patrool_code', ComboPatroolCode, ImItemsPatroolCode, #combo_patrool_code_list) then
				patrool.code = combo_patrool_code_list[ComboPatroolCode[0] + 1]
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

-- MD
imgui.OnFrame(
    function() return PostMenu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(settings.windows_pos.patrool_menu.x, settings.windows_pos.patrool_menu.y), imgui.Cond.FirstUseEver)
		--imgui.SetNextWindowSize(imgui.ImVec2(225 * settings.general.custom_dpi, 113 * settings.general.custom_dpi), imgui.Cond.FirstUseEver)
		imgui.Begin(getHelperIcon() .. u8" Rodina Helper " .. getHelperIcon() .. '##post_info_menu', PostMenu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize )
		change_dpi()
		if not isMonetLoader() and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then player.HideCursor = true else player.HideCursor = false end
		if patrool.active then
			imgui.Text(fa.MAP_LOCATION_DOT .. u8(' ����: ') .. u8(binderTags.get_patrool_name()))
			imgui.Text(fa.CLOCK .. u8(' ����� �� �����: ') .. u8(binderTags.get_patrool_time()))
			imgui.Text(fa.CIRCLE_INFO .. u8(' ���������: ') .. u8(binderTags.get_patrool_code()))
			imgui.SameLine()
			if imgui.SmallButton(fa.GEAR) then
				imgui.OpenPopup(fa.BUILDING_SHIELD .. u8(' Rodina Helper##post_select_code'))
			end
			imgui.Separator()
			if imgui.Button(fa.WALKIE_TALKIE .. u8(' ������##post'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				lua_thread.create(function ()
					sampSendChat('/r ' .. binderTags.my_doklad_nick() .. ' �� CONTROL. ����: ' .. binderTags.get_patrool_name() .. ', ��������� ' .. binderTags.get_patrool_code() .. '.')
					wait(1500)
					sampSendChat('/r �������� �� ����� ��� ' .. binderTags.get_patrool_format_time(), -1)
				end)
			end
			imgui.SameLine()
			if imgui.Button(fa.CIRCLE_STOP .. u8(' �����##post'), imgui.ImVec2(100 * settings.general.custom_dpi, 25 * settings.general.custom_dpi)) then
				lua_thread.create(function()
					PostMenu[0] = false
					patrool.active = false
					sampSendChat('/r ' .. binderTags.my_doklad_nick() .. ' �� CONTROL. ����: ' .. binderTags.get_patrool_name() .. ', ��������� ' .. binderTags.get_patrool_code() .. '.')
					wait(1500)
					sampSendChat('/r ���������� ����! ��������' .. binderTags.sex() .. ' �� �����: ' .. binderTags.get_patrool_format_time() .. '.', -1)
					patrool.time = 0
					patrool.start_time = 0
					patrool.current_time = 0
					patrool.code = 'CODE4'
					ComboPatroolCode[0] = 5
				end)
			end
		else
			player.HideCursor = false	
			imgui.PushItemWidth(200 * settings.general.custom_dpi)
			if imgui.InputTextWithHint(u8'##post_name', u8('������� �������� ������ �����'), input, 256) then
				patrool.name = u8:decode(ffi.string(input))
			end
			imgui.Separator()
			if imgui.Button(fa.CIRCLE_XMARK .. u8' ������##post', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
				PostMenu[0] = false
			end
			imgui.SameLine()
			if imgui.Button(fa.WALKIE_TALKIE .. u8' ���������##post', imgui.ImVec2(imgui.GetMiddleButtonX(2), 25 * settings.general.custom_dpi)) then
				patrool.time = 0
				patrool.start_time = os.time()
				patrool.active = true
				sampSendChat('/r ' .. binderTags.my_doklad_nick() .. ' �� CONTROL. �������� �� ���� ' .. binderTags.get_patrool_name() .. ', ��������� ' .. binderTags.get_patrool_code() .. '.')
				imgui.CloseCurrentPopup()
			end
		end
		--imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		if imgui.BeginPopup(fa.BUILDING_SHIELD .. u8(' Rodina Helper##post_select_code'), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  ) then
			change_dpi()
			player.HideCursor = false 
			imgui.PushItemWidth(150 * settings.general.custom_dpi)
			if imgui.Combo('##post_code', ComboPatroolCode, ImItemsPatroolCode, #combo_patrool_code_list) then
				patrool.code = combo_patrool_code_list[ComboPatroolCode[0] + 1]
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
    function() return ProbivMenu[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(getHelperIcon() .." Rodina Helper " .. getHelperIcon() .. '##probiv', ProbivMenu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize  + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
		change_dpi()
		
		if probiv ~= nil then
			if imgui.BeginChild('##probiv_2', imgui.ImVec2(400 * settings.general.custom_dpi, 405 * settings.general.custom_dpi), true) then
				imgui.CenterText(u8" ����� " .. u8(u8:decode(ffi.string(input))) .. " [UID " .. tostring(probiv.id or '0') .. u8"] �� ������� " .. (probiv.server and probiv.server.name and probiv.server.id and (u8(probiv.server.name) .. " (" .. tostring(probiv.server.id) .. ")") or "nil"))
				imgui.Separator()
				imgui.Text(fa.SIGNAL .. u8(' �������: ') ..  (probiv.level and probiv.level.level or "0") .. ' (' .. (probiv.level and probiv.level.current_exp or 0) .. '/' .. (probiv.level and probiv.level.next_exp or 0) .. ' exp)')
				imgui.Text(fa.CIRCLE .. u8' �������� �����: ' .. (probiv.hours_played or "0") .. u8" �����")
				imgui.Text(fa.CROWN .. u8(' VIP ������: ') ..  (probiv.vip_info and u8(probiv.vip_info.level) or u8"����������"))
				imgui.Text(fa.VAULT .. u8(' AZ ������: ') .. comma_value(probiv.money and probiv.money.donate_currency or "0"))
				imgui.Text(fa.PHONE .. u8' ����� ��������: ' .. u8(probiv.phone_number or "0"))			
				imgui.Text(fa.STAR .. u8(' ������� �������: ') .. comma_value(probiv.wanted_level or "0"))
				imgui.Text(fa.TRIANGLE_EXCLAMATION .. u8(' �����: ') .. (tostring(probiv.warnings or "0") .. "/3"))

				imgui.Separator()
				imgui.CenterText(fa.MONEY_CHECK_DOLLAR .. u8(' ������ ������ ') .. fa.MONEY_CHECK_DOLLAR)
				imgui.Text(fa.HAND_HOLDING_DOLLAR .. u8(' �� �����: $') .. comma_value(probiv.money and probiv.money.hand or "0"))
				imgui.Text(fa.LANDMARK .. u8(' �� ���������� �����: $') .. comma_value(probiv.money and probiv.money.bank or "0"))
				imgui.Text(fa.VAULT .. u8(' �� �������� � �����: $') .. comma_value(probiv.money and probiv.money.deposit or "0"))
				local function get_personal_money() 
					local money = 0
					if probiv.money and probiv.money.personal_accounts then
						for i = 1, 6 do
							local key = "bankAccount" .. i
							local money2 = probiv.money.personal_accounts[key]
							if money2 and money2 ~= "-1" then
								money = money + money2
							end
						end
						return comma_value(money)
					end
					return 0
				end
				imgui.Text(fa.VAULT .. u8(' �� ������ ������ � �����: $') .. (get_personal_money()))
				imgui.Separator()
				imgui.CenterText(fa.BUILDING .. u8(' ����������� ������ ') .. fa.BUILDING)
				imgui.Text(fa.CIRCLE .. u8" ��������: " .. u8(probiv.organization and probiv.organization.name or "����"))
				imgui.Text(fa.CIRCLE .. u8" ���������: " .. u8(probiv.organization and probiv.organization.rank or "����"))
				imgui.Separator()
				imgui.CenterText(fa.HOUSE .. u8(' ������ ���� ������ ') .. fa.HOUSE)
				if probiv.property and probiv.property.houses and #probiv.property.houses > 0 then
					local house_ids = {}
					for i, house in ipairs(probiv.property.houses) do
						table.insert(house_ids, tostring(house.id))
					end
					imgui.TextWrapped(fa.CIRCLE .. u8(' ') .. table.concat(house_ids, ", "))
				else
					imgui.Text(fa.CIRCLE .. u8(' ��� �����'))
				end
				imgui.Separator()
				imgui.CenterText(fa.BUSINESS_TIME .. u8(' ������ ������� ������ ') .. fa.BUSINESS_TIME)
				if probiv.property and probiv.property.businesses and #probiv.property.businesses > 0 then
					local business_ids = {}
					for i, biz in ipairs(probiv.property.businesses) do
						table.insert(business_ids, tostring(biz.id))
					end
					imgui.TextWrapped(fa.CIRCLE .. u8(' ') .. table.concat(business_ids, ", "))
				else
					imgui.Text(fa.CIRCLE .. u8(' ��� ��������'))
				end
				imgui.EndChild()
			end
		else
			if imgui.BeginChild('##probiv_1', imgui.ImVec2(300 * settings.general.custom_dpi, 230 * settings.general.custom_dpi), true) then
				imgui.CenterText(u8('��������� ���� ����� ��������� Deps API'))
				imgui.CenterText(u8('MTG MODS �� �������� �� ������ �������'))
				imgui.Separator()
				imgui.CenterText(fa.KEY .. u8(' API key ��� �������'))
				imgui.PushItemWidth(290 * settings.general.custom_dpi)
				if imgui.InputText(u8'##probiv_apikey', input_probiv_key, 256, imgui.InputTextFlags.Password) then
					settings.general.probiv_api_key = u8:decode(ffi.string(input_probiv_key))
					save_settings()
				end
				imgui.CenterText(u8('���� API key? ��������� ���� ������� /new'))
				if imgui.CenterButton(fa.CIRCLE_ARROW_RIGHT .. u8(' �������� API ���� � Telegram ���� ') .. fa.CIRCLE_ARROW_LEFT) then
					openLink('')
				end
				imgui.Separator()
				imgui.CenterText(fa.USER .. u8(' ��� ������ ��� �������'))
				imgui.PushItemWidth(290 * settings.general.custom_dpi)
				imgui.InputText(u8'##probiv_nick', input, 256)
				imgui.Separator()
				-- imgui.CenterText(fa.USER .. u8(' ����� ������� ������'))
				-- imgui.PushItemWidth(290 * settings.general.custom_dpi)
				-- imgui.InputText(u8'##probiv_server', input, 256)
				-- imgui.Separator()
				if imgui.CenterButton(fa.CIRCLE_ARROW_RIGHT .. u8(' ������ ���� �� ������ ') .. fa.CIRCLE_ARROW_LEFT) then
					sampAddChatMessage('[Rodina Helper] {ffffff}��������� ���������� ��� ������ ' .. ffi.string(input) .. "...", message_color)
					sampAddChatMessage('[Rodina Helper] {ffffff}��������! ��� ������ �� ���������� API, � MTG MODS �� ����� � ����� ���������.', message_color)
					getPlayerInfo(u8:decode(ffi.string(input)), getARZServerNumber())
				end
				imgui.EndChild()
			end
		end
		imgui.End()
    end
)

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
function imgui.Tooltip(text)
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

function main()

	if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(0) end 

	if settings.general.fraction_mode == '' then
		repeat wait(0) until sampIsLocalPlayerSpawned()
		InititalWindow[0] = true
		return
	end
	
	load_module('commands')
	load_module('notes')
	load_module('rpgun')
	load_module('arz_veh')

	if (settings.general.fraction_mode == 'police' or settings.general.fraction_mode == 'fbi') then
		load_module('smart_uk')
		load_module('smart_pdd')
		if settings.general.mobile_taser_button and isMonetLoader() then
			TaserWindow[0] = true
		end	
		if settings.general.mobile_meg_button and isMonetLoader() then
			MegafonWindow[0] = true
		end	
	elseif (settings.general.fraction_mode == 'prison') then
		load_module('smart_rptp')
		if settings.general.mobile_taser_button and isMonetLoader() then
			TaserWindow[0] = true
		end	
	end
	
	initialize_guns()
	initialize_commands()

	if not isMonetLoader() then loadHotkeys() end

	welcome_message()
	
	check_update()

	while true do
		wait(0)

		if (isMonetLoader() and settings.general.mobile_fastmenu_button) then
			if tonumber(#get_players()) > 0 and not FastMenu[0] and not FastMenuPlayers[0] then
				FastMenuButton[0] = true
			else
				FastMenuButton[0] = false
			end
		end

		if (isMode('police') or isMode('fbi') or isMode('army') or isMode('prison')) then
			if patrool.active then
				patrool.time = os.difftime(os.time(), patrool.start_time)
				
			end
			if patrool.active and isCharInAnyCar(PLAYER_PED) and settings.general.auto_change_code_siren then
				local currentSirenState = isCarSirenOn(storeCarCharIsInNoSave(PLAYER_PED))
				if firstCheck then
					lastSirenState = currentSirenState
					firstCheck = false
				end
				if currentSirenState ~= lastSirenState then
					lastSirenState = currentSirenState
					if currentSirenState then
						sampAddChatMessage("[Rodina Helper - ���������] {ffffff}� ����� �/� ���� �������� ������, ������� ������������ ��� �� CODE 3!", message_color)
						ComboPatroolCode[0] = 4
						patrool.code = combo_patrool_code_list[ComboPatroolCode[0] + 1]
					else
						sampAddChatMessage("[Rodina Helper - ���������] {ffffff}� ����� �/� ���� ��������� ������, ������� ������������ ��� �� CODE 4.", message_color)
						ComboPatroolCode[0] = 5
						patrool.code = combo_patrool_code_list[ComboPatroolCode[0] + 1]
					end
				end
			end
		end

		

		if (modules.rpgun.data.nowGun ~= getCurrentCharWeapon(PLAYER_PED)) then
            modules.rpgun.data.oldGun = modules.rpgun.data.nowGun
            modules.rpgun.data.nowGun = getCurrentCharWeapon(PLAYER_PED)
            if not isExistsWeapon(modules.rpgun.data.oldGun) then
                handleNewWeapon(modules.rpgun.data.oldGun)
            elseif not isExistsWeapon(modules.rpgun.data.nowGun) then
                handleNewWeapon(modules.rpgun.data.nowGun)
            end
            processWeaponChange(modules.rpgun.data.oldGun, modules.rpgun.data.nowGun)
        end


		if (settings.general.auto_notify_payday) then
			local currentMinute = os.date("%M", os.time())
			local currentSecond = os.date("%S", os.time())
			if ((currentMinute == "55" or currentMinute == "25") and currentSecond == "00") then
				if sampGetPlayerColor(binderTags.my_id()) == 368966908 then
					sampAddChatMessage('[Rodina Helper] {ffffff}����� 5 ����� ����� PAYDAY. �������� ����� ����� �� ���������� ��������!', message_color)
					playNotifySound()
					wait(1000)
				end
			end
		end
		
		if (debug_mode) then
			-- sampAddChatMessage(sampGetPlayerAnimationId(binderTags.my_id()), -1)
		end

	end

end

-- PieMenu (PC)
function importPieMenuLibnary()
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
return defaultPieMenu]])
		file:close()
	end
end
if (not isMonetLoader()) then
	if (not doesFileExist(getWorkingDirectory():gsub('\\','/') .. "/lib/mimgui_piemenu.lua")) then 
		importPieMenuLibnary()
	end
	local pie = require("mimgui_piemenu")
	FastPieMenu[0] = true
	imgui.OnFrame(
		function() return FastPieMenu[0] end,
		function(player)
			if not isMonetLoader() and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then player.HideCursor = true else player.HideCursor = false end
			imgui.Begin('##FastPieMenu', FastPieMenu, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoTitleBar)
			if imgui.IsMouseClicked(2) then
				imgui.OpenPopup('PieMenu')
			end
			if pie.BeginPiePopup('PieMenu', 2) then
				player.HideCursor = false
				
				if pie.PieMenuItem(u8' �������') then
					if imgui.IsMouseReleased(2) then 
						find_and_use_command('�� ������ �����', "")
					end
				end
				if pie.BeginPieMenu(u8'������� ����') then
					if pie.PieMenuItem('10-55') then 
						if imgui.IsMouseReleased(2) then
							find_and_use_command('������� 10%-55', "")
						end
					end
					if pie.PieMenuItem('10-66') then 
						if imgui.IsMouseReleased(2) then
							find_and_use_command('������� 10%-66', "")
						end
					end
					pie.EndPieMenu()
				end
				
				if pie.PieMenuItem(u8'������', false) then 
					if imgui.IsMouseReleased(2) then
						sampSendChat('/taser')
					end
				end

				if pie.BeginPieMenu('Test', false) then 
					if pie.BeginPieMenu('Test 1') then 
						
						pie.EndPieMenu()
					end
					if pie.BeginPieMenu('Cam') then 
						if pie.PieMenuItem(u8'CamON') then 
							if imgui.IsMouseReleased(2) then
								find_and_use_command('���� ������ ��������', "")
						end
					end
						if pie.PieMenuItem(u8'CamOFF') then 
							if imgui.IsMouseReleased(2) then
								find_and_use_command('���� ������ ���������', "")
						end
					end
					pie.EndPieMenu()
				end
					if pie.BeginPieMenu('MBD') then 
						if pie.PieMenuItem(u8'������ ����������') then 
							if imgui.IsMouseReleased(2) then
								find_and_use_command('����� ���������� ��������, �������������� ���� ��������.', "")
							end
						end
						if pie.PieMenuItem(u8'����-������') then 
							if imgui.IsMouseReleased(2) then
								find_and_use_command('������� 10%-55', "")
							end
						end
						if pie.PieMenuItem(u8'�������') then 
							if imgui.IsMouseReleased(2) then
								find_and_use_command('������������. �� ��������� ������������', "")
							end
						end
						pie.EndPieMenu()
					end
					-- if pie.BeginPieMenu('Test 4') then 
						
					-- 	pie.EndPieMenu()
					-- end
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
end

-- ����� ���� ��� ���� ������� � ������ �����


function onScriptTerminate(script, game_quit)
    if script == thisScript() and not game_quit and not reload_script then
		if InfraredVision then setInfraredVision(false) end
		if NightVision then setNightVision(false) end
		playNotifySound()
		sampAddChatMessage('[Rodina Helper] {ffffff}��������� ����������� ������, ������ ������������ ���� ������!', message_color)
		if not isMonetLoader() then 
			sampAddChatMessage('[Rodina Helper] {ffffff}����������� ' .. message_color_hex .. 'CTRL {ffffff}+ ' .. message_color_hex .. 'R {ffffff}����� ������������� ������.', message_color)
		end
    end
end
