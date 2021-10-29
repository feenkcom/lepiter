Extension { #name : #LePages }

{ #category : #'*Lepiter-UI' }
LePages >> asToolElement [
	^ LeDatabaseToolElement new
		margin: (BlInsets all: 10);
		database: self;
		matchParent
]
