Class {
	#name : #LeDatabaseSpotterStart,
	#superclass : #Object,
	#instVars : [
		'navigationModel'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #searching }
LeDatabaseSpotterStart >> gtSpotterForPagesByContentFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 23;
		title: 'Page contents';
		search: [ :aContext |
			[
			| filter results |
			results := OrderedCollection new.
			filter := LeSubstringFilter new
				caseSensitive: false;
				query: aContext searchQuery.
			self navigationModel database pagesWithNameDo: [ :eachPage |
				(filter isMatchedItem: eachPage)
					ifTrue: [ results add: eachPage ] ].
			self navigationModel database unnamedPagesDo: [ :eachPage |
				(filter isMatchedItem: eachPage)
					ifTrue: [ results add: eachPage ] ].
			results asAsyncStream
			] asAsyncFuture asAsyncStream flatten
		];
		itemName: #spotterItemName
]

{ #category : #searching }
LeDatabaseSpotterStart >> gtSpotterForPagesFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		title: 'Named pages';
		priority: 1;
		search: [ :aContext | self navigationModel database asyncPagesForWord: aContext searchQuery ];
		itemName: #title;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #accessing }
LeDatabaseSpotterStart >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSpotterStart >> navigationModel: aNavigationModel [
	navigationModel := aNavigationModel
]

{ #category : #printing }
LeDatabaseSpotterStart >> printOn: aStream [
	aStream nextPutAll: 'Spotter'
]
