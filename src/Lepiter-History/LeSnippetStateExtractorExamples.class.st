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

{ #category : #'examples - common state' }
LeSnippetStateExtractorExamples >> extractCommonStateEmptyPharoSnippet [
	<gtExample>
	| state |
	
	state := LePharoSnippet empty extractCommonState.
	self assertCommonStateAttributesFor: state.
	state attributes do: [ :anAttribute |
		self assert: anAttribute attributeValue isNil ].
	
	^ state
]

{ #category : #'examples - common state' }
LeSnippetStateExtractorExamples >> extractCommonStateEmptyTextSnippet [
	<gtExample>
	| state |
	
	state := LeTextSnippet empty extractCommonState.
	self assertCommonStateAttributesFor: state.
	state attributes do: [ :anAttribute |
		self assert: anAttribute attributeValue isNil ].
	
	^ state
]

{ #category : #'examples - common state' }
LeSnippetStateExtractorExamples >> extractCommonStateForAllEmptySnippetTypes [
	<gtExample>
	
	^ (LeSnippet allSubclasses reject: #isAbstract)
		collect: [ :aSnippetClass |
			| snippet state |
			snippet := aSnippetClass empty.
			state := snippet extractCommonState.
			
			self assertCommonStateAttributesFor: state.
			state attributes do: [ :anAttribute |
				self assert: anAttribute attributeValue isNil ].
			
			snippet -> state ]
]

{ #category : #'examples - common state' }
LeSnippetStateExtractorExamples >> extractCommonStateForAllSnippetTypes [
	<gtExample>
	| createEmail createTime editEmail editTime |
	createEmail := 'unknown@email.com'.
	createTime := DateAndTime now.
	editEmail := 'unknown@email.com'. 
	editTime := createTime + 1 second.
	
	^ (LeSnippet allSubclasses reject: #isAbstract)
		collect: [ :aSnippetClass |
			| snippet state |.
			snippet := aSnippetClass empty
				createEmail: createEmail;
				createTime: createTime;
				editEmail: editEmail;
				editTime: editTime.
			state := snippet extractCommonState.
			self 
				assert: (state attributeNamed: 'createEmail') attributeValue
				equals: createEmail.
			self 
				assert: (state attributeNamed: 'createTime') attributeValue
				equals: createTime.
			self 
				assert: (state attributeNamed: 'editEmail') attributeValue
				equals: editEmail.
			self 
				assert: (state attributeNamed: 'editTime') attributeValue
				equals: editTime.
			snippet -> state ]
]

{ #category : #'examples - state' }
LeSnippetStateExtractorExamples >> extractSpecificStateForAllEmptySnippetTypes [
	<gtExample>
	
	^ (LeSnippet allSubclasses reject: #isAbstract)
		collect: [ :aSnippetClass |
			| snippet state |.
			snippet := aSnippetClass empty.
			state := snippet extractSpecificState.
			self 
				assert: state attributesCount 
				equals: (aSnippetClass leJsonV4AttributeMapping size 
					- LeSnippet leJsonV4AttributeMapping size).
			snippet -> state ]
]

{ #category : #'examples - state' }
LeSnippetStateExtractorExamples >> extractSpecificStatePharoSnippet [
	<gtExample>
	| state |
	
	state := (LePharoSnippet code: '1') extractSpecificState.
	self 
		assert:  (state attributes collect: #attributeName) sorted
		equals: #(code).
		
	self assert: (state attributeNamed: 'code') attributeValue equals: '1'.
		
	^ state
]

{ #category : #'examples - state' }
LeSnippetStateExtractorExamples >> extractSpecificStateTextSnippet [
	<gtExample>
	| state |
	
	state := (LeTextSnippet string: 'a') extractSpecificState.
	self 
		assert:  (state attributes collect: #attributeName) sorted
		equals: #(paragraphStyle string).
	
	self 
		assert: (state attributeNamed: 'string') attributeValue 
		equals: 'a'.
		
	^ state
]
