Extension { #name : #LePharoClassDatabase }

{ #category : #'*Lepiter-Snippet-Text' }
LePharoClassDatabase >> pageNamed: aSymbol [

	^ pagesByName at: aSymbol ifAbsentPut:
		[ 
			| targetClass classComment |
			targetClass := self class environment at: aSymbol.
			classComment := self 
				forPharo12: [
					targetClass instanceSide comment ] 
				forPharo11AndPharo10: [ 
					targetClass instanceSide organization classComment ].
			
				(LePage pharoCommentClassName: aSymbol)
			addSnippet: (LeTextSnippet string: classComment);
			yourself ]
]
