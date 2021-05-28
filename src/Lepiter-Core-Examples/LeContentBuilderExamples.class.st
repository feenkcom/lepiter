Class {
	#name : #LeContentBuilderExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Builder'
}

{ #category : #'examples - basic' }
LeContentBuilderExamples >> basicDatabase [
	<gtExample>
	| aDatabase |
	aDatabase := LeDatabase new.
	self assert: aDatabase size equals: 0.
	^ aDatabase
]

{ #category : #'examples - basic' }
LeContentBuilderExamples >> database [
	<gtExample>
	| aDatabase |
	aDatabase := self basicDatabase.
	aDatabase userEmail: self userEmailString.
	self assert: aDatabase userEmail equals: self userEmail.
	^ aDatabase
]

{ #category : #'examples - basic' }
LeContentBuilderExamples >> userEmail [
	<gtExample>
	^ LeEmail new 
		email: self userEmailString
]

{ #category : #accessing }
LeContentBuilderExamples >> userEmailString [
	^ 'my@email.com'
]
