Class {
	#name : #LeSnippetSidebarStencil,
	#superclass : #BrStencil,
	#instVars : [
		'snippetElement'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #'api - instantiation' }
LeSnippetSidebarStencil >> create [
	<return: #Object>

	^ self createSidebarContainerFor: snippetElement
]

{ #category : #'api - instantiation' }
LeSnippetSidebarStencil >> createSidebarContainerFor: aSnippetElement [
	^ BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical matchParent.
			c ignoreByLayout.
			c ignored horizontal alignCenterAt: 1.
			c ignored vertical alignCenter ];
		clipChildren: false;
		preventMouseEvents;
		addChild:
			(GtInspectorRoundButtonStencil small asElement
				icon:
					(BrPlusIconStencil close
						thickness: 1;
						radius: 4;
						asElement);
				action: [ aSnippetElement snippetViewModel removeSelf ];
				elevation: (BlRelativeElevation elevation: 20);
				constraintsDo: [ :c | c frame vertical alignCenterAt: 0 ]);
		addChild:
			(GtInspectorRoundButtonStencil small asElement
				constraintsDo: [ :c | c frame vertical alignCenterAt: 1 ];
				addAptitude:
					(BrGlamorousWithExplicitDropdownAptitude new
						withGainFocusOnShow;
						handle: [ GtInspectorRoundButtonStencil small asElement
								aptitude: BrIconAptitude;
								icon:
									[ BrGlamorousVectorIcons hamburger asElement asScalableElement
										size: 12 @ 12 ] asStencil ]
						submenu: [ self createSidebarMenuItemsFor: aSnippetElement ]);
				icon:
					[ (BrGlamorousVectorIcons hamburger asElement
						background: Color darkGray) asScalableElement size: 12 @ 12 ]
						asStencil)
]

{ #category : #'api - instantiation' }
LeSnippetSidebarStencil >> createSidebarMenuFor: aSnippetElement [
	"This method can be removed. It is here just in case someone pulls changes
	in an existing GToolkit image."

	| theActionElements |

	theActionElements := Array streamContents: [ :aStream |
		aSnippetElement snippetViewModel gtActions
			select: [ :eachAction | eachAction target = LeSnippetContextMenuActionTarget uniqueInstance ]
			thenDo: [ :eachSnippetContentAction |
				eachSnippetContentAction 
					asElement: [ :anActionElement |
						aStream nextPut: anActionElement beSmallSize ]
					withHostElement: aSnippetElement ] ].

	^ BlElement new
		layout:
			(BlGridLayout horizontal
				columnCount: 2;
				cellSpacing: 5);
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: theActionElements
]

{ #category : #'api - instantiation' }
LeSnippetSidebarStencil >> createSidebarMenuItemsFor: aSnippetElement [
	| aMenuItems someMenuItems |
	aMenuItems := BrMenuItems new.

	someMenuItems := Array
			streamContents: [ :aStream | 
				aSnippetElement snippetViewModel gtActions
					select: [ :eachAction | eachAction target = LeSnippetContextMenuActionTarget uniqueInstance ]
					thenDo: [ :eachSnippetContentAction | 
						eachSnippetContentAction
							asMenuItem: [ :aMenuItem | aStream nextPut: aMenuItem ]
							withHostElement: aSnippetElement ] ].

	aMenuItems addItems: someMenuItems.
	
	^ aMenuItems
]

{ #category : #accessing }
LeSnippetSidebarStencil >> snippetElement: anObject [
	snippetElement := anObject
]
