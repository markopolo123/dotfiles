local hyper = {"ctrl", "alt", "cmd", "shift"}
-- local hyper = {"f18"}

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

hs.hotkey.bind(hyper, "1", moveWindowToDisplay(2))
hs.hotkey.bind(hyper, "2", moveWindowToDisplay(1))

--- quick open applications
hs.hotkey.bind(hyper, "S", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
hs.hotkey.bind(hyper, "A", open("Ghostty"))
hs.hotkey.bind(hyper, "V", open("Visual Studio Code"))
hs.hotkey.bind(hyper, "O", open("Obsidian"))
hs.hotkey.bind(hyper, "B", open("vivaldi"))

hs.hotkey.bind(hyper, "H", function()
  local script = [[
  tell application "System Preferences"
    activate
    set the current pane to pane id "com.apple.preference.displays"
    delay 2
    tell application "System Events"
      tell window "Displays" of application process "System Preferences"
        click button "Display Settings…"
        delay 2
        select row 2 of outline 1 of scroll area 1 of sheet 1
        click pop up button "Refresh Rate:" of sheet 1
        delay 0.25
        click menu item "120 Hertz" of menu 1 of pop up button "Refresh Rate:" of sheet 1
        click button "Done" of sheet 1
      end tell
    end tell
  end tell
  -- Quit System Preferences
  tell application "System Preferences" to quit
  ]]
  local _, res = hs.osascript.applescript(script)
  if res then
      hs.alert.show("Successfully changed refresh rate")
  else
      hs.alert.show("Failed to change refresh rate")
  end
end)


local usbWatcher = nil

-- This is our usbWatcher function
-- lock when yubikey is removed
function usbDeviceCallback(data)
    -- this line will let you know the name of each usb device you connect, useful for the string match below
    hs.notify.show("USB", "You just connected", data["productName"])
    -- Replace "Yubikey" with the name of the usb device you want to use.
    if string.match(data["productName"], "Yubikey") then
        if (data["eventType"] == "added") then
            hs.notify.show("Yubikey", "You just connected", data["productName"])
            -- wake the screen up, so knock will activate
            -- get knock here http://www.knocktounlock.com
            os.execute("caffeinate -u -t 5")
        elseif (data["eventType"] == "removed") then
            -- replace +000000000000 with a phone number registered to iMessage
            hs.messages.iMessage("+000000000000", "Your Yubikey was just removed from your Work iMac.")
            -- this locks to screensaver
            os.execute("pmset displaysleepnow")
       end
   end
end

-- Start the usb watcher
usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()