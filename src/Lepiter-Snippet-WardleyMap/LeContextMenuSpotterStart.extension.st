Extension { #name : #LeContextMenuSpotterStart }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
LeContextMenuSpotterStart >> gtSpotterForOnlineWardleyMapFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		title: 'Add Wardley Map';
		priority: 2;
		itemName: #title;
		search: [ :aContext | 
			((aContext searchQuery asAsyncFuture asAsyncStream
				collect: [ :aQuery | 
					(aQuery beginsWith: 'https://onlinewardleymaps.com/')
						ifTrue: [ aQuery removePrefix: 'https://onlinewardleymaps.com/#' ]
						ifFalse: [ nil ] ]) select: #notNil)
				collect: [ :aMapId | 
					LeContextMenuItemValuableSpecification new
						valuable: [ 
							| url json dictionary map |
							url := 'https://api.onlinewardleymaps.com/v1/maps/fetch?id='
									, (aMapId gtRemovePrefix: 'https://onlinewardleymaps.com/#').
							json := ZnClient new get: url.
							dictionary := STONJSON fromString: json.
							map := GtWardleyMapScriptImporter
									forString: (dictionary at: 'text') asString.
							LeWardleyMapSnippet new wardleyMap: map ];
						title: aMapId ] ]
]
