Class {
	#name : #LeChangeExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Refactoring'
}

{ #category : #'as yet unclassified' }
LeChangeExamples >> addSnippetBeforeChange [
	<gtExample>
	| change page snippet childrenCount undo |
	page := self examplePage.
	change := LeAddSnippetChange
			text: 'This is a new snippet'
			in: page
			before: page children first.
	childrenCount := page childrenCount.
	undo := change execute.
	snippet := change snippet.
	self assert: page childrenCount equals: childrenCount + 1.
	self assert: (page children at: 1) equals: snippet.
	self assert: undo class equals: LeRemoveSnippetChange.
	undo execute execute.
	self assert: page childrenCount equals: childrenCount + 1.
	self assert: (page children at: 1) equals: snippet.
	^ change
]

{ #category : #'as yet unclassified' }
LeChangeExamples >> addSnippetBeforeNamespace [
	<gtExample>
	| ns |
	ns := GtRBNamespace new.
	ns changes addChange: self addSnippetBeforeChange.
	^ ns
]

{ #category : #'as yet unclassified' }
LeChangeExamples >> addSnippetChange [
	<gtExample>
	| change page snippet childrenCount undo |
	page := self examplePage.
	change := LeAddSnippetChange text: 'This is a new snippet' in: page.
	childrenCount := page childrenCount.
	undo := change execute.
	snippet := change snippet.
	self assert: page childrenCount equals: childrenCount + 1.
	self assert: (page children at: childrenCount + 1) equals: snippet.
	self assert: undo class equals: LeRemoveSnippetChange.
	undo execute execute.
	self assert: page childrenCount equals: childrenCount + 1.
	self assert: (page children at: childrenCount + 1) equals: snippet.
	^ change
]

{ #category : #'as yet unclassified' }
LeChangeExamples >> addSnippetNamespace [
	<gtExample>
	| ns |
	ns := GtRBNamespace new.
	ns changes addChange: self addSnippetChange.
	^ ns
]

{ #category : #'as yet unclassified' }
LeChangeExamples >> examplePage [
	^ (LePage named: 'Some page')
		addSnippet: (LeTextSnippet new
				string: 'This is an example page';
				yourself);
		yourself
]

{ #category : #'as yet unclassified' }
LeChangeExamples >> removeFirstSnippetChange [
	<gtExample>
	| change page snippet childrenCount undo |
	page := self addSnippetBeforeChange parent.
	snippet := page children first.
	change := LeRemoveSnippetChange new snippet: snippet.
	childrenCount := page childrenCount.
	undo := change execute.
	snippet := change snippet.
	self assert: page childrenCount equals: childrenCount - 1.
	self assert: (page children includes: snippet) not.
	self assert: undo class equals: LeAddSnippetChange.
	undo execute execute.
	self assert: page childrenCount equals: childrenCount - 1.
	self assert: (page children includes: snippet) not.
	^ change
]

{ #category : #'as yet unclassified' }
LeChangeExamples >> removeFirstSnippetNamespace [
	<gtExample>
	| ns |
	ns := GtRBNamespace new.
	ns changes addChange: self removeFirstSnippetChange.
	^ ns
]

{ #category : #'as yet unclassified' }
LeChangeExamples >> removeSnippetChange [
	<gtExample>
	| change page snippet childrenCount undo |
	page := self addSnippetChange parent.
	snippet := page children last.
	change := LeRemoveSnippetChange new snippet: snippet.
	childrenCount := page childrenCount.
	undo := change execute.
	snippet := change snippet.
	self assert: page childrenCount equals: childrenCount - 1.
	self assert: (page children includes: snippet) not.
	self assert: undo class equals: LeAddSnippetChange.
	undo execute execute.
	self assert: page childrenCount equals: childrenCount - 1.
	self assert: (page children includes: snippet) not.
	^ change
]

{ #category : #'as yet unclassified' }
LeChangeExamples >> removeSnippetNamespace [
	<gtExample>
	| ns |
	ns := GtRBNamespace new.
	ns changes addChange: self removeSnippetChange.
	^ ns
]
