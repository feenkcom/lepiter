Class {
	#name : #LeContentBuilderExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Builder'
}

{ #category : #'examples - basic' }
LeContentBuilderExamples >> basicDatabase [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := LeDatabase new.
	self assert: aDatabase size equals: 0.
	^ aDatabase
]

{ #category : #'examples - basic' }
LeContentBuilderExamples >> database [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self basicDatabase.
	aDatabase userEmail: self userEmailString.
	self assert: aDatabase userEmail equals: self userEmail.
	^ aDatabase
]

{ #category : #'examples - basic' }
LeContentBuilderExamples >> userEmail [
	<gtExample>
	<return: #LeEmail>
	^ LeEmail new email: self userEmailString
]

{ #category : #accessing }
LeContentBuilderExamples >> userEmailString [
	^ 'my@email.com'
]
