"
LeSnippetContainerLook provides the common UI look for all snippets, i.e.:

- blue border when focussed.
- the plus ('+') button at the bottom for adding another snippet
- the delete button ('x') at the top right corner for removing the snippet
- the move / indent hamburger menu at the bottom right corner

 
Internal Representation and Key Implementation Points.

    Instance Variables
	areActionsVisible:		<Object>
	bottomToolbar:		<Object>
	closeButton:		<Object>
	margin:		<Object>
	padding:		<Object>
	sidebarContainer:		<Object>
	sidebarContent:		<Object>
	snippetContainer:		<Object>
	snippetContent:		<Object>
	snippetInsets:		<Object>
	widgetContent:		<Object>


    Implementation Points
"
Class {
	#name : #LeSnippetAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'bottomToolbar',
		'padding',
		'margin',
		'areActionsVisible',
		'snippetContent',
		'snippetContainer',
		'widgetContent',
		'sidebarContainer',
		'sidebarContent'
	],
	#category : #'Lepiter-UI-Snippet-Looks'
}

{ #category : #'private - accessing' }
LeSnippetAptitude >> bottomToolbar [
	^ bottomToolbar
]

{ #category : #'private - layout' }
LeSnippetAptitude >> bottomToolbarMargin [
	^ -8
]

{ #category : #'private - layout' }
LeSnippetAptitude >> computeBottomToolbarMargin [
	^ BlInsets bottom: self bottomToolbarMargin + self internalBorderBottomOffset
]

{ #category : #private }
LeSnippetAptitude >> hideActions [
	areActionsVisible := false.

	self bottomToolbar visibility: BlVisibility hidden.
	self sidebarContainer visibility: BlVisibility hidden.
	self updateBottomToolbarMargin
]

{ #category : #initialization }
LeSnippetAptitude >> initialize [
	super initialize.

	padding := BlInsets empty.
	margin := BlInsets empty.

	areActionsVisible := false.

	self initializeElements.
	
	snippetContent := BlElement new size: 0@0.
	sidebarContent := BlElement new size: 0@0.

	self addChangeProperty: #(widget margin) with: [ margin ].

	self addChangeAddChildAs: #(content) with: [ widgetContent ].
	self addChangeAddChildAs: #(content snippetContainer) with: [ snippetContainer ].
	self addChangeAddChildAs: #(content sidebarContainer) with: [ sidebarContainer ].

	self addChangeAddChildAs: #(snippetContainer snippetContent) with: [ snippetContent ].
	self addChangeAddChildAs: #(snippetContainer bottomToolbar) with: [ self bottomToolbar ].

	self addChangeAddChildAs: #(sidebarContainer sidebarContent) with: [ sidebarContent ].
	self addChangeProperty: #(snippetContainer padding) with: [ padding ].

	self add: (BrLayoutResizerAptitude new
		inherit;
		inherit: [ widgetContent ]).

	widgetContent addAptitude: (BrLayoutResizerAptitude new
		inherit;
		inherit: [ snippetContainer ]).
		
	snippetContainer addAptitude: (BrLayoutResizerAptitude new
		inherit;
		inherit: [ snippetContent ]).
		
	snippetContainer addShortcut: (BlShortcutWithAction new
		combination: (BlKeyCombination builder shift; primary; key: BlKeyboardKey return; build);
		action: [ :anEvent :aShortcut | 
			bottomToolbar dispatchEvent: BrDropdownShowWish new ]).

	self hideActions
]

{ #category : #initialization }
LeSnippetAptitude >> initializeBottomToolbar [
	bottomToolbar := self newAddSnippetDropdown
		elevation: (BlRelativeElevation elevation: 20);
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenter.
			c ignored vertical alignBottom ]
]

{ #category : #initialization }
LeSnippetAptitude >> initializeElements [
	self initializeBottomToolbar.
	self initializeWidgetContent.
	self initializeSnippetContainer.
	self initializeSidebarContainer
]

{ #category : #initialization }
LeSnippetAptitude >> initializeListeners [
	super initializeListeners.
	"self
		when: BlMouseEnterEvent
		do: [ self onMouseEnter ].
	self
		when: BlMouseLeaveEvent
		do: [ self onMouseLeave ]."
	self 
		when: BlFocusInEvent 
		do: [ self onFocusReceived ].
	self 
		when: BlFocusOutEvent 
		do: [ self onFocusLost ].
]

{ #category : #initialization }
LeSnippetAptitude >> initializeSidebarContainer [
	sidebarContainer := BlElement new
		layout: BlLinearLayout vertical;
		preventMouseEvents;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical matchParent ]
]

{ #category : #initialization }
LeSnippetAptitude >> initializeSnippetContainer [
	snippetContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		clipChildren: false
]

{ #category : #initialization }
LeSnippetAptitude >> initializeWidgetContent [
	widgetContent := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		clipChildren: false
]

{ #category : #'private - layout' }
LeSnippetAptitude >> internalBorderBottomOffset [
	"Return the bottom offset of the internal border"

	^ self padding bottom
]

{ #category : #'api - accessing' }
LeSnippetAptitude >> margin [
	^ margin
]

{ #category : #'api - accessing' }
LeSnippetAptitude >> margin: anObject [
	margin := anObject
]

{ #category : #private }
LeSnippetAptitude >> mayHideActions [
	"Only hide actions if the widget does not have focus"
	self widgetDo: [ :aWidget |
		aWidget hasFocus ifTrue: [ ^ self ] ].
	self hideActions
]

{ #category : #'instance creation' }
LeSnippetAptitude >> newAddSnippetDropdown [
	<return: #BlElement>
	
	| aButton |
	aButton := self newPlusElement.
	aButton
		addAptitude: (BrGlamorousWithDropdownAptitude
			handle: [ 
				self newPlusElement
					aptitude: BrIconAptitude;
					background: BrGlamorousColors secondaryHeaderBackgroundColor ]
			content: [
				GtSpotterDropdownButtonStencil new
					valuable: (LeContextMenuSpotterStart new database: widget database);
					extent: [ 300 @ 400 ];
					spotterModelDo: [ :aSpotter |
						aSpotter hidePreview.
						aSpotter announcer
							when: GtSpotterExitAnnouncement
							do: [ :anAnnouncement | self widgetDo: [ :aWidget | 
									aWidget snippetViewModel focused: true from: nil ] ]
						 ];
					actOn: [ :anActOnEvent :aMenuItem :theButton | 
						self snippetBelowRequested: aMenuItem asSnippet.
						anActOnEvent beActed ];
					spotterElementFor: aButton ]
			aptitudeDo: [ :anAnchoredLook | 
				anAnchoredLook background: BrGlamorousColors secondaryHeaderBackgroundColor ]) doNotHideWidget.
	^ aButton
]

{ #category : #'instance creation' }
LeSnippetAptitude >> newPlusElement [
	<return: #BlElement>

	^ GtInspectorRoundButtonStencil small asElement
		icon: (GtInspectorPlusIconStencil add thickness: 1; radius: 4; asElement);
		yourself
]

{ #category : #callbacks }
LeSnippetAptitude >> onFocusLost [
	self hideActions
]

{ #category : #callbacks }
LeSnippetAptitude >> onFocusReceived [
	self showActions
]

{ #category : #callbacks }
LeSnippetAptitude >> onMouseEnter [
	self showActions
]

{ #category : #callbacks }
LeSnippetAptitude >> onMouseLeave [
	self mayHideActions
]

{ #category : #'api - accessing' }
LeSnippetAptitude >> padding [
	<return: #BlInsets>

	^ padding
]

{ #category : #'api - accessing' }
LeSnippetAptitude >> padding: aBlInsets [
	padding := aBlInsets
]

{ #category : #private }
LeSnippetAptitude >> showActions [
	areActionsVisible := true.

	self bottomToolbar visibility: BlVisibility visible.
	self sidebarContainer visibility: BlVisibility visible.
	self updateBottomToolbarMargin
]

{ #category : #'private - accessing' }
LeSnippetAptitude >> sidebarContainer [
	^ sidebarContainer
]

{ #category : #'api - accessing' }
LeSnippetAptitude >> sidebarContainer: anElement [
	sidebarContainer := anElement.
	sidebarContainer visibility: (areActionsVisible
		ifTrue: [ BlVisibility visible ]
		ifFalse: [ BlVisibility hidden ] )
]

{ #category : #'api - accessing' }
LeSnippetAptitude >> sidebarContent: anElement [
	sidebarContent := anElement
]

{ #category : #private }
LeSnippetAptitude >> snippetBelowRequested: aSnippet [
	self hasOwner ifNil: [ 
		^ self inform: 'Must be attached to a container' ].

	self widget snippetViewModel insertNewSnippet: aSnippet
]

{ #category : #'private - accessing' }
LeSnippetAptitude >> snippetContainer [
	^ snippetContainer
]

{ #category : #'api - accessing' }
LeSnippetAptitude >> snippetContent: aSnippetContent [
	snippetContent := aSnippetContent
]

{ #category : #'private - layout' }
LeSnippetAptitude >> updateBottomToolbarMargin [
	bottomToolbar margin: self computeBottomToolbarMargin
]
