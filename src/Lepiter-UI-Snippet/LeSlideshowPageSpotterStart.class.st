Class {
	#name : #LeSlideshowPageSpotterStart,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Spotter'
}

{ #category : #printing }
LeSlideshowPageSpotterStart >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Add New Slide'
]

{ #category : #searching }
LeSlideshowPageSpotterStart >> gtNewSnippetFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Add Slide to Page';
		priority: 1;
		items: [ LeSlideshowNewSlideItemSpecification emptySlideAndTemplates ];
		itemName: #title;
		previewElement: #preview;
		filterBySubstring;
		withoutCategoryAction;
		withoutItemsLimit;
		wantsToDisplayOnEmptyQuery: true
]
