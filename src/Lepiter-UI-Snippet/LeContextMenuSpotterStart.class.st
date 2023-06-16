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
	aStream nextPutAll: 'New snippet'
]

{ #category : #searching }
LeContextMenuSpotterStart >> gtNewSnippetFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Snippet type';
		priority: 1;
		items: [ LeContextMenuSnippetItemsCollector new 
			collectMenuItems ];
		itemName: #title;
		filterBySubstring;
		withoutCategoryAction;
		withoutItemsLimit;
		wantsToDisplayOnEmptyQuery: true
]
