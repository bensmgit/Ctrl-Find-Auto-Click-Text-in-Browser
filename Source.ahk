SetTitleMatchMode, 2
#If WinActive("Google Chrome")
Enter::
Px = 0
Py = 0
PixelSearch, Px, Py, 100, 100, 2736, 1824, 0x3296FF, 0, Fast
If ErrorLevel
	Send {Enter}
Else
	Click %Px%,%Py%
Return

#If WinActive("Microsoft Edge")
!d::
isfinding := 0
Send !d
Return

Enter::
isfinding := 1
If isfinding = 1
Px = 0
Py = 0
PixelSearch, Px, Py, 100, 100, 2736, 1824, 0xFF9933, 0, Fast ; look for blue
If ErrorLevel
	PixelSearch, Px, Py, 100, 100, 2736, 1824, 0x00FFFF, 0, Fast ; look for yellow
		If ErrorLevel
    	Send {Enter}
Else
	Click %Px%,%Py%
Return

