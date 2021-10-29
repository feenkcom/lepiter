Extension { #name : #LeNullDatabase }

{ #category : #'*Lepiter-UI' }
LeNullDatabase >> asContentUIModel [
	^ LeDatabaseViewModel new database: self
]
