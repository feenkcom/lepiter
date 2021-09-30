Trait {
	#name : #TLeSpotterPagesSearch,
	#category : 'Lepiter-Core-Utility'
}

{ #category : #'api - accessing' }
TLeSpotterPagesSearch >> children [
	<return: #Collection of: #LeContent>
	^ self explicitRequirement
]

{ #category : #'gt-extensions' }
TLeSpotterPagesSearch >> gtSpotterContainingSubPartsFor: aStep [
	<gtSearch>
	self hasChildren ifNil: [ ^ self ].
	aStep listProcessor
		priority: 23;
		title: 'Children Tree Content';
		wantsToDisplayOnEmptyQuery: false;
		filter: LeSubstringFilter;
		items: [ self children ]
]

{ #category : #'gt-extensions' }
TLeSpotterPagesSearch >> gtSpotterContentFor: aStep [
	<gtSearch>
	self hasChildren ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Direct Children Content';
		priority: 21;
		items: [ self children ];
		itemFilterName: #content;
		wantsToDisplayOnEmptyQuery: true;
		filter: GtFilterSubstring
]

{ #category : #'gt-extensions' }
TLeSpotterPagesSearch >> gtSpotterSubPartsFor: aStep [
	<gtSearch>
	false ifFalse: [ ^ self ].
	aStep listProcessor
		priority: 24;
		title: 'Navigate To Children';
		wantsToDisplayOnEmptyQuery: false;
		filter: GtFilterSubstring
			item: [ :filter :context | 
				self allChildrenBreadthFirstDo: filter ]
]

{ #category : #'api - testing' }
TLeSpotterPagesSearch >> hasChildren [
	<return: #Boolean>
	^ self explicitRequirement
]
