Class {
	#name : #LeRangeValueNode,
	#superclass : #LeFileReferenceParseNode,
	#instVars : [
		'start',
		'colon',
		'end'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
LeRangeValueNode >> acceptVisitor: aFileReferenceParseVisitor [
	^ aFileReferenceParseVisitor visitRangeValue: self
]

{ #category : #generated }
LeRangeValueNode >> colon [
	^ colon
]

{ #category : #generated }
LeRangeValueNode >> colon: aSmaCCToken [
	colon := aSmaCCToken
]

{ #category : #generated }
LeRangeValueNode >> end [
	^ end
]

{ #category : #generated }
LeRangeValueNode >> end: aSmaCCToken [
	end := aSmaCCToken
]

{ #category : #accessing }
LeRangeValueNode >> endInteger [
	^ self endString ifNil: [ nil ] ifNotNil: [ :value | value asInteger ]
]

{ #category : #accessing }
LeRangeValueNode >> endString [
	^ end ifNil: [ nil ] ifNotNil: [ end value ]
]

{ #category : #generated }
LeRangeValueNode >> start [
	^ start
]

{ #category : #generated }
LeRangeValueNode >> start: aSmaCCToken [
	start := aSmaCCToken
]

{ #category : #accessing }
LeRangeValueNode >> startInteger [
	^ self startString ifNil: [ nil ] ifNotNil: [ :value | value asInteger ]
]

{ #category : #accessing }
LeRangeValueNode >> startString [
	^ start ifNil: [ nil ] ifNotNil: [ start value ]
]

{ #category : #generated }
LeRangeValueNode >> tokenVariables [
	^ #(#start #colon #end)
]
