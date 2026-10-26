"
I represent a Markdown table delimiter cell. The grammar records one of leftAlignment (:---), centerAlignment (:---:), rightAlignment (---:), or defaultAlignment (---) as a source-positioned token. My alignment accessor exposes the corresponding column justification without reparsing source text.
"
Class {
	#name : #LeTableDelimiterCellNode,
	#superclass : #LeTableCellNode,
	#instVars : [
		'leftAlignment',
		'centerAlignment',
		'rightAlignment',
		'defaultAlignment'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeTableDelimiterCellNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitTableDelimiterCell: self
]

{ #category : #accessing }
LeTableDelimiterCellNode >> alignment [
	"The grammar identifies justification; do not interpret the token text again."
	leftAlignment ifNotNil: [ ^ #left ].
	centerAlignment ifNotNil: [ ^ #center ].
	rightAlignment ifNotNil: [ ^ #right ].
	^ #default
]

{ #category : #generated }
LeTableDelimiterCellNode >> centerAlignment [
	^ centerAlignment
]

{ #category : #generated }
LeTableDelimiterCellNode >> centerAlignment: aSmaCCToken [
	centerAlignment := aSmaCCToken
]

{ #category : #accessing }
LeTableDelimiterCellNode >> contentSource [
	^ self text value
]

{ #category : #generated }
LeTableDelimiterCellNode >> defaultAlignment [
	^ defaultAlignment
]

{ #category : #generated }
LeTableDelimiterCellNode >> defaultAlignment: aSmaCCToken [
	defaultAlignment := aSmaCCToken
]

{ #category : #testing }
LeTableDelimiterCellNode >> isCenterAligned [
	^ centerAlignment isNotNil
]

{ #category : #testing }
LeTableDelimiterCellNode >> isDefaultAligned [
	^ defaultAlignment isNotNil
]

{ #category : #testing }
LeTableDelimiterCellNode >> isLeftAligned [
	^ leftAlignment isNotNil
]

{ #category : #testing }
LeTableDelimiterCellNode >> isRightAligned [
	^ rightAlignment isNotNil
]

{ #category : #generated }
LeTableDelimiterCellNode >> leftAlignment [
	^ leftAlignment
]

{ #category : #generated }
LeTableDelimiterCellNode >> leftAlignment: aSmaCCToken [
	leftAlignment := aSmaCCToken
]

{ #category : #generated }
LeTableDelimiterCellNode >> rightAlignment [
	^ rightAlignment
]

{ #category : #generated }
LeTableDelimiterCellNode >> rightAlignment: aSmaCCToken [
	rightAlignment := aSmaCCToken
]

{ #category : #accessing }
LeTableDelimiterCellNode >> text [
	^ leftAlignment ifNil: [ centerAlignment ifNil: [ rightAlignment ifNil: [ defaultAlignment ] ] ]
]

{ #category : #generated }
LeTableDelimiterCellNode >> tokenVariables [
	^ #(#leftAlignment #centerAlignment #rightAlignment #defaultAlignment)
]
