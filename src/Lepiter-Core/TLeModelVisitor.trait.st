Trait {
	#name : #TLeModelVisitor,
	#category : #'Lepiter-Core-Visitor'
}

{ #category : #visiting }
TLeModelVisitor >> visitAttachment: aLeAttachment [

	^ self visitModel: aLeAttachment
]

{ #category : #visiting }
TLeModelVisitor >> visitCollection: aLeCollection [

	aLeCollection do: [ :child |
		child acceptVisitor: self ]
]

{ #category : #visiting }
TLeModelVisitor >> visitContent: aLeContent [

	aLeContent children do: [ :child |
		child acceptVisitor: self ].
	^ aLeContent
]

{ #category : #visiting }
TLeModelVisitor >> visitDatabase: aLeDatabase [

	aLeDatabase pagesDo: [ :page |
		page acceptVisitor: self ].

]

{ #category : #visiting }
TLeModelVisitor >> visitDoubleBracketLink: aDoubleBracketLink [
]

{ #category : #visiting }
TLeModelVisitor >> visitElementSnippet: aLeElementSnippet [

	^ self visitTextualSnippet: aLeElementSnippet
]

{ #category : #visiting }
TLeModelVisitor >> visitJavaScriptSnippet: aLeJavaScriptSnippet [

	^ self visitTextualSnippet: aLeJavaScriptSnippet
]

{ #category : #visiting }
TLeModelVisitor >> visitModel: aLeModel [


]

{ #category : #visiting }
TLeModelVisitor >> visitPage: aLePage [

	^ self visitContent: aLePage
]

{ #category : #visiting }
TLeModelVisitor >> visitPageAnnotation: aDoubleBracketLink [
]

{ #category : #visiting }
TLeModelVisitor >> visitPages: aLePages [

	^ self visitCollection: aLePages
]

{ #category : #visiting }
TLeModelVisitor >> visitPharoSnippet: aLePharoSnippet [

	^ self visitTextualSnippet: aLePharoSnippet
]

{ #category : #visiting }
TLeModelVisitor >> visitPictureSnippet: aLePictureSnippet [

	^ self visitSnippet: aLePictureSnippet 
]

{ #category : #visiting }
TLeModelVisitor >> visitPythonSnippet: aLePythonSnippet [

	^ self visitTextualSnippet: aLePythonSnippet
]

{ #category : #visiting }
TLeModelVisitor >> visitSlide: aLeSlide [

	^ self visitSnippet: aLeSlide
]

{ #category : #visiting }
TLeModelVisitor >> visitSlideshowSnippet: aLeSlideshowSnippet [
	^ self visitTextualSnippet: aLeSlideshowSnippet.
]

{ #category : #visiting }
TLeModelVisitor >> visitSnippet: aLeSnippet [

	^ self visitContent: aLeSnippet
]

{ #category : #visiting }
TLeModelVisitor >> visitSnippets: aLeSnippets [

	^ self visitCollection: aLeSnippets
]

{ #category : #visiting }
TLeModelVisitor >> visitSparqlSnippet: aLeJavaScriptSnippet [

	^ self visitTextualSnippet: aLeJavaScriptSnippet
]

{ #category : #visiting }
TLeModelVisitor >> visitTextSnippet: aLeTextSnippet [

	^ self visitTextualSnippet: aLeTextSnippet
]

{ #category : #visiting }
TLeModelVisitor >> visitTextualLink: aDoubleBracketLink [
]

{ #category : #visiting }
TLeModelVisitor >> visitTextualSnippet: aLeTextualSnippet [

	aLeTextualSnippet allOutgoingLinks do: [ :link | 
		link acceptVisitor: self ].
	^ self visitSnippet: aLeTextualSnippet
]

{ #category : #visiting }
TLeModelVisitor >> visitUnknownSnippet: aLeTextSnippet [

	^ self visitTextualSnippet: aLeTextSnippet
]
