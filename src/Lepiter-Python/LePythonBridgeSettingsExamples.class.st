Class {
	#name : #LePythonBridgeSettingsExamples,
	#superclass : #LePropertiesExamples,
	#category : #'Lepiter-Python-Examples'
}

{ #category : #examples }
LePythonBridgeSettingsExamples >> defaultDirectory [
	"Answer the default directory  from the settings"
	<gtExample>
	| fileReference |

	fileReference := self settings directory.
	self assert: fileReference isNil.
	^ fileReference
]

{ #category : #examples }
LePythonBridgeSettingsExamples >> defaultPipenvPath [
	"Answer the default pipenv path from the settings"
	<gtExample>
	| fileReference |

	fileReference := self settings pipenvPath.
	self assert: fileReference isNil.
	^ fileReference
]

{ #category : #examples }
LePythonBridgeSettingsExamples >> setAbsoluteDirectory [
	"Set the directory to an absolute file reference"
	<gtExample>
	| fileReference settings propertiesObject |

	settings := self settings.
	fileReference := FileLocator image resolve asAbsolute.
	settings directory: fileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self assert: ((propertiesObject at: #pythonBridge) at: #directory)
			equals: fileReference fullName.

	^ fileReference
]

{ #category : #examples }
LePythonBridgeSettingsExamples >> setAbsolutePipenvPath [
	"Set the pipenv path to an absolute file reference"
	<gtExample>
	| fileString settings propertiesObject |

	settings := self settings.
	fileString := '/usr/bin/pipenv'.
	settings pipenvPath: fileString.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self assert: ((propertiesObject at: #pythonBridge) at: #pipenvPath)
			equals: fileString.

	^ fileString asFileReference
]

{ #category : #examples }
LePythonBridgeSettingsExamples >> setFileLocatorDirectory [
	"Set the directory to an absolute file reference"
	<gtExample>
	| fileReference settings propertiesObject |

	settings := self settings.
	fileReference := FileLocator home / 'path'.
	settings directory: fileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self assert: ((propertiesObject at: #pythonBridge) at: #directory)
			equals: '{home}/path'.

	^ fileReference
]

{ #category : #examples }
LePythonBridgeSettingsExamples >> setFileLocatorPipenvPath [
	"Set the pipenv path to an absolute file reference"
	<gtExample>
	| fileLocator settings propertiesObject |

	settings := self settings.
	fileLocator := FileLocator home / '.local/bin/pipenv'.
	settings pipenvPath: fileLocator.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self assert: ((propertiesObject at: #pythonBridge) at: #pipenvPath)
			equals: '{home}/.local/bin/pipenv'.

	^ fileLocator
]

{ #category : #examples }
LePythonBridgeSettingsExamples >> setRelativeDirectory [
	"Set the directory to a relative file reference"
	<gtExample>
	| fileString settings propertiesObject |

	settings := self settings.
	fileString := '../relative'.

	settings directory: fileString.
	propertiesObject := self propertiesDictionaryFrom: settings.
	self assert: ((propertiesObject at: #pythonBridge) at: #directory)
			equals: fileString.

	settings directory: fileString asFileReference.
	propertiesObject := self propertiesDictionaryFrom: settings.
	self assert: ((propertiesObject at: #pythonBridge) at: #directory)
			equals: fileString.

	^ fileString
]

{ #category : #examples }
LePythonBridgeSettingsExamples >> setRelativePipenvPath [
	"Set the pipenv path to an absolute file reference"
	<gtExample>
	| fileString settings propertiesObject |

	settings := self settings.
	fileString := '../bin/pipenv'.
	settings pipenvPath: fileString.
	propertiesObject := self propertiesDictionaryFrom: settings.

	self assert: ((propertiesObject at: #pythonBridge) at: #pipenvPath)
			equals: fileString.

	^ fileString asFileReference
]

{ #category : #private }
LePythonBridgeSettingsExamples >> settings [ 
	"Answer a default LePythonBridgeSettings object"

	^ self newProperties pythonBridgeSettings 
]
