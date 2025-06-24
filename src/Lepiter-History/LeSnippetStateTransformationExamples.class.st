Class {
	#name : #LeSnippetStateTransformationExamples,
	#superclass : #Object,
	#category : #'Lepiter-History-Examples - State'
}

{ #category : #asserting }
LeSnippetStateTransformationExamples >> asserTransformedTextualSnippetFor: aStateAttribute [
	self assert: aStateAttribute shouldTransformForLogStorage not.
	self assert: aStateAttribute source isNil.
	self assert: aStateAttribute string equals: self stringValue. 
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> genericAttributeWithSource [
	<gtExample>
	<return: #LeGenericSnippetStateAttribute>
	| attribute |
	attribute := LeGenericSnippetStateAttribute new
			attributeName: 'test_string';
			attributeValue: self stringValue.

	self assert: attribute shouldTransformForLogStorage not.

	^ attribute
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> genericAttributeWithSource_transformed [
	<gtExample>
	<return: #LeGenericSnippetStateAttribute>
	| initialAttribute transformedAttribute |
	initialAttribute := self genericAttributeWithSource.
	transformedAttribute := initialAttribute asAttributeForLogStorage.

	self
		assert: initialAttribute identityHash
		equals: transformedAttribute identityHash.

	^ transformedAttribute
]

{ #category : #'examples - state' }
LeSnippetStateTransformationExamples >> stateWithMultipleAttributes [
	<gtExample>
	<return: #LeGenericSnippetState>
	| state |
	state := LeGenericSnippetState new.
	state addAttribute: self genericAttributeWithSource.
	state addAttribute: self stringAttributeWithSource.
	state
		addAttribute: (self stringAttributeWithoutSource attributeName: 'string2').
	state addAttribute: (self textAttributeWithSource attributeName: 'test1').
	state addAttribute: (self textAttributeWithoutSource attributeName: 'text2').

	self assert: state attributesCount equals: 5.
	self assert: state shouldTransformForLogStorage.

	^ state
]

{ #category : #'examples - state' }
LeSnippetStateTransformationExamples >> stateWithMultipleAttributes_transformed [
	<gtExample>
	<return: #LeGenericSnippetState>
	| initialState transfomedState |
	initialState := self stateWithMultipleAttributes.
	transfomedState := initialState asStateForLogStorage.

	self assert: (initialState = transfomedState) not.
	self assert: transfomedState shouldTransformForLogStorage not.

	self assert: transfomedState attributesCount equals: 5.

	^ transfomedState
]

{ #category : #'examples - state' }
LeSnippetStateTransformationExamples >> stateWithStringAttributeWithSource [
	<gtExample>
	<return: #LeGenericSnippetState>
	| state |
	state := LeGenericSnippetState new.
	state addAttribute: self stringAttributeWithSource.

	self assert: state attributesCount equals: 1.
	self assert: state shouldTransformForLogStorage.

	^ state
]

{ #category : #'examples - state' }
LeSnippetStateTransformationExamples >> stateWithStringAttributeWithSource_transformed [
	<gtExample>
	<return: #LeGenericSnippetState>
	| initialState transfomedState |
	initialState := self stateWithStringAttributeWithSource.
	transfomedState := initialState asStateForLogStorage.

	self assert: initialState equals: transfomedState.
	self assert: transfomedState shouldTransformForLogStorage not.

	self assert: transfomedState attributes first source isNil.

	^ transfomedState
]

{ #category : #'examples - state' }
LeSnippetStateTransformationExamples >> stateWithTwoGenericAttributes [
	<gtExample>
	<return: #LeGenericSnippetState>
	| state |
	state := LeGenericSnippetState new.
	state addAttribute: self genericAttributeWithSource.
	state
		addAttribute: (LeGenericSnippetStateAttribute new
				attributeName: 'test_int';
				attributeValue: 42).

	self assert: state attributesCount equals: 2.
	self assert: state shouldTransformForLogStorage not.

	^ state
]

{ #category : #'examples - state' }
LeSnippetStateTransformationExamples >> stateWithTwoGenericAttributes_transformed [
	<gtExample>
	<return: #LeGenericSnippetState>
	| initialState transfomedState |
	initialState := self stateWithTwoGenericAttributes.
	transfomedState := initialState asStateForLogStorage.

	self assert: initialState equals: transfomedState.
	self assert: transfomedState shouldTransformForLogStorage not.

	^ transfomedState
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> stringAttributeWithSource [
	<gtExample>
	<return: #LeTextualSnippetStringAttribute>
	| attribute |
	attribute := LeTextualSnippetStringAttribute new
			string: self stringValue;
			source: Object new.

	self assert: attribute shouldTransformForLogStorage.

	^ attribute
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> stringAttributeWithSource_transformed [
	<gtExample>
	<return: #LeTextualSnippetStringAttribute>
	| initialAttribute transformedAttribute |
	initialAttribute := self stringAttributeWithSource.
	transformedAttribute := initialAttribute asAttributeForLogStorage.

	self asserTransformedTextualSnippetFor: transformedAttribute.
	self assert: initialAttribute equals: transformedAttribute.

	^ transformedAttribute
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> stringAttributeWithoutSource [
	<gtExample>
	<return: #LeTextualSnippetStringAttribute>
	| attribute |
	attribute := LeTextualSnippetStringAttribute new
			string: 'abc';
			source: nil.

	self assert: attribute shouldTransformForLogStorage not.

	^ attribute
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> stringAttributeWithoutSource_transformed [
	<gtExample>
	<return: #LeTextualSnippetStringAttribute>
	| initialAttribute transformedAttribute |
	initialAttribute := self stringAttributeWithoutSource.
	transformedAttribute := initialAttribute asAttributeForLogStorage.

	self asserTransformedTextualSnippetFor: transformedAttribute.
	self assert: initialAttribute equals: transformedAttribute.

	^ transformedAttribute
]

{ #category : #accessing }
LeSnippetStateTransformationExamples >> stringValue [
	^ 'abc'
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> textAttributeWithSource [
	<gtExample>
	<return: #LeTextualSnippetTextAttribute>
	| attribute |
	attribute := LeTextualSnippetTextAttribute new
			text: 'abc' asRopedText;
			source: Object new.

	self assert: attribute shouldTransformForLogStorage.

	^ attribute
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> textAttributeWithSource_transformed [
	<gtExample>
	<return: #LeTextualSnippetStringAttribute>
	| initialAttribute transformedAttribute |
	initialAttribute := self textAttributeWithSource.
	transformedAttribute := initialAttribute asAttributeForLogStorage.

	self asserTransformedTextualSnippetFor: transformedAttribute.
	self assert: (initialAttribute = transformedAttribute) not.

	^ transformedAttribute
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> textAttributeWithoutSource [
	<gtExample>
	<return: #LeTextualSnippetTextAttribute>
	| attribute |
	attribute := LeTextualSnippetTextAttribute new
			text: 'abc' asRopedText;
			source: nil.

	self assert: attribute shouldTransformForLogStorage.

	^ attribute
]

{ #category : #'examples - attributes' }
LeSnippetStateTransformationExamples >> textAttributeWithoutSource_transformed [
	<gtExample>
	<return: #LeTextualSnippetStringAttribute>
	| initialAttribute transformedAttribute |
	initialAttribute := self textAttributeWithoutSource.
	transformedAttribute := initialAttribute asAttributeForLogStorage.

	self asserTransformedTextualSnippetFor: transformedAttribute.
	self assert: (initialAttribute = transformedAttribute) not.

	^ transformedAttribute
]
