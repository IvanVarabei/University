(command "_rectang" "0,0" "@110,80")
(command "_extrude" "_last" "" "50")
(setq Body1 (entlast))

(command "_rectang" "35,0,35" "@40,30")
(command "_extrude" "_last" "" "15")
(setq Body2 (entlast))

(command "_rectang" "15,30" "@80,50")
(command "_extrude" "_last" "" "90")
(setq Body3 (entlast))

(command "_ucs" "_3" "55,30,90" "100,30,45" "0,30,100")
(command "_circle"  "0,0,0" "25")
(command "_extrude" "_last" "" "50")
(setq Body4 (entlast))

(command "_subtract" Body1 "" Body2 "")
(command "_subtract" Body3 "" Body4 "")
(command "_union" Body1 Body3 Body4 "")

(command "_ucs" "_w")
(command "_-view" "_swiso")