"
Upgrade 3.3 to 4.0.

3.3 was never released, so this shouldn't normally be used.

"
Class {
	#name : #LeJsonV3003Updater,
	#superclass : #LeJsonV3SchemaUpdater,
	#category : 'Lepiter-Store-JSONV3'
}

{ #category : #accessing }
LeJsonV3003Updater class >> minorVersion [ 
	"Answer the minor version number that this class upgrades FROM"

	^ 3
]

{ #category : #accessing }
LeJsonV3003Updater class >> updatedVersion [ 
	"Answer the version that the file is updated to, V4.0 in this case"

	^ LeDbVersion new
		major: 4;
		minor: 0.
]

{ #category : #private }
LeJsonV3003Updater >> fileReferenceFor: jsonObject named: file [
	"Answer the new file name to be used to store the page.
	V4.0 changed the file extension from .json to .lepiter."

	file extension = #links ifTrue: [ ^ self linksFileFor: file ].
	^ file withExtension: 'lepiter'

]

{ #category : #private }
LeJsonV3003Updater >> linksFileFor: file [
	"Rename the .json.links file to .lepiter.links"
	| fullName |

	fullName := file fullName.
	self assert: (fullName endsWith: '.lepiter.links').
	^ file
]

{ #category : #private }
LeJsonV3003Updater >> update: jsonObject [
	"Update the supplied JSON object by one version"

	jsonObject at: #'__schema' put: '4.0'
]
