
'======================================================================='

' Title: 2-Digit 7Segment LED Number Counter
' Last Updated :  01.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : ATmega8 + 2-Digit 7Segment

'======================================================================='

$crystal = 1000000
$regfile = "M8def.dat"

Config Portb = Output
Config Pind.0 = Output
Config Pind.1 = Output

Config Debounce = 20
Config Portc.0 = Input : Portc.0 = 1 : Key_counter Alias Pinc.0
Config Portc.5 = Input : Portc.5 = 1 : Key_reset Alias Pinc.5

S1 Alias Portd.1
S2 Alias Portd.0

Portb = 255
Set S1 : Set S2

Dim A As Byte : A = 0
Dim T As Byte : T = 0
Dim I As Byte : I = 0
Dim K As Byte
Dim K_eeprom As Eram Byte

Declare Sub Show(byval A As Byte)

K = K_eeprom

'-----------------------------------------------------------

Do
   Call Show(k)
   Debounce Key_counter , 0 , T1 , Sub.
   Debounce Key_reset , 0 , T2 , Sub
Loop

End

'-----------------------------------------------------------

T1:
   Incr K : If K > 99 Then K = 0
   K_eeprom = K
Return

''''''''''''''''''''''''''''''

T2:
   K = 0
   K_eeprom = K
Return

''''''''''''''''''''''''''''''

Sub Show(a As Byte)
Do
   Incr I
   T = A Mod 10
   Portb = Lookup(t , Annode_display)
   Select Case I
      Case 1:
         Reset S1 : Set S2                                  'Display1 is ON   :  Display2 is OFF
         Waitms 1
      Case 2:
         Set S1 : Reset S2                                  'Display1 is OFF   :  Display2 is ON
         Waitms 1
   End Select
   Set S1 : Set S2                                          'Display1 is OFF : Display2 is OFF
   A = A \ 10
   If A = 0 Then
      I = 0
      Exit Sub
   End If
Loop
End Sub

''''''''''''''''''''''''''''''

Annode_display:
Data 192 , 249 , 164 , 176 , 153 , 146 , 130 , 248 , 128 , 144 , 191 , 127 , 199
'      0      1    2     3     4     5     6     7     8     9     -    dp    L

'-----------------------------------------------------------