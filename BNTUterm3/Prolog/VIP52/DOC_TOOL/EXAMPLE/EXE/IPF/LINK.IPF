:userdoc.
:title.Links

:p.Purpose 

:p.Activates a link to additional information. 

:p.Attributes 

:p.reftype= 
:p.Defines the type of link.  Possible values are hd, fn, launch, and inform. 

:p.    reftype=hd 
:p.       Links to a heading.  The heading definition (or an overriding definition in the link) causes its 
       information to be displayed in the current window, or a secondary window. The integer value of 
       refid= identifies the ID of the heading. If the heading is in an external IPF database, its file 
       name is specified with the database= attribute. 

:p.    In the following example, selection of the hypertext link causes the external database, 
       EDITOR.HLP, to be loaded, and the heading with the ID of 001 to be displayed. 

:p.       :link reftype=hd refid=001
             database='editor.hlp'.
       Editing Functions
       :elink.
       
:p.       The heading definition in the external database must contain the global attribute.  If the link to 
       the file cannot be resolved, the hypertext phrase in the link will not be highlighted. 

:p.       Restriction:  You cannot AUTOLINK to an extended database.  The auto attribute cannot be 
       used with the database= attribute. 

:p.    reftype=fn 
:p.       Links to a footnote. Its contents are displayed in a pop-up window in the current window.  The 
       refid= attribute specifies the ID of the footnote. 

:p.       Restriction:  A split window cannot contain a link to a footnote. 

:p.    reftype=launch 
:p.       Starts a Presentation Manager program.  The file name of the program is specified with the 
       object= attribute.  Any parameters to the program are specified with data=.  In the following 
       example, the hypertext link starts the System Editor and opens the file, MYFILE, for editing. 

:p.       :link reftype=launch
             object='c:\os2\e.exe'
             data='myfile'.
       Start Editor
       :elink.
       

:p.    reftype=inform 
:p.       Causes a message to be sent to the application.  The res= attribute is required and is an 
       integer value that directs the application to perform some application-specific function. When 
       using this attribute, DO NOT use elink For example: 

:p.       :link reftype=inform res=1000 auto.
       
:sl compact. 
:li. auto
:li. viewport 
:li. dependent 
:li. split 
:li. child 
:esl.
:p. group=
 
:p.    The child attribute specifies to open the new panel as a child. 

:p.    With the auto attribute, you can define any of the link types described above, with the exception 
    of a footnote link, as an automatic link. 

:p.    The automatic-link definition follows a heading definition and is activated as soon as a reference to 
    the heading definition is made.  The reference can be made by the user selecting an IPF window 
    entry (for example, the Contents window), or by a hypertext or hypergraphic link. 

:p.    Following are the automatic-link actions that can be specified, and the attributes used: 
:ul.
    :li. Open a secondary window when the heading that contains the link is referred to: 

    :lp.  auto reftype=hd viewport dependent res=
      
    :lp.  Note the inclusion of the dependent attribute. Usually, the information in an automatic window 
      is dependent on the information in its secondary window.  Specifying dependent causes an 
      automatic window to close when the user closes the window of the secondary that contains the 
      automatic link. 

    :li. Open secondary windows when the heading of the primary window that contains the links 
      is referred to: 

    :lp.  auto reftype=hd split res=
      
    :lp.  Restriction: The primary heading cannot contain text or graphics; only links to its secondary 
      headings.  For more information, see Split Windows. 

    :li. Start a Presentation Manager program when the heading that contains the link is 
      referred to: 

    :lp.  auto reftype=launch object= data=
      

    :li. Send the application a message when the heading that contains the link is referred to: 

    :lp.  auto reftype=inform res=
      
:eul.
:p.    To display more than one window on the screen, you must assign a unique group number to each 
    window with the group= attribute. This attribute can be specified with :link. or the heading tag.  
    For more information about group numbers, see Window Group Numbers. 
:xmp. 
 vpx=
 vpy=
 vpcx=
 vpcy=
 
    Define the size and position of the window.  Any values specified by these attributes override size 
    and position values specified by the attributes in a heading tag. See Window Origin and Size. for 
    details about these attributes. 
 
 titlebar=yes | sysmenu | minmax | both | none 
 scroll=horizontal | vertical | both | none 
 rules=border | sizeborder | none 
 
    Define window controls.  Any values specified by these attributes override window-control values 
    specified by the attributes in a heading tag. See (Headings) for details about 
    these attributes.) 
 
 When titlebar=yes is specified the window displays a titlebar WITHOUT the system menu symbol, 
 the hide button, and the maximize button. 
:h2 id="1".Editing Features
This is a link target
:exmp.
:euserdoc.