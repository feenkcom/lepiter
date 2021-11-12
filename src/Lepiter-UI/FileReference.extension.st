Extension { #name : #FileReference }

{ #category : #'*Lepiter-UI' }
FileReference >> gtXdocFor: aView [

	<gtView>
	| aParsedPage |
	(self isFile and: [ 
		 (GtFileUtility mimeTypeOfExtension: self extension)
		 = ZnMimeType applicationJson ]) ifFalse: [ ^ aView empty ].
	aParsedPage := LeJsonV4 uniqueInstance deserialize: self readStream.
	^ (aParsedPage
		  isKindOf: LePage)
		  ifTrue: [ 
			  aView forward
				  title: 'XDoc';
				  priority: 1;
				  object: [ aParsedPage asContentUIModel ];
				  view: #gtLiveFor: ]
		  ifFalse: [ aView empty ]
]
