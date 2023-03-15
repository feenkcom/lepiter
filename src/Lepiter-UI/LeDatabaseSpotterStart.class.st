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
	^ aSearch list
		priority: 2;
		items: [ self navigationModel pages ];
		title: 'Page Content';
		itemName: [ :page | page title ];
		previewElement: [ :aLePage | 
			| aPageViewModel |
			aPageViewModel := aLePage asContentUIModel.
			LePageToolElement new pageViewModel: aPageViewModel ];
		filter: (GtSpotterSubstringFilter new
				itemString: [ :aPage | aPage printPageSummaryLimitedTo: Float infinity ]);
		wantsToDisplayOnEmptyQuery: self navigationModel hasPage not
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
