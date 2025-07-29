Trait {
	#name : #TLeInvalidCommentsConstraint,
	#category : #'Lepiter-Validator-Model'
}

{ #category : #examples }
TLeInvalidCommentsConstraint >> issues [
	| results packages |
	results := LePageValidatorMissingReferencesGroup new.
	packages := self packagesToAnalyse.
	packages do: [ :aPackage |  
		(aPackage definedClasses select: #hasComment) do: [ :aClass |
			| classCommentPage visitor missingReferences |
			classCommentPage := self pageForClassCommentOf: aClass.
			visitor := LeMissingCodeReferencesModelVisitor new.
			
			missingReferences := visitor missingReferencesInPage: classCommentPage.
			missingReferences isNotEmpty ifTrue: [ 
				results addMissingReferences: missingReferences ] ] ].
	^ results
]

{ #category : #accessing }
TLeInvalidCommentsConstraint >> packagesToAnalyse [
	self explicitRequirement
]

{ #category : #accessing }
TLeInvalidCommentsConstraint >> pageForClassCommentOf: aClass [
	| classComment |
	classComment := self
		forPharo12: [ aClass comment ]
		forPharo11AndPharo10: [ aClass organization classComment ].
		
	^ (LePage pharoCommentClassName: aClass name)
		addSnippet: (LeTextSnippet string: classComment);
		yourself
]
