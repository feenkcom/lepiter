Extension { #name : #LeContextMenuSpotterStart }

{ #category : #'*Lepiter-Snippet-Youtube' }
LeContextMenuSpotterStart >> gtSearchExampleMethodFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 4;
		title: 'Add example snippet';
		search: [ :aContext | 
			((AsyncMaybeOnceStream
				forFuture: [ self concreteMethodExampleInContext: aContext ] asAsyncFuture)
				select: #notNil)
				collect: [ :method | 
					LeContextMenuItemValuableSpecification new
						valuable: [ LeExampleSnippet new
								exampleBehaviorName: method methodClass name;
								exampleSelector: method selector ];
						title: method gtDisplayString ] ]
]

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
