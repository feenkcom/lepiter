Class {
	#name : #LeContextMenuBuilder,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Spotter'
}

{ #category : #building }
LeContextMenuBuilder >> build [

	| aCollector aCollection |
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

{ #category : #accessing }
LeContextMenuBuilder >> gtMenuItemsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Menu Items';
		items: [ self build ];
		column: 'Title' text: #title;
		column: 'Snippet' text: #snippetClass;
		column: 'Priority' text: [ :aMenuItem | 
			aMenuItem isDefaultPriority
				ifTrue: [ aMenuItem priority asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] 
				ifFalse: [ aMenuItem priority asRopedText ] ]
]
