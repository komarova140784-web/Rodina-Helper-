require "lib.moonloader"
require 'lib.sampfuncs'

local ffi = require 'ffi'
local statuscheckafk = true
local inicfg = require 'inicfg'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'    
u8 = encoding.UTF8
CP1251 = encoding.CP1251
sw,sh = getScreenResolution()

script_name("Control AFK") 
script_author("leeky rave") 
script_description("я не люблю табуляцию") 
script_version_number(1) 
script_version("1")
script_properties('work-in-pause')


function ShowMessage(text, title, style)
    ffi.cdef [[
        int MessageBoxA(
            void* hWnd,
            const char* lpText,
            const char* lpCaption,
            unsigned int uType
        );
    ]]
    local hwnd = ffi.cast('void*', readMemory(0x00C8CF88, 4, false))
    ffi.C.MessageBoxA(hwnd, text,  title, style and (style + 0x50000) or 0x50000)
end








local directIni = "ControlAFK\\settings.ini"



local def = {

    settings = {
        
        state = true,
        limit = 900,
        allowance = -1,
        exit = true,
    },

}



local ini = inicfg.load(def, directIni)

if not doesDirectoryExist('moonloader/config/ControlAFK') then createDirectory ("moonloader/config/ControlAFK") end
if not doesFileExist('moonloader/config/ControlAFK/settings.ini') then inicfg.save(def, directIni) end


local afkSet = {
    ['state']   = imgui.ImBool(ini.settings.state),
    ['limit']       = imgui.ImInt(ini.settings.limit),
    ['allowance']   = imgui.ImInt(ini.settings.allowance), 
    ['exitstate']   = imgui.ImBool(ini.settings.exit),
    ['wstate']      = imgui.ImBool(false)
}
local startafktime = 0

function main()

    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end

    sampRegisterChatCommand('cafk',function() afkSet['wstate'].v = not afkSet['wstate'].v end)


    while true do 
        imgui.Process = afkSet['wstate'].v
    wait(0)
        if isGamePaused() and afkSet['state'].v and statuscheckafk then  

            startafktime = os.time()

            statuscheckafk = false 

        elseif not isGamePaused()  then  

        

            statuscheckafk = true 
            startafktime = 0
       
        end 

            if afkSet['state'].v and isGamePaused() then 
        
                if os.time() - startafktime == afkSet['limit'].v - afkSet['allowance'].v then  

                    ShowMessage('Значение афк уже достигло '.. afkSet['limit'].v - afkSet['allowance'].v ..' секунд\nЧерез 30 секунд игра будет закрыта.', 'Control AFK', 0x30)
      

                end 
            end
            
            if afkSet['exitstate'].v and afkSet['state'].v and isGamePaused() then  

                if os.time() - startafktime == afkSet['limit'].v  then  
                  
                  os.exit()
          
                end 
          
            end 
              
    end

    wait(-1)

end



function imgui.OnDrawFrame()

    if afkSet['wstate'].v then
    
        imgui.Begin(u8'Контроль афк',afkSet['wstate'],imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)
          imgui.SetWindowPos(u8'Контроль афк', imgui.ImVec2(sw/2 - imgui.GetWindowSize().x/2, sh/2 - imgui.GetWindowSize().y/2),imgui.Cond.FirstUseEver)
            imgui.PushItemWidth(50)
            if imgui.Checkbox(u8'Вкл/Выкл',afkSet['state']) then ini.settings.state = afkSet['state'].v inicfg.save(def,directIni) end 
            imgui.Hint(u8'Состояние контроля афк. Включить или выключить,и бобру понятно')
            if imgui.Checkbox(u8'Выход при превышении ',afkSet['exitstate']) then ini.settings.exit = afkSet['exitstate'].v inicfg.save(def,directIni) end 
            imgui.Hint(u8'Выходить при достижении лимита афк ставьте на 30 секунд меньше')
            if imgui.InputInt(u8'Лимит афк',afkSet['limit'],0,0) then ini.settings.limit = afkSet['limit'].v inicfg.save(def,directIni) end
            imgui.Hint(u8'Лимит афк в секундах')
            if imgui.InputInt(u8'Допуск афк',afkSet['allowance'],0,0) then ini.settings.allowance = afkSet['allowance'].v inicfg.save(def,directIni) end 
            imgui.Hint(u8'Вывод предупреждения за допускное время не меняйте')
            imgui.Text(u8'Авторство: ') 
            imgui.SameLine()
            imgui.Link('https://www.blast.hk/members/354365/','BH')
            imgui.SameLine()
            imgui.Link('https://vk.com/ravexl','VK')
            imgui.PopItemWidth()


        
        imgui.End()
    end

end



function imgui.Hint(text, delay)
    if imgui.IsItemHovered() then
        if go_hint == nil then go_hint = os.clock() + (delay and delay or 0.0) end
        local alpha = (os.clock() - go_hint) * 5 -- скорость появления
        if os.clock() >= go_hint then
            imgui.PushStyleVar(imgui.StyleVar.Alpha, (alpha <= 1.0 and alpha or 1.0))
                imgui.PushStyleColor(imgui.Col.PopupBg, imgui.GetStyle().Colors[imgui.Col.ButtonHovered])
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    imgui.TextUnformatted(text)
                    if not imgui.IsItemVisible() and imgui.GetStyle().Alpha == 1.0 then go_hint = nil end
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()
                imgui.PopStyleColor()
            imgui.PopStyleVar()
        end
    end
  end
  





  function violet_theme()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    style.WindowPadding = imgui.ImVec2(8, 8)
  style.WindowRounding = 6
  style.ChildWindowRounding = 5
  style.FramePadding = imgui.ImVec2(5, 3)
  style.FrameRounding = 3.0
  style.ItemSpacing = imgui.ImVec2(5, 4)
  style.ItemInnerSpacing = imgui.ImVec2(4, 4)
  style.IndentSpacing = 21
  style.ScrollbarSize = 10.0
  style.ScrollbarRounding = 13
  style.GrabMinSize = 8
  style.GrabRounding = 1
  style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
  style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
  
    colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
    colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
    colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
    colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
    colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
    colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
    colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
    colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
    colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
    colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
    colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
    colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
    colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
    colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
    colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
    colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
    colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
    colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
    colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
    colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
    colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
    colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
    colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
    colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
end
violet_theme()

  -- [[плохо криптуешь,бабенко]]


  function imgui.Link(link,name,myfunc)
    myfunc = type(name) == 'boolean' and name or myfunc or false
    name = type(name) == 'string' and name or type(name) == 'boolean' and link or link
    local size = imgui.CalcTextSize(name)
    local p = imgui.GetCursorScreenPos()
    local p2 = imgui.GetCursorPos()
    local resultBtn = imgui.InvisibleButton('##'..link..name, size)
    if resultBtn then
        if not myfunc then
            os.execute('explorer '..link)
        end
    end
    imgui.SetCursorPos(p2)
    if imgui.IsItemHovered() then
        imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], name)
        imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + size.y), imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
    else
        imgui.TextColored(imgui.GetStyle().Colors[imgui.Col.Button], name)
    end
    return resultBtn
end
