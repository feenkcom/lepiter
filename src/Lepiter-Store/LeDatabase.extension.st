Extension { #name : #LeDatabase }

{ #category : #'*Lepiter-Store' }
LeDatabase >> clearReloadReason [
	self clearOption: #reloadReason ifAbsent: [  "ignore" ]
]

{ #category : #'*Lepiter-Store' }
LeDatabase >> reloadReason [
	^ self optionAt: #reloadReason ifAbsent: [ nil ]
]

{ #category : #'*Lepiter-Store' }
LeDatabase >> reloadReason: aReason [
	^ self optionAt: #reloadReason put: aReason
]
