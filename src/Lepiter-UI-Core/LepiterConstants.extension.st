Extension { #name : #LepiterConstants }

{ #category : #'*Lepiter-UI-Core' }
LepiterConstants class >> alignmentTypes [
	^ AlignmentStrategy allSubclasses collect: #strategyName
]

{ #category : #'*Lepiter-UI-Core' }
LepiterConstants class >> defaultAlignment [
	^ ParagraphWidthAlignmentStrategy strategyName.
]
