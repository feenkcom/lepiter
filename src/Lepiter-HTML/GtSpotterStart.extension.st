Extension { #name : #GtSpotterStart }

{ #category : #'*Lepiter-HTML' }
GtSpotterStart >> gtSpotterGtBookFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 60;
		title: 'book.gtoolkit.com';
		itemName: [ :aPage | aPage title ];
		wantsToDisplayOnEmptyQuery: false;
		search: [ :aContext | 
			LeHtmlBookUrlToPageFinder new
				spotterContext: aContext;
				find ]
]
