Extension { #name : #LePharoClassDatabase }

{ #category : #'*Lepiter-Snippet-Text' }
LePharoClassDatabase >> pageNamed: aSymbol [

	^ pagesByName at: aSymbol ifAbsentPut:
		[ (LePage pharoCommentClassName: aSymbol)
			addSnippet: (LeTextSnippet string: (self class 
				environment at: aSymbol) instanceSide organization classComment);
			yourself ]
]
