Class {
	#name : #LeHtmlExampleWriter,
	#superclass : #Object,
	#instVars : [
		'html',
		'sequencer',
		'resource'
	],
	#category : #'Lepiter-HTML-Writers'
}

{ #category : #accessing }
LeHtmlExampleWriter >> html [
	^ html
]

{ #category : #accessing }
LeHtmlExampleWriter >> html: anObject [
	html := anObject
]

{ #category : #accessing }
LeHtmlExampleWriter >> resource [
	^ resource
]

{ #category : #convenience }
LeHtmlExampleWriter >> resource: aResource [
	resource := aResource
]

{ #category : #accessing }
LeHtmlExampleWriter >> sequencer [
	^ sequencer
]

{ #category : #accessing }
LeHtmlExampleWriter >> sequencer: anObject [
	sequencer := anObject
]

{ #category : #'api - writing' }
LeHtmlExampleWriter >> write [
	html 
		tag: #div
		class: 'example_annotation'
		do: [
			html 
				tag: #div
				class: 'example_display'
				do: [
					resource wantsCodeOutput ifTrue: [ 
						self writeCode ].

					resource wantsPreviewOutput ifTrue: [ 
						self writePreview ] ] ]
]

{ #category : #'api - writing' }
LeHtmlExampleWriter >> writeCode [
	html 
		tag: #div
		class: 'example_definition'
		do: [ 
			html 
				tag: #figure
				class: 'codeBlock gtexample-src paragraphWidth'
				do: [
					html 
						tag: #pre
						do: [ 
							html 
								tag: #code
								class: 'hljs smalltalk'
								with: resource sourceCode
						]
				]
		]
]

{ #category : #'api - writing' }
LeHtmlExampleWriter >> writePreview [
	LeHtmlFigureImageWriter new
		html: html;
		imageSrc: resource pathName;
		write
]
