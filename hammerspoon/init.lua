-- Recarrega a configuração do Hammerspoon
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Configuração do Hammerspoon carregada")

-- Define o atalho base para os comandos (Command + Option + Control)
local mash = {"cmd", "alt", "ctrl"}

-- --- Gerenciamento de Janelas ---

-- Centralizar a janela na tela
hs.hotkey.bind(mash, "C", function()
  local win = hs.window.focusedWindow()
  if win then win:centerOnScreen() end
end)

-- Mover a janela para a metade esquerda da tela
hs.hotkey.bind(mash, "Left", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x; f.y = max.y; f.w = max.w / 2; f.h = max.h
    win:setFrame(f)
end)

-- Mover a janela para a metade direita da tela
hs.hotkey.bind(mash, "Right", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w / 2); f.y = max.y; f.w = max.w / 2; f.h = max.h
    win:setFrame(f)
end)

-- Maximizar a janela
hs.hotkey.bind(mash, "F", function()
  local win = hs.window.focusedWindow()
  if win then win:setFullscreen(true) end
end)

-- --- Lançador Rápido de Aplicativos ---

-- Lançar ou focar o terminal (Ghostty)
hs.hotkey.bind(mash, "T", function() hs.application.launchOrFocus("ghostty") end)

-- Lançar ou focar o navegador (Cursor)
hs.hotkey.bind(mash, "B", function() hs.application.launchOrFocus("Cursor") end)


-- --- Expansão de Texto (Snippets) ---

-- Digitar um email
hs.hotkey.bind(mash, "E", function()
    hs.eventtap.keyStroke({}, "seu.email.super.longo@provedor.com")
end)

-- Digitar um comando do git
hs.hotkey.bind(mash, "G", function()
    hs.eventtap.keyStroke({}, "git commit -m ''")
    hs.eventtap.keyStroke({"cmd"}, "left")
    hs.eventtap.keyStroke({}, "right")
end)

-- --- Controle do Sistema ---

-- Ligar/Desligar Wi-Fi
hs.hotkey.bind(mash, "W", function()
  if hs.wifi.power() then
    hs.wifi.setPower(false)
    hs.alert.show("Wi-Fi Desligado")
  else
    hs.wifi.setPower(true)
    hs.alert.show("Wi-Fi Ligado")
  end
end) 