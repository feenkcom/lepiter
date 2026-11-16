"
I reference a picture snippet ({{gtClass:LePictureSnippet}}) by its reference string, as written in a `gtPictureReference` annotation ({{gtClass:LePictureAnnotationNode}}).
I know the snippet, the reference and the index of the picture, which numbers pictures the way the editor does: across the database in table of contents order, or across the page if the page has no database.
Find me with {{gtMethod:LePictureSnippetReference class>>#forReference:inPage:}}. The editor ({{gtMethod:LeSnippetStyler>>#pictureSnippetWithReference:}}) and the HTML export use the same lookup and show my {{gtMethod:LePictureSnippetReference>>#label}}.
See {{gtExample:LePictureSnippetReferenceExamples>>#referenceOnOtherPage}}.
"
Class {
	#name : #LePictureSnippetReference,
	#superclass : #Object,
	#instVars : [
		'snippetModel',
		'reference',
		'index'
	],
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #private }
LePictureSnippetReference class >> detect: aBlock inPage: aPage [
	"Answer a reference to the first picture snippet for which aBlock answers true, or nil.
	Pictures are numbered across the database of aPage in table of contents order,
	or across aPage if it has no database."

	<return: #LePictureSnippetReference or: nil>
	| anIndex aDatabase aFoundBlock |
	aPage ifNil: [ ^ nil ].

	anIndex := 0.
	aFoundBlock := [ :eachSnippet |
		eachSnippet isPictureSnippet ifTrue: [ anIndex := anIndex + 1 ].
		(eachSnippet isPictureSnippet and: [ aBlock value: eachSnippet ])
			ifTrue: [ ^ self new
					snippetModel: eachSnippet;
					reference: eachSnippet reference;
					index: anIndex ] ].

	aDatabase := aPage database.
	(aDatabase isNil or: [ aDatabase isDatabase not ])
		ifTrue: [ aPage allChildrenDepthFirstDo: aFoundBlock.
			^ nil ].

	aDatabase snippetsIterator snippetsDo: aFoundBlock.
	^ nil

]

{ #category : #'instance creation' }
LePictureSnippetReference class >> forReference: aReference inPage: aPage [
	"Answer a reference to the picture snippet whose reference is aReference (a String), or nil if there is none.
	Pictures are numbered like in the editor: across the database of aPage in table of contents order,
	or across aPage if it has no database."

	<return: #LePictureSnippetReference or: nil>
	aReference ifNil: [ ^ nil ].

	^ self
		detect: [ :eachSnippet | eachSnippet isPictureSnippetWithReference: aReference ]
		inPage: aPage

]

{ #category : #'instance creation' }
LePictureSnippetReference class >> forSnippet: aPictureSnippet [
	"Answer a reference to aPictureSnippet with its number (see #forReference:inPage:),
	or nil if aPictureSnippet is not in a page"

	<return: #LePictureSnippetReference or: nil>
	^ self
		detect: [ :eachSnippet | eachSnippet == aPictureSnippet ]
		inPage: aPictureSnippet page

]

{ #category : #accessing }
LePictureSnippetReference class >> labelTemplate [
	"The label of a picture reference, filled with the picture caption, or the picture index if it has no caption"

	^ 'Figure {1}'

]

{ #category : #accessing }
LePictureSnippetReference >> caption [
	<return: #String>
	^ snippetModel caption
]

{ #category : #testing }
LePictureSnippetReference >> hasCaption [
	^ snippetModel hasCaption
]

{ #category : #accessing }
LePictureSnippetReference >> index [
	<return: #Integer>
	^ index
]

{ #category : #accessing }
LePictureSnippetReference >> index: anInteger [
	index := anInteger
]

{ #category : #accessing }
LePictureSnippetReference >> label [
	"Answer the label the editor shows for this picture reference, for example 'Figure 3' or 'Figure <caption>'"

	<return: #String>
	^ self class labelTemplate
		format: {self hasCaption
					ifTrue: [ self caption ]
					ifFalse: [ self index ]}

]

{ #category : #accessing }
LePictureSnippetReference >> numberLabel [
	"Answer the label with the picture number, for example 'Figure 3', whether or not the picture has a caption.
	The HTML export shows it in the figure caption (see LePictureSnippet>>#figureNumberLabel)."

	<return: #String>
	^ self class labelTemplate format: {self index}

]

{ #category : #accessing }
LePictureSnippetReference >> page [
	<return: #LePage or: nil>
	^ snippetModel ifNotNil: [ :aSnippet | aSnippet page ]

]

{ #category : #accessing }
LePictureSnippetReference >> reference [
	<return: #String>
	^ reference
]

{ #category : #accessing }
LePictureSnippetReference >> reference: aString [
	reference := aString
]

{ #category : #accessing }
LePictureSnippetReference >> snippetModel [
	<return: #LePictureSnippet>
	^ snippetModel
]

{ #category : #accessing }
LePictureSnippetReference >> snippetModel: aSnippet [
	snippetModel := aSnippet
]
