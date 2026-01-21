"
Upgrade to V4.0.

"
Class {
	#name : #LeJsonV3002Updater,
	#superclass : #LeJsonV3SchemaUpdater,
	#category : 'Lepiter-Store-JSONV3'
}

{ #category : #accessing }
LeJsonV3002Updater class >> minorVersion [ 
	"Answer the minor version number that this class upgrades FROM"

	^ 2
]

{ #category : #accessing }
LeJsonV3002Updater class >> updatedVersion [ 
	"Answer the version that the file is updated to, V4.0 in this case"

	^ LeDbVersion new
		major: 4;
		minor: 0.
]

{ #category : #private }
LeJsonV3002Updater >> fileReferenceFor: jsonObject named: file [
	"Answer the new file name to be used to store the page.
	V4.0 changed the file extension from .json to .lepiter."

	file extension = #links ifTrue: [ ^ self linksFileFor: file ].
	^ file withExtension: 'lepiter'

]

{ #category : #private }
LeJsonV3002Updater >> linksFileFor: file [
	"Rename the .json.links file to .lepiter.links"
	| fullName |

	fullName := file fullName.
	self assert: (fullName endsWith: '.json.links').
	^ FileReference
		fileSystem: file fileSystem
		path: ((fullName copyFrom: 1 to: fullName size - 10), 'lepiter.links') asPath.
]

{ #category : #private }
LeJsonV3002Updater >> update: jsonObject [
	"Update the supplied JSON object by one version"

	jsonObject at: #'__schema' put: '4.0'
]
