Class {
	#name : #LeObjectReferenceAnnotationSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #examples }
LeObjectReferenceAnnotationSnippetExamples >> parseNewAttributes [
	<gtExample>
	| ast annotation |
	ast := LeParser
				parse: '{{gtObject:id=eehjmwhvkh4de3o55fyirb3fo|show=#gtViewsFor:|height=300|fallbackLabel=#missingWidget}}'.
	annotation := (ast // LeObjectReferenceAnnotationNode) anyOne.
	self assert: annotation uuid equals: 'eehjmwhvkh4de3o55fyirb3fo'.
	self assert: annotation showSelector equals: 'gtViewsFor:'.
	self assert: annotation heightValue equals: 300.
	self assert: annotation fallbackLabel equals: 'missingWidget'.
	^ast
]

{ #category : #examples }
LeObjectReferenceAnnotationSnippetExamples >> parseViaLeParser [
	<gtExample>
	| ast annotation |
	ast := LeParser
				parse: '{{gtObject:id=eehjmwhvkh4de3o55fyirb3fo|label=#gtDisplayString}}'.
	annotation := (ast // LeObjectReferenceAnnotationNode) anyOne.
	self assert: annotation notNil.
	self assert: annotation uuid equals: 'eehjmwhvkh4de3o55fyirb3fo'.
	self assert: annotation labelSelector equals: 'gtDisplayString'.
	^ast
]

{ #category : #fixtures }
LeObjectReferenceAnnotationSnippetExamples >> sampleId [
	^'eehjmwhvkh4de3o55fyirb3fo'
]

{ #category : #examples }
LeObjectReferenceAnnotationSnippetExamples >> styleSnippetWithFallbackLabel [
	<gtExample>
	| string text snippet snippetViewModel styler anAst |
	string := '{{gtObject:id=0000000000000000000000000|fallbackLabel=#missingWidget}}'.
	anAst := LeParser parse: string.
	snippet := LeTextSnippet new string: string.
	text := snippet text.
	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationSnippetExamples >> styleSnippetWithMissingObject [
	<gtExample>
	| string text snippet snippetViewModel styler anAst |
	string := '{{gtObject:id=0000000000000000000000000}}'.
	anAst := LeParser parse: string.
	snippet := LeTextSnippet new string: string.
	text := snippet text.
	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationSnippetExamples >> styleSnippetWithObjectAnnotation [
	<gtExample>
	| string text snippet snippetViewModel styler anAst |
	string := '{{gtObject:id=' , self sampleId , '}}'.
	anAst := LeParser parse: string.
	snippet := LeTextSnippet new string: string.
	text := snippet text.
	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationSnippetExamples >> styleSnippetWithObjectAnnotationAndLabel [
	<gtExample>
	| string text snippet snippetViewModel styler anAst |
	string := '{{gtObject:id=' , self sampleId , '|label=#size}}'.
	anAst := LeParser parse: string.
	snippet := LeTextSnippet new string: string.
	text := snippet text.
	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationSnippetExamples >> styleSnippetWithObjectAnnotationExpanded [
	<gtExample>
	| string text snippet snippetViewModel styler anAst |
	string := '{{gtObject:id=' , self sampleId , '|expanded=true}}'.
	anAst := LeParser parse: string.
	snippet := LeTextSnippet new string: string.
	text := snippet text.
	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^text
]

{ #category : #examples }
LeObjectReferenceAnnotationSnippetExamples >> styleSnippetWithShowAndHeight [
	<gtExample>
	| string text snippet snippetViewModel styler anAst |
	string := '{{gtObject:id=' , self sampleId
				, '|show=#gtViewsFor:|height=300|expanded=true}}'.
	anAst := LeParser parse: string.
	snippet := LeTextSnippet new string: string.
	text := snippet text.
	snippetViewModel := snippet asSnippetViewModel.
	styler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	styler style: text ast: anAst.
	^text
]
