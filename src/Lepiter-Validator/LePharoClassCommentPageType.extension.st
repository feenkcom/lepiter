Extension { #name : #LePharoClassCommentPageType }

{ #category : #'*Lepiter-Validator' }
LePharoClassCommentPageType >> asPageValidatorPhlowTool [
	<return: #GtPhlowTool>
	^ self class environment
		at: self pharoClassName
		ifPresent: [ :aClass | GtClassCoderTool forClass: aClass ]
		ifAbsent: [ LePagePhlowTool page: self page ]
]
