Extension { #name : #LeHtmlTextSnippetAnnotationVisitor }

{ #category : #'*Lepiter-Snippet-Words' }
LeHtmlTextSnippetAnnotationVisitor >> visitWordAnnotation: aLeWordAnnotationNode [
	"Do nothing, neither call `#visitAnnotation:` because it produces a
	`does not understand` error while iterating child nodes."
	
	LeHtmlTextSnippetWordAnnotationWriter new
		snippet: snippet;
		context: context;
		annotation: aLeWordAnnotationNode;
		write
]
