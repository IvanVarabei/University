#
# Borland C++ IDE generated makefile
#
.AUTODEPEND


#
# Borland C++ tools
#
IMPLIB  = Implib
BCC     = Bcc +BccW16.cfg 
TLINK   = TLink
TLIB    = TLib
BRC     = Brc
TASM    = Tasm
#
# IDE macros
#


#
# Options
#
IDE_LFLAGS =  -LC:\BC45\LIB
IDE_RFLAGS = 
LLATW16_odbclibdlib =  -Twe -P -LC:\BC45\LIB
RLATW16_odbclibdlib =  -31
BLATW16_odbclibdlib = 
CNIEAT_odbclibdlib = -IC:\BC45\INCLUDE -D_RTLDLL
LNIEAT_odbclibdlib = -x
LEAT_odbclibdlib = $(LLATW16_odbclibdlib)
REAT_odbclibdlib = $(RLATW16_odbclibdlib)
BEAT_odbclibdlib = $(BLATW16_odbclibdlib)

#
# Dependency List
#
Dep_odbclib = \
   odbclib.lib

odbclib : BccW16.cfg $(Dep_odbclib)
  echo MakeNode 

Dep_odbclibdlib = \
   odbclib.obj

odbclib.lib : $(Dep_odbclibdlib)
  $(TLIB) $< $(IDE_BFLAGS) $(BEAT_odbclibdlib) @&&|
 -+odbclib.obj
|

odbclib.obj :  ..\..\source\odbclib.c
  $(BCC)   -P- -c @&&|
 $(CEAT_odbclibdlib) $(CNIEAT_odbclibdlib) -o$@ ..\..\source\odbclib.c
|

# Compiler configuration file
BccW16.cfg : 
   Copy &&|
-R
-v
-vi
-H
-H=odbclib.csm
-ml
-WE
-Ot
-w-pia
-b
-r-
-f
-ff
-X-
-u
-v-
-R-
-H
-Ff-
-dc-
-Od
-C
-wrpt
-w-pro
-j250
-2
-Vb
| $@


