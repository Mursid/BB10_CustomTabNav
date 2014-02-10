BB10_CustomTabNav
=================

It is difficult or near impossible to stylize BB10 Cascades' native Tab Navigation layout.
This provided coding structure achieves the native Tab Navigation look and feel without 
needing to actually use the TabbedPane Component. All that is used are essentially plain 
old containers with customized touch event handler to replicate the TabbedPane layout and 
functionality.


Originally designed/conceived by Brian Scheirer of the CrackBerry team, inspired by the Sochi 2014 app. 
I have now optimized this to be almost one to one identical to BB10 Cascades's own implementation of the tab navigation.

Subtle Important Features:
-Swipe to the right will bring up the Tab Nav List.
-Swipe to left will bring back the main content container.
-Content container will be faded as user swipe to see the tab nav list.
-Proper rebound threshold for popping back the container in the right position, relative to the left edge of device screen.
-Tab Page Icon will fade out on viewing the tab nav list, fade in when viewing the content container.(animation occurs)
-Tab list Icon 'scroll' to the center when viewing the tab nav list, else scroll position to the left(animation occurs)


**missing features that are present in original Cascades' Tab Navigation that is left out for now:
-Partial Tab List view where only the icons on the tab list are visible.(fairly easy fix, will do in next commit)


~mdrestyanto