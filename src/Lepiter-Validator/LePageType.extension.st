Extension { #name : #LePageType }

{ #category : #'*Lepiter-Validator' }
LePageType >> asPageValidatorPhlowTool [
	<return: #GtPhlowTool>
	^ LePagePhlowTool page: self page
]
