Class {
	#name : #LeSnippetStateExtractorExamples,
	#superclass : #Object,
	#category : #'Lepiter-History-Examples - State'
}

{ #category : #asserting }
LeSnippetStateExtractorExamples >> assertCommonStateAttributesFor: aState [
	self 
		assert: aState attributes size
		equals:  self commonStateAttributes size.
	self 
		assert:  (aState attributes collect: #attributeName) sorted
		equals: self commonStateAttributes
]

{ #category : #accessing }
LeSnippetStateExtractorExamples >> commonStateAttributes [
	^ #(createEmail createTime editEmail editTime)
]
