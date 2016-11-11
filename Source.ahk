SetTitleMatchMode, 2
isfinding = 0
xp := 0
yp := 0

#If WinActive("Google Chrome")

; Chrome highlights matches that are a link in orange, after a user has pressed ctrl+f and typed something.

Enter::
Px = 0
Py = 0
PixelSearch, Px, Py, 100, 100, 2736, 1824, 0x3296FF, 0, Fast
If ErrorLevel
	Send {Enter}
Else
	Click %Px%,%Py%
Return

#If WinActive("Internet Explorer") or ("Microsoft Edge")

; IE and Edge highlights matches in either blue or yellow. So we will look for both of those colors.
; Text in the address bar, when active, is also highlighted blue. Under this condition, our mouse will automatically click in the address bar when the user hits enter--rather than the address or search being run, as normally occurs when a user hits enter when the address bar is active.
; We have to selectivly turn off this action, then.
; There are two main conditions that will indicate the user does not want the hotkey to be run, in which case our script will be turned off:
; When the user has moved the mouse after they have pressed ctrl+f (meaning they probably clicked a link all by themselves, or clicked the address bar, or somewhere else).
; When the user has pressed alt+d, to select the address bar.

{
^f::
Send ^f
MouseGetPos, xp, yp
Return

!d::
isfinding := 0
Send !d
Return

Enter::
MouseGetPos, xpnew, ypnew
If (xpnew = xp or ypnew = yp) ; if mouse has not moved along x and y axis the user is probably wanting to use enter to click a link
  {
  isfinding := 1
  }
Else ; if mouse has moved along x or y axis then user is probably not wanting enter to click a link at this time (e.g., they've moved the mouse to click the address bar, and are no longer actively using ctrl+f)
  {
  isfinding := 0
  }

Px = 0
Py = 0
PixelSearch, Px, Py, 100, 100, 2736, 1824, 0xFF9933, 0, Fast ; look for blue
If ErrorLevel
	PixelSearch, Px, Py, 100, 100, 2736, 1824, 0x00FFFF, 0, Fast ; look for yellow
    If ErrorLevel 
      {
      Send {Enter} ; if niether color is found (the two colors that are used to show highlighted matches in ctrl+f), then make enter act as normal
      }
  Else if (isfinding = 1)
  {
  Click %Px%,%Py% ; if one of the colors is found
  }
Else if (isfinding = 0) ; and the user appears to be using ctrl+f actively
  {
  Send {Enter}
  }
  Return
}
Return

