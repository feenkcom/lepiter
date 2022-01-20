Extension { #name : #LePage }

{ #category : #'*Lepiter-Parser' }
LePage >> hasGtTodo [

	"Report whether this page has a todo.
	Useful for finding all todos in a lepiter database:
		thisSnippet database pages  select: #hasGtTodo
	"

	^ (self deep: #children select: [ :child | 
		   (child isKindOf: LeTextSnippet) and: [ 
			   (child ast // #LeTodoAnnotationNode) notEmpty ] ]) notEmpty
]

{ #category : #'*Lepiter-Parser' }
LePage >> hasUncompletedGtTodo [

	"Report whether this page has a todo.
	Useful for finding all uncompleted todos in a lepiter database:
		thisSnippet database pages  select: #hasUncompletedGtTodo
	"

	^ (self deep: #children select: [ :child | 
		   (child isKindOf: LeTextSnippet) and: [ 
			   child ast // #LeTodoAnnotationNode anySatisfy: [ :todo | 
				   todo isCompleted not ] ] ]) notEmpty
]
