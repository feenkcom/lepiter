Class {
	#name : #LeHtmlFigureImageWriter,
	#superclass : #Object,
	#instVars : [
		'imageSrc',
		'caption',
		'html'
	],
	#category : #'Lepiter-HTML-Writers'
}

{ #category : #accessing }
LeHtmlFigureImageWriter >> caption [
	^ caption
]

{ #category : #accessing }
LeHtmlFigureImageWriter >> caption: anObject [
	caption := anObject
]

{ #category : #accessing }
LeHtmlFigureImageWriter >> html [
	^ html
]

{ #category : #accessing }
LeHtmlFigureImageWriter >> html: anObject [
	html := anObject
]

{ #category : #accessing }
LeHtmlFigureImageWriter >> imageSrc [
	^ imageSrc
]

{ #category : #accessing }
LeHtmlFigureImageWriter >> imageSrc: anObject [
	imageSrc := anObject
]

{ #category : #'api - writing' }
LeHtmlFigureImageWriter >> write [
	html
		tag: #figure
		attributes: #('class' 'snippet picture-snippet paragraphWidth')
		do: [

			html
				inlineTag: 'img'
				attributes: {'class'. 'picture-snippet-image'. 'src'. imageSrc }.

			(caption isNotNil
				and: [ caption trimBoth isNotEmpty ])
					ifTrue: [ 
						self html
							inlineTag: 'figcaption'
							attributes: #('class' 'picture-snippet-caption')
							with: caption asString ] ]
]
