Class {
	#name : #GtEpiceaNewStateVisitor,
	#superclass : #EpNewStateVisitor,
	#category : #'Lepiter-Core-Epicea'
}

{ #category : #printing }
GtEpiceaNewStateVisitor >> printProtocol: aProtocol behaviorName: aBehaviorName sourceCode: aSourceCode [

	^ String streamContents: [ :stream |
		stream
			nextPutAll: '"protocol: '; 
			nextPutAll: aProtocol printString;
			nextPut: $"; cr; cr;
			nextPutAll: aBehaviorName;
			nextPutAll: ' >> ';
			nextPutAll: aSourceCode ]	
]

{ #category : #visitor }
GtEpiceaNewStateVisitor >> visitMethodAddition: aMethodCreatedChange [
	^ self 
		printProtocol: aMethodCreatedChange protocol
		behaviorName: aMethodCreatedChange behaviorAffectedName
		sourceCode: aMethodCreatedChange sourceCode
]

{ #category : #visitor }
GtEpiceaNewStateVisitor >> visitMethodModification: aMethodModification [
	^ self 
		printProtocol: aMethodModification newProtocol
		behaviorName: aMethodModification behaviorAffectedName
		sourceCode: aMethodModification newSourceCode
]
