"
{{gtClass:LeContextMenuSnippetItemsCollector}} gathers the lists of menu items for creating new snippets in a Lepiter page.

A new menu action is added to the list by creating on the class side of a snipppet a method having the pragma `leSnippetSpecification` that returns the menu item.
"
Class {
	#name : #LeContextMenuSnippetItemsCollector,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Spotter'
}

{ #category : #building }
LeContextMenuSnippetItemsCollector >> collectMenuItems [
	| aCollection |
	
	aCollection := OrderedCollection new.

	LeSnippet allSubclassesDo: [ :eachClass | 
		| aClassPragmas |
		aClassPragmas := Pragma
			allNamed: #leSnippetSpecification
			in: eachClass class.

		aClassPragmas do: [ :aPragma | 
			| aMenuItem |
			aMenuItem := aPragma method
				valueWithReceiver: aPragma methodClass
				arguments: #(  ).
			aMenuItem definingMethod: aPragma method.

			aCollection add: aMenuItem ] ].

	aCollection sort: [ :a :b | 
		a priority = b priority
			ifTrue: [ a title < b title ]
			ifFalse: [ a priority < b priority ] ].

	^ aCollection
]

{ #category : #'gt - extensions' }
LeContextMenuSnippetItemsCollector >> gtMenuItemsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Menu Items';
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
