Extension { #name : #PyRootNode }

{ #category : #'*Lepiter-Python' }
PyRootNode >> isValueStatement [
	"Answer a boolean indicating whether the receiver represents a single statement, i.e. not a compound statement, function declarations, etc."
	
	^ false
]
