Class {
	#name : #LeHtmlFigureImageWriter,
	#superclass : #Object,
	#instVars : [
		'imageSrc',
		'caption',
		'html',
		'width',
		'elementId',
		'label'
	],
	#category : #'Lepiter-HTML-Writers'
}

{ #category : #accessing }
LeHtmlFigureImageWriter class >> elementIdForPictureReference: aString [
	"Answer the HTML element id of a picture snippet with the reference aString (see LePictureSnippet>>#reference).
	The id is computed from the reference only, so links from other pages can use it.
	It is filtered like LeHtmlElementIdBuilder>>#pushFilteredString:."

	<return: #String>
	| aFilteredString isDash |
	isDash := false.
	aFilteredString := String
			new: aString size
			streamContents: [ :aStream |
				aString
					do: [ :aCharacter |
						aCharacter isAlphaNumeric
							ifTrue: [ aStream nextPut: aCharacter asLowercase.
								isDash := false ]
							ifFalse: [ isDash ifFalse: [ aStream nextPut: $- ].
								isDash := true ] ] ].

	^ 'figure-' , (aFilteredString trimBoth: [ :each | each = $- ])

]

{ #category : #accessing }
LeHtmlFigureImageWriter >> caption [
	^ caption
]

{ #category : #accessing }
LeHtmlFigureImageWriter >> caption: anObject [
	caption := anObject
]

{ #category : #accessing }
LeHtmlFigureImageWriter >> elementId [
	^ elementId

]

{ #category : #accessing }
LeHtmlFigureImageWriter >> elementId: aString [
	"Set the id of the figure element, or nil for no id"

	elementId := aString

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

{ #category : #accessing }
LeHtmlFigureImageWriter >> label [
	^ label

]

{ #category : #accessing }
LeHtmlFigureImageWriter >> label: aString [
	"Set a label written before the caption, for example 'Figure 3', or nil for no label"

	label := aString

]

{ #category : #accessing }
LeHtmlFigureImageWriter >> width [
	^ width
]

{ #category : #accessing }
LeHtmlFigureImageWriter >> width: anObject [
	width := anObject
]

{ #category : #'api - writing' }
LeHtmlFigureImageWriter >> write [
	html
		tag: #figure
		attributes: (elementId
				ifNil: [ {'class'.
						'snippet picture-snippet ' , self width cssClass} ]
				ifNotNil: [ {'id'.
						elementId.
						'class'.
						'snippet picture-snippet ' , self width cssClass} ])
		do: [ html
				inlineTag: 'img'
				attributes: {'class'.
						'picture-snippet-image'.
						'src'.
						imageSrc}.

			self writeCaption ]

]

{ #category : #'private - writing' }
LeHtmlFigureImageWriter >> writeCaption [
	"Write the figure caption: the label (if any), followed by the caption (if any)"

	| hasCaption hasLabel |
	hasCaption := caption isNotNil and: [ caption trimBoth isNotEmpty ].
	hasLabel := label isNotNil and: [ label isNotEmpty ].
	(hasCaption or: [ hasLabel ]) ifFalse: [ ^ self ].

	hasLabel
		ifFalse: [ ^ self html
				inlineTag: 'figcaption'
				attributes: #('class' 'picture-snippet-caption')
				with: caption asString ].

	self html
		inlineTag: 'figcaption'
		attributes: #('class' 'picture-snippet-caption')
		do: [ self html
				inlineTag: 'span'
				attributes: #('class' 'picture-snippet-caption-label')
				with: label.
			hasCaption ifTrue: [ self html escape: ': ' , caption asString ] ]

]
