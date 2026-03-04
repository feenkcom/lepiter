"
I contain examples for {{gtClass:name=LeTodoSnippet}}.
"
Class {
	#name : #LeTodoSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Todo'
}

{ #category : #examples }
LeTodoSnippetExamples >> todoSnippetDefaultState [
	<gtExample>
	| snippet |
	snippet := LeTodoSnippet new.
	self assert: snippet state equals: #todo.
	^ snippet
]

{ #category : #examples }
LeTodoSnippetExamples >> todoSnippetStateChange [
	<gtExample>
	| snippet |
	snippet := LeTodoSnippet new.
	snippet state: #done.
	self assert: snippet state equals: #done.
	^ snippet
]

{ #category : #examples }
LeTodoSnippetExamples >> todoSnippetViewModel [
	<gtExample>
	| snippet viewModel |
	snippet := LeTodoSnippet new.
	viewModel := snippet asSnippetViewModel.
	self assert: viewModel state equals: #todo.
	^ viewModel
]
