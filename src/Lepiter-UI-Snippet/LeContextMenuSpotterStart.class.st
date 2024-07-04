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
