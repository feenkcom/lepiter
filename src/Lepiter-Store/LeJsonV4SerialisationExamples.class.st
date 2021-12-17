Class {
	#name : #LeJsonV4SerialisationExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Store-Examples'
}

{ #category : #examples }
LeJsonV4SerialisationExamples >> durationSerialisation [
	"Demonstrate serialisation and reconstructing a {{gtClass:Duration}}."
	| duration serialised reconstructed |

	duration := 2.5 seconds.

	self assert: duration basicSeconds equals: 2.
	self assert: duration nanos equals: 500000000.

	serialised := LeJsonV4 default serialize: duration.
	reconstructed := LeJsonV4 default deserialize: serialised readStream.

	self assert: reconstructed basicSeconds equals: 2.
	self assert: reconstructed nanos equals: 500000000.

	^ reconstructed

]
