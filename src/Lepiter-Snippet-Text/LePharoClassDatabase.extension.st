Extension { #name : #LePharoClassDatabase }

{ #category : #'*Lepiter-Snippet-Text' }
LePharoClassDatabase >> pageNamed: aSymbol [

	^ pagesByName at: aSymbol ifAbsentPut:
		[ 
			| targetClass classComment |
			targetClass := self class environment at: aSymbol.
			classComment := targetClass instanceSide gtComment.
			
				(LePage pharoCommentClassName: aSymbol)
			addSnippet: (LeTextSnippet string: classComment);
			yourself ]
]
