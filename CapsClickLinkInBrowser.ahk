SetTitleMatchMode, 2

$^f::
WinGetPos, x1, y1, w, h, A
Send ^f
Return

$Capslock::
IfWinActive, Google Chrome
{
Px = 0
Py = 0
PixelSearch, Px, Py, x1, y1, w, h, 0x3296FF, 0, Fast
If ErrorLevel
  {
    Send {Capslock}
  }
Else
  {
  Px += 1
  Py += 1
  Click %Px%,%Py%
  }
}
Else
  SetCapsLockState, % GetKeyState("Capslock","t") ? "Off" : "On" ; toggle capslock -- by None
Return
 
Return