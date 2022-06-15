local hyper = {"ctrl", "alt", "cmd", "shift"}
hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.1
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})


function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title="Hammerspoon", informativeText="Config Reloaded"}):send()


caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("AWAKE")
    else
        caffeine:setTitle("SLEEPY")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end



-- -- WORK-RELATED AUTOMATION --

-- local workWifi = "AZ-Corporate"

-- hs.wifi.watcher.new(function ()
--   local currentWifi = wifi.currentNetwork()
--   -- short-circuit if disconnectingw
--   if not currentWifi then return end

--   local note = hs.notify.new({
--     title="Welcome to the office",
--     informativeText="Now connected to " .. currentWifi
--   }):send()

  --Dismiss notification in 3 seconds
  --Notification does not auto-withdraw if Hammerspoon is set to use "Alerts"
  --in System Preferences > Notifications
  -- hs.timer.doAfter(3, function ()
  --   note:withdraw()
  --   note = nil
  -- end)

--   if currentWifi == workWifi then
--     -- Allowance for internet connectivity delays.
--     hs.timer.doAfter(3, function ()
--       hs.execute('kess', true)
--     end)
--   end
-- end):start()

-- -- END WORK-RELATED AUTOMATION --



-- --- A closure function
function open(name)
  return function()
    hs.application.launchOrFocus(name)
    if name == 'Finder' then
      hs.appfinder.appFromName(name):activateshift()
    end
  end
end

function moveWindowToDisplay(d)
  return function()
    local displays = hs.screen.allScreens()
    local win = hs.window.focusedWindow()
    win:moveToScreen(displays[d], false, true)
  end
end

hs.hotkey.bind(hyper, "1", moveWindowToDisplay(1))
hs.hotkey.bind(hyper, "2", moveWindowToDisplay(2))

--- quick open applications
hs.hotkey.bind(hyper, "S", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
hs.hotkey.bind(hyper, "A", open("Alacritty"))
hs.hotkey.bind(hyper, "V", open("Visual Studio Code"))
hs.hotkey.bind(hyper, "O", open("Obsidian"))
hs.hotkey.bind(hyper, "B", open("vivaldi"))

