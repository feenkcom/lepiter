Extension { #name : #TLeAnnotationParseNodeVisitor }

{ #category : #'*Lepiter-Snippet-Words' }
TLeAnnotationParseNodeVisitor >> visitWordAnnotation: aLeWordAnnotationNode [
	"Do nothing, neither call `#visitAnnotation:` because it produces a
	`does not understand` error while iterating child nodes."
]
