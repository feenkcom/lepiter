Extension { #name : #LeLocalStore }

{ #category : #'*Lepiter-Translator-Roam' }
LeLocalStore class >> forRoamJson [
	"Answer an instance of the receiver with Roam JSON storage format"

	^ self new storage: LeLocalRoamJsonStorage new
]
