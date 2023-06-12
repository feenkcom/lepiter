Class {
	#name : #LeHtmlTextSnippetWordAnnotationWriter,
	#superclass : #Object,
	#instVars : [
		'context',
		'snippet',
		'annotation',
		'response'
	],
	#category : #'Lepiter-Snippet-Words'
}

{ #category : #accessing }
LeHtmlTextSnippetWordAnnotationWriter >> annotation [
	^ annotation
]

{ #category : #accessing }
LeHtmlTextSnippetWordAnnotationWriter >> annotation: anObject [
	annotation := anObject
]

{ #category : #accessing }
LeHtmlTextSnippetWordAnnotationWriter >> context [
	^ context
]

{ #category : #accessing }
LeHtmlTextSnippetWordAnnotationWriter >> context: anObject [
	context := anObject
]

{ #category : #'private - writing' }
LeHtmlTextSnippetWordAnnotationWriter >> requestExplanation [
	LeWordClient sync
		onResponse: [ :theResponse | 
			response := theResponse ];
		explanation: annotation word
]

{ #category : #accessing }
LeHtmlTextSnippetWordAnnotationWriter >> snippet [
	^ snippet
]

{ #category : #accessing }
LeHtmlTextSnippetWordAnnotationWriter >> snippet: anObject [
	snippet := anObject
]

{ #category : #'api - writing' }
LeHtmlTextSnippetWordAnnotationWriter >> write [
	self requestExplanation.

	response isSuccess
		ifTrue: [ self writeExplanation ]
]

{ #category : #'private - writing' }
LeHtmlTextSnippetWordAnnotationWriter >> writeExplanation [
	context html 
		tag: #div
		class: 'text-snippet-annotation word-annotation-content'
		do: [
			LeWordExplanationHtmlBuilder new
				explanation: response explanation;
				context: context;
				build ]
]
