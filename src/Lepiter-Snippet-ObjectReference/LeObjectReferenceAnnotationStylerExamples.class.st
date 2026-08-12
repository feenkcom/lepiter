Class {
	#name : #LeObjectReferenceAnnotationStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #private }
LeObjectReferenceAnnotationStylerExamples >> annotationRangeIn: aString [
	| start end |
	start := aString indexOfSubCollection: '{{'.
	end := (aString indexOfSubCollection: '}}') + 1.
	^start to: end
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> blElementRegistry [
	| element layout constraints |
	element := (BlElement new)
				size: 200 @ 100;
				background: Color blue.
	layout := BlLinearLayout horizontal.
	element layout: layout.
	constraints := element constraints.
	^(Dictionary new)
		at: self elementId put: element;
		at: self layoutId put: layout;
		at: self constraintsId put: constraints;
		yourself
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> constraintsId [
	^'24pfc2vvzgvus2luf91blfrl'
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> elementId [
	^'8jwnpw09gncfdy26uo4hzu9i9'
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> errorProneId [
	^'5fxjx7jsi3yv9fj2'
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> errorProneObject [
	^Object new
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> exampleStyler [
	<gtExample>
	| styler |
	styler := LeObjectReferenceExampleStyler new.
	styler objectRegistry: self sampleRegistry.
	self assert: (styler objectForId: self sampleId)
		equals: self sampleObject.
	self assert: (styler objectForId: self missingId) isNil.
	^styler
]

{ #category : #private }
LeObjectReferenceAnnotationStylerExamples >> hasAttribute: aClass inRange: aRange of: aText [
	^aRange anySatisfy: 
			[:index |
			(aText attributesAt: index)
				anySatisfy: [:attribute | attribute isKindOf: aClass]]
]

{ #category : #private }
LeObjectReferenceAnnotationStylerExamples >> labelForAnnotation: anAnnotationString withRegistry: aRegistry [
	| ast annotation object |
	ast := LeObjectReferenceAnnotationParser parse: anAnnotationString.
	annotation := ast.
	object := annotation uuid
				ifNotNil: [:uuid | aRegistry at: uuid ifAbsent: [nil]].
	^object
		ifNotNil: 
			[| selector |
			selector := annotation labelSelector ifNil: ['gtDisplayString'].
			[object perform: selector asSymbol] on: Error do: [:e | e printString]]
		ifNil: [annotation fallbackLabel ifNil: [annotation uuid]]
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> layoutId [
	^'84ugjevsvnrrvkbia8lx54m40'
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> missingId [
	^'0000000000000000000000000'
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> multiObjectRegistry [
	^(Dictionary new)
		at: self sampleId put: self sampleObject;
		at: self secondId put: self secondObject;
		yourself
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> sampleId [
	^'eehjmwhvkh4de3o55fyirb3fo'
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> sampleObject [
	^'Hello World'
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> sampleRegistry [
	^(Dictionary new)
		at: self sampleId put: self sampleObject;
		yourself
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> secondId [
	^'b5yuithd6w5dupmxayuz9ppkh'
]

{ #category : #fixtures }
LeObjectReferenceAnnotationStylerExamples >> secondObject [
	^42
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextDescribingBlElement [
	<gtExample>
	| styler text string range |
	styler := LeObjectReferenceExampleStyler new.
	styler objectRegistry: self blElementRegistry.
	string := 'A \{\{gtObject:id={1}|label=#gtDisplayString\}\} uses \{\{gtObject:id={2}|label=#class\}\} as its layout and \{\{gtObject:id={3}|label=#class\}\} as constraints.'
				format: 
					{self elementId.
					self layoutId.
					self constraintsId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self
		assert: (self hasAttribute: GtButtonAttribute inRange: range of: text).
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextDescribingBlElementExpanded [
	<gtExample>
	| styler text string range |
	styler := LeObjectReferenceExampleStyler new.
	styler objectRegistry: self blElementRegistry.
	string := 'Inspect the element: \{\{gtObject:id={1}|expanded=true\}\} and its layout: \{\{gtObject:id={2}|expanded=true\}\}'
				format: 
					{self elementId.
					self layoutId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self assert: (self
				hasAttribute: GtCachedTextExpandButtonAttribute
				inRange: range
				of: text).
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextExpanded [
	<gtExample>
	| styler text string range |
	styler := self exampleStyler.
	string := '\{\{gtObject:id={1}|expanded=true\}\}' format: {self sampleId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self
		assert: (self hasAttribute: GtButtonAttribute inRange: range of: text).
	self assert: (self
				hasAttribute: GtCachedTextExpandButtonAttribute
				inRange: range
				of: text).
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextMissingObject [
	<gtExample>
	| styler text string range foregroundAttr |
	styler := self exampleStyler.
	string := '\{\{gtObject:id={1}\}\}' format: {self missingId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	foregroundAttr := (text attributesAt: range first)
				detect: [:a | a isKindOf: BlTextForegroundAttribute].
	self assert: foregroundAttr paint
		equals: BrGlamorousColors linkWithErrorColor.
	self assert: (self labelForAnnotation: self missingId
				withRegistry: self sampleRegistry)
		equals: self missingId.
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithAllAttributes [
	<gtExample>
	| styler text string range |
	styler := self exampleStyler.
	string := '\{\{gtObject:id={1}|label=#size|show=#gtViewsFor:|height=300|expanded=true\}\}'
				format: {self sampleId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self
		assert: (self hasAttribute: GtButtonAttribute inRange: range of: text).
	self assert: (self
				hasAttribute: GtCachedTextExpandButtonAttribute
				inRange: range
				of: text).
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithFallbackLabel [
	<gtExample>
	| styler text string range foregroundAttr |
	styler := self exampleStyler.
	string := '\{\{gtObject:id={1}|fallbackLabel=#missingWidget\}\}'
				format: {self missingId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	foregroundAttr := (text attributesAt: range first)
				detect: [:a | a isKindOf: BlTextForegroundAttribute].
	self assert: foregroundAttr paint
		equals: BrGlamorousColors linkWithErrorColor.
	self
		assert: (self hasAttribute: GtButtonAttribute inRange: range of: text).
	self assert: (self
				labelForAnnotation: self missingId , '|fallbackLabel=#missingWidget'
				withRegistry: self sampleRegistry)
		equals: 'missingWidget'.
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithHeight [
	<gtExample>
	| styler text string range |
	styler := self exampleStyler.
	string := '\{\{gtObject:id={1}|height=300|expanded=true\}\}'
				format: {self sampleId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self assert: (self
				hasAttribute: GtCachedTextExpandButtonAttribute
				inRange: range
				of: text).
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithLabel [
	<gtExample>
	| styler text string range |
	styler := self exampleStyler.
	string := '\{\{gtObject:id={1}|label=#size\}\}' format: {self sampleId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self
		assert: (self hasAttribute: GtButtonAttribute inRange: range of: text).
	self assert: (self labelForAnnotation: self sampleId , '|label=#size'
				withRegistry: self sampleRegistry)
		equals: 11.
	^text
]

{ #category : #running }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithLabelError [
	<gtExample>
	| styler text string registry range |
	registry := (Dictionary new)
				at: self errorProneId put: self errorProneObject;
				yourself.
	styler := LeObjectReferenceExampleStyler new.
	styler objectRegistry: registry.
	string := '\{\{gtObject:id={1}|label=#thisWillFail\}\}'
				format: {self errorProneId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self
		assert: (self hasAttribute: GtButtonAttribute inRange: range of: text).
	self
		assert: ((self
				labelForAnnotation: self errorProneId , '|label=#thisWillFail'
				withRegistry: registry) includesSubstring: 'did not understand').
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithMultipleObjects [
	<gtExample>
	| styler text string |
	styler := LeObjectReferenceExampleStyler new.
	styler objectRegistry: self multiObjectRegistry.
	string := 'See \{\{gtObject:id={1}\}\} and also \{\{gtObject:id={2}\}\} here.'
				format: 
					{self sampleId.
					self secondId}.
	text := string asRopedText.
	styler style: text.
	self assert: (self
				hasAttribute: GtButtonAttribute
				inRange: (5 to: 5 + self sampleId size + 14)
				of: text).
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithMultipleObjectsAndLabels [
	<gtExample>
	| styler text string |
	styler := LeObjectReferenceExampleStyler new.
	styler objectRegistry: self multiObjectRegistry.
	string := 'First: \{\{gtObject:id={1}|label=#size\}\} second: \{\{gtObject:id={2}|label=#printString\}\}'
				format: 
					{self sampleId.
					self secondId}.
	text := string asRopedText.
	styler style: text.
	self assert: (self
				hasAttribute: GtButtonAttribute
				inRange: (8 to: 8 + self sampleId size + 26)
				of: text).
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithObject [
	<gtExample>
	| styler text string range |
	styler := self exampleStyler.
	string := '\{\{gtObject:id={1}\}\}' format: {self sampleId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self
		assert: (self hasAttribute: GtButtonAttribute inRange: range of: text).
	self assert: (self
				hasAttribute: GtCachedTextExpandButtonAttribute
				inRange: range
				of: text).
	self assert: (self labelForAnnotation: self sampleId
				withRegistry: self sampleRegistry)
		equals: 'Hello World'.
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithShow [
	<gtExample>
	| styler text string range |
	styler := self exampleStyler.
	string := '\{\{gtObject:id={1}|show=#gtViewsFor:|expanded=true\}\}'
				format: {self sampleId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self assert: (self
				hasAttribute: GtCachedTextExpandButtonAttribute
				inRange: range
				of: text).
	^text
]

{ #category : #running }
LeObjectReferenceAnnotationStylerExamples >> styledTextWithShowItems [
	<gtExample>
	| styler text string range |
	styler := self exampleStyler.
	string := '\{\{gtObject:id={1}|show=#gtItemsFor:|expanded=true\}\}'
				format: {self sampleId}.
	text := string asRopedText.
	styler style: text.
	range := self annotationRangeIn: string.
	self
		assert: (self hasAttribute: BlTextForegroundAttribute inRange: range of: text).
	self assert: (self
				hasAttribute: GtCachedTextExpandButtonAttribute
				inRange: range
				of: text).
	self
		assert: (self
				labelForAnnotation: self sampleId , '|show=#gtItemsFor:|expanded=true'
				withRegistry: self sampleRegistry) = 'Hello World'.
	^text
]
