"
I exemplify {{gtClass:LeJsonV4000SnippetVisitor}}, which rewrites block links of snippets stored in the version 4.0 format.
Annotations are left untouched, see {{gtExample:LeJsonV4000SnippetVisitorExamples>>#snippetStringWithClassAnnotation}}.
"
Class {
	#name : #LeJsonV4000SnippetVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #examples }
LeJsonV4000SnippetVisitorExamples >> snippetStringWithClassAnnotation [
	<gtExample>
	<return: #LeJsonV4000SnippetVisitor>
	| aString visitor |
	aString := 'See {{gtClass:LeDatabase}} for details'.
	visitor := LeJsonV4000SnippetVisitor new
			updater: LeJsonV4000Updater new;
			snippetString: aString.

	(LeParser parseWithErrors: aString) acceptVisitor: visitor.

	self assert: visitor updatedSnippetString equals: aString.
	^ visitor

]
