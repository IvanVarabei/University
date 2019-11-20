:userdoc.
Artwork and Artlink
:link refid=1 REFTYPE=hd.:artwork name='globie.gif'.
:elink.Purpose  Identifies link definitions for hypergraphic areas of a bit map or a metafile.  Attributes  None  Description  Use in conjunction with the artwork tag artwork to indicate links to a bit map 
or  segments of a bit map, or a metafile.  The link definitions are specified by link tags (and follow  artlink, as in Example 1.  (See for more details.)  All of the above could be in a separate 
file, which would be identified by the linkfile attribute of the  artwork tag, as in Example 2.  Example 2  In this example, mybitmap.bmp is the name of the file containing the bit map, and mylinks 
is  the file consisting of the entries shown in Example 1.  If the artwork tag does not specify the attribute linkfile IPF looks for artlink on the line  immediately following artwork as shown in 
Example 3.  Example 3 
:artwork name='mybitmap.bmp'.
:artlink.
:link REFTYPE=hd HREF='#1'.
:eartlink.In this example, if the user clicks on the bit map associated with this art link, the window with the  identifier, 001 is displayed.  If no art-link tag is found, no hypergraphic areas for the bit 
map are defined.  You can divide a bit map into rectangular segments, each of which is selectable and links to different  information. For each segment, you need to define values for x, y, cx, and 
cy, which represent pixel  values on the x and y axes. The x axis is always horizontal, and the y axis is always vertical; x and y  define the origin of the segment, while cx and cy identify the 
changes in x and y. The value 0,0  indicates the origin of the bit map and is always the bottom left corner.  Following is an example of a segmented bit map.  Example 4 shows the tagging when the 
link is from a segmented bit map. The name of the  segmented bit-map file is show2.bmp the name of the file with the link information is link.dat.  Example 4 
:artwork name='show2.bmp' LINKFILE='link.dat'.The following information could be placed into link.dat. 
:artlink.
:link REFTYPE=hd HREF='#1' X=0 Y=0 CX=16 CY=8.
:link REFTYPE=fn HREF='#afnr' X=16 Y=8 CX=16 CY=8.
:link REFTYPE=inform HREF='#345' X=0 Y=8 CX=16 CY=8.
:link REFTYPE=launch OBJECT='c:\os2\e.exe' DATA='c:\appsdir\tutor.dat' X=16 Y=0 CX=16 CY=8.
:eartlink.
:h1 RES=1 NAME=1.Link Target

Link Target
:euserdoc.