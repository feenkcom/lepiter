Trait {
	#name : #TLeHtmlContext,
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #'api - accessing' }
TLeHtmlContext >> html [
	"Return HTML output stream.
	Currently we use {{gtClass:ZnHtmlOutputStream}} API to write HTML source code.
	{{gtClass:LeHtmlOutputPrettyStream}} is a pretty-print variant."

	<return: #ZnHtmlOutputStream>
	^ self explicitRequirement
]

{ #category : #'api - initialization' }
TLeHtmlContext >> stream: aStream [
	"Set output stream"
	self explicitRequirement
]
