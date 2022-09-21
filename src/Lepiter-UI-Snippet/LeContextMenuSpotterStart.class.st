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
LeContextMenuSpotterStart >> gtDisplayString [
	^ 'New snippet'
]

{ #category : #searching }
LeContextMenuSpotterStart >> gtNewSnippetFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Snippet type';
		priority: 1;
		items: [ LeContextMenuBuilder new build ];
		itemName: #title;
		filterBySubstring;
		withoutCategoryAction;
		withoutItemsLimit;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #searching }
LeContextMenuSpotterStart >> gtSpotterForNewSnippetFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 1;
		items: [ LeContextMenuBuilder new build ];
		title: 'Snippet type';
		itemName: #title;
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]
