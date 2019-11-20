.*--------------------------------------------------------------------
.* This file contains the tagged source for IPF Sample
.*--------------------------------------------------------------------

:userdoc.

.*--------------------------------------------------------------------
.* Provide a title for the title line of the main window
.*--------------------------------------------------------------------

:title.Information Presentation Facility Sample

.*--------------------------------------------------------------------
.* Allow only heading level 1 to appear in the contents window and
.* specify no control area for pushbuttons
.*--------------------------------------------------------------------

:docprof toc=1 ctrlarea=none.

.*--------------------------------------------------------------------
.* Identify the heading level entries to be displayed in the contents
.* window (Personal System/2)
.*--------------------------------------------------------------------

:h1 id=content1 x=left y=top width=100% height=100% scroll=none    clear.Personal System/2

.*--------------------------------------------------------------------
.* Identify and display a bitmap (Office)
.*--------------------------------------------------------------------
.*--------------------------------------------------------------------
.* Specify a segmented hypergraphic area to link split screen support
.*--------------------------------------------------------------------

:artwork name='OFFICE.bmp' align=center.
:artlink.
:link reftype=hd res=01 x=350 y=100 cx=190 cy=120 dependent.
:eartlink.

