Class {
	#name : #LeFileReferenceRangeNode,
	#superclass : #LeFileReferenceArgumentNode,
	#instVars : [
		'start',
		'colon',
		'end'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
LeFileReferenceRangeNode >> acceptVisitor: aFileReferenceParseVisitor [
	^ aFileReferenceParseVisitor visitFileReferenceRange: self
]

{ #category : #generated }
LeFileReferenceRangeNode >> colon [
	^ colon
]

{ #category : #generated }
LeFileReferenceRangeNode >> colon: aSmaCCToken [
	colon := aSmaCCToken
]

{ #category : #generated }
LeFileReferenceRangeNode >> end [
	^ end
]

{ #category : #generated }
LeFileReferenceRangeNode >> end: aSmaCCToken [
	end := aSmaCCToken
]

{ #category : #accessing }
LeFileReferenceRangeNode >> endInteger [
	^ self endString ifNil: [ nil ] ifNotNil: [ :value | value asInteger ]
]

{ #category : #accessing }
LeFileReferenceRangeNode >> endString [
	^ end ifNil: [ nil ] ifNotNil: [ end value ]
]

{ #category : #generated }
LeFileReferenceRangeNode >> start [
	^ start
]

{ #category : #generated }
LeFileReferenceRangeNode >> start: aSmaCCToken [
	start := aSmaCCToken
]

{ #category : #accessing }
LeFileReferenceRangeNode >> startInteger [
	^ self startString ifNil: [ nil ] ifNotNil: [ :value | value asInteger ]
]

{ #category : #accessing }
LeFileReferenceRangeNode >> startString [
	^ start ifNil: [ nil ] ifNotNil: [ start value ]
]

{ #category : #generated }
LeFileReferenceRangeNode >> tokenVariables [
	^ #(#start #colon #end #name #equals)
]
