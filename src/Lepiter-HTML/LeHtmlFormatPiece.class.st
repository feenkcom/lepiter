Class {
	#name : #LeHtmlFormatPiece,
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
LeHtmlFormatPiece class >> fromFile: aFileReference [
	self
		assert: [ aFileReference exists ]
		description: [ 'File with template must exist: {1}' 
			format: {aFileReference} ].

	^ self new template: aFileReference contents
]

{ #category : #accessing }
LeHtmlFormatPiece >> arguments [
	^ arguments
]

{ #category : #accessing }
LeHtmlFormatPiece >> arguments: anObject [
	arguments := anObject
]

{ #category : #'private - writing' }
LeHtmlFormatPiece >> at: index [
	<return: #TLeHtmlPiece>
	^ arguments at: index ifAbsent: [ LeHtmlEmptyPiece uniqueInstance ]
]

{ #category : #'api - initialization' }
LeHtmlFormatPiece >> at: index put: value [
	arguments at: index put: value asLeHtmlFormatPiece
]

{ #category : #'gt - extensions' }
LeHtmlFormatPiece >> gtArgumentsFor: aView [
	<gtView>
	arguments ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Arguments';
		priority: 15;
		object: [ arguments ];
		view: #gtItemsFor:
]

{ #category : #'gt - extensions' }
LeHtmlFormatPiece >> gtTemplateFor: aView [
	<gtView>
	template ifNil: [ ^ aView empty ].

	^ aView textEditor
		title: 'Template';
		priority: 10;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ template ]
]

{ #category : #initialization }
LeHtmlFormatPiece >> initialize [
	super initialize.

	arguments := Dictionary new
]

{ #category : #accessing }
LeHtmlFormatPiece >> template [
	^ template
]

{ #category : #accessing }
LeHtmlFormatPiece >> template: anObject [
	template := anObject
]

{ #category : #'api - writing' }
LeHtmlFormatPiece >> writeWithContext: aContext [
	"Like String>>#format: format the string template using the args given"

	| input currentChar |
	input := template readStream.
	[ input atEnd ] whileFalse: [
		(currentChar := input next) == ${
			ifTrue: [ | expression index piece |
				expression := input upTo: $}.
				index := Integer 
					readFrom: expression 
					ifFail: [ expression ].
				piece := self  at: index.
				piece writeWithContext: aContext. ]
			ifFalse: [
				currentChar == $\
					ifTrue: [ input atEnd ifFalse: [ 
						aContext html << input next ] ]
					ifFalse: [ aContext html << currentChar ] ] ]
]
