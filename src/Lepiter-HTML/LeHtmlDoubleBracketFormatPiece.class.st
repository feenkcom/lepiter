Class {
	#name : #LeHtmlDoubleBracketFormatPiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#instVars : [
		'template',
		'arguments'
	],
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'instance-creation' }
LeHtmlDoubleBracketFormatPiece class >> fromFile: aFileReference [
	self
		assert: [ aFileReference exists ]
		description: [ 'File with template must exist: {1}' 
			format: {aFileReference} ].

	^ self new template: aFileReference contents
]

{ #category : #accessing }
LeHtmlDoubleBracketFormatPiece >> arguments [
	^ arguments
]

{ #category : #accessing }
LeHtmlDoubleBracketFormatPiece >> arguments: anObject [
	arguments := anObject
]

{ #category : #'private - writing' }
LeHtmlDoubleBracketFormatPiece >> at: index [
	<return: #TLeHtmlPiece>
	^ arguments at: index ifAbsent: [ LeHtmlEmptyPiece uniqueInstance ]
]

{ #category : #'api - initialization' }
LeHtmlDoubleBracketFormatPiece >> at: index put: value [
	arguments at: index put: value asLeHtmlFormatPiece
]

{ #category : #'gt - extensions' }
LeHtmlDoubleBracketFormatPiece >> gtArgumentsFor: aView [
	<gtView>
	arguments ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Arguments';
		priority: 15;
		object: [ arguments ];
		view: #gtItemsFor:
]

{ #category : #'gt - extensions' }
LeHtmlDoubleBracketFormatPiece >> gtTemplateFor: aView [
	<gtView>
	template ifNil: [ ^ aView empty ].

	^ aView textEditor
		title: 'Template';
		priority: 10;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ template ]
]

{ #category : #initialization }
LeHtmlDoubleBracketFormatPiece >> initialize [
	super initialize.

	arguments := Dictionary new
]

{ #category : #accessing }
LeHtmlDoubleBracketFormatPiece >> template [
	^ template
]

{ #category : #accessing }
LeHtmlDoubleBracketFormatPiece >> template: anObject [
	template := anObject
]

{ #category : #'api - writing' }
LeHtmlDoubleBracketFormatPiece >> writeWithContext: aContext [
	"Like LeHtmlFormatPiece>>#writeWithContext: but using double brackets"

	| input currentChar |
	input := template readStream.
	[ input atEnd ]
		whileFalse: [ (currentChar := input next) == ${
				ifTrue: [ | expression index piece |
					(currentChar := input next) == ${
						ifTrue: [ expression := input upTo: $}.
							[ (currentChar := input next) == $} ]
								whileFalse: [ expression := expression , '}' , currentChar asString , (input upTo: $}) ].
							index := Integer readFrom: expression ifFail: [ expression ].
							piece := self at: index.
							piece writeWithContext: aContext ]
						ifFalse: [ aContext html << '{' << currentChar ] ]
				ifFalse: [ currentChar == $\
						ifTrue: [ input atEnd ifFalse: [ aContext html << input next ] ]
						ifFalse: [ aContext html << currentChar ] ] ]
]
