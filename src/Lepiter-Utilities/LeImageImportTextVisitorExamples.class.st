"
I exemplify {{gtClass:LeImageImportTextVisitor}} on text snippets with annotations.
The visitor only looks for external image links, so it must skip annotations of any kind, see {{gtExample:LeImageImportTextVisitorExamples>>#textSnippetWithClassAnnotation}}.
"
Class {
	#name : #LeImageImportTextVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Utilities-Examples'
}

{ #category : #examples }
LeImageImportTextVisitorExamples >> textSnippetWithClassAnnotation [
	<gtExample>
	<return: #LeImageImportTextVisitor>
	| snippet visitor |
	snippet := LeTextSnippet string: 'See {{gtClass:LeDatabase}} for details'.
	visitor := LeImageImportTextVisitor new snippet: snippet.

	snippet ast acceptVisitor: visitor.

	self assert: visitor snippet equals: snippet.
	^ visitor

]
