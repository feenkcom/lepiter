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
		'sidebarStencil',
		'sidebar',
		'shouldShowSidebar',
		'shouldShowBottomToolbar',
		'shouldShowActionsOnFocus'
	],
	#category : #'Lepiter-UI-Snippet-Looks'
}

{ #category : #'private - bottom toolbar' }
LeSnippetAptitude >> bottomToolbarMargin [
	^ -8
]

{ #category : #'private - bottom toolbar' }
LeSnippetAptitude >> computeBottomToolbarMargin [
	^ BlInsets bottom: self bottomToolbarMargin + self internalBorderBottomOffset
]

{ #category : #'private - accessing' }
LeSnippetAptitude >> contentContainer [
	^ self snippetContainer
]

{ #category : #'private - bottom toolbar' }
LeSnippetAptitude >> createBottomToolbar [
	^ self newAddSnippetDropdown
		elevation: (BlRelativeElevation elevation: 20);
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenter.
			c ignored vertical alignBottom ]
]

{ #category : #'private - sidebar' }
LeSnippetAptitude >> createSidebar [
	^ sidebarStencil asElement
]

{ #category : #'private - bottom toolbar' }
LeSnippetAptitude >> ensureBottomToolbar [
	"Make sure that the bottom toolbar is initialized and added to the snippet content container.
	We initialize the bottom toolbar lazily the first time it appears"

	bottomToolbar ifNil: [ bottomToolbar := self createBottomToolbar ].

	(self contentContainer hasChild: bottomToolbar)
		ifTrue: [ ^ self ].

	self contentContainer addChild: bottomToolbar as: #bottomToolbar
]

{ #category : #'private - sidebar' }
LeSnippetAptitude >> ensureSidebar [
	"Make sure that the sidebar is initialized and added to the snippet content container.
	We initialize the sidebar lazily the first time it appears"

	sidebar ifNil: [ sidebar := self createSidebar ].

	(widgetContent hasChild: sidebar)
		ifTrue: [ ^ self ].

	widgetContent addChild: sidebar as: #sidebarContainer
]

{ #category : #private }
LeSnippetAptitude >> hideActions [
	areActionsVisible := false.

	self hideSidebar.
	self hideBottomToolbar
]

{ #category : #'private - bottom toolbar' }
LeSnippetAptitude >> hideBottomToolbar [
	bottomToolbar ifNil: [ ^ self ].
	bottomToolbar visibility: BlVisibility hidden.
	self updateBottomToolbarMargin
]

{ #category : #'private - sidebar' }
LeSnippetAptitude >> hideSidebar [
	sidebar ifNil: [ ^ self ].
	sidebar visibility: BlVisibility hidden
]

{ #category : #initialization }
LeSnippetAptitude >> initialize [
	super initialize.

	padding := BlInsets empty.
	margin := BlInsets empty.

	areActionsVisible := false.

	self initializeElements.

	snippetContent := BlElement new size: 0 @ 0.
	sidebarStencil := [ BlElement new
			layout: BlLinearLayout vertical;
			preventMouseEvents;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical matchParent ] ] asStencil.

	self addChangeProperty: #(widget margin) with: [ margin ].

	self
		addChangeAddChildAs: #(content)
		with: [ widgetContent addChild: snippetContainer as: #snippetContainer.

			self contentContainer addChild: snippetContent.

			widgetContent ].

	self addChangeProperty: #(snippetContainer padding) with: [ padding ].

	self add: (BrLayoutResizerAptitude new inherit: [ widgetContent ]).
	widgetContent
		addAptitude: (BrLayoutResizerAptitude new inherit: [ snippetContainer ]).
	self contentContainer
		addAptitude: (BrLayoutResizerAptitude new inherit: [ snippetContent ]).

	self
		add: (BrLazyStyleCommonAptitude new
				when: BlElementState focused | BlElementState hovered
					style: [ :aStyle | 
						self shouldShowActionsOnFocus
							ifTrue: [ aStyle do: [ self showActions ] after: [ self hideActions ] ] ];
				when: BlElementState focused & BlElementState hovered
					style: [ :aStyle | aStyle do: [ self visuallyFocus ] after: [ self visuallyUnfocusAndUnhover ] ];
				when: BlElementState focused & BlElementState hovered not
					style: [ :aStyle | aStyle do: [ self visuallyFocus ] after: [ self visuallyUnfocusAndUnhover ] ];
				when: BlElementState hovered & BlElementState focused not
					style: [ :aStyle | aStyle do: [ self visuallyHover ] after: [ self visuallyUnfocusAndUnhover ] ]).

	snippetContainer
		addShortcut: (BlShortcutWithAction new
				combination: (BlKeyCombination builder
						shift;
						primary;
						key: BlKeyboardKey return;
						build);
				action: [ :anEvent :aShortcut | self showBottomToolbarDropdown ]).

	self hideActions
]

{ #category : #initialization }
LeSnippetAptitude >> initializeElements [
	self initializeWidgetContent.
	self initializeSnippetContainer
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

{ #category : #'instance creation' }
LeSnippetAptitude >> newAddSnippetDropdown [
	<return: #BlElement>
	| aButton |
	
	aButton := self newPlusElement.
	aButton
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
			handle: [ 
				self newPlusElement
					aptitude: BrIconAptitude;
					background: BrGlamorousColors secondaryHeaderBackgroundColor ]
			content: [
				GtSpotterDropdownButtonStencil new
					valuable: (LeContextMenuSpotterStart new 
						database: widget database);
					extent: [ 300 @ 400 ];
					spotterModelDo: [ :aSpotter |
						aSpotter hidePreview.
						aSpotter announcer weak
							when: GtSpotterExitAnnouncement
							send: #onSpotterExitAnnouncement:
							to: self ];
					objectActOn: [ :anActOnEvent :aMenuItem :theButton | 
						self snippetBelowRequested: aMenuItem asSnippet.
						anActOnEvent beActed ];
					spotterElementFor: aButton ]
			containerDo: [ :aMenuContainer | 
				aMenuContainer background: BrGlamorousColors secondaryHeaderBackgroundColor ]) doNotHideWidget.
	^ aButton
]

{ #category : #'instance creation' }
LeSnippetAptitude >> newPlusElement [
	<return: #BlElement>

	^ GtInspectorRoundButtonStencil small asElement
		icon: (BrPlusIconStencil add thickness: 1; radius: 4; asElement);
		yourself
]

{ #category : #'private - event management' }
LeSnippetAptitude >> onSpotterExitAnnouncement: anAnnouncement [
	self widgetDo: [ :aWidget | aWidget snippetViewModel focused: true from: nil ]
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

{ #category : #accessing }
LeSnippetAptitude >> shouldShowActionsOnFocus [
	^ shouldShowActionsOnFocus ifNil: [ true ]
]

{ #category : #accessing }
LeSnippetAptitude >> shouldShowActionsOnFocus: aBoolean [
	shouldShowActionsOnFocus := aBoolean.
	(shouldShowActionsOnFocus or: [ areActionsVisible ])
		ifFalse: [ self showActions ]
]

{ #category : #accessing }
LeSnippetAptitude >> shouldShowBottomToolbar [
	^ shouldShowBottomToolbar ifNil: [ true ]
]

{ #category : #accessing }
LeSnippetAptitude >> shouldShowBottomToolbar: aBoolean [
	shouldShowBottomToolbar := aBoolean
]

{ #category : #accessing }
LeSnippetAptitude >> shouldShowSidebar [
	^ shouldShowSidebar ifNil: [ true ]
]

{ #category : #accessing }
LeSnippetAptitude >> shouldShowSidebar: aBoolean [
	shouldShowSidebar := aBoolean
]

{ #category : #private }
LeSnippetAptitude >> showActions [
	areActionsVisible := true.

	self showSidebar.
	self showBottomToolbar
]

{ #category : #'private - bottom toolbar' }
LeSnippetAptitude >> showBottomToolbar [
	self shouldShowBottomToolbar ifFalse: [ ^ self ].
	self ensureBottomToolbar.
	bottomToolbar visibility: BlVisibility visible.
	self updateBottomToolbarMargin
]

{ #category : #'private - bottom toolbar' }
LeSnippetAptitude >> showBottomToolbarDropdown [
	self ensureBottomToolbar.
	bottomToolbar dispatchEvent: BrDropdownShowWish new
]

{ #category : #'private - sidebar' }
LeSnippetAptitude >> showSidebar [
	self shouldShowSidebar ifFalse: [ ^ self ].
	self ensureSidebar.
	sidebar visibility: BlVisibility visible
]

{ #category : #'api - accessing' }
LeSnippetAptitude >> sidebarStencil: aStencil [
	sidebarStencil := aStencil asStencil
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

{ #category : #'private - bottom toolbar' }
LeSnippetAptitude >> updateBottomToolbarMargin [
	bottomToolbar ifNil: [ ^ self ].
	bottomToolbar margin: self computeBottomToolbarMargin
]

{ #category : #private }
LeSnippetAptitude >> visuallyFocus [
]

{ #category : #private }
LeSnippetAptitude >> visuallyHover [
]

{ #category : #private }
LeSnippetAptitude >> visuallyUnfocusAndUnhover [
]
