"
I have examples that are used to exemplify text example annotations and example snippets.
Please, DO NOT CHANGE this class comment.

I am a number of the following value: {{gtExample: LeUIDummyExamples >> #number | label=#yourself}}. I can also be displayed using embedded inspectors: {{gtExample: LeUIDummyExamples >> #number | noCode | previewHeight = 250 }}. 
"
Class {
	#name : #LeUIDummyExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Examples'
}

{ #category : #accessing }
LeUIDummyExamples >> number [
	<gtExample>
	<noTest>
	^ 42
]
