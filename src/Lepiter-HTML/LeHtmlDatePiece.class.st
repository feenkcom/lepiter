Class {
	#name : #LeHtmlDatePiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#instVars : [
		'printerBlock'
	],
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #accessing }
LeHtmlDatePiece >> dateToString: aDate [ 
	^ String streamContents: [ :aStream | 
		self printer value: aDate value: aStream ]
]

{ #category : #initialization }
LeHtmlDatePiece >> defaultPrinter [
	^ [ :aDateAndTime :aStream | 
		ExtendedDatePrinter new
			printDate: aDateAndTime asDate
			format: #(2 1 3 $  2 1 1)
			on: aStream ]
]

{ #category : #accessing }
LeHtmlDatePiece >> printer [
	^ printerBlock ifNil: [ printerBlock := self defaultPrinter ]
]

{ #category : #accessing }
LeHtmlDatePiece >> printer: aBlock [
	"Block with two arguments [ :aDateAndTime :aStream | ]"

	printerBlock := aBlock
]

{ #category : #accessing }
LeHtmlDatePiece >> writeWithContext: aContext [
	aContext date ifNotNil: [ :aDate | 
		| aString |
		aString := self dateToString: aDate.
		aContext html escape: aString asString ]
]
