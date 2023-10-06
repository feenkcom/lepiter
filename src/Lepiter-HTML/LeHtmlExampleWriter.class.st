Class {
	#name : #LeHtmlExampleWriter,
	#superclass : #Object,
	#instVars : [
		'html',
		'sequencer',
		'resources',
		'width'
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
LeHtmlExampleWriter >> resources [
	<return: #LeExportSnippetResources>
	^ resources
]

{ #category : #accessing }
LeHtmlExampleWriter >> resources: someResources [
	resources := someResources
]

{ #category : #accessing }
LeHtmlExampleWriter >> sequencer [
	^ sequencer
]

{ #category : #accessing }
LeHtmlExampleWriter >> sequencer: anObject [
	sequencer := anObject
]

{ #category : #accessing }
LeHtmlExampleWriter >> width [
	^ width
]

{ #category : #accessing }
LeHtmlExampleWriter >> width: anObject [
	width := anObject
]

{ #category : #'api - writing' }
LeHtmlExampleWriter >> write [
	resources 
		ifEmpty: [ "ignore" ] 
		ifOne: [ :aResource |
			aResource wantsCodeOutput ifTrue: [ self writeCode ].
			aResource wantsPreviewOutput ifTrue: [ self writePreview ] ] 
		ifMore: [ :aCollection | 
			aCollection anyOne wantsCodeOutput ifTrue: [ self writeCode ].
			aCollection anyOne wantsPreviewOutput ifTrue: [ self writePreview ] ].
]

{ #category : #'api - writing' }
LeHtmlExampleWriter >> writeCode [
	| anyResource |
	resources 
		ifEmpty: [ "ignore" ] 
		ifOne: [ :aResource | anyResource := aResource ] 
		ifMore: [ :aCollection | anyResource := aCollection anyOne ].
		
	anyResource ifNil: [ ^ self ].

	html 
		tag: #div
		attributes: {'class' . 'snippet textual-snippet code-snippet pharo-snippet ', self width cssClass}
		do: [ 
			 html 
				tag: #pre
				attributes: #('class' 'no_bottom_margin') 
				with: anyResource sourceCode
		].
]

{ #category : #'api - writing' }
LeHtmlExampleWriter >> writePreview [
	resources 
		ifEmpty: [ "ignore" ]
		ifOne: [ :aResource |
			LeHtmlFigureImageWriter new
				html: html;
				imageSrc: aResource pathName;
				width: self width;
				write ]
		ifMore: [ :aCollection |
			LeHtmlCarouselWriter new
				html: html;
				sequencer: sequencer;
				resources: aCollection;
				write ].
]
