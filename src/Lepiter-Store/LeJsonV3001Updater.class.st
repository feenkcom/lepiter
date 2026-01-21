Class {
	#name : #LeJsonV3001Updater,
	#superclass : #LeJsonV3SchemaUpdater,
	#category : 'Lepiter-Store-JSONV3'
}

{ #category : #'accessing structure variables' }
LeJsonV3001Updater class >> minorVersion [ 
	"Answer the minor version number that this class upgrades from"

	^ 1
]

{ #category : #private }
LeJsonV3001Updater >> fileReferenceFor: jsonObject named: file [
	"Answer the new file name to be used to store the page.
	V3.2 changed the file naming from the hash of the title to the UID String32 representation"
	| uuid |

	uuid := UUID fromString: ((jsonObject at: #uid) at: #uuid).
	^ file parent / (uuid asString36, '.json')

	
]

{ #category : #private }
LeJsonV3001Updater >> update: jsonObject [
	"V3.2 adds a UID to LePage."

	super update: jsonObject.

	jsonObject 
		at: #uid
		put: { #'__type' -> #uuid.
				#uuid -> UUID new asString } asDictionary.

]
