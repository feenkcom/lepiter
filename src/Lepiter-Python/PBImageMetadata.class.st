Class {
	#name : #PBImageMetadata,
	#superclass : #PBProxyObject,
	#category : #'Lepiter-Python-ProxyObjects'
}

{ #category : #accessing }
PBImageMetadata class >> pythonClass [
	"There does not seem to be a corresponding Python class"
	
	^ #Image
]

{ #category : #accessing }
PBImageMetadata >> at: attributeString [
	"Answer the value of the named attribute"

	^ self newCommandFactory 
		<< (self => #get callWith: { attributeString });
		sendAndWait
]

{ #category : #accessing }
PBImageMetadata >> attributes [
	"Answer the list of metadata attributes"

	^ self newCommandFactory
		<< (#dir asP3GI callWith: { self });
		sendAndWait
]

{ #category : #accessing }
PBImageMetadata >> getAll [
	"Answer all attributes"

	^ self newCommandFactory
		<< (self => #get_all callWith: #());
		sendAndWait
]

{ #category : #ui }
PBImageMetadata >> gtAttributesFor: aView [
	<gtView>

	^ aView forward 
		title: 'Attributes';
		priority: 5;
		object: [ self getAll ];
		view: #gtItemsFor:
]

{ #category : #ui }
PBImageMetadata >> gtImageFor: aView [
	<gtView>

	^ aView explicit
		title: 'Image';
		priority: 10;
		stencil: [ (BrAsyncFileWidget new file: self sourceFileName)
			constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #accessing }
PBImageMetadata >> imageData [
	"Answer the image data"

	^ self newCommandFactory
		<< (self => #get_file callWith: #());
		sendAndWait
]

{ #category : #accessing }
PBImageMetadata >> sourceFileName [
	"Answer the image source file name"

	^ self newCommandFactory
		<< (self => #source_file_name);
		sendAndWait
]
