Extension { #name : 'LeTextualLink' }

{ #category : '*Lepiter-Store' }
LeTextualLink >> stonContainSubObjects [
	"Lepiter links are regenerated during loading, so don't need to be processed (and go into infinite recusion, anyway)"
	^ false
]
