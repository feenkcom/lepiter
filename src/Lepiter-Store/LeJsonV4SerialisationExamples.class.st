Class {
	#name : #LeJsonV4SerialisationExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Store-Examples'
}

{ #category : #examples }
LeJsonV4SerialisationExamples >> bitmap [
	<gtExample>
	<return: #LeJsonV4SerialisationExamples>
	| original deserialized |
	original := Bitmap gtExampleIconBits.
	deserialized := LeJsonV4 uniqueInstance
			deserialize: (LeJsonV4 uniqueInstance serialize: original) readStream.
	self assert: deserialized class equals: original class.
	self assert: original equals: deserialized
]

{ #category : #examples }
LeJsonV4SerialisationExamples >> byteArray [
	"ByteArray serialisation changed from storeString to base64Encoded.
	Confirm that both can be deserialised."

	<gtExample>
	<return: #LeJsonV4SerialisationExamples>
	| original serialized deserialized storeString |
	LeJsonV4 cleanUp.
	original := #[3 1 4 1 5].
	storeString := '{"__schema":"4.1","__type":"byteArray","byteArrayString":"#[3 1 4 1 5]"}'.
	deserialized := LeJsonV4 uniqueInstance deserialize: storeString readStream.
	self assert: deserialized class equals: ByteArray.
	self assert: original equals: deserialized.

	serialized := LeJsonV4 uniqueInstance serialize: original.
	deserialized := LeJsonV4 uniqueInstance deserialize: serialized readStream.
	self
		assert: serialized
		equals: '{"__schema":"4.1","__type":"byteArray","byteArrayString":"AwEEAQU="}'.
	self assert: deserialized class equals: ByteArray.
	self assert: original equals: deserialized
]

{ #category : #private }
LeJsonV4SerialisationExamples >> checkInstance: instance [
	"Check that the supplied object is the same after serialisation and deserialisation"
	| leJsonV4 deserialisedInstance |

	leJsonV4 := LeJsonV4 uniqueInstance.
	deserialisedInstance := leJsonV4 deserialize: (leJsonV4 serialize: instance) readStream.
	self assert: instance class identicalTo: deserialisedInstance class.
]

{ #category : #examples }
LeJsonV4SerialisationExamples >> deSerializeAllImplementors [
	"Perform a basic check on all implementors of #leJsonV4Name that the basic serialisation / deserialisation doesn't raise an error and looks sensible"

	<gtExample>
	<return: #LeJsonV4SerialisationExamples>
	| allImplementors allClasses leJsonV4 clsCount testedCount excludedClasses |
	LeJsonV4 cleanUp.
	allImplementors := SystemNavigation default allImplementorsOf: #leJsonV4Name.
	allClasses := allImplementors
			flatCollect: [ :method | method methodClass instanceSide withAllSubclasses ]
			as: Set.
	clsCount := allClasses size.
	testedCount := 0.
	leJsonV4 := LeJsonV4 uniqueInstance.	"excludedClasses is a set of classes that can't serialise the default instance due to its implementation"
	excludedClasses := {FileLocator.
			FileReference.
			Fraction.
			GtPackageExampleGroup.
			Point.
			ScaledDecimal.
			LeUnknownSnippet}.
	allClasses removeAll: excludedClasses.	"Give developers the chance to exclude classes that are not part of core Gt"
	(self class methods
		select: [ :method | method hasPragmaNamed: #leJsonV4ExcludedClasses ])
		do: [ :method | allClasses removeAll: (self perform: method selector) ].
	allClasses
		do: [ :cls | 
			(cls perform: #leJsonV4Name)
				ifNotNil: [ cls deSerializeAllImplementorsInstances
						do: [ :instance | self checkInstance: instance ] ].
			testedCount := testedCount + 1 ]
]

{ #category : #examples }
LeJsonV4SerialisationExamples >> durationSerialisation [
	"Demonstrate serialisation and reconstructing a {{gtClass:Duration}}."

	<gtExample>
	<return: #Duration>
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

{ #category : #examples }
LeJsonV4SerialisationExamples >> form [
	<gtExample>
	<return: #LeJsonV4SerialisationExamples>
	| original deserialized |
	LeJsonV4 cleanUp.
	original := Form extent: 100 @ 100 depth: 32.
	original getCanvas fillRectangle: (0 @ 0 corner: 30 @ 30) color: Color red.
	original getCanvas fillRectangle: (10 @ 10 corner: 40 @ 40) color: Color green.
	original getCanvas fillRectangle: (20 @ 20 corner: 50 @ 50) color: Color blue.
	deserialized := LeJsonV4 uniqueInstance
			deserialize: (LeJsonV4 uniqueInstance serialize: original) readStream.
	self assert: deserialized class equals: Form.
	self assert: deserialized width equals: original width.
	self assert: deserialized height equals: original height.
	self assert: deserialized depth equals: original depth.
	self assert: deserialized offset equals: original offset.
	self assert: deserialized bits equals: original bits
]

{ #category : #examples }
LeJsonV4SerialisationExamples >> fraction [
	<gtExample>
	<return: #LeJsonV4SerialisationExamples>
	| original deserialized |
	original := 4 / 3.
	deserialized := LeJsonV4 uniqueInstance
			deserialize: (LeJsonV4 uniqueInstance serialize: original) readStream.
	self assert: deserialized class equals: Fraction.
	self assert: original equals: deserialized
]

{ #category : #examples }
LeJsonV4SerialisationExamples >> point [
	<gtExample>
	<return: #LeJsonV4SerialisationExamples>
	| original deserialized |
	LeJsonV4 cleanUp.
	original := 4 @ 2.
	deserialized := LeJsonV4 uniqueInstance
			deserialize: (LeJsonV4 uniqueInstance serialize: original) readStream.
	self assert: deserialized class equals: Point.
	self assert: original equals: deserialized
]

{ #category : #examples }
LeJsonV4SerialisationExamples >> scaledDecimal [
	<gtExample>
	<return: #LeJsonV4SerialisationExamples>
	| original deserialized |
	original := 1.2345s4.
	deserialized := LeJsonV4 uniqueInstance
			deserialize: (LeJsonV4 uniqueInstance serialize: original) readStream.
	self assert: deserialized class equals: ScaledDecimal.
	self assert: original equals: deserialized.
	self assert: deserialized scale equals: 4
]

{ #category : #examples }
LeJsonV4SerialisationExamples >> uuid [
	<gtExample>
	<return: #LeJsonV4SerialisationExamples>
	| original deserialized |
	original := UUID new.
	deserialized := LeJsonV4 uniqueInstance
			deserialize: (LeJsonV4 uniqueInstance serialize: original) readStream.
	self assert: deserialized class equals: UUID.
	self assert: original equals: deserialized
]
