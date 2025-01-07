Class {
	#name : #LeHtmlConditionPiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#instVars : [
		'condition',
		'piece'
	],
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #accessing }
LeHtmlConditionPiece >> condition [
	^ condition ifNil: [ condition := self defaultCondition ]
]

{ #category : #accessing }
LeHtmlConditionPiece >> condition: aTwoArgBlock [
	"Set a condition block [ :aHtmlContext :aPiece | ]. 
	If the block returns true, a given piece is executed (written)."

	condition := aTwoArgBlock
]

{ #category : #accessing }
LeHtmlConditionPiece >> defaultCondition [
	^ [ :aContext :aPiece | true ]
]

{ #category : #accessing }
LeHtmlConditionPiece >> piece [
	^ piece ifNil: [ piece := LeHtmlEmptyPiece default ]
]

{ #category : #accessing }
LeHtmlConditionPiece >> piece: aPiece [
	piece := aPiece asLeHtmlFormatPiece
]

{ #category : #'api - writing' }
LeHtmlConditionPiece >> writeWithContext: aContext [
	| aResult |
	aResult := self condition cull: aContext cull: self.
	aResult ifFalse: [ ^ self ].
	
	self piece writeWithContext: aContext
]
