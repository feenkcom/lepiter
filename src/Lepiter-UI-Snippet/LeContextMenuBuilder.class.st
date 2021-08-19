Class {
	#name : 'LeContextMenuBuilder',
	#superclass : 'Object',
	#category : 'Lepiter-UI-Snippet-Spotter'
}

{ #category : 'building' }
LeContextMenuBuilder >> build [
	| aCollector aCollection |
	aCollector := (PragmaCollector
		filter: [ :aPragma | aPragma selector = #leSnippetSpecification ])
		reset.
	aCollection := aCollector
		collect: [ :aPragma |
			| aMenuItem |
			aMenuItem := aPragma method valueWithReceiver: aPragma methodClass arguments: #().
			aMenuItem definingMethod: aPragma method.
			aMenuItem ].
	aCollector release.
	aCollection sort: [ :a :b | a priority = b priority 
		ifTrue: [ a title < b title ] 
		ifFalse: [ a priority < b priority ] ].
	^ aCollection
]

{ #category : 'accessing' }
LeContextMenuBuilder >> gtMenuItemsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Menu Items';
		items: [ self build ];
		column: 'Title' item: #title;
		column: 'Snippet' item: #snippetClass;
		column: 'Priority' text: [ :aMenuItem | 
			aMenuItem isDefaultPriority
				ifTrue: [ aMenuItem priority asRopedText foreground: BrGlamorousColors disabledButtonTextColor ] 
				ifFalse: [ aMenuItem priority asRopedText ] ]
]
