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
	<gtSpotterSearch>

	^ aSearch list
		priority: 1;
		items: [ LeContextMenuBuilder new build ];
		title: 'Snippet type';
		itemName: #title;
		filter: GtSpotterSubstringFilter;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #searching }
LeContextMenuSpotterStart >> gtSpotterForNewSnippetFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 1;
		allCandidates: [ LeContextMenuBuilder new build ];
		title: 'Snippet type';
		itemName: #title;
		filter: GtFilterSubstring;
		keyBinding: $s meta;
		wantsToDisplayOnEmptyQuery: true
]
