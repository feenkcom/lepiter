Class {
	#name : #LeStringSpotterStart,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-String'
}

{ #category : #printing }
LeStringSpotterStart >> gtDisplayOn: stream [
	stream nextPutAll: 'Select parser'
]

{ #category : #searching }
LeStringSpotterStart >> gtSpotterParsersAndStylersFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Parsers';
		items: ((AsyncBehaviorAllSubclassesStream forBehavior: SmaCCParser)
				select: [ :aClass | 
					[ aClass isAbstract not and: [ aClass gtStyler notNil ] ]
						on: Error
						do: [ false ] ]);
		itemName: [ :aParser | 
			LeStringParserNameBuilder new
				parserClass: aParser;
				buildWithExtensions ];
		filterBySubstring;
		withoutCategoryAction;
		withoutItemsLimit;
		wantsToDisplayOnEmptyQuery: true
]
