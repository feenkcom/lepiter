Extension { #name : #LeContextMenuSpotterStart }

{ #category : #'*Lepiter-Snippet-Youtube' }
LeContextMenuSpotterStart >> gtSpotterForOnlineYouTubeVideoFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		title: 'Add YouTube video';
		priority: 2;
		itemName: #title;
		search: [ :aContext | 
			((aContext searchQuery asAsyncFuture asAsyncStream
				collect: [ :aQuery | 
					| aYouTubeUrl |
					aYouTubeUrl := LeYoutubeUrl new string: aQuery.
					aYouTubeUrl isValidYoutubeUrl
						ifFalse: [ nil ]
						ifTrue: [ aYouTubeUrl ] ]) select: #notNil)
				collect: [ :aYouTubeUrl | 
					LeContextMenuItemValuableSpecification new
						valuable: [ 
							LeYoutubeReferenceSnippet new
								urlString: aYouTubeUrl url asString. ];
						title: aYouTubeUrl string ] ]
]
