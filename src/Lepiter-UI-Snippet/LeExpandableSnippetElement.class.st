Class {
	#name : #LeExpandableSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'expander',
		'collapsedElement',
		'expandedElement'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #accessing }
LeExpandableSnippetElement >> initialize [
	super initialize.

	self
		hMatchParent;
		vFitContent.

	expander := BrExpander new.
	expander
		hMatchParent;
		vFitContent;
		margin: (BlInsets all: 4);
		aptitude: (GtCoderExpanderAptitude new padding: BlInsets empty);
		beInSingleCompositionLayer.

	expander states withExpansion.

	expander when: BrExpandedEvent do: [ self onExpanded ].
	expander when: BrCollapsedEvent do: [ self onCollapsed ].

	expander
		header: [ self newCollapsedElement ];
		content: [ self newExpandedElement ].

	expander
		when: BlClickEvent
		do: [ :anEvent | 
			expander isCollapsed
				ifTrue: [ anEvent consumed: true.
					expander expand ] ].
	self addChild: expander
]

{ #category : #accessing }
LeExpandableSnippetElement >> newCollapsedElement [
	collapsedElement := self newContentElement.
	self updateSnippetViewModels.
	^ collapsedElement
]

{ #category : #accessing }
LeExpandableSnippetElement >> newContentElement [
	^ BrVerticalPane new
		hMatchParent;
		vFitContent;
		padding: (BlInsets all: 5);
		addChild: LeSnippetHeaderElement new as: #header;
		yourself
]

{ #category : #accessing }
LeExpandableSnippetElement >> newExpandedElement [
	expandedElement := self newContentElement.
	self updateSnippetViewModels.
	^ expandedElement
]

{ #category : #accessing }
LeExpandableSnippetElement >> onCollapsed [
]

{ #category : #accessing }
LeExpandableSnippetElement >> onExpanded [
	self
		enqueueTask: [ expandedElement
				ifNotNil: [ expandedElement isVisible ifTrue: [ expandedElement requestFocus ] ] ]
				asBlTask
]

{ #category : #accessing }
LeExpandableSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	self updateSnippetViewModels
]

{ #category : #accessing }
LeExpandableSnippetElement >> snippetContent [
	^ expander
]

{ #category : #accessing }
LeExpandableSnippetElement >> updateSnippetViewModels [
	collapsedElement
		ifNotNil: [ collapsedElement
				childNamed: #content
				ifFound: [ :content | content removeFromParent ].
			snippetViewModel
				ifNotNil: [ | element |
					collapsedElement
						childNamed: #header
						ifFound: [ :header | header snippetViewModel: snippetViewModel ].
					element := snippetViewModel collapsedElement.
					element
						padding: element padding
								+ (BlInsets
										top: 13
										bottom: 5
										left: 10
										right: 10).
					element snippetViewModel: snippetViewModel.
					collapsedElement addChild: element as: #content ] ].
	expandedElement
		ifNotNil: [ expandedElement
				childNamed: #content
				ifFound: [ :content | content removeFromParent ].
			snippetViewModel
				ifNotNil: [ | element look toolbar |
					expandedElement
						childNamed: #header
						ifFound: [ :header | header snippetViewModel: snippetViewModel ].
					element := snippetViewModel expandedElement.
					look := LeSnippetWithToolbarAptitude new.
					look shouldShowBottomToolbar: false.
					look shouldShowSidebar: false.
					look margin: (BlInsets top: 3 bottom: 3).

					look snippetContent: element snippetContent.

					element clipChildren: false.
					toolbar := element snippetToolbar.
					toolbar
						ifNotNil: [ toolbar
								childNamed: #spawnDestination
								ifFound: [ :el | el visibility: BlVisibility gone ] ].
					look snippetToolbar: toolbar.
					look sidebarStencil: (LeSnippetSidebarStencil new snippetElement: element).

					element addAptitude: look.
					element snippetViewModel: snippetViewModel.
					element
						padding: element padding
								+ (BlInsets
										top: 5
										bottom: 5
										left: 5
										right: 8).
					expandedElement addChild: element as: #content ] ]
]
