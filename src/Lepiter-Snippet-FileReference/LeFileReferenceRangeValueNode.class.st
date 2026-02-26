Class {
	#name : #LeFileReferenceRangeValueNode,
	#superclass : #LeFileReferenceParseNode,
	#instVars : [
		'start',
		'end',
		'colon'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #accessing }
LeFileReferenceRangeValueNode >> endInteger [
	^ self endString ifNil: [ nil ] ifNotNil: [ :value | value asInteger ]
]

{ #category : #accessing }
LeFileReferenceRangeValueNode >> endString [
	^ end ifNil: [ nil ] ifNotNil: [ end value ]
]

{ #category : #accessing }
LeFileReferenceRangeValueNode >> startInteger [
	^ self startString ifNil: [ nil ] ifNotNil: [ :value | value asInteger ]
]

{ #category : #accessing }
LeFileReferenceRangeValueNode >> startString [
	^ start ifNil: [ nil ] ifNotNil: [ start value ]
]
