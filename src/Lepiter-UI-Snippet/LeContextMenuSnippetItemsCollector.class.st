"
{{gtClass:LeContextMenuSnippetItemsCollector}} gathers the lists of menu items for creating new snippets in a Lepiter page.

A new menu action is added to the list by creating on the class side of a snipppet a method having the pragma `leSnippetSpecification` that returns the menu item.

The method {{gtMethod:LeContextMenuSnippetItemsCollector>>collectMenuItems}} is the main API method for getting the menu items.
```
LeContextMenuSnippetItemsCollector new collectMenuItems
```

The current list of menu items for creating  snippets:

{{gtExample:LeContextMenuSnippetItemsCollectorExamples>>basicBuilder|noCode=true|previewShow=#gtMenuItemsFor:}}

"
Class {
	#name : #LeContextMenuSnippetItemsCollector,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Spotter'
}

{ #category : #'gt - extensions' }
LeContextMenuSnippetItemsCollector class >> gtClassViewMenuItemsFor: aView [
	<gtView>
	<gtClassView>
	
	^ aView forward
		title: 'Menu items';
		object: [ self new ];
		view: #gtMenuItemsFor:
]

{ #category : #building }
LeContextMenuSnippetItemsCollector >> collectMenuItems [
	| menuItems |
	menuItems := OrderedCollection new.
	self pragmaRootClass allSubclasses
		do: [ :eachClass | 
			| targetPragmas |
			targetPragmas := self collectPragmasInClass: eachClass.

			targetPragmas
				do: [ :aPragma | 
					| newMenuItem |
					newMenuItem := self createMenuItemFromPragma: aPragma.
					menuItems add: newMenuItem ] ].

	self sortMenuItems: menuItems.

	^ menuItems
]

{ #category : #building }
LeContextMenuSnippetItemsCollector >> collectPragmasInClass: aClass [
	^ Pragma allNamed: self pragmaSelector in: aClass class
]

{ #category : #building }
LeContextMenuSnippetItemsCollector >> createMenuItemFromPragma: aPragma [
	| menuItem |
	menuItem := aPragma method
			valueWithReceiver: aPragma methodClass instanceSide
			arguments: #().
	menuItem definingMethod: aPragma method.
	^ menuItem
]

{ #category : #'gt - extensions' }
LeContextMenuSnippetItemsCollector >> gtMenuItemsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Menu items';
		items: [ self collectMenuItems ];
		column: 'Title' text: #title;
		column: 'Snippet' text: #snippetClass;
		column: 'Priority' text: [ :aMenuItem | 
			aMenuItem isDefaultPriority
				ifTrue: [ 
					aMenuItem priority asRopedText 
						foreground: BrGlamorousColors disabledButtonTextColor ] 
				ifFalse: [ 
					aMenuItem priority asRopedText ] ]
]

{ #category : #configuration }
LeContextMenuSnippetItemsCollector >> pragmaRootClass [
	"Where to start searching for pragmas."

	^ LeSnippet
]

{ #category : #configuration }
LeContextMenuSnippetItemsCollector >> pragmaSelector [
	^ #leSnippetSpecification
]

{ #category : #building }
LeContextMenuSnippetItemsCollector >> sortMenuItems: aCollectionOfMenuItems [
	aCollectionOfMenuItems sort: [ :a :b | 
		a priority = b priority
			ifTrue: [ a title < b title ]
			ifFalse: [ a priority < b priority ] ] 
]
