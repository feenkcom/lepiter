Class {
	#name : #LeDatabasePropertiesExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #example }
LeDatabasePropertiesExamples >> fileReferenceEncoding [
	"Confirm referencing the image directory by name in lepiter.properties"

	<gtExample>
	<return: #FileLocator>
	| localStore locator string fileReference |
	"LeLocalStore needs the localRoot set to resolve dbParentDirectory.
	Set a directory here to avoid errors."
	localStore := LeLocalStore new localRoot: FileLocator imageDirectory.
	locator := FileLocator imageDirectory / 'pharo-local'.
	string := localStore fileReferenceString: locator.
	self
		assert: string
		equals: '{imageDirectory}' , FileSystem disk delimiter asString , 'pharo-local'.
	fileReference := localStore fileReferenceFrom: string.
	self assert: fileReference equals: locator.
	^ fileReference
]
