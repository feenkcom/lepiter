Class {
	#name : #LeMissingCodeReferencesExamples,
	#superclass : #Object,
	#category : #'Lepiter-Validator-Examples'
}

{ #category : #examples }
LeMissingCodeReferencesExamples >> emptyMissingReferences [
	<gtExample>
	<return: #LePageValidatorMissingReferencesResult>
	| targetPage visitor missingReferences |
	targetPage := self pageWithNoMissingReferences.
	visitor := LeMissingCodeReferencesModelVisitor new.
	missingReferences := visitor missingReferencesInPage: targetPage.

	self assert: missingReferences isNotEmpty not.
	self assert: missingReferences exampleAnnotations size equals: 0.
	self assert: missingReferences methodAnnotations size equals: 0.
	self assert: missingReferences classAnnotations size equals: 0.

	^ missingReferences
]

{ #category : #examples }
LeMissingCodeReferencesExamples >> missingReferencesResultWithMissingClass [
	<gtExample>
	<return: #LePageValidatorMissingReferencesResult>
	| targetPage visitor missingReferences |
	targetPage := self pageWithMissingClassReference.
	visitor := LeMissingCodeReferencesModelVisitor new.
	missingReferences := visitor missingReferencesInPage: targetPage.

	self assert: missingReferences isNotEmpty.
	self assert: missingReferences exampleAnnotations size equals: 0.
	self assert: missingReferences methodAnnotations size equals: 0.
	self assert: missingReferences classAnnotations size equals: 1.

	^ missingReferences
]

{ #category : #examples }
LeMissingCodeReferencesExamples >> missingReferencesResultWithMissingMethod [
	<gtExample>
	<return: #LePageValidatorMissingReferencesResult>
	| targetPage visitor missingReferences |
	targetPage := self pageWithMissingMethodReference.
	visitor := LeMissingCodeReferencesModelVisitor new.
	missingReferences := visitor missingReferencesInPage: targetPage.

	self assert: missingReferences isNotEmpty.
	self assert: missingReferences exampleAnnotations size equals: 0.
	self assert: missingReferences methodAnnotations size equals: 1.
	self assert: missingReferences classAnnotations size equals: 0.

	^ missingReferences
]

{ #category : #examples }
LeMissingCodeReferencesExamples >> missingReferencesResultWithMultipleReferenceTypes [
	<gtExample>
	<return: #LePageValidatorMissingReferencesResult>
	| targetPage visitor missingReferences |
	targetPage := self pagesWithMultipleMissingReferences.
	visitor := LeMissingCodeReferencesModelVisitor new.
	missingReferences := visitor missingReferencesInPage: targetPage.

	self assert: missingReferences isNotEmpty.
	self assert: missingReferences exampleAnnotations size equals: 1.
	self assert: missingReferences methodAnnotations size equals: 1.
	self assert: missingReferences classAnnotations size equals: 1.

	^ missingReferences
]

{ #category : #accessing }
LeMissingCodeReferencesExamples >> pageWithMissingClassReference [
	| page |
	page := LePage named: 'Test'.
	page addSnippet: (LeTextSnippet string: '
	Present class annotation:
	{{gtClass:MissingClassReference}}
	
	Missing method in existing class:
	{{gtMethod:Class>>#name}}
').
	^ page
	
	

]

{ #category : #accessing }
LeMissingCodeReferencesExamples >> pageWithMissingMethodReference [
	| page |
	page := LePage named: 'Test'.
	page addSnippet: (LeTextSnippet string: '
	Present class annotation:
	{{gtClass:Object}}
	
	Missing method in existing class:
	{{gtMethod:LeMissingCodeReferencesExamples>>#missingMethodInExistingClass}}
').
	^ page
	
	

]

{ #category : #accessing }
LeMissingCodeReferencesExamples >> pageWithNoMissingReferences [
	| page |
	page := LePage named: 'Test'.
	page addSnippet: (LeTextSnippet string: '
	Present class annotation:
	{{gtClass:Object}}
	
	Missing method in existing class:
	{{gtMethod:Class>>#name}}
').
	^ page
	
	

]

{ #category : #accessing }
LeMissingCodeReferencesExamples >> pagesWithMultipleMissingReferences [
	| page |
	page := LePage named: 'Test'.
	page addSnippet: (LeTextSnippet string:  '
	Missing class annotation:
	{{gtClass:MissingClassAnnotation}}
	
	Missing method in existing class:
	{{gtMethod:LeMissingCodeReferencesExamples>>#missingMethodInExistingClass}}
	
	Missing example in existing class:
	{{gtExample:LeMissingCodeReferencesExamples>>#missingMethodInExistingClass}}
').
	^ page
	
	

]
