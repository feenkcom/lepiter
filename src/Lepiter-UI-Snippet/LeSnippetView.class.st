Class {
	#name : #LeSnippetView,
	#superclass : #BrStencil,
	#instVars : [
		'snippetElementClass',
		'needsEmbellishments',
		'needsContentDecorationBar'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #comparing }
LeSnippetView >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ snippetElementClass = anObject snippetElementClass
]

{ #category : #'api - instantiation' }
LeSnippetView >> create [
	<return: #Object>
	| aSnippetElement aSnippetLook |

	aSnippetElement := self snippetElementClass new.

	self needsEmbellishments
		ifFalse: [
			aSnippetElement snippetContent
				ifNotNil: [ :aSnippetContent |
					aSnippetElement addAptitude: (LeSnippetWithoutEmbellishmentsAptitude new
						snippetContent: aSnippetContent) ].
			^ aSnippetElement ].

	aSnippetLook := self snippetElementLookClass new.
	aSnippetLook margin: (BlInsets top: 3 left: 0 bottom: 3 right: 0).
	aSnippetLook snippetContent: aSnippetElement snippetContent.

	aSnippetElement clipChildren: false.
	aSnippetLook snippetToolbar: aSnippetElement snippetToolbar.
	aSnippetLook sidebarContainer: (self createSidebarContainerFor: aSnippetElement).

	aSnippetElement addAptitude: aSnippetLook.

	^ aSnippetElement
]

{ #category : #'api - instantiation' }
LeSnippetView >> createSidebarContainerFor: aSnippetElement [
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
					(GtInspectorPlusIconStencil close
						thickness: 1;
						radius: 4;
						asElement);
				action: [ aSnippetElement snippetViewModel snippetModel removeSelf ];
				elevation: (BlRelativeElevation elevation: 20);
				constraintsDo: [ :c | c frame vertical alignCenterAt: 0 ]);
		addChild:
			(GtInspectorRoundButtonStencil small asElement
				constraintsDo: [ :c | c frame vertical alignCenterAt: 1 ];
				addAptitude:
					(BrGlamorousWithDropdownAptitude
						handle: [ GtInspectorRoundButtonStencil small asElement
								aptitude: BrIconAptitude;
								icon:
									[ BrGlamorousVectorIcons hamburger asElement asScalableElement
										size: 12 @ 12 ] asStencil ]
						content: [ self createSidebarMenuFor: aSnippetElement ]);
				icon:
					[ (BrGlamorousVectorIcons hamburger asElement
						background: Color darkGray) asScalableElement size: 12 @ 12 ]
						asStencil)
]

{ #category : #'api - instantiation' }
LeSnippetView >> createSidebarMenuFor: aSnippetElement [
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

{ #category : #comparing }
LeSnippetView >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ snippetElementClass hash
]

{ #category : #initialization }
LeSnippetView >> initialize [
	super initialize.
	
	needsEmbellishments := true.
	needsContentDecorationBar := false
]

{ #category : #accessing }
LeSnippetView >> needsContentDecorationBar [
	^ needsContentDecorationBar
]

{ #category : #accessing }
LeSnippetView >> needsContentDecorationBar: anObject [
	needsContentDecorationBar := anObject
]

{ #category : #accessing }
LeSnippetView >> needsEmbellishments [
	^ needsEmbellishments
]

{ #category : #accessing }
LeSnippetView >> needsEmbellishments: anObject [
	needsEmbellishments := anObject
]

{ #category : #accessing }
LeSnippetView >> snippetElementClass [
	^ snippetElementClass
]

{ #category : #accessing }
LeSnippetView >> snippetElementClass: anObject [
	snippetElementClass := anObject
]

{ #category : #accessing }
LeSnippetView >> snippetElementLookClass [
	^ self needsContentDecorationBar
		ifFalse: [ LeSnippetExpandableAptitude ]
		ifTrue: [ LeSnippetExpandableWithBarAptitude ]
]
