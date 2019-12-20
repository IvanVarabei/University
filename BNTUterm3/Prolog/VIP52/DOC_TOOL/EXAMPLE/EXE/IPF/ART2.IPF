:userdoc
:title.Artwork and Artlink
:link reftype=hd res=001.:artwork name='globie.gif'.:elink.

Purpose 

Identifies link definitions for hypergraphic areas of a bit map or a metafile. 

Attributes 

None 

Description 

Use in conjunction with the artwork tag artwork to indicate links to a bit map or 
segments of a bit map, or a metafile.  The link definitions are specified by link tags (and follow 
artlink, as in Example 1. 

(See for more details.) 

All of the above could be in a separate file, which would be identified by the linkfile attribute of the 
artwork tag, as in Example 2. 

Example 2 

In this example, mybitmap.bmp is the name of the file containing the bit map, and mylinks is 
the file consisting of the entries shown in Example 1. 

If the artwork tag does not specify the attribute linkfile IPF looks for artlink on the line 
immediately following artwork as shown in Example 3. 

Example 3 

:artwork name='mybitmap.bmp'.
:artlink.
:link reftype=hd res=001.
:eartlink.

In this example, if the user clicks on the bit map associated with this art link, the window with the 
identifier, 001 is displayed. 

If no art-link tag is found, no hypergraphic areas for the bit map are defined. 

You can divide a bit map into rectangular segments, each of which is selectable and links to different 
information. For each segment, you need to define values for x, y, cx, and cy, which represent pixel 
values on the x and y axes. The x axis is always horizontal, and the y axis is always vertical; x and y 
define the origin of the segment, while cx and cy identify the changes in x and y. The value 0,0 
indicates the origin of the bit map and is always the bottom left corner. 

Following is an example of a segmented bit map. 

Example 4 shows the tagging when the link is from a segmented bit map. The name of the 
segmented bit-map file is show2.bmp the name of the file with the link information is link.dat. 

Example 4 

:artwork name='show2.bmp' linkfile='link.dat'.

The following information could be placed into link.dat. 

:artlink.
:link reftype=hd res=001 x=0 y=0 cx=16 cy=8.
:link reftype=fn refid=afnr x=16 y=8 cx=16 cy=8.
:link reftype=inform res=0345 x=0 y=8 cx=16 cy=8.
:link reftype=launch object='c:\os2\e.exe' data='c:\appsdir\tutor.dat'
        x=16 y=0 cx=16 cy=8.
:eartlink.

:h1 res=001.Link Target
Link Target

:euserdoc.


