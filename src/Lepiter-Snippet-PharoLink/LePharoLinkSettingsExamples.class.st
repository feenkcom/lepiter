Class {
	#name : #LePharoLinkSettingsExamples,
	#superclass : #LePropertiesExamples,
	#category : #'Lepiter-Snippet-PharoLink-Examples'
}

{ #category : #examples }
LePharoLinkSettingsExamples >> defaultValues [
	"Confirm the default values in the settings"

	<gtExample>
	<return: #LePharoLinkSettings>
	| settings |
	settings := self settings.
	self assert: settings clientAddress isNil.
	self assert: settings clientSocketAddress isNil.
	self assert: settings serverAddress isNil.
	self assert: settings serverSocketAddress isNil.
	self deny: settings manualProcess.
	self deny: settings serverDebugMode.
	self assert: settings serverExecutable isNil.
	self assert: settings serverImage isNil.
	^ settings
]

{ #category : #examples }
LePharoLinkSettingsExamples >> setAbsoluteServerExecutable [
	"Set the serverExecutable to an absolute file reference"

	<gtExample>
	<return: #FileReference>
	| fileReference settings propertiesObject |
	settings := self settings.
	fileReference := FileLocator vmBinary resolve asAbsolute.
	settings serverExecutable: fileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #pharoLink) at: #serverExecutable)
		equals: fileReference fullName.

	^ fileReference
]

{ #category : #examples }
LePharoLinkSettingsExamples >> setAbsoluteServerImage [
	"Set the serverImage to an absolute file reference"

	<gtExample>
	<return: #FileReference>
	| fileReference settings propertiesObject |
	settings := self settings.
	fileReference := FileLocator image resolve asAbsolute.
	settings serverImage: fileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #pharoLink) at: #serverImage)
		equals: fileReference fullName.

	^ fileReference
]

{ #category : #examples }
LePharoLinkSettingsExamples >> setClientAddressLocalhost [
	"Set the client address to a port on the localhost"

	<gtExample>
	<return: #LanguageLinkSocketAddress>
	| settings propertiesObject socketAddress |
	settings := self settings.
	settings clientAddress: 'localhost:1234'.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #pharoLink) at: #clientAddress)
		equals: 'localhost:1234'.

	socketAddress := settings clientSocketAddress.
	self assert: socketAddress ipOrName equals: 'localhost'.
	self assert: socketAddress port equals: 1234.

	^ socketAddress
]

{ #category : #examples }
LePharoLinkSettingsExamples >> setFileLocatorServerExecutable [
	"Set the serverExecutable to a FileLocator"

	<gtExample>
	<return: #FileLocator>
	| fileReference settings propertiesObject |
	settings := self settings.
	fileReference := FileLocator home / 'path'.
	settings serverExecutable: fileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #pharoLink) at: #serverExecutable)
		equals: (self
				pathFrom: {'{home}'.
						'path'}).

	^ fileReference
]

{ #category : #examples }
LePharoLinkSettingsExamples >> setFileLocatorServerImage [
	"Set the serverExecutable to a FileLocator"

	<gtExample>
	<return: #FileLocator>
	| fileReference settings propertiesObject |
	settings := self settings.
	fileReference := FileLocator image.
	settings serverImage: fileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #pharoLink) at: #serverImage)
		equals: (self pathFrom: {'{image}'}).

	^ fileReference
]

{ #category : #examples }
LePharoLinkSettingsExamples >> setRelativeServerExecutable [
	"Set the directory to a relative file reference"

	<gtExample>
	<return: #ByteString>
	| fileString settings propertiesObject |
	settings := self settings.
	fileString := self
			pathFrom: {'..'.
					'relative'}.

	settings serverExecutable: fileString.
	propertiesObject := self propertiesDictionaryFrom: settings.
	self
		assert: ((propertiesObject at: #pharoLink) at: #serverExecutable)
		equals: fileString.

	settings serverExecutable: fileString asFileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.
	self
		assert: ((propertiesObject at: #pharoLink) at: #serverExecutable)
		equals: fileString.

	^ fileString
]

{ #category : #examples }
LePharoLinkSettingsExamples >> setRelativeServerImage [
	"Set the directory to a relative file reference"

	<gtExample>
	<return: #ByteString>
	| fileString settings propertiesObject |
	settings := self settings.
	fileString := self
			pathFrom: {'..'.
					'relative'}.

	settings serverImage: fileString.
	propertiesObject := self propertiesDictionaryFrom: settings.
	self
		assert: ((propertiesObject at: #pharoLink) at: #serverImage)
		equals: fileString.

	settings serverImage: fileString asFileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.
	self
		assert: ((propertiesObject at: #pharoLink) at: #serverImage)
		equals: fileString.

	^ fileString
]

{ #category : #private }
LePharoLinkSettingsExamples >> settings [ 
	"Answer a default LePythonBridgeSettings object"

	^ self newProperties pharoLinkSettings 
]
