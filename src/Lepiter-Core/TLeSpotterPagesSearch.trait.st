Trait {
	#name : #TLeSpotterPagesSearch,
	#category : #'Lepiter-Core-Utility'
}

{ #category : #'api - accessing' }
TLeSpotterPagesSearch >> children [
	<return: #Collection of: #LeContent>
	^ self explicitRequirement
]

{ #category : #'gt-extensions' }
TLeSpotterPagesSearch >> gtSpotterContainingSubPartsFor: aSearch [
	<gtSearch>
	self hasChildren ifNil: [ ^ aSearch empty ].
	^ aSearch list
		priority: 23;
		title: 'Children Tree Content';
		wantsToDisplayOnEmptyQuery: false;
		filterBySubstring;
		items: [ self children ]
]

{ #category : #'gt-extensions' }
TLeSpotterPagesSearch >> gtSpotterContentFor: aSearch [
	<gtSearch>
	self hasChildren ifFalse: [ ^ aSearch empty ].
	^ aSearch list
		title: 'Direct Children Content';
		priority: 21;
		items: [ self children ];
		itemName: [ :each | each contentAsString ];
		wantsToDisplayOnEmptyQuery: true;
		filterBySubstring
]

{ #category : #'gt-extensions' }
TLeSpotterPagesSearch >> gtSpotterUidFor: aSearch [
	<gtSearch>
	self hasChildren ifFalse: [ ^ aSearch empty ].
	^ aSearch list
		title: 'Pages with UUID';
		priority: 51;
		items: [ self children ];
		itemName: [ :each | each uidString ];
		wantsToDisplayOnEmptyQuery: true;
		filterBySubstring
]

{ #category : #'api - testing' }
TLeSpotterPagesSearch >> hasChildren [
	<return: #Boolean>
	^ self explicitRequirement
]
