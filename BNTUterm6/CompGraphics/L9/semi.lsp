(command "_ucs" "_w")
(command "_-view" "_swiso")
(setq snapMode (getvar "osmode")) ;Get current Object Snap Mode

; base
(command "_rectang" "0,0" "@110,80")
(command "_extrude" "_last" "" "50")
(setq baseBody (entlast))

; help line for little parallelepiped
(setvar "osmode" 0) ;Turn off Object snap
(command "_line" "35,0,50" "35,80,50" "")
(setq littleParallelepipedHelpLine (entlast))

; litlle parallelepiped
(command "_rectang" "150,0,0" "@40,30")
(command "_extrude" "_last" "" "-15")
(setq littleParallelepiped (entlast))
(setvar "osmode" 1) ;Turn on Object snap
(command  "_move" pause "" (getpoint "\nBase point:") (getpoint "Second point:"))
(entdel littleParallelepipedHelpLine) ; delete help line

; help line for big parallelepiped
(setvar "osmode" 0)
(command "_line" "15,0,0" "15,80,0" "")
(setq bigParallelepipedHelpLine (entlast))

; big parallelepiped
(command "_rectang" "0,150,0" "@80,50")
(command "_extrude" "_last" "" "90")
(setq bigParallelepiped (entlast))
(setvar "osmode" 1)
(command  "_move" pause "" (getpoint "\nBase point:") (getpoint "Second point:"))
(entdel bigParallelepipedHelpLine) ; delete help line

; help line for cilinder home
(setvar "osmode" 0)
(command "_line" "55,30,90" "55,80,90" "")
(setq cilinderHelpLine (entlast)) 

; cilinder
(command "_ucs" "_3" "155,30,90" "156,30,90" "155,30,91")
(command "_circle"  "0,0,0" "25")
(command "_extrude" "_last" "" "-50")
(setq cilinder (entlast))

; help line circle radius
(command "_line" "0,0,0" "25,0,0" "")
(setq cirlceHelpLine (entlast))

(setvar "osmode" 1)
(command  "_move" pause "" (getpoint "\nBase point:") (getpoint "Second point:"))
(entdel cilinderHelpLine) ; delete help line
(entdel cirlceHelpLine) ; delete help line

(command "_subtract" baseBody "" littleParallelepiped "")
(command "_subtract" bigParallelepiped "" cilinder "")
(command "_union" baseBody bigParallelepiped "")

(command "_ucs" "_w")
(command "_-view" "_swiso")