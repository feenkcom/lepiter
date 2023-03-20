Extension { #name : #AbstractFileReference }

{ #category : #'*Lepiter-Snippet-SmaCC-Rewrites' }
AbstractFileReference >> asyncAllFilesWithExtension: aString [
	^ self asyncAllFilesWithExtensions: {aString}
]

{ #category : #'*Lepiter-Snippet-SmaCC-Rewrites' }
AbstractFileReference >> asyncAllFilesWithExtensions: anArray [
	^ self asyncWithAllChildrenStream
		select: [ :each | 
			[ (anArray includes: each extension) and: [ each isDirectory not ] ]
				on: Error
				do: [ :ex | ex return: false ] ]
]

{ #category : #'*Lepiter-Snippet-SmaCC-Rewrites' }
AbstractFileReference >> asyncWithAllChildrenStream [
	^ AsyncDepthFirstTraversalStream
		root: self
		children: [ :each | 
			[ ((each == self or: [ each isSymlink not ]) and: [ each isDirectory ])
				ifTrue: [ each children ]
				ifFalse: [ #() ] ] on: Error do: [ :ex | ex return: #() ] ]
]
