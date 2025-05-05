Class {
	#name : #LeJSLinkSettingsExamples,
	#superclass : #LePropertiesExamples,
	#category : #'Lepiter-JavaScript-Examples'
}

{ #category : #examples }
LeJSLinkSettingsExamples >> defaultDirectory [
	"Answer the default directory  from the settings"

	<gtExample>
	<return: #UndefinedObject>
	| fileReference |
	fileReference := self settings directory.
	self assert: fileReference isNil.
	^ fileReference
]

{ #category : #examples }
LeJSLinkSettingsExamples >> defaultNodeJSPath [
	"Answer the default NodeJS path from the settings"

	<gtExample>
	<return: #UndefinedObject>
	| fileReference |
	fileReference := self settings nodejsPath.
	self assert: fileReference isNil.
	^ fileReference
]

{ #category : #examples }
LeJSLinkSettingsExamples >> setAbsoluteDirectory [
	"Set the directory to an absolute file reference"

	<gtExample>
	<return: #FileReference>
	| fileReference settings propertiesObject |
	settings := self settings.
	fileReference := FileLocator image resolve asAbsolute.
	settings directory: fileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #jsLink) at: #directory)
		equals: fileReference fullName.

	^ fileReference
]

{ #category : #examples }
LeJSLinkSettingsExamples >> setAbsoluteNodeJSPath [
	"Set the NodeJS path to an absolute file reference"

	<gtExample>
	<return: #FileReference>
	| fileString settings propertiesObject |
	settings := self settings.
	fileString := '/usr/bin/nodejs'.
	settings nodejsPath: fileString.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #jsLink) at: #nodejsPath)
		equals: fileString.

	^ fileString asFileReference
]

{ #category : #examples }
LeJSLinkSettingsExamples >> setFileLocatorDirectory [
	"Set the directory to an absolute file reference"

	<gtExample>
	<return: #FileLocator>
	| fileReference settings propertiesObject |
	settings := self settings.
	fileReference := FileLocator home / 'path'.
	settings directory: fileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #jsLink) at: #directory)
		equals: (self
				pathFrom: {'{home}'.
						'path'}).

	^ fileReference
]

{ #category : #examples }
LeJSLinkSettingsExamples >> setFileLocatorNodeJSPath [
	"Set the NodeJS path to an absolute file reference"

	<gtExample>
	<return: #FileLocator>
	| fileLocator settings propertiesObject |
	settings := self settings.
	fileLocator := FileLocator home / '.local' / 'bin' / 'nodejs'.
	settings nodejsPath: fileLocator.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #jsLink) at: #nodejsPath)
		equals: (self
				pathFrom: {'{home}'.
						'.local'.
						'bin'.
						'nodejs'}).

	^ fileLocator
]

{ #category : #examples }
LeJSLinkSettingsExamples >> setRelativeDirectory [
	"Set the directory to a relative file reference"

	<gtExample>
	<return: #ByteString>
	| fileString settings propertiesObject |
	settings := self settings.
	fileString := self
			pathFrom: {'..'.
					'relative'}.

	settings directory: fileString.
	propertiesObject := self propertiesDictionaryFrom: settings.
	self assert: ((propertiesObject at: #jsLink) at: #directory) equals: fileString.

	settings directory: fileString asFileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.
	self assert: ((propertiesObject at: #jsLink) at: #directory) equals: fileString.

	^ fileString
]

{ #category : #examples }
LeJSLinkSettingsExamples >> setRelativeNodeJSPath [
	"Set the NodeJS path to a relative file reference"

	<gtExample>
	<return: #FileReference>
	| fileString settings propertiesObject |
	settings := self settings.
	fileString := '../bin/nodejs'.
	settings nodejsPath: fileString.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self
		assert: ((propertiesObject at: #jsLink) at: #nodejsPath)
		equals: fileString.

	^ fileString asFileReference
]

{ #category : #private }
LeJSLinkSettingsExamples >> settings [ 
	"Answer a default LeJSLinkSettings object"

	^ self newProperties jsLinkSettings 
]
