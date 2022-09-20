Class {
	#name : #LeJsonV4SerialisationExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Store-Examples'
}

{ #category : #examples }
LeJsonV4SerialisationExamples >> deSerializeAllImplementors [
	"Perform a basic check on all implementors of #leJsonV4Name that the basic serialisation / deserialisation doesn't raise an error and looks sensible"
	<gtExample>
	| allImplementors allClasses leJsonV4 instance deserialisedInstance clsCount testedCount excludedClasses |

	LeJsonV4 cleanUp.
	allImplementors := SystemNavigation default allImplementorsOf: #leJsonV4Name.
	allClasses := allImplementors 
		flatCollect: [ :method | method methodClass instanceSide withAllSubclasses ] 
		as: Set.
	clsCount := allClasses size.
	testedCount := 0.
	leJsonV4 := LeJsonV4 uniqueInstance.
	"excludedClasses is a set of classes that can't serialise the default instance due to its implementation"
	excludedClasses := {
		FileLocator.
		FileReference.
		GtPackageExampleGroup.
		ScaledDecimal.
		}.
	allClasses removeAll: excludedClasses.
	allClasses do: [ :cls |
		(cls perform: #leJsonV4Name) ifNotNil:
			[ [ instance := cls new ]
				on: Error
				do: [ :ex | "Skip this class" ].
			instance ifNotNil:
				[ deserialisedInstance := leJsonV4 deserialize: (leJsonV4 serialize: instance) readStream ].
			self assert: instance class identicalTo: deserialisedInstance class ].
		testedCount := testedCount + 1 ].
]

{ #category : #examples }
LeJsonV4SerialisationExamples >> durationSerialisation [
	"Demonstrate serialisation and reconstructing a {{gtClass:Duration}}."
	<gtExample>
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

{ #category : #accessing }
LeJsonV4SerialisationExamples >> scaledDecimal [
	<gtExample>
	| original deserialized |

	original := 1.2345s4.
	deserialized := LeJsonV4 uniqueInstance deserialize:
		(LeJsonV4 uniqueInstance serialize: original) readStream.
	self assert: deserialized class equals: ScaledDecimal.
	self assert: original equals: deserialized.
	self assert: deserialized scale equals: 4.
]
