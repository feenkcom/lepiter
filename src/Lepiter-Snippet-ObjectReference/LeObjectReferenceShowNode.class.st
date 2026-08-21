Class {
	#name : #LeObjectReferenceShowNode,
	#superclass : #LeObjectReferenceArgumentNode,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
LeObjectReferenceShowNode >> acceptVisitor: anObjectReferenceParseVisitor [
	^anObjectReferenceParseVisitor visitObjectReferenceShow: self
]

{ #category : #accessing }
LeObjectReferenceShowNode >> selectorFrom: aString [
	^ (self
		dequote:
			(aString first = $#
				ifTrue: [ aString allButFirst ]
				ifFalse: [ aString ])) asSymbol
]

{ #category : #accessing }
LeObjectReferenceShowNode >> selectorValue [
	^ self selectorFrom: value source
]
