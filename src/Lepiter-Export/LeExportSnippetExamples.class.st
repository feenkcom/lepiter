Class {
	#name : #LeExportSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotation [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtExample:', BrExamplesShowroom name, ' >> #', #glamorousLargeButton, '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotationWithLabel [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtExample:', BrExamplesShowroom name, ' >> #', #glamorousLargeButton, ' | label=#printString}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotationWithPreviewExpanded [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtExample:', BrExamplesShowroom name, ' >> #', #glamorousLargeButton, ' | previewExpanded=true}}'.

	^ snippet
]
