Extension { #name : #LePage }

{ #category : #'*Lepiter-Tool' }
LePage >> printPageSummaryLimitedTo: aNumber [
	"Return a short textual representation of the content of the page"
	<return: #String>
	^ String 
		streamContents: [ :aStream | 
			self allChildrenBreadthFirstDo: [ :eachChild | 
				eachChild contentAsString asString
					do: [ :eachCharacter | 
						eachCharacter isLineSeparator
							ifTrue: [ aStream space ]
							ifFalse: [ aStream nextPut: eachCharacter ] ] ] ]
		limitedTo: aNumber
]

{ #category : #'*Lepiter-Tool' }
LePage >> spotterItemName [
	^ self isUnnamedPage
		ifTrue: [ self printPageSummaryLimitedTo: 50 ]
		ifFalse: [ self contentAsString ]
]
