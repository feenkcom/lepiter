"
Spotter extensions should return {{gtClass:TLeContextMenuItemSpecification}} objects.

"
Class {
	#name : #LeContextMenuSpotterStart,
	#superclass : #Object,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-UI-Snippet-Spotter'
}

{ #category : #'as yet unclassified' }
LeContextMenuSpotterStart >> concreteMethodExampleInContext: aContext [
	" return the concrete methods described by the expression (Class >> #Selector) - evaluate it safely"

	<return: #AsyncOptionalValue>
	| classAndSelectorStrings class selector compiledMethod |
	classAndSelectorStrings := (aContext searchQuery trimBoth splitOn: '>>')
			collect: [ :each | each trimBoth ].	" Jenkins reports include `Object.method` strings."
	classAndSelectorStrings size = 2
		ifFalse: [ classAndSelectorStrings := (aContext searchQuery trimBoth splitOn: '.')
					collect: [ :each | each trimBoth ] ].	" check preconditions "
	classAndSelectorStrings size = 2 ifFalse: [ ^ AsyncOptionalValue none ].
	classAndSelectorStrings second size < 2 ifTrue: [ ^ AsyncOptionalValue none ].	" retrieve concrete class and selector - or search all behaviors "
	selector := classAndSelectorStrings second first = $#
			ifTrue: [ classAndSelectorStrings second allButFirst asSymbol ]
			ifFalse: [ classAndSelectorStrings second asSymbol ].

	(class := Smalltalk classNamed: classAndSelectorStrings first)
		ifNil: [ ^ AsyncOptionalValue none ].

	(class canUnderstand: selector) ifFalse: [ ^ AsyncOptionalValue none ].
	
	compiledMethod := class compiledMethodAt: selector.
	
	(compiledMethod pragmas anySatisfy: [ :p | p selector = #gtExample ]) 
		ifFalse: [ ^ AsyncOptionalValue none ].
	
	^ AsyncOptionalValue some: compiledMethod
]

{ #category : #accessing }
LeContextMenuSpotterStart >> database [
	^ database
]

{ #category : #accessing }
LeContextMenuSpotterStart >> database: anObject [
	database := anObject
]

{ #category : #printing }
LeContextMenuSpotterStart >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Add new snippet'
]

{ #category : #searching }
LeContextMenuSpotterStart >> gtNewSnippetFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Add page with snippet';
		priority: 1;
		items: [ LeContextMenuSnippetItemsCollector new 
			collectMenuItems ];
		itemName: #title;
		filterBySubstring;
		withoutCategoryAction;
		withoutItemsLimit;
		wantsToDisplayOnEmptyQuery: true
]
