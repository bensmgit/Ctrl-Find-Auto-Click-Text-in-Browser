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