import bb.cascades 1.0
NavigationPane {
    id: navPane
    backButtonsVisible: false
    property double initialWindowX
    property double startPosition
    
    Page {
        
        Container {
            id: parentWrapper
            property bool dragHappening: false
            layout: DockLayout {
            
            }
            
            
            /**
             * 	The following component "TheTabs" and the following container essentially builds offscreen and onscreen
             * 	containers respectively. These to components are painted stacked one on top of another..
             * 	The onscreen container uses the verticalAlignment.Fill to effectively fill the whole screen, and push the 
             * 	tab screen to the bottom of the stack.
             * 
             * 	-mdrecoder
             */
            TheTabs {
            
            }
            Container {
                id: contentCont
                background: Color.LightGray
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                layout: DockLayout {
                
                }
                Container {
                    //content
                    ControlDelegate {
                        id: tabDelegate
                        source: "TabOneContent.qml"
                        onError: {
                        
                        }
                    }
                
                }
                Container {
                    background: actionbarpaint.imagePaint
                    
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Bottom
                    attachedObjects: [
                        ImagePaintDefinition {
                            id: actionbarpaint
                            imageSource: "asset:///images/action_bar.png"
                        }
                    ]
                    layout: DockLayout {
                    
                    }
                    Container {
                        //   background: Color.Magenta
                        minHeight: 125
                        minWidth: 150
                        gestureHandlers: TapHandler {
                            onTapped: {
                                if (contentCont.translationX == 0) {
                                    contentCont.translationX = 570;
                                    parentWrapper.onSwitchToTab();
                                } else {
                                    contentCont.translationX = 0;
                                    parentWrapper.onSwitchToContent();
                                }
                                //fadeContainer.opacity = (contentCont.translationX/1000)*0.5;
                            }
                        }
                        layout: DockLayout {
                        
                        }
                        Container{
                            id: tabListIconHolder
                            leftPadding: -95.0;
                            ImageView {
                                id: ab_bg_img
                                imageSource: "asset:///images/action_bg2.png"
                            
                            }
                        }
                        ImageView {
                            id: ab_selected_img
                            imageSource: "asset:///images/1tab.png"
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Center
                        }
                    
                    }
                }
                
                /**
                 * 	This gives a fades overlay on the content container.
                 * 	***But it seems that it is bugging the touch event.***
                 */
                Container {
                    id: fadeContainer
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                    background: Color.Black
                    opacity: 0
                    overlapTouchPolicy: OverlapTouchPolicy.Allow
                    touchPropagationMode: TouchPropagationMode.PassThrough
                }
                onTouch: {
                    if(event.isUp()){
                        // this will add the behaviour where the view is switched to the content container, 
                        // when user single tap on the contentCont while viewing the tab container.
                        if(contentCont.translationX == 570){
                            contentCont.translationX = 0;
                            parentWrapper.onSwitchToContent();
                        }
                    }
                }
            }
            //bring touch event here
            onTouch: {
                // Determine the location inside the image that was touched,
                // relative to the container, and move it accordingly
                
                if (event.isDown()) {
                    // Start a dragging gesture       
                    /**
                     * 	this will keep track of the touch point position on the screen, 
                     * 	for the x-axis
                     */
                    initialWindowX = event.windowX;           
                    /**
                     * 	We need to track the content container's (x=0,y=0) distance from the phones actual left edge.	
                     * 	For more info see translationX inherited member variable.
                     */
                    startPosition = contentCont.translationX;
                    if(startPosition == 0 || startPosition == 570){
                        dragHappening = true;
                    }
                } else if(event.isMove()){
                    //behaviour when user swipes to the right
                    if(dragHappening && event.windowX >= initialWindowX){
                        if(contentCont.translationX <= 570){
                            contentCont.translationX = startPosition +(event.windowX - initialWindowX);
                            if(contentCont.translationX > 570){
                                contentCont.translationX = 570;
                            }
                            fadeContainer.opacity = (contentCont.translationX/1000)*.7;
                        }
                    }
                    //behaviour if user swipes to the left
                    else if(dragHappening && event.windowX <= initialWindowX){
                        if (contentCont.translationX >= 0) {
                            contentCont.translationX = startPosition - (initialWindowX - event.windowX);
                            if(contentCont.translationX < 0){
                                contentCont.translationX = 0;
                            }
                            fadeContainer.opacity = (contentCont.translationX/1000)*.7;
                        }
                    }
                } else if (event.isUp() || event.isCancel()) {
                    /**
                     *  We want the rebound point different depending on which container the user is viewing.
                     */
                    if(dragHappening){
                        if (startPosition == 0) {
                            if (contentCont.translationX > 100) {
                                contentCont.translationX = 570;
                                parentWrapper.onSwitchToTab();
                            } else {
                                contentCont.translationX = 0;
                            }
                        }
                        if (startPosition == 570) {
                            if (contentCont.translationX < 450) {
                                contentCont.translationX = 0;
                                parentWrapper.onSwitchToContent();
                            } else {
                                contentCont.translationX = 570;
                            }
                        }
                        dragHappening = false;
                    }
                }

            } // END onTouch()
            
            function onSwitchToTab(){
                ab_selected_img.opacity = 0.0;
                tabListIconHolder.leftPadding = 0.0;
                fadeContainer.opacity = .5;
            }
            
            function onSwitchToContent(){
                ab_selected_img.opacity = 1.0;
                tabListIconHolder.leftPadding = -95.0;
                fadeContainer.opacity = 0.0;
            }
        }// END parentWrapper
    }
}

