Class {
	#name : #LePageBuilderExamples,
	#superclass : #LeContentBuilderExamples,
	#category : #'Lepiter-Core-Examples-Builder'
}

{ #category : #'examples - basic' }
LePageBuilderExamples >> basicBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := LePage builder.
	^ aBuilder
]

{ #category : #'examples - pages' }
LePageBuilderExamples >> basicPage [
	<gtExample>
	| aBuilder aPage |
	aBuilder := self basicBuilder.
	aPage := aBuilder build.
	self assert: aPage class equals: LePage.
	^ aPage
]
