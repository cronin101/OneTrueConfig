-- Imports
import XMonad
import XMonad.Layout.Cross
import XMonad.Layout.Grid
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import Data.Monoid
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat



-- Terminal choice
myTerminal  = "terminator"

-- Whether focus follows the mouse pointer. This annoys me so it is off.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Width of the window border in pixels. Subtle 2px win.
myBorderWidth = 2

-- mod4Mask is the Windows Key, set as ModKey
myModMask = mod4Mask

-- Workspaces name array
myWorkspaces    = ["1: Internet","2: Music","3: Communication","4: System","5: SSH","6: Programming","7: Documents","8: Virtual Machine","float"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#1b1e1a" -- Dark grey
myFocusedBorderColor = "#545e63"-- Lighter grey

-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

      -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
      -- suspend laptop
      , ((modm .|. shiftMask, xK_s     ), spawn "sudo pm-suspend")
      -- launch uzbl
      , ((modm,               xK_u     ), spawn "uzbl-tabbed")
      -- launch pavucontrol
      , ((modm,               xK_v     ), spawn "pavucontrol")
      -- screenshot
      , ((modm,               xK_s), spawn "touch screenshot.jpg && rm screenshot.jpg && import -window root screenshot.jpg && notify-send -t 400 \"Screenshot taken\"")
      -- launch dmenu
      , ((modm,               xK_p     ), spawn "exe=`dmenu_run -fn \"xft:DejaVu Sans Mono:size=13\" -nb \"#111111\" -nf white -sb DimGrey -sf black` && eval \"exec $exe\"")
      -- toggle all gaps
      , ((modm,               xK_g), sendMessage $ ToggleGaps)
      -- close focused window
      , ((modm .|. shiftMask, xK_c     ), kill)
       -- Rotate through the available layout algorithms
      , ((modm,               xK_space ), sendMessage NextLayout)
      --  Reset the layouts on the current workspace to default
      , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
      -- Resize viewed windows to the correct size
      , ((modm,               xK_n     ), refresh)
      -- Move focus to the next window
      , ((modm,               xK_j     ), windows W.focusDown)
      -- Move focus to the previous window
      , ((modm,               xK_k     ), windows W.focusUp)
      -- Move focus to the master window
      , ((modm,               xK_m     ), windows W.focusMaster)
      -- Swap the focused window and the master window
      , ((modm,               xK_Return), windows W.swapMaster)
      -- Swap the focused window with the next window
      , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)
      -- Swap the focused window with the previous window
      , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)
      -- Shrink the master area
      , ((modm,               xK_h     ), sendMessage Shrink)
      -- Expand the master area
      , ((modm,               xK_l     ), sendMessage Expand)
      -- Push window back into tiling
      , ((modm,               xK_t     ), (withFocused $ windows . W.sink))
      -- Increment the number of windows in the master area
      , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
      -- Deincrement the number of windows in the master area
      , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
      -- Toggle the status bar gap
      -- Use this binding with avoidstruts from Hooks.ManageDocks.
      -- See also the statusBar function from Hooks.DynamicLog.
      , ((modm              , xK_b     ), sendMessage ToggleStruts)
      -- Quit xmonad
      , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
      -- Restart xmonad
      , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")]
    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace
    [((m .|. modm, k), (windows $ f i))
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- Whenever a new dock appears, refresh the layout immediately to avoid the
-- new dock.
mydocksEventHook :: Event -> X All
mydocksEventHook (MapNotifyEvent {ev_window = w}) = do
     whenX ((not `fmap` (isClient w)) <&&> runQuery checkDock w) refresh
     return (All True)
mydocksEventHook _ = return (All True)

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

-- Layouts:
myLayout = avoidStruts $ onWorkspace "float" simplestFloat $ tiled ||| simpleCross ||| Mirror tiled ||| Grid ||| noBorders Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = gaps [(L,2),(D,2),(R,2),(U,2)] $ spacing 2 $ Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- Window rules:
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Spotify"       --> doShift "2: Music"
    , resource  =? "desktop_window" --> doIgnore
    , resource =? "xfce4-notifyd" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ] <+> manageDocks

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.

-- Background is set
myStartupHook     = startup
startup :: X ()
startup = do
          spawn "tint2"
          spawn "dropboxd"
          spawn "xsetroot -cursor_name left_ptr"
          spawn "nm-applet"
          spawn "xflux -l 55 -g -3"
          spawn "xbacklight -set 30"
          spawn "export EDITOR=vim"
          spawn "setxkbmap -layout gb"
          spawn "feh --bg-scale /home/cronin/wall.jpg"
          spawn "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
          setWMName "LG3D"

--
-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what's being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#c4a000" "" . wrap "[" "]"
                , ppUrgent = xmobarColor "#e6db74" ""
                , ppTitle = xmobarColor "#06989a" "" }

-- Keybinding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = mydocksEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
